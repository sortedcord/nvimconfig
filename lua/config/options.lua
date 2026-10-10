-- Options configuration
local opt = vim.opt

-- Disable unused legacy providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- Ensure Go tools in ~/go/bin are in PATH
local go_bin = vim.fn.expand("$HOME/go/bin")
if not vim.env.PATH:find(go_bin, 1, true) then
  vim.env.PATH = go_bin .. ":" .. vim.env.PATH
end

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance & UI
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- Windows & Splitting
opt.splitright = true
opt.splitbelow = true

-- Mouse & Clipboard
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- Fallback to OSC 52 clipboard when headless or over SSH without display
if vim.env.DISPLAY == nil and vim.env.WAYLAND_DISPLAY == nil then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
  if ok then
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = osc52.copy("+"),
        ["*"] = osc52.copy("*"),
      },
      paste = {
        ["+"] = osc52.paste("+"),
        ["*"] = osc52.paste("*"),
      },
    }
  end
end

-- Undo & Backup
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Update time (faster diagnostic update & git signs)
opt.updatetime = 250
opt.timeoutlen = 300

-- Go specific formatting: use actual tabs with width 4
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
