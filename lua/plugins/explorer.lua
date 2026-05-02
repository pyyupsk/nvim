return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
      { "<leader>fe", "<cmd>Neotree reveal<cr>", desc = "Reveal in explorer" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    deactivate = function() vim.cmd([[Neotree close]]) end,
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("neotree_start", { clear = true }),
        once = true,
        callback = function()
          local argv0 = vim.fn.argv(0)
          if type(argv0) ~= "string" or argv0 == "" then return end
          local path = vim.fn.fnamemodify(argv0, ":p")
          if vim.fn.isdirectory(path) ~= 1 then return end

          vim.cmd("cd " .. vim.fn.fnameescape(path))
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.api.nvim_buf_get_name(b)
            if name == path or name == path:gsub("/$", "") then
              pcall(vim.api.nvim_buf_delete, b, { force = true })
            end
          end
          vim.schedule(function()
            local ok, snacks = pcall(require, "snacks")
            if ok and snacks.dashboard then snacks.dashboard.open() end
            require("neo-tree.command").execute({ action = "show", source = "filesystem", position = "right" })
            vim.cmd("wincmd p")
          end)
        end,
      })

      vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("neotree_git_refresh", { clear = true }),
        callback = function()
          if package.loaded["neo-tree.sources.manager"] then
            pcall(require("neo-tree.sources.manager").refresh, "git_status")
            pcall(require("neo-tree.sources.manager").refresh, "filesystem")
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "neo-tree" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = { ".DS_Store", "thumbs.db", "node_modules" },
          never_show = {},
        },
      },
      window = {
        position = "right",
        width = 32,
        mappings = {
          ["<space>"] = "none",
          ["Y"] = function(state)
            local node = state.tree:get_node()
            vim.fn.setreg("+", node.path, "c")
          end,
        },
      },
      default_component_configs = {
        indent = { with_expanders = true, expander_collapsed = "", expander_expanded = "" },
        git_status = {
          symbols = {
            added = "✚", modified = "", deleted = "✖", renamed = "󰁕",
            untracked = "", ignored = "", unstaged = "󰄱", staged = "", conflict = "",
          },
        },
      },
    },
  },
}
