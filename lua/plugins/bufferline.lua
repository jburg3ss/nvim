return {
  "akinsho/bufferline.nvim",
  commit = "2e3c8cc5a57ddd32f1edd2ffd2ccb10c09421f6c",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      commit = "746ffbb17975ebd6c40142362eee1b0249969c5c",
    },
  },
  opts = {
    options = {
      mode = "buffers",
      numbers = "ordinal",
      always_show_bufferline = true,
      diagnostics = "nvim_lsp",
      separator_style = "thin",
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- Only add if you find yourself using it
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
  end,
}
