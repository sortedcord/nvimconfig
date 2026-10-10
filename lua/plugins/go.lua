return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
    ft = { "go", "gomod", "gowork", "gosum" },
    config = function()
      require("go").setup({
        go = "go",
        goimports = "gopls",
        gofmt = "gofumpt",
        lsp_cfg = false, -- Handled centrally in lsp.lua
        lsp_gofumpt = true,
        lsp_keymaps = false, -- Handled by our UserLspConfig and custom keymaps
        lsp_codelens = true,
        lsp_inlay_hints = {
          enable = true,
          style = "inlay",
          only_current_line = false,
          show_variable_name = true,
          parameter_hints_prefix = "󰊕 ",
          show_parameter_hints = true,
          other_hints_prefix = "=> ",
        },
        diagnostic = {
          hdlr = true,
          underline = true,
          virtual_text = { space = 0, prefix = "●" },
          signs = true,
        },
        dap_debug = true,
        dap_debug_gui = true,
        dap_debug_keymap = false, -- Handled in dap.lua
        dap_debug_vt = true,
        floaterm = {
          positon = "auto",
          width = 0.85,
          height = 0.85,
          title_colors = "tokyonight",
        },
        test_runner = "go",
        verbose = false,
      })

      -- Format & organize imports on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormatOnSave", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        group = format_sync_grp,
        callback = function()
          require("go.format").goimports()
        end,
      })
    end,
  },
}
