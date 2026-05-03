# nvim

Personal Neovim config. TypeScript-first, lazy-loaded, opinionated.

## Stack

- **Plugin manager** — [lazy.nvim](https://github.com/folke/lazy.nvim) (everything `lazy = true` by default)
- **Completion** — [blink.cmp](https://github.com/saghen/blink.cmp)
- **LSP** — `nvim-lspconfig` + `mason-lspconfig` (auto-install)
- **Format** — `conform.nvim` (biome → prettierd → stylua)
- **Lint** — `nvim-lint` (`eslint_d`)
- **Treesitter** — `main` branch
- **Theme** — Catppuccin Mocha
- **AI** — `claudecode.nvim`

## Install

```sh
git clone git@github.com:pyyupsk/nvim.git ~/.config/nvim
nvim   # lazy.nvim bootstraps + installs everything
```

Requires Neovim 0.11+, `git`, `make`, a Nerd Font, and `node` for some LSPs.

## Layout

```
init.lua               -- bootstrap
lua/config/
  options.lua          -- vim.opt
  keymaps.lua          -- pure-vim maps only
  autocmds.lua
  lazy.lua             -- lazy bootstrap + plugin import
lua/plugins/
  lsp.lua              -- mason, lspconfig, conform, lint
  completion.lua       -- blink.cmp
  editor.lua           -- autopairs, surround, flash, persistence, grug-far
  explorer.lua         -- neo-tree, oil
  git.lua              -- gitsigns, diffview
  telescope.lua
  treesitter.lua
  ui.lua               -- catppuccin, snacks, lualine, bufferline, noice, which-key, render-markdown
  claudecode.lua
lazy-lock.json         -- committed lockfile
```

## Keymaps

Leader: `<Space>` · Localleader: `\`

### Windows
| Key               | Action                          |
| ----------------- | ------------------------------- |
| `<C-h/j/k/l>`     | Move focus (normal/insert/term) |
| `<C-Up/Down/L/R>` | Resize window                   |

### Buffers
| Key            | Action               |
| -------------- | -------------------- |
| `<S-h>` / `<S-l>` | Prev / next buffer |
| `<Tab>` / `<S-Tab>` | Prev / next buffer |
| `<C-q>`        | Close buffer         |
| `<leader>bp`   | Pin buffer           |
| `<leader>bP`   | Close unpinned       |
| `<leader>bd`   | Delete buffer        |
| `<leader>bD`   | Delete other buffers |

### Files / search
| Key              | Action                |
| ---------------- | --------------------- |
| `<leader><spc>`  | Find files            |
| `<leader>fg`     | Live grep             |
| `<leader>fb`     | Buffers               |
| `<leader>fr`     | Recent files          |
| `<leader>fh`     | Help tags             |
| `<leader>fc`     | Commands              |
| `<leader>fk`     | Keymaps               |
| `<leader>fd`     | Diagnostics           |
| `<leader>fs`     | Document symbols      |
| `<leader>fS`     | Workspace symbols     |
| `<leader>sw`     | Word under cursor     |
| `<leader>sr`     | Resume search         |
| `<leader>sR`     | Search & replace      |
| `<leader>st`     | Todo list             |
| `s` / `S`        | Flash jump / TS jump  |

### Explorer
| Key          | Action                  |
| ------------ | ----------------------- |
| `<leader>e`  | Toggle neo-tree         |
| `<leader>fe` | Reveal file in neo-tree |
| `-`          | Open parent dir (oil)   |

### Code / LSP
| Key           | Action            |
| ------------- | ----------------- |
| `gd` `gr`     | Definition / refs |
| `gI`          | Implementation    |
| `K`           | Hover             |
| `<leader>ca`  | Code action       |
| `<leader>cr`  | Rename            |
| `<leader>cf`  | Format buffer     |
| `<leader>cd`  | Line diagnostics  |
| `[d` / `]d`   | Prev / next diagnostic |

### Diagnostics / Trouble
| Key           | Action              |
| ------------- | ------------------- |
| `<leader>xx`  | All diagnostics     |
| `<leader>xX`  | Buffer diagnostics  |
| `<leader>xs`  | Symbols             |
| `<leader>xl`  | LSP refs            |
| `<leader>xL`  | Location list       |
| `<leader>xQ`  | Quickfix            |

### Git
| Key           | Action          |
| ------------- | --------------- |
| `<leader>gd`  | Diffview        |
| `<leader>gh`  | File history    |
| `<leader>gH`  | Branch history  |
| `<leader>tg`  | Lazygit (float) |

### Terminal
| Key           | Action               |
| ------------- | -------------------- |
| `<C-\>`       | Toggle terminal      |
| `<leader>tf`  | Float terminal       |
| `<leader>th`  | Horizontal terminal  |
| `<leader>tv`  | Vertical terminal    |

### Editor
| Key           | Action                       |
| ------------- | ---------------------------- |
| `gcc` / `gc`  | Comment line / selection     |
| `<C-/>`       | Comment line / selection     |
| `ys` / `cs` / `ds` | Surround add/change/delete |
| `<C-d>`       | Multicursor: add next match  |
| `<C-S-d>`     | Multicursor: skip next match |
| `<leader>ma`  | Multicursor: select all      |
| `]t` / `[t`   | Next / prev TODO             |

### Session
| Key           | Action               |
| ------------- | -------------------- |
| `<leader>qs`  | Restore session      |
| `<leader>ql`  | Restore last session |
| `<leader>qd`  | Don't save session   |

### UI
| Key           | Action                   |
| ------------- | ------------------------ |
| `<leader>um`  | Toggle render-markdown   |
| `<leader>un`  | Dismiss notifications    |
| `<leader>uN`  | Notification history     |
| `<leader>?`   | Buffer keymaps (which-key) |

### AI (claudecode)
| Key           | Action         |
| ------------- | -------------- |
| `<leader>ac`  | Toggle Claude  |
| `<leader>af`  | Focus Claude   |
| `<leader>ar`  | Resume         |
| `<leader>ab`  | Add buffer     |
| `<leader>as`  | Send selection |
| `<leader>aa`  | Accept diff    |
| `<leader>ad`  | Deny diff      |

## Commands

- `:Lazy` — plugin UI · `:Lazy sync` — install/update/clean
- `:Mason` — tool installer
- `:LspInfo` · `:ConformInfo` · `:checkhealth`
- `:FormatToggle` — toggle auto-format on save (add `!` for buffer-local)

## License

[MIT](./LICENSE)
