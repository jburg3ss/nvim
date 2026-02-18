require "options.options"
vim.g.mapleader = ","

-- Pin Lazy to known-good version
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=v11.14.1", -- Update this when you test new versions
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Configure Lazy with security-focused settings
require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    enabled = false, -- Don't auto-reload
    notify = false,
  },
  checker = {
    enabled = false, -- Don't auto-check for updates
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "editorconfig", -- EditorConfig support
        "gzip", -- Edit .gz files
        "man", -- :Man command
        "matchit", -- Extended % matching
        "matchparen", -- Highlight matching parens
        "netrwPlugin", -- File browser
        "osc52", -- OSC 52 clipboard (terminal)
        "rplugin", -- Remote plugins
        "shada", -- Persistent state (DON'T DISABLE)
        "spellfile", -- Spell file downloads
        "tarPlugin", -- Browse .tar files
        "tohtml", -- :TOhtml command
        "tutor", -- :Tutor command
        "zipPlugin", -- Browse .zip files
      },
    },
  },
})

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.HINT] = "●",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    linehl = {},
    numhl = {},
  },
}

-- Modular config loading
local opts = { "appearance", "autocmd", "keymaps", "menu", "filetypes" }
for _, mod in ipairs(opts) do
  require("options." .. mod)
end

require "docs.man"
