#!/usr/bin/env python3

from __future__ import annotations

import argparse
import html
import re
from dataclasses import dataclass, field
from pathlib import Path


BUILTIN_TYPES = {"any", "boolean", "fun(...):any", "integer", "nil", "number", "string", "table"}
KNOWN_TYPE_ALIASES = {
    "function": "fun(...):any",
    "integer": "integer",
    "number": "number",
    "string": "string",
    "boolean": "boolean",
    "table": "table",
    "nil": "nil",
    "none": "nil",
    "mask": "Mask",
    "rect": "Rect",
    "unsigned": "integer",
    "sportframe": "LuaSPortFrame",
    "sportsensor": "LuaSPortSensor",
}
RESERVED_WORDS = {
    "and",
    "break",
    "do",
    "else",
    "elseif",
    "end",
    "false",
    "for",
    "function",
    "goto",
    "if",
    "in",
    "local",
    "nil",
    "not",
    "or",
    "repeat",
    "return",
    "then",
    "true",
    "until",
    "while",
}


@dataclass
class Parameter:
    name: str
    type_name: str
    description: str = ""
    optional: bool = False


@dataclass
class ReturnValue:
    name: str | None
    type_name: str
    description: str = ""


@dataclass
class Field:
    name: str
    type_name: str
    description: str = ""


@dataclass
class Item:
    owner: str
    name: str
    kind: str
    description: str = ""
    since: str | None = None
    deprecated: bool = False
    params: list[Parameter] = field(default_factory=list)
    returns: list[ReturnValue] = field(default_factory=list)
    return_struct: str | None = None


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def strip_tags(value: str) -> str:
    value = re.sub(r"<br\s*/?>", "\n", value)
    value = re.sub(r"</?(code|p|li|ul|ol|div|span|a|dl|dt|dd|table|tr|td|tbody|thead|em|strong|b|i)[^>]*>", " ", value)
    value = re.sub(r"<[^>]+>", " ", value)
    value = html.unescape(value)
    value = value.replace("\xa0", " ")
    value = re.sub(r"\s+", " ", value)
    return value.strip()


def clean_doc(value: str) -> str:
    text = strip_tags(value)
    return text.replace(" ,", ",").replace(" .", ".")


def safe_identifier(name: str) -> str:
    cleaned = re.sub(r"[^A-Za-z0-9_]", "_", name.strip())
    cleaned = re.sub(r"_+", "_", cleaned).strip("_")
    if not cleaned:
        cleaned = "value"
    if cleaned[0].isdigit():
        cleaned = f"value_{cleaned}"
    if cleaned in RESERVED_WORDS:
        cleaned = f"{cleaned}_value"
    return cleaned


def to_pascal_case(value: str) -> str:
    parts = re.findall(r"[A-Za-z0-9]+", value)
    return "".join(part[:1].upper() + part[1:] for part in parts) or "Value"


def to_snake_case(value: str) -> str:
    parts = re.findall(r"[A-Za-z0-9]+", value.lower())
    result = "_".join(parts)
    return safe_identifier(result or "result")


def split_union(text: str) -> list[str]:
    if re.fullmatch(r"\d+(?:\s*,\s*\d+)*(?:\s+or\s+\d+)?", text.strip(), flags=re.I):
        return [text.strip()]
    text = text.replace(" / ", "|")
    text = re.sub(r"\s+or\s+", "|", text, flags=re.IGNORECASE)
    text = re.sub(r"\s*\|\s*", "|", text)
    return [part.strip() for part in text.split("|") if part.strip()]


def infer_simple_type(text: str) -> str:
    raw = strip_tags(text)
    lowered = raw.lower().strip()
    if re.fullmatch(r"\d+(?:\s*,\s*\d+)*(?:\s+or\s+\d+)?", lowered):
        return "integer"
    lowered = lowered.replace("optional", "").replace(",", " ")
    lowered = re.sub(r"\s+", " ", lowered).strip()

    if not lowered:
        return "any"
    if lowered in KNOWN_TYPE_ALIASES:
        return KNOWN_TYPE_ALIASES[lowered]
    if lowered.startswith("integer"):
        return "integer"
    if lowered.startswith("number"):
        return "number"
    if lowered.startswith("string"):
        return "string"
    if lowered.startswith("boolean"):
        return "boolean"
    if lowered.startswith("function"):
        return "fun(...):any"
    if lowered.startswith("table"):
        return "table"
    if lowered.startswith("userdata"):
        return "any"
    if lowered == "sources list":
        return "Source[]"
    if lowered.endswith(" list"):
        base = raw[:-5].strip()
        return f"{safe_identifier(base)}[]" if base.islower() else f"{base}[]"
    if "as a string" in lowered:
        return "string"
    if "true" in lowered and "false" in lowered:
        return "boolean"
    if raw in {"Rect", "Mask"}:
        return raw
    if re.fullmatch(r"[A-Z][A-Za-z0-9_]*", raw):
        return raw
    return "any"


def normalize_type(text: str) -> str:
    raw = strip_tags(text).strip()
    if not raw:
        return "any"
    union_parts = []
    for part in split_union(raw):
        union_parts.append(infer_simple_type(part))
    deduped = []
    for part in union_parts:
        if part not in deduped:
            deduped.append(part)
    return "|".join(deduped) if deduped else "any"


def parse_first_paragraph(memdoc_html: str) -> str:
    match = re.search(r"<p[^>]*>(.*?)</p>", memdoc_html, flags=re.S)
    return clean_doc(match.group(1)) if match else ""


def parse_since(memdoc_html: str) -> str | None:
    match = re.search(r'<dl class="section since"><dt>Since</dt><dd>(.*?)</dd></dl>', memdoc_html, flags=re.S)
    return clean_doc(match.group(1)) if match else None


def parse_deprecated(memdoc_html: str) -> bool:
    # Restrict deprecation detection to explicit Doxygen deprecated sections.
    # This avoids false positives from cross-reference tooltips that happen to
    # contain the word "deprecated" in examples.
    return bool(re.search(r'<dl class="section deprecated">\s*<dt>Deprecated</dt>', memdoc_html, flags=re.S | re.I))


def parse_type_and_description(text: str) -> tuple[str, str]:
    text = strip_tags(text)
    match = re.match(r"^\(([^)]*)\)\s*:?[ ]*(.*)$", text)
    if not match:
        return "any", text
    return normalize_type(match.group(1)), match.group(2).strip()


def parse_optional_flag(text: str) -> bool:
    lowered = strip_tags(text).lower()
    return (
        "optional" in lowered
        or "default=" in lowered
        or "default =" in lowered
        or "default is" in lowered
    )


def parse_parameters(memdoc_html: str) -> list[Parameter]:
    match = re.search(r'<dl class="params"><dt>Parameters</dt><dd>\s*<table class="params">(.*?)</table>', memdoc_html, flags=re.S)
    if not match:
        return []

    parameters: list[Parameter] = []
    rows = re.findall(r'<tr><td class="paramname">(.*?)</td><td>(.*?)</td></tr>', match.group(1), flags=re.S)
    for raw_name, raw_info in rows:
        name_text = clean_doc(raw_name)
        info_text = clean_doc(raw_info)
        if name_text.lower() == "none":
            continue

        combined = f"{name_text} {info_text}".strip()
        combined_specs = list(re.finditer(r'([A-Za-z_][A-Za-z0-9_]*)\s*\(([^)]*)\)', combined))
        complex_row = "(" in name_text or re.search(r'\b(?:and|or)\s+[A-Za-z_][A-Za-z0-9_]*\s*\(', info_text)
        if complex_row and combined_specs:
            trailing_desc = combined[combined_specs[-1].end():].strip(" :") if combined_specs else ""
            for index, spec in enumerate(combined_specs):
                description = trailing_desc if index == len(combined_specs) - 1 else ""
                parameters.append(
                    Parameter(
                        name=safe_identifier(spec.group(1)),
                        type_name=normalize_type(spec.group(2)),
                        description=description,
                        optional=parse_optional_flag(spec.group(2)),
                    )
                )
            if combined_specs:
                continue

        type_name, description = parse_type_and_description(info_text)
        parameters.append(
            Parameter(
                name=safe_identifier(name_text),
                type_name=type_name,
                description=description,
                optional=parse_optional_flag(info_text),
            )
        )

    deduped: list[Parameter] = []
    seen: set[tuple[str, str, str]] = set()
    for parameter in parameters:
        key = (parameter.name, parameter.type_name, parameter.description)
        if key in seen:
            continue
        seen.add(key)
        deduped.append(parameter)

    return deduped


def sanitize_return_name(name: str) -> str | None:
    text = strip_tags(name).strip()
    if not text:
        return None
    text = re.sub(r"^and\s+", "", text, flags=re.I)
    lowered = text.lower()
    if lowered.startswith("the ") or lowered.startswith("a ") or lowered.startswith("an "):
        return None
    if any(char in text for char in ",:/"):
        return None
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", text):
        return safe_identifier(text)
    return to_snake_case(text)


def infer_return_from_context(owner: str, name: str, text: str) -> str | None:
    lowered = text.lower()
    context_map = {
        ("form", "addBitmapField"): "FormFieldLib",
        ("form", "addBooleanField"): "FormFieldLib",
        ("form", "addButton"): "LuaButton",
        ("form", "addChoiceField"): "ChoiceLib",
        ("form", "addColorField"): "FormFieldLib",
        ("form", "addExpansionPanel"): "ExpansionPanel",
        ("form", "addFileField"): "FormFieldLib",
        ("form", "addLine"): "FormLine",
        ("form", "addNumberField"): "NumberEditLib",
        ("form", "addSensorField"): "FormFieldLib",
        ("form", "addSliderField"): "SliderLib",
        ("form", "addSourceField"): "FormFieldLib",
        ("form", "addStaticText"): "FormFieldLib",
        ("form", "addSwitchField"): "FormFieldLib",
        ("form", "addTextButton"): "LuaButton",
        ("form", "addTextField"): "FormFieldLib",
        ("form", "addTimeField"): "FormFieldLib",
        ("form", "openDialog"): "Dialog",
        ("form", "openProgressDialog"): "ProgressDialog",
        ("form", "openWaitDialog"): "WaitDialog",
        ("glasses", "createLayout"): "GlassesLayout",
        ("lcd", "loadBitmap"): "Bitmap",
        ("lcd", "loadMask"): "Mask",
        ("serial", "open"): "LuaSPortSerial",
        ("model", "createCurve"): "Curve",
        ("model", "getCurve"): "Curve",
        ("model", "createLogicSwitch"): "LogicSwitch",
        ("model", "getLogicSwitch"): "LogicSwitch",
        ("model", "createTimer"): "Timer",
        ("model", "getTimer"): "Timer",
        ("model", "getChannel"): "Channel",
        ("model", "getModule"): "Module",
        ("model", "createSensor"): "Source",
        ("sport", "getSensor"): "LuaSPortSensor",
        ("system", "readEvents"): "integer",
    }
    if (owner, name) in context_map:
        return context_map[(owner, name)]
    if "bitmap handle" in lowered:
        return "Bitmap"
    if "mask handle" in lowered:
        return "Mask"
    if "serial connection" in lowered:
        return "LuaSPortSerial"
    if lowered == "the new curve":
        return "Curve"
    if lowered == "the new timer":
        return "Timer"
    if lowered == "the new logic switch":
        return "LogicSwitch"
    if lowered == "channel":
        return "Channel"
    if lowered == "curve":
        return "Curve"
    if lowered == "logic switch":
        return "LogicSwitch"
    if lowered == "module":
        return "Module"
    if lowered == "timer":
        return "Timer"
    if lowered == "source of the created sensor":
        return "Source"
    if " as a string" in lowered:
        return "string"
    if lowered == "the new field":
        return "FormFieldLib"
    if lowered == "the new button":
        return "LuaButton"
    if owner == "form" and name.startswith("add"):
        return "FormFieldLib"
    return None


def parse_return_struct(owner: str, name: str, dd_html: str) -> tuple[str, list[Field]]:
    struct_name = f"{to_pascal_case(owner)}{to_pascal_case(name)}Result"
    fields: list[Field] = []
    for field_html in re.findall(r"<li>(.*?)</li>", dd_html, flags=re.S):
        match = re.search(r"<code>(.*?)</code>\s*\(([^)]*)\)\s*(.*)", field_html, flags=re.S)
        if not match:
            continue
        fields.append(
            Field(
                name=safe_identifier(clean_doc(match.group(1))),
                type_name=normalize_type(match.group(2)),
                description=clean_doc(match.group(3)),
            )
        )
    return struct_name, fields


def parse_returns(memdoc_html: str, owner: str, name: str) -> tuple[list[ReturnValue], dict[str, list[Field]]]:
    match = re.search(r'<dl class="section return"><dt>Returns</dt>(.*?)</dl>', memdoc_html, flags=re.S)
    if not match:
        return [], {}

    dd_entries = re.findall(r"<dd>(.*?)</dd>", match.group(1), flags=re.S)
    returns: list[ReturnValue] = []
    structs: dict[str, list[Field]] = {}

    for dd_html in dd_entries:
        text = clean_doc(dd_html)
        if not text or text == "None":
            continue
        if text.startswith("Table with elements:"):
            struct_name, fields = parse_return_struct(owner, name, dd_html)
            if fields:
                structs[struct_name] = fields
                returns.append(ReturnValue(name="result", type_name=struct_name))
            continue

        union_match = re.match(r"^(nil|table|string|number|integer|boolean|function)\s+or\s+([A-Za-z][A-Za-z0-9_ ]*)\s*\((.*?)\)$", text, flags=re.I)
        if union_match:
            union_type = normalize_type(f"{union_match.group(1)}|{union_match.group(2)}")
            returns.append(ReturnValue(name="result", type_name=union_type, description=clean_doc(union_match.group(3))))
            continue

        specs = list(re.finditer(r"([^,]+?)\s*\(([^)]*)\)", text))
        if specs:
            multi_value = len(specs) > 1 and ("," in text or " and " in text)
            for spec in specs:
                raw_name = spec.group(1).strip().strip(",")
                name_hint = sanitize_return_name(raw_name)
                if not multi_value and name_hint is None:
                    name_hint = "result"
                type_name = normalize_type(spec.group(2))
                if type_name == "any":
                    context_type = infer_return_from_context(owner, name, text)
                    if context_type:
                        type_name = context_type
                returns.append(
                    ReturnValue(
                        name=name_hint,
                        type_name=type_name,
                        description="" if multi_value else raw_name,
                    )
                )
            continue

        context_type = infer_return_from_context(owner, name, text)
        if context_type:
            returns.append(ReturnValue(name="result", type_name=context_type, description=text))
            continue

        returns.append(ReturnValue(name="result", type_name=infer_simple_type(text), description=text))

    return returns, structs


def parse_items(page_html: str, owner: str) -> tuple[list[Item], dict[str, list[Field]]]:
    anchor_pattern = re.compile(r'<a id="[^"]+"[^>]*></a>\s*<h2 class="memtitle">', flags=re.S)
    matches = list(anchor_pattern.finditer(page_html))
    items: list[Item] = []
    structs: dict[str, list[Field]] = {}

    for index, match in enumerate(matches):
        end = matches[index + 1].start() if index + 1 < len(matches) else len(page_html)
        chunk = page_html[match.start():end]
        title_match = re.search(r'<h2 class="memtitle">.*?</span>(.*?)</h2>', chunk, flags=re.S)
        memdoc_match = re.search(r'<div class="memdoc">(.*)</div>\s*</div>', chunk, flags=re.S)
        if not title_match or not memdoc_match:
            continue

        raw_title = clean_doc(title_match.group(1))
        if not raw_title:
            continue

        item_kind = "function" if raw_title.endswith("()") else "constant"
        item_name = raw_title[:-2] if item_kind == "function" else raw_title
        memdoc_html = memdoc_match.group(1)
        item_returns, item_structs = parse_returns(memdoc_html, owner, item_name)
        structs.update(item_structs)
        description = parse_first_paragraph(memdoc_html)
        deprecated = parse_deprecated(memdoc_html) or "(deprecated" in description.lower() or description.strip().lower() == "deprecated"
        params = parse_parameters(memdoc_html)

        # Ethos accepts nil for form.add* rect parameters even when docs omit it.
        if owner == "form" and item_kind == "function" and item_name.startswith("add"):
            for parameter in params:
                if parameter.name == "rect":
                    parameter.type_name = "Rect|nil"
                    parameter.optional = True

            if not item_returns:
                item_returns = [ReturnValue(name="result", type_name="FormFieldLib", description="The new field")]

        # Ethos addButton last 3 args are passed as a single options table.
        if owner == "form" and item_kind == "function" and item_name == "addButton":
            params = [
                Parameter(name="line", type_name="FormLine", description="the line where the field should be added"),
                Parameter(name="rect", type_name="Rect|nil", description="the coordinates", optional=True),
                Parameter(
                    name="params",
                    type_name="table",
                    description="table with elements: text (string, optional), icon (Mask, optional), press (function)",
                ),
            ]

        # addStaticText returns a FrSkyStaticTextLib, not a plain FormFieldLib.
        if owner == "form" and item_kind == "function" and item_name == "addStaticText":
            item_returns = [ReturnValue(name="result", type_name="FrSkyStaticTextLib", description="The new field")]

        # addExpansionPanel returns ExpansionPanel, not FormFieldLib.
        if owner == "form" and item_kind == "function" and item_name == "addExpansionPanel":
            item_returns = [ReturnValue(name="result", type_name="ExpansionPanel", description="The new field")]

        # Ethos openDialog is called with a single options table.
        if owner == "form" and item_kind == "function" and item_name == "openDialog":
            params = [
                Parameter(
                    name="params",
                    type_name="table",
                    description="table with elements: title, message, buttons, options, wakeup, paint, closeWhenClickOutside",
                )
            ]

        # Ethos openWaitDialog is called with a single options table.
        if owner == "form" and item_kind == "function" and item_name == "openWaitDialog":
            params = [
                Parameter(
                    name="params",
                    type_name="table",
                    description="table with elements: title, message, progress, wakeup, close",
                )
            ]

        # Ethos openProgressDialog takes title, message, wakeup and close callbacks.
        if owner == "form" and item_kind == "function" and item_name == "openProgressDialog":
            params = [
                Parameter(name="title", type_name="string", description="dialog title"),
                Parameter(name="message", type_name="string", description="dialog message"),
                Parameter(name="wakeup", type_name="fun(...):any", description="wakeup callback"),
                Parameter(name="close", type_name="fun(...):any", description="close callback"),
            ]
            item_returns = [ReturnValue(name="result", type_name="ProgressDialog", description="ProgressDialog")]

        # In practice these form APIs accept omitted line/panel in examples.
        if owner == "form" and item_kind == "function" and item_name == "addLine":
            for parameter in params:
                if parameter.name == "panel":
                    parameter.optional = True
                    if "nil" not in parameter.type_name.split("|"):
                        parameter.type_name = f"{parameter.type_name}|nil"

        if owner == "form" and item_kind == "function" and item_name in {
            "addFunctionSwitch",
            "addPot",
            "addRadioHardware",
            "addRotaryEncoder",
            "addStick",
            "addSwitch",
            "addTrim",
        }:
            for parameter in params:
                if parameter.name == "line":
                    parameter.optional = True
                    if "nil" not in parameter.type_name.split("|"):
                        parameter.type_name = f"{parameter.type_name}|nil"
                    break

        items.append(
            Item(
                owner=owner,
                name=item_name,
                kind=item_kind,
                description=description,
                since=parse_since(memdoc_html),
                deprecated=deprecated,
                params=params,
                returns=item_returns,
                return_struct=next(iter(item_structs), None),
            )
        )

    return items, structs


def parse_index_names(path: Path, pattern: str) -> list[tuple[str, str]]:
    html_text = read_text(path)
    pairs = re.findall(pattern, html_text, flags=re.S)
    unique_pairs: list[tuple[str, str]] = []
    for file_name, display_name in pairs:
        pair = (display_name, file_name)
        if pair not in unique_pairs:
            unique_pairs.append(pair)
    return unique_pairs


def type_tokens(type_name: str) -> list[str]:
    tokens: list[str] = []
    for part in type_name.split("|"):
        token = part.strip()
        if token.endswith("[]"):
            token = token[:-2]
        if token:
            tokens.append(token)
    return tokens


def collect_unknown_types(items: list[Item], structs: dict[str, list[Field]], known_classes: set[str], known_structs: set[str]) -> list[str]:
    unknown: set[str] = set()

    def visit(type_name: str) -> None:
        for token in type_tokens(type_name):
            if token in BUILTIN_TYPES:
                continue
            if token in known_classes or token in known_structs:
                continue
            if token in {"Mask", "Rect"}:
                unknown.add(token)

    for item in items:
        for parameter in item.params:
            visit(parameter.type_name)
        for return_value in item.returns:
            visit(return_value.type_name)
    for fields in structs.values():
        for field in fields:
            visit(field.type_name)

    return sorted(unknown)


def emit_comment(lines: list[str], text: str) -> None:
    if not text:
        return
    for paragraph in text.split("\n"):
        content = paragraph.strip()
        if content:
            lines.append(f"---{content}")


def emit_param(lines: list[str], parameter: Parameter) -> None:
    suffix = f" # {parameter.description}" if parameter.description else ""
    optional_marker = "?" if parameter.optional else ""
    lines.append(f"---@param {parameter.name}{optional_marker} {parameter.type_name}{suffix}")


def emit_return(lines: list[str], return_value: ReturnValue) -> None:
    name_part = f" {return_value.name}" if return_value.name else ""
    desc_part = f" # {return_value.description}" if return_value.description else ""
    lines.append(f"---@return {return_value.type_name}{name_part}{desc_part}")


def emit_function(lines: list[str], prefix: str, item: Item, method: bool) -> None:
    emit_comment(lines, item.description)
    if item.since:
        lines.append(f"---Since: {item.since}")
    if item.deprecated:
        lines.append("---@deprecated")
    for parameter in item.params:
        emit_param(lines, parameter)
    for return_value in item.returns:
        emit_return(lines, return_value)
    params = ", ".join(parameter.name for parameter in item.params)
    valid_member_name = re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", item.name) and item.name not in RESERVED_WORDS
    if valid_member_name:
        separator = ":" if method else "."
        lines.append(f"function {prefix}{separator}{item.name}({params}) end")
    else:
        if method:
            signature = ", ".join(part for part in ["self", params] if part)
        else:
            signature = params
        lines.append(f'{prefix}["{item.name}"] = function({signature}) end')
    lines.append("")


def emit_constant(lines: list[str], item: Item) -> None:
    emit_comment(lines, item.description)
    if item.since:
        lines.append(f"---Since: {item.since}")
    lines.append(f"---@type integer")
    lines.append(f"{item.name} = 0")
    lines.append("")


def emit_missing_constants(lines: list[str], base_constants: list[Item]) -> None:
    constant_names = {item.name for item in base_constants}

    # Keep constants that exist in Ethos but may be missing from current docs.
    if "FONT_BOLD" not in constant_names:
        lines.append("---STD Bold Font")
        lines.append("---@type integer")
        lines.append("FONT_BOLD = 0")
        lines.append("")
    if "TOUCH_MOVE" not in constant_names:
        lines.append("---Touch Move")
        lines.append("---@type integer")
        lines.append("TOUCH_MOVE = 0")
        lines.append("")
    if "TOUCH_START" not in constant_names:
        lines.append("---Touch Start")
        lines.append("---@type integer")
        lines.append("TOUCH_START = 0")
        lines.append("")
    if "TOUCH_END" not in constant_names:
        lines.append("---Touch End")
        lines.append("---@type integer")
        lines.append("TOUCH_END = 0")
        lines.append("")

def emit_struct(lines: list[str], struct_name: str, fields: list[Field]) -> None:
    lines.append(f"---@class {struct_name}")
    for field in fields:
        suffix = f" # {field.description}" if field.description else ""
        lines.append(f"---@field {field.name} {field.type_name}{suffix}")
    lines.append(f"local {struct_name} = {{}}")
    lines.append("")


def emit_class(lines: list[str], class_name: str, items: list[Item]) -> None:
    class_inheritance = {
        "ChoiceLib": "FormFieldLib",
        "SliderLib": "FormFieldLib",
    }
    parent_class = class_inheritance.get(class_name)
    class_declaration = f"{class_name}: {parent_class}" if parent_class else class_name
    lines.append(f"---@class {class_declaration}")
    lines.append(f"local {class_name} = {{}}")
    lines.append("")
    for item in items:
        if item.kind == "function":
            emit_function(lines, class_name, item, method=True)


def emit_module(lines: list[str], module_name: str, items: list[Item]) -> None:
    lines.append(f"---@class {module_name}")
    lines.append(f"{module_name} = {{}}")
    lines.append("")
    for item in items:
        if item.kind == "function":
            emit_function(lines, module_name, item, method=False)


def generate(doc_dir: Path, output_path: Path) -> None:
    class_pairs = parse_index_names(doc_dir / "classes.html", r'href="(class[^"]+\.html)">([^<]+)</a>')
    module_pairs = parse_index_names(doc_dir / "namespaces.html", r'href="(namespace[^"]+\.html)"[^>]*>([^<]+)</a>')

    class_names = {name for name, _ in class_pairs}
    module_names = [name for name, _ in module_pairs]
    class_items: dict[str, list[Item]] = {}
    module_items: dict[str, list[Item]] = {}
    struct_defs: dict[str, list[Field]] = {}
    base_constants: list[Item] = []

    for class_name, file_name in class_pairs:
        items, structs = parse_items(read_text(doc_dir / file_name), class_name)
        class_items[class_name] = [item for item in items if item.kind == "function"]
        struct_defs.update(structs)

    # Ethos LuaButton supports focus() even if some doc snapshots omit it.
    if "LuaButton" in class_items and not any(item.name == "focus" for item in class_items["LuaButton"]):
        class_items["LuaButton"].append(
            Item(
                owner="LuaButton",
                name="focus",
                kind="function",
                description="Give the focus to the button.",
                since="1.5.10",
            )
        )
    if "LuaButton" in class_items and not any(item.name == "enable" for item in class_items["LuaButton"]):
        class_items["LuaButton"].append(
            Item(
                owner="LuaButton",
                name="enable",
                kind="function",
                description="Enable or disable the button.",
                params=[Parameter(name="enabled", type_name="boolean")],
            )
        )

    # Some Ethos snapshots omit ProgressDialog; keep this API available for LuaLS.
    if "ProgressDialog" not in class_items:
        class_items["ProgressDialog"] = []
    class_names.add("ProgressDialog")
    progress_dialog_methods = [
        Item(
            owner="ProgressDialog",
            name="message",
            kind="function",
            description="Set the dialog message.",
            params=[Parameter(name="message", type_name="string")],
        ),
        Item(
            owner="ProgressDialog",
            name="value",
            kind="function",
            description="Set the progress value.",
            params=[Parameter(name="value", type_name="number")],
        ),
        Item(
            owner="ProgressDialog",
            name="closeAllowed",
            kind="function",
            description="Allow or disallow user-initiated close.",
            params=[Parameter(name="allowed", type_name="boolean")],
        ),
        Item(
            owner="ProgressDialog",
            name="close",
            kind="function",
            description="Close the progress dialog.",
        ),
    ]
    for method in progress_dialog_methods:
        if not any(item.name == method.name for item in class_items["ProgressDialog"]):
            class_items["ProgressDialog"].append(method)

    for module_name, file_name in module_pairs:
        items, structs = parse_items(read_text(doc_dir / file_name), module_name)
        struct_defs.update(structs)
        if module_name == "base":
            base_constants = [item for item in items if item.kind == "constant"]
        else:
            module_items[module_name] = [item for item in items if item.kind == "function"]

    # Keep form.openProgressDialog available when absent from docs.
    if "form" in module_items and not any(item.name == "openProgressDialog" for item in module_items["form"]):
        module_items["form"].append(
            Item(
                owner="form",
                name="openProgressDialog",
                kind="function",
                description="Open a progress dialog.",
                params=[
                    Parameter(name="title", type_name="string", description="dialog title"),
                    Parameter(name="message", type_name="string", description="dialog message"),
                    Parameter(name="wakeup", type_name="fun(...):any", description="wakeup callback"),
                    Parameter(name="close", type_name="fun(...):any", description="close callback"),
                ],
                returns=[ReturnValue(name="result", type_name="ProgressDialog", description="ProgressDialog")],
            )
        )

    all_items = [*base_constants]
    for items in class_items.values():
        all_items.extend(items)
    for items in module_items.values():
        all_items.extend(items)

    unknown_types = collect_unknown_types(all_items, struct_defs, class_names, set(struct_defs))

    lines = [
        "---@meta",
        "",
        "---Generated from the Ethos Doxygen HTML reference in lua-doc/.",
        "---Constants documented under the base namespace are emitted as globals because the examples use them that way.",
        "",
    ]

    for unknown_type in unknown_types:
        lines.append(f"---@alias {unknown_type} table")
    if unknown_types:
        lines.append("")

    for struct_name in sorted(struct_defs):
        emit_struct(lines, struct_name, struct_defs[struct_name])

    for class_name in sorted(class_items):
        emit_class(lines, class_name, class_items[class_name])

    for constant in base_constants:
        emit_constant(lines, constant)

    emit_missing_constants(lines, base_constants)

    for module_name in module_names:
        if module_name == "base":
            continue
        emit_module(lines, module_name, module_items[module_name])

    lines.extend(
        [
            "---Check if a file or directory exists and retrieve its info.",
            "---@param path string",
            "---@return table|nil result",
            "function os.stat(path) end",
            "",
            "---Remove a file or an empty directory.",
            "---@param path string",
            "---@return boolean result",
            "function os.remove(path) end",
            "",
            "---Rename a file or a directory.",
            "---@param from string",
            "---@param to string",
            "---@return boolean result",
            "function os.rename(from, to) end",
            "",
            "---Remove a directory tree recursively.",
            "---@param path string",
            "---@return boolean result",
            "function os.rmtree(path) end",
            "",
            "---Create an empty directory.",
            "---@param path string",
            "---@return boolean result",
            "function os.mkdir(path) end",
            "",
            "---Copy a file or directory to another directory.",
            "---@param source string",
            "---@param destination string",
            "---@return boolean result",
            "function os.copy(source, destination) end",
            "",
        ]
    )

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate LuaLS annotations from the Ethos HTML reference.")
    parser.add_argument(
        "--doc-dir",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "lua-doc",
        help="Path to the extracted Doxygen HTML directory.",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "library" / "ethos.lua",
        help="Output Lua file for LuaLS.",
    )
    args = parser.parse_args()
    generate(args.doc_dir.resolve(), args.output.resolve())


if __name__ == "__main__":
    main()
