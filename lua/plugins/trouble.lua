return {
  "folke/trouble.nvim",
  commit = "bd67efe408d4816e25e8491cc5ad4088e708a69a",
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references (Trouble)",
    },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xC", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
  },
  opts = {
    auto_close = true,
    auto_refresh = true,
    focus = true,
    warn_no_results = false,
    modes = {
      diagnostics = {
        auto_open = false,
        win = { position = "bottom" },
      },
    },
  },
}
