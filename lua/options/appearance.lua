local cmd = vim.cmd

vim.cmd.colorscheme "moonfly"

vim.o.winborder = "rounded"
vim.opt.guicursor = "a:block"

vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#00FF00" }) -- main cursor color
vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#FF0000" }) -- insert mode color

cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
