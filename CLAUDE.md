# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repo

Personal Neovim config. Lua. Plugin manager: `lazy.nvim`. Leader: `<Space>`, localleader: `\`.

## Layout

- `init.lua` — bootstrap; loads `config.{options,keymaps,autocmds,lazy}` in order.
- `lua/config/lazy.lua` — clones lazy.nvim, imports `plugins/` spec, defaults `lazy = true, version = false`. Colorschemes installed: `catppuccin`, `habamax`.
- `lua/config/{options,keymaps,autocmds}.lua` — editor-wide settings, no plugin logic.
- `lua/plugins/*.lua` — one file per concern (`lsp`, `completion`, `editor`, `explorer`, `git`, `telescope`, `treesitter`, `ui`, `claudecode`). Each returns a lazy spec table; lazy auto-imports them.
  - `editor.lua` also owns session restore (`persistence.nvim`, `<leader>q*`) and project search/replace (`grug-far.nvim`, `<leader>sR`).
  - `ui.lua` owns markdown rendering (`render-markdown.nvim`, `<leader>um`).
- `lazy-lock.json` — committed lockfile; do not hand-edit.

## LSP / Tooling Architecture (`lua/plugins/lsp.lua`)

Single file owns the full toolchain — keep additions here, not split.

- **Mason** installs CLI tools via `ensure_installed` (formatters/linters: `biome`, `eslint_d`, `prettierd`, `stylua`, `shfmt`).
- **mason-lspconfig** auto-installs every key in the `servers` table, then enables them. To add a server: add a key under `servers` with its config — install + enable is automatic.
- Server config uses Neovim 0.11 `vim.lsp.config(name, cfg)` API (not the old `lspconfig.<name>.setup`). Capabilities come from `blink.cmp`.
- Keymaps and inlay-hint enable live in the `LspAttach` autocmd — not per-server.
- **conform.nvim** does formatting; chain order matters (`{ "biome", "prettierd", stop_after_first = true }` → biome wins when present). `format_on_save` respects `vim.g.disable_autoformat` / `vim.b.disable_autoformat`; toggle with `:FormatToggle` (buffer-local with `!`).
- **nvim-lint** runs `eslint_d` on `BufReadPost`/`BufWritePost`/`InsertLeave`.

Completion is `blink.cmp` (see `completion.lua`); LSP capabilities flow from there into every server via `vim.lsp.config("*", { capabilities })`.

## Commands

- Apply changes — restart Neovim, or `:Lazy reload <plugin>` for a single spec.
- Sync plugins — `:Lazy sync` (install + update + clean). `:Lazy` opens the UI.
- Tools — `:Mason`, `:LspInfo`, `:ConformInfo`, `:checkhealth`.
- Format current buffer — `<leader>cf` (or `:lua require("conform").format()`).
- Headless smoke test — `nvim --headless "+Lazy! sync" +qa` (also runs in CI-style checks).

## Conventions

- Keymaps that target plugin commands belong in that plugin's `keys = { ... }` spec (so they trigger lazy-load), not `lua/config/keymaps.lua`. `keymaps.lua` is for pure-vim/builtin maps only.
- Plugin spec style: prefer `opts = { ... }` over a `config` function. Use `config = function(_, opts)` only when setup needs imperative work (autocmds, custom registries, `vim.lsp.config` loops).
- Trigger lazy-loading via `event` / `cmd` / `keys` / `ft` — avoid `lazy = false` unless the plugin must load at startup (colorscheme is the typical exception).
- 2-space indent, double-quoted strings, no trailing semicolons — match the existing files.
