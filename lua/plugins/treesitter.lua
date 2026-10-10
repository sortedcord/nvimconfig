return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "lua",
        "vim",
        "vimdoc",
        "json",
        "yaml",
        "bash",
        "markdown",
      }

      local ok, ts = pcall(require, "nvim-treesitter")
      if ok then
        local ts_config = require("nvim-treesitter.config")
        local installed = ts_config.get_installed()
        local to_install = {}
        for _, p in ipairs(parsers) do
          if not vim.tbl_contains(installed, p) then
            table.insert(to_install, p)
          end
        end
        if #to_install > 0 then
          ts.install(to_install)
        end
      end

      -- Enable treesitter highlighting and indentation on supported files
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
