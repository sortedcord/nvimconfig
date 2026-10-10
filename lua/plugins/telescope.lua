return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        path_display = { "truncate" },
        file_ignore_patterns = { "node_modules", ".git/", "vendor/" },
      },
    },
  },
}
