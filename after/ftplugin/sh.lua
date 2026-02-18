-- after/ftplugin/sh.lua

opt_local = vim.opt_local

opt_local.shiftwidth = 2
opt_local.tabstop = 2
opt_local.softtabstop = 2
opt_local.expandtab = true
opt_local.textwidth = 80
opt_local.formatoptions:append("croql")

vim.b.is_bash = 1

vim.api.nvim_create_autocmd("BufWritePost", {
  buffer = 0,
  once = true,
  callback = function()
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    if first_line and first_line:match("^#!/") then
      local file = vim.fn.expand("%:p")
      vim.fn.system({ "chmod", "+x", file })
      vim.notify("Made executable: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
    end
  end,
})
