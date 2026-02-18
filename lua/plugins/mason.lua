return {
  "williamboman/mason.nvim",
  lazy = false,
  commit = "44d1e90e1f66e077268191e3ee9d2ac97cc18e65",
  priority = 100,
  config = function()
    require("mason").setup {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        check_outdated_packages_on_open = false,
      },
      max_concurrent_installers = 4,
      log_level = vim.log.levels.INFO,
    }

    -- Keybinding to open Mason
    vim.keymap.set("n", "<leader>m", ":Mason<CR>", { desc = "Open Mason" })
  end,
}
