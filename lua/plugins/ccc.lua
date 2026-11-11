return {
  {
    "uga-rosa/ccc.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },
}
