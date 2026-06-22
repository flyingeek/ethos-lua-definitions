#!/usr/bin/env python3
"""Review example/signature mismatches in library/ethos.lua.

Flags functions whose doc-comment examples pass more arguments than the
declared signature allows.  Known false positives (caused by nested
tables or closures confusing the argument counter) are filtered out, as
are issues that have been intentionally left unfixed.

Usage:
    python3 tools/review_examples.py
    python3 tools/review_examples.py --lua library/ethos.lua
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


# ---------------------------------------------------------------------------
# Tuning knobs
# ---------------------------------------------------------------------------

# These produce spurious "too many args" counts because the regex can't
# reliably count commas inside nested tables or closures.
FALSE_POSITIVES: set[str] = {
    "LogicSwitch:values",    # {{...}, {...}} — outer table is one arg
    "form.addButton",        # {press=function() end} contains a comma-less closure
    "glasses.createLayout",  # deeply nested table with many commas
}

# Real mismatches that have been intentionally left as-is.
KNOWN_SKIPS: set[str] = {
    "Module:muteSensorLost",  # example calls system.muteSensorLost — wrong namespace in docs
}


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def count_args(raw: str) -> int:
    """Count top-level comma-separated arguments (ignores commas inside {})."""
    if not raw.strip():
        return 0
    return len(re.split(r",(?![^{]*})", raw))


def review(lua_path: Path) -> list[str]:
    content = lua_path.read_text(encoding="utf-8")

    blocks = re.findall(
        r"((?:---[^\n]*\n)+)((?:local [\w\[\]\"]+\s*=\s*)?function\s+[\w.:\"\\[\\]]+\([^)]*\)[^\n]*)",
        content,
    )

    issues: list[str] = []

    for doc, sig in blocks:
        examples = re.findall(r"```lua\n(.*?)```", doc, re.S)
        if not examples:
            continue

        sig_match = re.match(r"function\s+([\w.:\"\\[\\]]+)\(([^)]*)\)", sig)
        if not sig_match:
            continue

        func_name = sig_match.group(1)
        declared_params = [p.strip() for p in sig_match.group(2).split(",") if p.strip()]
        # Strip the implicit "self" that method syntax adds
        total_declared = len([p for p in declared_params if p != "self"])
        short_name = func_name.split(":")[-1].split(".")[-1].strip('"[]')

        for ex in examples:
            for line in ex.strip().splitlines():
                call_match = re.search(
                    rf"[:\.](?:{re.escape(short_name)})\(([^)]*)\)", line
                )
                if not call_match:
                    continue
                call_argc = count_args(call_match.group(1))
                if call_argc > total_declared:
                    issues.append(
                        f"{func_name} | declared={total_declared} example={call_argc}"
                        f" | {line.strip()}"
                    )

    return issues


def classify(issues: list[str]) -> tuple[list[str], list[str], list[str]]:
    real, false_pos, skipped = [], [], []
    for issue in issues:
        if any(fp in issue for fp in FALSE_POSITIVES):
            false_pos.append(issue)
        elif any(sk in issue for sk in KNOWN_SKIPS):
            skipped.append(issue)
        else:
            real.append(issue)
    return real, false_pos, skipped


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(description="Review example/signature mismatches.")
    parser.add_argument(
        "--lua",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "library" / "ethos.lua",
        help="Path to the generated Lua definitions file.",
    )
    args = parser.parse_args()

    issues = review(args.lua.resolve())
    real, false_pos, skipped = classify(issues)

    if real:
        print(f"Actionable issues ({len(real)}):")
        for i in real:
            print(f"  {i}")
    else:
        print("No actionable issues found.")

    if skipped:
        print(f"\nIntentionally skipped ({len(skipped)}):")
        for i in skipped:
            print(f"  {i}")

    if false_pos:
        print(f"\nFiltered as false positives ({len(false_pos)}):")
        for i in false_pos:
            print(f"  {i}")


if __name__ == "__main__":
    main()
