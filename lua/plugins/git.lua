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
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    keys = {
      { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "CodeDiff (status)" },
      { "<leader>gD", "<cmd>CodeDiff file HEAD<cr>", desc = "CodeDiff vs HEAD" },
      { "<leader>gh", "<cmd>CodeDiff history<cr>", desc = "File history" },
    },
  },

  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
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
      picker = "snacks",
      use_local_fs = true,
    },
  },
}
