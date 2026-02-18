return {
  "echasnovski/mini.nvim",
  commit = "4e61631464a12138bc0c82ea216b1d0d3cc2b315",
  config = function()

    require("mini.surround").setup({
      mappings = {
        add = "sa",            -- Add surrounding in Normal and Visual modes
        delete = "sd",         -- Delete surrounding
        find = "sf",           -- Find surrounding (to the right)
        find_left = "sF",      -- Find surrounding (to the left)
        highlight = "sh",      -- Highlight surrounding
        replace = "sr",        -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    })
  end,
}
