local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.numberwidth = 3
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.splitright = true
opt.splitbelow = true

opt.termguicolors = true
opt.background = "dark"
opt.pumheight = 12
opt.pumblend = 10
opt.winblend = 0

opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.backup = false
opt.updatetime = 200
opt.timeoutlen = 400

opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.confirm = true
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append("WcC")
opt.fillchars = { eob = " ", fold = " ", foldsep = " " }

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.laststatus = 3
opt.cmdheight = 1

vim.g.have_nerd_font = true
vim.g.js_runtime = "bun" -- "node" | "bun" | "deno"
