# Ethos LuaLS Definitions

This repository generates Lua language server annotations from the Doxygen HTML in `lua-doc/`.

The `lua-doc/` directory is intentionally not included in this repository. Before generating the definitions, download the documentation from the FrSky nightly release:

- [FrSky nightly26 release](https://github.com/FrSkyRC/ETHOS-Feedback-Community/releases/tag/nightly26)

Extract or copy the `lua-doc/` directory into the project root so the layout looks like this:

```text
.
├── library/
├── lua-doc/
├── tools/
└── README.md
```

The generated output is:

- `library/ethos.lua`: LuaLS-compatible annotations for modules, classes, methods, constants, and the documented Ethos-specific `os.*` additions.

## Regenerate

After placing `lua-doc/` in the repository root, run:

```sh
python3 tools/generate_luals_definitions.py
```

The generator reads the HTML files in `lua-doc/` and rewrites `library/ethos.lua`.

## Using with AI

To set up LuaLS Ethos definitions in another project using an AI assistant, use this prompt:

> Set up LuaLS type definitions for the FrSky Ethos Lua API in this project. Clone or reference https://github.com/flyingeek/ethos-lua-definitions and configure `.luarc.json` accordingly.

For best results, point the AI at the `llms.txt` file first:

> Read https://github.com/flyingeek/ethos-lua-definitions/blob/main/llms.txt then set up LuaLS for Ethos Lua in this project.

## LuaLS Setup

Point LuaLS at the `library/` directory. For example, in `.luarc.json`:

```json
{
  "Lua.runtime.version": "Lua 5.4",
  "Lua.workspace.library": [
    "./library"
  ]
}
```

## Notes

- The documentation groups global constants under the `base` namespace, but Ethos examples use them as globals such as `FONT_XS` and `CATEGORY_SYSTEM`. The generated file therefore exposes them as globals.
- A few return types in the HTML are underspecified, for example `The value read` or `The new field`. Where the docs were clear enough, the generator maps them to the corresponding Ethos classes; otherwise it falls back to `any`.
