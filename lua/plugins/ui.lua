return {
  -- File icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        icons_enabled = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view = {
        width = 32,
        side = "left",
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
      },
      git = {
        enable = true,
        ignore = false,
      },
    },
  },

  -- Keymap discovery helper
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader><leader>", desc = "Find project files" },
        { "<leader>e", desc = "Toggle file explorer" },
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code / LSP" },
        { "<leader>d", group = "Debugger (DAP)" },
        { "<leader>f", group = "Find / Telescope" },
        { "<leader>g", group = "Go Tools" },
        { "<leader>h", group = "Git Hunks" },
        { "<leader>t", group = "Toggles" },
      })
    end,
  },
}
