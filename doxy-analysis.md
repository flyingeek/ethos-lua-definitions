# Doxygen XML vs HTML — Gap Analysis

## Problem

The XML export is missing many classes that exist in the HTML export:
`Channel`, `Curve`, `Timer`, `LogicSwitch`, `Dialog`, `ExpansionPanel`, `FormLine`,
`GlassesLayout`, `Module`, `MultimoduleSensor`, `Source`, `WaitDialog`.

Three root causes were identified by comparing the XML `Doxyfile.xml` against the
behaviour observed in the HTML output.

---

## 1. `OPTIMIZE_OUTPUT_SLICE = YES` — primary culprit

Slice is an Interface Definition Language (IDL) unrelated to C++. Enabling this flag
changes how Doxygen parses C++ classes and namespaces. Classes that are only exposed
via the `LUA_CLASS(LibName, LuaName)` macro are silently dropped because the Slice
parser does not understand those C++ macro patterns.

**Fix:**
```
OPTIMIZE_OUTPUT_SLICE = NO
```

---

## 2. Missing `PREDEFINED` macro expansions

The XML Doxyfile only defines:
```
PREDEFINED = DOXYGEN \
             protected=private
```

Without expansions, `LUA_CLASS(ChannelLib, Channel)` is parsed as a free function
named `LUA_CLASS`, not as a class definition for `Channel`. The HTML export must
be expanding these macros so Doxygen sees proper C++ class structures.

The actual expansion depends on the real macro definitions in `lua/lua.h`, but
something along the lines of:

```
PREDEFINED            += LUA_LIB(lib,ns)=class lib {
PREDEFINED            += LUA_CLASS(lib,name)=class name {
PREDEFINED            += LUA_FUNC(fn)=int fn(lua_State *L);
PREDEFINED            += LUA_FUNC_ALIAS(fn,al)=int al(lua_State *L);
MACRO_EXPANSION        = YES
```

The API owner should check the exact signatures in the source `lua/lua.h` and
mirror them here.

---

## 3. `EXTRACT_ALL = NO`

Combined with the missing macro expansions, any class that Doxygen fails to
recognise as a proper C++ class (because the macro isn't expanded) is simply
discarded. Setting this to `YES` would at least retain undocumented symbols and
may surface otherwise invisible classes.

**Fix:**
```
EXTRACT_ALL = YES
```

---

## Summary — changes to apply in the Doxyfile

```diff
-OPTIMIZE_OUTPUT_SLICE = YES
+OPTIMIZE_OUTPUT_SLICE = NO

-EXTRACT_ALL           = NO
+EXTRACT_ALL           = YES

 MACRO_EXPANSION        = YES

 PREDEFINED             = DOXYGEN \
                          protected=private \
+                         LUA_LIB(lib,ns)=class lib { \
+                         LUA_CLASS(lib,name)=class name { \
+                         LUA_FUNC(fn)=int fn(lua_State *L); \
+                         LUA_FUNC_ALIAS(fn,al)=int al(lua_State *L);
```

After applying these fixes, regenerate with:

```sh
doxygen Doxyfile
```
