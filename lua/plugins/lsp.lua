return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "lazy.nvim", words = { "LazyPlugin" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 100,
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ui = { border = "rounded" },
      ensure_installed = {
        "biome",
        "eslint_d",
        "prettierd",
        "stylua",
        "shfmt",
        "jdtls",
        "google-java-format",
        "gofumpt",
        "goimports",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({ event = "FileType", buf = vim.api.nvim_get_current_buf() })
        end, 100)
      end)
      local function ensure()
        for _, tool in ipairs(opts.ensure_installed) do
          local ok, p = pcall(mr.get_package, tool)
          if ok and not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure)
      else
        ensure()
      end
    end,
  },

  { "williamboman/mason-lspconfig.nvim", lazy = true },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    opts = function()
      return {
        diagnostics = {
          virtual_text = { prefix = "●", spacing = 4, source = "if_many" },
          severity_sort = true,
          underline = true,
          update_in_insert = false,
          float = { border = "rounded", source = "if_many" },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            },
          },
        },
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                completion = { callSnippet = "Replace" },
                hint = { enable = true },
              },
            },
          },
          vtsls = {
            settings = {
              typescript = {
                inlayHints = {
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  variableTypes = { enabled = false },
                  propertyDeclarationTypes = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  enumMemberValues = { enabled = true },
                },
              },
              vtsls = { experimental = { completion = { enableServerSideFuzzyMatch = true } } },
            },
          },
          eslint = { settings = { workingDirectories = { mode = "auto" } } },
          biome = {},
          tailwindcss = {
            filetypes = {
              "html",
              "css",
              "scss",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "svelte",
              "astro",
            },
          },
          cssls = {},
          html = {},
          jsonls = {},
          yamlls = {},
          bashls = {},
          dockerls = {},
          docker_compose_language_service = {},
          marksman = {},
          prismals = {},
          vue_ls = {
            init_options = { vue = { hybridMode = false } },
          },
          gopls = {
            settings = {
              gopls = {
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            },
          },
          basedpyright = {},
          rust_analyzer = {},
          clangd = {},
        },
      }
    end,
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(ev)
          local bufnr = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
          end
          map("gd", "<cmd>Telescope lsp_definitions<cr>", "Definition")
          map("gD", vim.lsp.buf.declaration, "Declaration")
          map("gr", "<cmd>Telescope lsp_references<cr>", "References")
          map("gI", "<cmd>Telescope lsp_implementations<cr>", "Implementation")
          map("gy", "<cmd>Telescope lsp_type_definitions<cr>", "Type definition")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>lr", vim.lsp.buf.rename, "Rename")
          map("<leader>la", vim.lsp.buf.code_action, "Code action")
          map("<leader>ld", vim.diagnostic.open_float, "Line diagnostic")
          map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, "Prev diagnostic")
          map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, "Next diagnostic")

          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })

      vim.lsp.config("*", { capabilities = capabilities })

      local servers = opts.servers
      for server, cfg in pairs(servers) do
        vim.lsp.config(server, cfg)
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        automatic_enable = { exclude = { "ts_ls", "jdtls" } },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        javascript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        javascriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        typescript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        typescriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        vue = { "oxfmt", "prettierd", stop_after_first = true },
        svelte = { "prettierd" },
        astro = { "prettierd" },
        json = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        jsonc = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        css = { "prettierd" },
        scss = { "prettierd" },
        html = { "prettierd" },
        markdown = { "prettierd" },
        yaml = { "prettierd" },
        java = { "google-java-format" },
        go = { "goimports", "gofumpt" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1500, lsp_format = "fallback" }
      end,
    },
    init = function()
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
      end, { desc = "Toggle autoformat", bang = true })
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local function start()
        local root = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" })
        local name = vim.fn.fnamemodify(root or vim.fn.getcwd(), ":p:h:t")
        local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. name
        require("jdtls").start_or_attach({
          cmd = { vim.fn.exepath("jdtls"), "-data", workspace },
          root_dir = root,
          capabilities = require("blink.cmp").get_lsp_capabilities(),
          settings = {
            java = {
              signatureHelp = { enabled = true },
              inlayHints = { parameterNames = { enabled = "all" } },
              completion = { favoriteStaticMembers = { "org.junit.jupiter.api.Assertions.*" } },
            },
          },
        })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_jdtls", { clear = true }),
        pattern = "java",
        callback = start,
      })

      if vim.bo.filetype == "java" then
        start()
      end
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        svelte = { "eslint_d" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
