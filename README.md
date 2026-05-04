# Ethos LuaLS Definitions

This is an addon for the Lua extension by sumneko.

It provides lint and autocomplete for the Ethos Lua API by producing a LuaLS-compatible annotations for modules, classes, methods, constants, and the documented Ethos-specific os.* additions.

## Easy setup

If you do not intend to use AI, the simplest way to use the Ethos Lua definitions in VS Code is by using the built-in LuaLS Addon manager:

1. Install the [Lua extension](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) by sumneko in VS Code.
2. Open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`).
3. Run the command **Lua: Open Addon Manager**.
4. Find and enable the **Ethos Lua (FrSky)** addon.

For more details on addons, see the [LuaLS addons documentation](https://luals.github.io/wiki/addons/).

## Manual Project SetUp

### Custom Setup

The generated output is:

library/ethos.lua: LuaLS-compatible annotations for modules, classes, methods, constants, and the documented Ethos-specific os.* additions.

The VSCode plugin used to read those defininitions is [Lua By sumneko](https://marketplace.visualstudio.com/items?itemName=sumneko.lua).

I recommend you clone the repo in the folder where all your project**s** are setup, then symlink the library folder inside your project, you may also add library to .gitignore.

### AI SetUp

(This will probably put a submodule in your project)

```md
Prompt your agent with:

Read https://github.com/flyingeek/ethos-lua-definitions/blob/main/llms.txt then set up LuaLS for Ethos Lua in this project.
```

## LuaLS Setup

Point LuaLS at the `library/` directory. For example, using recommanded options, `.luarc.json` should look like:

```json
{
    "workspace.library": [
        "./library"
  ],
  "completion.callSnippet": "Replace",
  "completion.autoRequire": false,
  "runtime.version": "Lua 5.4",
  "runtime.builtin": {
    "bit": "disable",
    "bit32": "disable",
    "coroutine": "disable",
    "debug": "disable",
    "ffi": "disable",
    "jit": "disable",
    "os": "disable"
  }
}
```

## Usage with AI

You can use a prompt like this (customize path), to improve greatly the inference of agents:

```md
This is an **FrSky Ethos Lua** project. Ethos has a completely different API from OpenTX/EdgeTX — do not use OpenTX/EdgeTX patterns, function names, or idioms.

**Only use APIs, functions, and constants defined in the LuaLS definitions file (`library/ethos.lua` from ethos-lua-definitions).**

Key rules:
- Constants are bare globals: `FONT_XS`, `KEY_ENTER`, `COLOR_WHITE` — never `base.FONT_XS`.
- `form.add*()` returns a typed widget: `LuaButton`, `NumberEditLib`, `ChoiceLib`, etc.
- `model.getChannel(n)` returns a `Channel` object — there is no `model.getChannelValue()`.
- `model.getTimer()` / `model.createTimer()` return a `Timer` object — call methods on it.
- Script entry point is `local app = {}` with `app.init`, `app.wakeup`, `app.paint`, `app.event`, `app.close` callbacks — not the OpenTX `init()`/`run()` pattern.
- `lcd` drawing functions accept an optional `Rect` table `{x, y, w, h}`.
```

## If you need to regenerate the definitions yourself

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

After placing `lua-doc/` in the repository root, run:

```sh
python3 tools/generate_luals_definitions.py
```

The generator reads the HTML files in `lua-doc/` and rewrites `library/ethos.lua`.

## Notes

- The documentation groups global constants under the `base` namespace, but Ethos examples use them as globals such as `FONT_XS` and `CATEGORY_SYSTEM`. The generated file therefore exposes them as globals.
- `FONT_STD` is emitted as a standalone global constant.
- A few return types in the HTML are underspecified, for example `The value read` or `The new field`. Where the docs were clear enough, the generator maps them to the corresponding Ethos classes; otherwise it falls back to `any`.
