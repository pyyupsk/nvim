-- bootstrap
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable netrw (using neo-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
