return {
  "rcarriga/nvim-notify",
  commit = "8701bece920b38ea289b457f902e2ad184131a5d",
  lazy = false,
  priority = 1000,
  config = function()
    local notify = require "notify"

    notify.setup {
      fps = 60,
      render = "compact",
      stages = "fade", -- Less distracting
      timeout = 2000, -- Easier to read
      top_down = false, -- Bottom-up
      background_colour = "#000000",

      -- Filter noise
      on_open = function(win) vim.api.nvim_win_set_config(win, { focusable = false }) end,
    }

    -- Set as default
    vim.notify = notify

    -- Filter noisy LSP messages
    local orig = notify
    vim.notify = function(msg, level, opts)
      -- Skip certain messages
      if msg:match "warning: multiple different client" then
        return
      end
      orig(msg, level, opts)
    end
  end,
}
