local keymap = vim.keymap

-- ============================================================================
-- NAVIGATION
-- ============================================================================

-- Start of line
keymap.set("n", "<C-a>", "0", { silent = true })
keymap.set("i", "<C-a>", "<ESC>0i", { silent = true })

-- End of line
keymap.set("n", "<C-e>", function()
	vim.o.virtualedit = "onemore"
	local row = vim.fn.line(".")
	local line = vim.fn.getline(".")
	vim.api.nvim_win_set_cursor(0, { row, #line })
end, { silent = true })
keymap.set("i", "<C-e>", "<ESC>$a", { silent = true })

-- Jump back one word
keymap.set("n", "<C-f>", "b", { silent = true })
keymap.set("i", "<C-f>", "<ESC>bi", { silent = true })

-- Jump forward one word
keymap.set("n", "<C-k>", "<ESC>wi", { silent = true })

-- Scroll up/down half page and center cursor
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Center cursor after search jumps
keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Jump back/forward in jump list
keymap.set("n", "<leader>j", "<C-o>", { noremap = true, silent = true, desc = "Jump back" })
keymap.set("n", "<leader>k", "<C-i>", { noremap = true, silent = true, desc = "Jump forward" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================

-- Save and quit
keymap.set("n", "<leader>s", ":wq<CR>", { noremap = true, silent = true, desc = "Save and quit" })

-- Save without quitting
keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save" })

-- Quit without saving
keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })

-- ============================================================================
-- BUFFER MANAGEMENT (Telescope pickers)
-- ============================================================================

-- List and switch buffers with Telescope
keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { silent = true, desc = "List buffers" })

-- Previous/next buffer
keymap.set("n", "<leader>,", ":bp<CR>", { silent = true, desc = "Previous buffer" })
keymap.set("n", "<leader>.", ":bn<CR>", { silent = true, desc = "Next buffer" })

-- Delete buffer
keymap.set("n", "<leader>x", ":bd!<CR>", { silent = true, desc = "Delete buffer" })

-- Close all buffers except current
keymap.set("n", "<leader>X", ":%bd|e#|bd#<CR>", { silent = true, desc = "Close other buffers" })

-- ============================================================================
-- TELESCOPE PICKERS
-- ============================================================================

-- Find files
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- Live grep (search in files)
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })

-- Recent files
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Help tags
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- ============================================================================
-- EDITING
-- ============================================================================

-- Delete word before cursor
keymap.set("n", "d9", "dvb", { noremap = true })

-- Keep visual selection when indenting
keymap.set("v", "<", "<gv", { noremap = true, silent = true })
keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Move lines up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- ============================================================================
-- CLIPBOARD BEHAVIOR
-- ============================================================================

-- Prevent delete from adding to clipboard
keymap.set("n", "d", '"_d', { noremap = true, silent = true })
keymap.set("x", "d", '"_d', { noremap = true, silent = true })
keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- Delete to clipboard (when you actually want it)
keymap.set("n", "<leader>d", "d", { noremap = true, silent = true, desc = "Delete to clipboard" })
keymap.set("x", "<leader>d", "d", { noremap = true, silent = true, desc = "Delete to clipboard" })

-- ============================================================================
-- UI/VISUAL
-- ============================================================================

-- Clear search highlights
keymap.set("n", "<leader>l", ":nohlsearch<CR>", { silent = true, desc = "Clear highlights" })

-- ============================================================================
-- LSP (with Telescope integration)
-- ============================================================================

-- Go to declaration (not using Telescope)
keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })

-- Go to definition (Telescope)
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition" })

-- Go to type definition (Telescope)
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Go to type definition" })

-- Go to implementation (Telescope)
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Go to implementation" })

-- Find references (Telescope)
keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Find references" })

-- Document symbols (Telescope)
keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })

-- Workspace symbols (Telescope)
keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })

-- Hover documentation
keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover documentation" })

-- Rename symbol
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename" })

-- Code actions
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code action" })

-- Format buffer
keymap.set("n", "<leader>cf", function()
	vim.lsp.buf.format({ async = false })
end, { noremap = true, silent = true, desc = "Format" })

-- Diagnostics (Telescope)
keymap.set("n", "<leader>td", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })

-- ============================================================================
-- SPELL CHECKING
-- ============================================================================

-- Auto-fix spelling with top suggestion
keymap.set("n", "<leader>sf", "1z=", { noremap = true, silent = true, desc = "Fix spelling" })

-- Show all suggestions
keymap.set("n", "<leader>ss", "z=", { noremap = true, silent = true, desc = "Spelling suggestions" })

-- Add word to dictionary
keymap.set("n", "<leader>sa", "zg", { noremap = true, silent = true, desc = "Add to dictionary" })

-- Jump to next/prev spelling error
keymap.set("n", "]s", "]s", { noremap = true, silent = true, desc = "Next spelling error" })
keymap.set("n", "[s", "[s", { noremap = true, silent = true, desc = "Previous spelling error" })
