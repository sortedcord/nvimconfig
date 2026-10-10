-- ============================================================================
-- Keymaps Configuration
-- All keybindings are centralized here.
-- ============================================================================

local map = vim.keymap.set
local M = {}

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ----------------------------------------------------------------------------
-- General & Navigation
-- ----------------------------------------------------------------------------
-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Quick save & quit
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize window with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete current buffer" })

-- Move lines up and down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Better indenting in visual mode (keeps selection)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- File explorer toggle
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- ----------------------------------------------------------------------------
-- Find / Telescope (<leader>f and <leader><leader>)
-- ----------------------------------------------------------------------------
map("n", "<leader><leader>", function()
  local builtin = require("telescope.builtin")
  local ok = pcall(builtin.git_files, { show_untracked = true })
  if not ok then
    builtin.find_files()
  end
end, { desc = "Find project files" })

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep (search text)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Workspace symbols" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })

-- ----------------------------------------------------------------------------
-- Debugger (DAP) (<leader>d and F-keys)
-- ----------------------------------------------------------------------------
map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Start / Continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Conditional Breakpoint" })
map("n", "<leader>dt", function() require("dap-go").debug_test() end, { desc = "Debug: Test under cursor" })
map("n", "<leader>dl", function() require("dap-go").debug_last_test() end, { desc = "Debug: Last test" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Debug: Open REPL" })
map("n", "<leader>dc", function() require("dap").terminate() end, { desc = "Debug: Terminate session" })

-- ----------------------------------------------------------------------------
-- Go Workflows (<leader>g)
-- ----------------------------------------------------------------------------
local go_opts = function(desc)
  return { silent = true, desc = desc }
end
map("n", "<leader>gt", "<cmd>GoTest<CR>", go_opts("Run package tests"))
map("n", "<leader>gf", "<cmd>GoTestFunc<CR>", go_opts("Run test function"))
map("n", "<leader>gT", "<cmd>GoTestFile<CR>", go_opts("Run test file"))
map("n", "<leader>gc", "<cmd>GoCoverageToggle<CR>", go_opts("Toggle test coverage"))
map("n", "<leader>ga", "<cmd>GoAddTag json<CR>", go_opts("Add json tags"))
map("n", "<leader>gr", "<cmd>GoRmTag<CR>", go_opts("Remove struct tags"))
map("n", "<leader>ge", "<cmd>GoIfErr<CR>", go_opts("Generate if err != nil"))
map("n", "<leader>gi", "<cmd>GoImpl<CR>", go_opts("Implement interface"))
map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", go_opts("Fill struct fields"))
map("n", "<leader>gS", "<cmd>GoFillSwitch<CR>", go_opts("Fill switch cases"))
map("n", "<leader>gm", "<cmd>GoModTidy<CR>", go_opts("Go mod tidy"))
map("n", "<leader>gA", "<cmd>GoAlt<CR>", go_opts("Toggle test/code file"))
map("n", "<leader>gd", "<cmd>GoDoc<CR>", go_opts("View Go doc in float"))
map("n", "<leader>gl", "<cmd>GoLint<CR>", go_opts("Run golangci-lint"))
map("n", "<leader>gv", "<cmd>GoVet<CR>", go_opts("Run go vet"))

-- ----------------------------------------------------------------------------
-- Global Diagnostics
-- ----------------------------------------------------------------------------
map("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })

-- ----------------------------------------------------------------------------
-- LSP Keymaps (Buffer-local, attaches via LspAttach autocommand)
-- ----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    bufmap("n", "gr", vim.lsp.buf.references, "Go to references")
    bufmap("n", "gt", vim.lsp.buf.type_definition, "Type definition")
    bufmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
    bufmap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
    bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    bufmap("v", "<leader>ca", vim.lsp.buf.code_action, "Code action (range)")
    bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    bufmap("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format code")

    -- Inlay hints toggle
    if client and client.server_capabilities.inlayHintProvider then
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      bufmap("n", "<leader>th", function()
        if vim.lsp.inlay_hint then
          local current = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
          vim.lsp.inlay_hint.enable(not current, { bufnr = bufnr })
        end
      end, "Toggle inlay hints")
    end
  end,
})

-- ----------------------------------------------------------------------------
-- Git Keymaps (Invoked by Gitsigns on_attach)
-- ----------------------------------------------------------------------------
function M.gitsigns_attach(bufnr)
  local gs = require("gitsigns")
  local bufmap = function(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
  end

  -- Navigation
  bufmap("n", "]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, "Next Git hunk")

  bufmap("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, "Previous Git hunk")

  -- Actions
  bufmap("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
  bufmap("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
  bufmap("v", "<leader>hs", function()
    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "Stage selected hunk")
  bufmap("v", "<leader>hr", function()
    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "Reset selected hunk")
  bufmap("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
  bufmap("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
  bufmap("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
  bufmap("n", "<leader>hb", function()
    gs.blame_line({ full = true })
  end, "Blame line")
  bufmap("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
  bufmap("n", "<leader>hd", gs.diffthis, "Diff this")
end

return M
