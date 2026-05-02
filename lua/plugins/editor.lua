return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true, fast_wrap = {} },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    version = "*",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle" },
      { "gb", mode = { "n", "v" }, desc = "Comment block" },
      { "<C-/>", "<Plug>(comment_toggle_linewise_current)", mode = "n", desc = "Comment line" },
      { "<C-_>", "<Plug>(comment_toggle_linewise_current)", mode = "n", desc = "Comment line" },
      { "<C-/>", "<Plug>(comment_toggle_linewise_visual)", mode = "v", desc = "Comment selection" },
      { "<C-_>", "<Plug>(comment_toggle_linewise_visual)", mode = "v", desc = "Comment selection" },
      { "<C-/>", "<Esc><Plug>(comment_toggle_linewise_current)", mode = "i", desc = "Comment line" },
      { "<C-_>", "<Esc><Plug>(comment_toggle_linewise_current)", mode = "i", desc = "Comment line" },
    },
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo list" },
    },
    opts = {},
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP refs" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
    },
    opts = {},
  },

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical terminal" },
      { "<leader>tg", function()
        local Terminal = require("toggleterm.terminal").Terminal
        Terminal:new({ cmd = "lazygit", direction = "float", hidden = true }):toggle()
      end, desc = "Lazygit" },
    },
    opts = {
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = { border = "rounded" },
      shade_terminals = true,
      start_in_insert = true,
      shell = vim.o.shell,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function(args)
          local name = vim.api.nvim_buf_get_name(args.buf)
          if name:find("claude") then
            vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { buffer = args.buf, desc = "Back to editor" })
            return
          end
          local o = { buffer = args.buf }
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], o)
          vim.keymap.set("t", "jk", [[<C-\><C-n>]], o)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], o)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], o)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], o)
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], o)
        end,
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent dir" } },
    opts = {
      default_file_explorer = false,
      view_options = { show_hidden = true },
      keymaps = { ["q"] = "actions.close" },
    },
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200, providers = { "lsp", "treesitter", "regex" } },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        css = true,
        css_fn = true,
        tailwind = true,
        names = false,
      },
    },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      local map = vim.keymap.set
      map({ "n", "v" }, "<C-d>", function() mc.matchAddCursor(1) end, { desc = "MC: add next match" })
      map({ "n", "v" }, "<C-S-d>", function() mc.matchSkipCursor(1) end, { desc = "MC: skip next match" })
      map({ "n", "v" }, "<leader>ma", function() mc.matchAllAddCursors() end, { desc = "MC: select all matches" })
      map({ "n", "v" }, "<C-Down>", function() mc.lineAddCursor(1) end, { desc = "MC: cursor below" })
      map({ "n", "v" }, "<C-Up>", function() mc.lineAddCursor(-1) end, { desc = "MC: cursor above" })
      map({ "n", "v" }, "<C-LeftMouse>", mc.handleMouse, { desc = "MC: add cursor (click)" })
      map("n", "<Esc>", function()
        if not mc.cursorsEnabled() then mc.enableCursors()
        elseif mc.hasCursors() then mc.clearCursors()
        else vim.cmd("nohlsearch") end
      end, { desc = "Clear cursors / search" })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash TS" },
      { "<C-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle flash search" },
    },
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save session" },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    opts = {},
    keys = {
      { "<leader>sR", function() require("grug-far").open() end, desc = "Search & replace" },
      { "<leader>sR", function() require("grug-far").with_visual_selection() end, mode = "v", desc = "Search & replace selection" },
    },
  },
}
