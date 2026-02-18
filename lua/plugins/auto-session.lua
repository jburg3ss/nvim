return {
  "rmagatti/auto-session",
  commit = "dcbc339a1a0e6505f755d980ad11f892b6a8d492",
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>wf", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    { "<leader>wd", "<cmd>AutoSession delete<CR>", desc = "Delete session" },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
    session_lens = {
      picker = telescope, -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also manually choose one. Falls back to vim.ui.select
      mappings = {
        -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
        -- delete_session = { "n", "<leader>wd" },
        -- alternate_session = { "i", "<C-s>" },
        -- copy_session = { "i", "<C-y>" },
      },

      picker_opts = {
        -- For Telescope, you can set theme options here, see:
        -- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
        -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
        --
        border = true,
        layout_config = {
          width = 0.8, -- Can set width and height as percent of window
          height = 0.5,
        },

        -- For Snacks, you can set layout options here, see:
        -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
        --
        -- preset = "dropdown",
        -- preview = false,
        -- layout = {
        --   width = 0.4,
        --   height = 0.4,
        -- },

        -- For Fzf-Lua, picker_opts just turns into winopts, see:
        -- https://github.com/ibhagwan/fzf-lua#customization
        --
        --  height = 0.8,
        --  width = 0.50,
      },

      -- Telescope only: If load_on_setup is false, make sure you use `:AutoSession search` to open the picker as it will initialize everything first
      load_on_setup = true,
    },
  },
}
