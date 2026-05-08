return {
  {
    "Exafunction/windsurf.vim",
    event = "InsertEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1
      local map = vim.keymap.set
      map("i", "<M-y>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true, desc = "Codeium: accept" })
      map("i", "<M-w>", function() return vim.fn["codeium#AcceptNextWord"]() end, { expr = true, silent = true, desc = "Codeium: accept word" })
      map("i", "<M-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true, desc = "Codeium: next" })
      map("i", "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true, desc = "Codeium: prev" })
      map("i", "<M-e>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true, desc = "Codeium: clear" })
      map("n", "<leader>ua", "<cmd>CodeiumToggle<cr>", { desc = "Toggle AI suggestions" })
    end,
  },

  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
    dependencies = { "rafamadriz/friendly-snippets", "folke/lazydev.nvim" },
    opts = {
      keymap = { preset = "enter" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
          },
        },
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      signature = { enabled = true, window = { border = "rounded" } },
    },
    opts_extend = { "sources.default" },
  },
}
