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
  lsp.lua              -- mason, lspconfig, conform, lint, tailwind-tools
  completion.lua       -- blink.cmp
  editor.lua           -- autopairs, surround, comment, flash, persistence, grug-far
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

### Files / search
| Key             | Action                |
| --------------- | --------------------- |
| `<leader><spc>` | Find files            |
| `<leader>fg`    | Live grep             |
| `<leader>fb`    | Buffers               |
| `<leader>fr`    | Recent files          |
| `<leader>sw`    | Word under cursor     |
| `<leader>sR`    | Search & replace      |
| `s` / `S`       | Flash jump / TS jump  |

### Code / LSP
| Key          | Action            |
| ------------ | ----------------- |
| `gd` `gr`    | Definition / refs |
| `K`          | Hover             |
| `<leader>cf` | Format buffer     |
| `<leader>la` | Code action       |
| `<leader>lr` | Rename            |
| `<leader>cT` | Sort Tailwind     |

### AI (claudecode)
| Key          | Action          |
| ------------ | --------------- |
| `<leader>ac` | Toggle Claude   |
| `<leader>af` | Focus Claude    |
| `<leader>ar` | Resume          |
| `<leader>ab` | Add buffer      |
| `<leader>as` | Send selection  |
| `<leader>aa` | Accept diff     |
| `<leader>ad` | Deny diff       |

### Misc
| Key          | Action               |
| ------------ | -------------------- |
| `<leader>e`  | Explorer (neo-tree)  |
| `<leader>gd` | Diffview             |
| `<leader>qs` | Restore session      |
| `<leader>um` | Toggle render-markdown |
| `<leader>?`  | Buffer keymaps       |

## Commands

- `:Lazy` — plugin UI · `:Lazy sync` — install/update/clean
- `:Mason` — tool installer
- `:LspInfo` · `:ConformInfo` · `:checkhealth`

## License

[MIT](./LICENSE)
