local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search" })
map("i", "jk", "<Esc>", { desc = "Exit insert" })

map({ "n", "v", "i" }, "<C-h>", "<Esc><C-w>h", { desc = "Window left" })
map({ "n", "v", "i" }, "<C-j>", "<Esc><C-w>j", { desc = "Window down" })
map({ "n", "v", "i" }, "<C-k>", "<Esc><C-w>k", { desc = "Window up" })
map({ "n", "v", "i" }, "<C-l>", "<Esc><C-w>l", { desc = "Window right" })

map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Window left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Window down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Window up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Window right" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Resize up" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Resize down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize right" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<C-q>", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })

map("n", "n", "nzzzv", { desc = "Next match center" })
map("n", "N", "Nzzzv", { desc = "Prev match center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

map({ "n", "x" }, "<leader>p", [["_dP]], { desc = "Paste without yank" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yank" })

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })

map("n", "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "Make executable", silent = true })

map({ "n" }, "<C-/>", "gcc", { desc = "Comment line", remap = true })
map({ "n" }, "<C-_>", "gcc", { desc = "Comment line", remap = true })
map("v", "<C-/>", "gc", { desc = "Comment selection", remap = true })
map("v", "<C-_>", "gc", { desc = "Comment selection", remap = true })
map("i", "<C-/>", "<Esc>gcc", { desc = "Comment line", remap = true })
map("i", "<C-_>", "<Esc>gcc", { desc = "Comment line", remap = true })

map("n", "q", "<nop>", { desc = "Disable macro recording" })
map("n", "Q", "<nop>", { desc = "Disable Ex mode" })

map("n", "gx", function()
  local url = vim.fn.expand("<cfile>")
  vim.ui.open(url)
  Snacks.notify.info("Opened: " .. url, { title = "Browser" })
end, { desc = "Open URL" })
