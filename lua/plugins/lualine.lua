return {
  "nvim-lualine/lualine.nvim",
  commit = "47f91c416daef12db467145e16bed5bbfe00add8",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    commit = "746ffbb17975ebd6c40142362eee1b0249969c5c",
  },
  config = function()
    require("lualine").setup {
      options = {
        theme = "moonfly",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename", "filetype" },
        lualine_x = { "diagnostics" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
