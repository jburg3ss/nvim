-- ============================================================================
-- LSP
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Disable semantic tokens (use Treesitter instead)",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor position when reopening files",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local name = vim.api.nvim_buf_get_name(0)

    -- Skip Oil virtual paths
    if name:match "^oil://" then
      return
    end

    local dir = vim.fn.expand "<afile>:p:h"
    if dir ~= "" then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- ============================================================================
-- VISUAL FEEDBACK
-- ============================================================================

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text briefly",
  callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 } end,
})

vim.api.nvim_create_user_command(
  "ArduinoSerial",
  function() vim.cmd "split | terminal picocom /dev/ttyACM0 -b 9600" end,
  {}
)

-- ============================================================================
-- AUTO-RELOAD
-- ============================================================================
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  desc = "Auto-reload files changed outside vim",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd "checktime"
    end
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*/devdocs/docs/*/*.md",
  callback = function()
    local file = vim.fn.expand "%:p"
    vim.cmd "enew"
    vim.fn.termopen("glow " .. vim.fn.shellescape(file))
    vim.cmd "startinsert"
  end,
})

-- ============================================================================
-- AUTO-COMMIT
-- ============================================================================

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand "%:p:h"
    -- Only if inside a git repo
    if
      vim.fn.system("git -C " .. dir .. " rev-parse --is-inside-work-tree 2>/dev/null"):match "true"
    then
      local file = vim.fn.expand "%:p"
      vim.fn.system("git add " .. file)
      vim.fn.system('git commit -m "auto: update ' .. vim.fn.expand "%:t" .. '"')
      vim.fn.system "git push"
    end
  end,
})
