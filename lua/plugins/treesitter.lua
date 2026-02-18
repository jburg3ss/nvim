return {
  "nvim-treesitter/nvim-treesitter",
  commit = "9f2dad22ef8bb14fd1e0a3aa8859cdc88170668b",
  lazy = false,
  build = "false",

  opts = {
    ensure_installed = {
      "vimdoc",
      "lua",
      "bash",
      "c",
      "rust",
      "python",
      "javascript",
      "typescript",
      "html",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "dockerfile",
      "asm",
    },

    auto_install = false,
    sync_install = false,

    highlight = {
      enable = true,
      disable = function(lang, buf)
        if lang == "html" then
          return true
        end

        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

        return ok and stats and stats.size > max_filesize
      end,
      additional_vim_regex_highlighting = { "markdown" },
    },

    indent = { enable = true },
  },

  config = function(_, opts) require("nvim-treesitter.config").setup(opts) end,
}
