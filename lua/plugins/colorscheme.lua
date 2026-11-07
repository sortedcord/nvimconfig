return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
        on_colors = function(colors)
          -- Match the ANSI palette and foreground from ~/.config/kitty/colors.conf.
          colors.bg = "#0e1017"
          colors.fg = "#787c99"
          colors.fg_dark = "#787c99"
          colors.fg_gutter = "#444b6a"
          colors.black = "#24283b"
          colors.terminal_black = "#444b6a"
          colors.red = "#f7768e"
          colors.red1 = "#f7768e"
          colors.green = "#41a6b5"
          colors.green2 = "#41a6b5"
          colors.yellow = "#e0af68"
          colors.blue = "#7aa2f7"
          colors.magenta = "#bb9af7"
          colors.cyan = "#7dcfff"

          colors.terminal = {
            black = "#24283b",
            black_bright = "#444b6a",
            red = "#f7768e",
            red_bright = "#f7768e",
            green = "#41a6b5",
            green_bright = "#41a6b5",
            yellow = "#e0af68",
            yellow_bright = "#e0af68",
            blue = "#7aa2f7",
            blue_bright = "#7aa2f7",
            magenta = "#bb9af7",
            magenta_bright = "#bb9af7",
            cyan = "#7dcfff",
            cyan_bright = "#7dcfff",
            white = "#787c99",
            white_bright = "#d5d6db",
          }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
