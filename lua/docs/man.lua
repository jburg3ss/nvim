local keymap = vim.keymap

-- Open man pages for the word under the cursor in a vertical split
keymap.set("n", "<leader>cm", function()
  local word = vim.fn.expand "<cword>"
  vim.cmd("vert Man " .. word)
end)

-- -- Open man search input in a vertical split
-- keymap.set("n", "<leader>cc", function()
--   vim.cmd("vert Man")
-- end)
