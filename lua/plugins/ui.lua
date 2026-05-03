return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      custom_highlights = function(c)
        return {
          Function       = { fg = c.blue },
          Identifier     = { fg = c.blue },
          ["@function"]  = { fg = c.blue },
          ["@function.builtin"] = { fg = c.blue },
          ["@function.method"]  = { fg = c.blue },
          ["@constructor"]      = { fg = c.blue },
          Type           = { fg = c.sapphire },
          Statement      = { fg = c.blue },
          Keyword        = { fg = c.blue },
          ["@keyword"]   = { fg = c.blue },
          Special        = { fg = c.sapphire },
          CursorLineNr   = { fg = c.blue, bold = true },
          MatchParen     = { fg = c.blue, bg = c.surface1, bold = true },
          Visual         = { bg = c.surface1 },
          Search         = { fg = c.base, bg = c.blue },
          IncSearch      = { fg = c.base, bg = c.sky },
          TelescopeBorder        = { fg = c.blue },
          TelescopeSelectionCaret = { fg = c.blue },
          TelescopeMatching      = { fg = c.blue },
          NeoTreeDirectoryIcon   = { fg = c.blue },
          NeoTreeDirectoryName   = { fg = c.blue },
          NeoTreeRootName        = { fg = c.blue, bold = true },
          BufferLineIndicatorSelected = { fg = c.blue },
        }
      end,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = { enabled = true },
        mason = true,
        which_key = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotree = true,
        snacks = { enabled = true, indent_scope_color = "lavender" },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "echasnovski/mini.icons",
    version = "*",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      indent = { enabled = true, animate = { enabled = false } },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 2500, style = "compact" },
      scope = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find file",   action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New file",    action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find text",   action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent",      action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config",      action = ":e $MYVIMRC" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",        action = ":Lazy" },
            { icon = " ", key = "m", desc = "Mason",       action = ":Mason" },
            { icon = " ", key = "q", desc = "Quit",        action = ":qa" },
          },
          header = table.concat({
            "",
            "  ██████╗ ██╗   ██╗██╗   ██╗██╗   ██╗██████╗ ███████╗██╗  ██╗ ",
            "  ██╔══██╗╚██╗ ██╔╝╚██╗ ██╔╝██║   ██║██╔══██╗██╔════╝██║ ██╔╝ ",
            "  ██████╔╝ ╚████╔╝  ╚████╔╝ ██║   ██║██████╔╝███████╗█████╔╝  ",
            "  ██╔═══╝   ╚██╔╝    ╚██╔╝  ██║   ██║██╔═══╝ ╚════██║██╔═██╗  ",
            "  ██║        ██║      ██║   ╚██████╔╝██║     ███████║██║  ██╗ ",
            "  ╚═╝        ╚═╝      ╚═╝    ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝ ",
          }, "\n"),
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    keys = {
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
      { "<leader>uN", function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bD", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin-mocha",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = { "diff", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "neo-tree", "lazy", "trouble", "mason", "toggleterm" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Close unpinned" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        indicator = { style = "icon", icon = "▎" },
        separator_style = "thin",
        offsets = {
          { filetype = "neo-tree", text = "Neo-tree", highlight = "Directory", text_align = "left", position = "right" },
        },
      },
      highlights = {
        buffer_selected = { bold = true, italic = false },
        indicator_selected = { fg = "#89b4fa" },
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline = { icon = " " },
          search_down = { icon = " " },
          search_up = { icon = " " },
          help = { icon = "󰋖 " },
          lua = { icon = " " },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = { enabled = false },
      },
      notify = { enabled = false },
      messages = { enabled = false },
      popupmenu = { enabled = true, backend = "nui" },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      routes = {
        { filter = { event = "msg_show", find = "is deprecated" }, opts = { skip = true } },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>a", group = "ai/claude" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find/file" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>q", group = "session" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "terminal/test" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps" },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      file_types = { "markdown", "Avante" },
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
    },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle render-markdown" },
    },
  },
}
