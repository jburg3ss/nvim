opt_local = vim.opt_local

opt_local.expandtab = true
opt_local.shiftwidth = 4
opt_local.tabstop = 4
opt_local.softtabstop = 4
opt_local.autoindent = true
opt_local.smartindent = true
opt_local.cindent = true
opt_local.makeprg = "cmake --build build"
opt_local.errorformat = "%f:%l:%c: %t%*[^:]: %m"

vim.keymap.set("n", "<leader>m", "<cmd>make<CR>", { buffer = true })
vim.keymap.set("n", "<leader>r", "<cmd>terminal ./build/main<CR>", { buffer = true })
