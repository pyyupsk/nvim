return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
    },
  },

  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "echasnovski/mini.icons",
    },
    keys = {
      { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List issues" },
      { "<leader>gI", "<cmd>Octo issue create<cr>", desc = "Create issue" },
      { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gP", "<cmd>Octo pr create<cr>", desc = "Create PR" },
      { "<leader>gr", "<cmd>Octo review start<cr>", desc = "Start PR review" },
      { "<leader>gS", "<cmd>Octo search<cr>", desc = "Search GitHub" },
    },
    opts = {
      enable_builtin = true,
      picker = "telescope",
      use_local_fs = true,
    },
  },
}
