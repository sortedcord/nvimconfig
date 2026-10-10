return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {},
        automatic_installation = true,
      })

      -- Diagnostic signs
      local signs = { Error = "✘ ", Warn = "▲ ", Hint = "⚑ ", Info = "ℹ " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure gopls
      local gopls_config = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        capabilities = capabilities,
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
              shadow = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
            semanticTokens = true,
          },
        },
      }

      if vim.lsp.config then
        vim.lsp.config("gopls", gopls_config)
        vim.lsp.enable("gopls")
      else
        require("lspconfig").gopls.setup(gopls_config)
      end

      -- Enable golangci-lint-langserver if binary exists
      if vim.fn.executable("golangci-lint-langserver") == 1 then
        local golangci_config = {
          cmd = { "golangci-lint-langserver" },
          filetypes = { "go", "gomod" },
          root_markers = { ".golangci.yml", ".golangci.yaml", "go.work", "go.mod", ".git" },
          capabilities = capabilities,
          init_options = {
            command = {
              "golangci-lint",
              "run",
              "--output.json.format=stdout",
              "--show-stats=false",
              "--issues-exit-code=1",
            },
          },
        }
        if vim.lsp.config then
          vim.lsp.config("golangci_lint_ls", golangci_config)
          vim.lsp.enable("golangci_lint_ls")
        else
          require("lspconfig").golangci_lint_ls.setup(golangci_config)
        end
      end
    end,
  },
}
