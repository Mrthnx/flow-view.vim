# nvim-flowview

A modern Neovim plugin to **visually understand code flow** through nested inline function expansion.

---

## ✨ What is this?

`nvim-flowview` helps developers understand complex codebases by rendering
a **fully expanded, nested, readable view of function execution flow**.

Instead of jumping across files using “go to definition”, the plugin shows:

- the full body of the current function
- inline expansion of called functions
- recursive nesting (A → B → C)
- all code rendered line-by-line
- with real navigation to implementations

The goal is **code comprehension**, not symbol browsing.

---

## 🧠 Core Idea

Given this code:

```ts
function A() {
  const x = getUser()
  const y = buildPayload(x)
  sendToApi(y)
}
```

Flowview renders:

```
A()
│
├─ const x = getUser()          ▶
│     getUser()
│       ...
│
├─ const y = buildPayload(x)    ▶
│     buildPayload()
│       ...
│
└─ sendToApi(y)                 ▶
      sendToApi()
        ...
```

All functions are:

* shown **inline**
* **fully expanded**
* **properly indented**
* **foldable**
* **navigable**
* resolved using real LSP destinations

---

## 🎯 Primary Goals

* Eliminate mental overhead of jumping file-to-file
* Make call flow visible and readable
* Provide a “story view” of execution
* Work with large real-world projects
* Remain fast and predictable

---

## 🚀 Supported Languages (initial)

### Phase 1 (MVP)

* TypeScript
* JavaScript

via:

* `tsserver`
* tree-sitter-typescript
* tree-sitter-javascript

### Phase 2

* Go (`gopls`)

---

## 🧩 Architecture Overview

Flowview combines **three layers**:

### 1️⃣ LSP — Symbol Resolution

Used for:

* resolving function destinations
* jumping to implementations
* handling overloads
* detecting multiple call targets

Priority order:

1. `textDocument/implementation`
2. `textDocument/definition`
3. `textDocument/typeDefinition`
4. `textDocument/references` (filtered)

If multiple destinations exist → user selection UI.

---

### 2️⃣ Tree-sitter — Syntax & Ranges

Used for:

* locating full function ranges
* extracting complete function bodies
* detecting function calls
* mapping calls to line numbers
* indentation / nesting logic

Tree-sitter is **never used for symbol resolution**.

---

### 3️⃣ Flow Graph Engine

Internal model:

```lua
Node = {
  id,
  name,
  uri,
  range,
  language,
  code_lines = {},
  calls = {
    {
      line,
      column,
      text,
      targets = { Node }
    }
  }
}
```

Supports:

* recursive expansion
* depth limit
* cycle detection
* lazy loading
* caching per buffer

---

## 🖥 UI Design

### Layout

* Dedicated **side split panel**
* Width ~45–55 columns
* Uses a normal Neovim buffer (not floating)
* Read-only buffer
* Tree-style indentation

Inspired by:

* sqlit.nvim
* lazygit
* neo-tree

---

### Visual Example

```
▾ A()  [src/main.ts:10–52]
    10 const x = getUser()
    11 if (!x) return
    12 const y = buildPayload(x)      ▶
        ▸ buildPayload() [payload.ts:4–38]
    13 await sendToApi(y)             ▶
        ▾ sendToApi() [api.ts:21–88]
            21 const client = new Api()
            22 client.send(y)
```

---

## 🎮 Keybindings

| Key       | Action                   |
| --------- | ------------------------ |
| `<Enter>` | Jump to implementation   |
| `o`       | Open in horizontal split |
| `v`       | Open in vertical split   |
| `p`       | Preview floating window  |
| `za`      | Fold / unfold block      |
| `zM`      | Collapse all             |
| `zR`      | Expand all               |
| `r`       | Refresh flow             |
| `d`       | Increase depth           |
| `D`       | Decrease depth           |
| `q`       | Close panel              |

---

## 🔍 Behavior Rules

### Function Expansion

* Always show full function body
* Render line numbers
* Preserve original indentation
* Nested functions increase indent visually

---

### Cycle Detection

Prevent infinite loops:

```
A → B → A
```

Render as:

```
↺ already visited
```

---

### Depth Control

Default:

```lua
max_depth = 3
```

User adjustable at runtime.

---

### Noise Filtering

Ignore common utility calls:

* console.log
* logger.*
* fmt.Println
* assert
* getters/setters

Configurable allow/deny lists.

---

## ⚡ Performance Strategy

* Cache document symbols per buffer
* Cache function ranges
* Lazy-expand children only when requested
* Invalidate cache on buffer write
* Never parse entire workspace eagerly

---

## 🧱 Repository Structure

```
nvim-flowview/
├─ lua/
│  └─ flowview/
│     ├─ init.lua
│     ├─ config.lua
│     ├─ commands.lua
│     ├─ ui/
│     │  ├─ panel.lua
│     │  ├─ renderer.lua
│     │  └─ highlights.lua
│     ├─ lsp/
│     │  ├─ resolver.lua
│     │  └─ navigator.lua
│     ├─ treesitter/
│     │  ├─ queries.lua
│     │  └─ calls.lua
│     ├─ graph/
│     │  ├─ builder.lua
│     │  ├─ node.lua
│     │  └─ cache.lua
│     └─ utils/
│        ├─ range.lua
│        └─ buffer.lua
├─ README.md
├─ FLOWVIEW.md
└─ AGENTS.md
```

---

## 📦 Dependencies

Required:

* Neovim ≥ 0.9
* LSP configured
* Tree-sitter parsers installed

Optional:

* `nui.nvim` (preferred for UI polish)

---

## 🧪 Manual Testing

1. Open TS project
2. Place cursor inside a function
3. Run:

```vim
:FlowView
```

4. Panel opens with expanded function
5. Expand nested calls
6. Navigate to implementations
7. Adjust depth
8. Validate no file jumping is required

---

## 🧠 Future Enhancements (Not MVP)

* Runtime call overlays (from tests)
* Coverage-aware flow paths
* AI summary mode
* “Explain this flow”
* Export flow to markdown
* Diff between two flows

---

## 🎯 MVP Definition

The MVP is considered complete when:

* Function body renders fully
* Nested calls expand inline
* LSP navigation works correctly
* Multiple implementations selectable
* Cycles prevented
* UI feels clean and responsive
* Works reliably on TS + JS

---

## ❗ Non-goals

* No AST rewriting
* No code execution
* No runtime tracing
* No AI dependency required

---

## ✅ Summary

`nvim-flowview` is not a call tree.

It is:

> “A visual execution narrative of your code.”

The plugin exists to help developers understand **what actually happens**, not merely where symbols live.
