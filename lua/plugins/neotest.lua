return {
  "nvim-neotest/neotest",
  commit = "deadfb1af5ce458742671ad3a013acb9a6b41178",
  dependencies = {
    {
      "nvim-neotest/nvim-nio",
      commit = "21f5324bfac14e22ba26553caf69ec76ae8a7662",
    },
    {
      "nvim-lua/plenary.nvim",
      commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509",
    },
    {
      "nvim-treesitter/nvim-treesitter",
      commit = "9f2dad22ef8bb14fd1e0a3aa8859cdc88170668b",
    },
    {
      "nvim-neotest/neotest-python",
      commit = "b0d3a861bd85689d8ed73f0590c47963a7eb1bf9",
    },
  },
  keys = {
    { "<leader>tn", function() require("neotest").run.run() end, desc = "Test Nearest" },
    {
      "<leader>tf",
      function() require("neotest").run.run(vim.fn.expand "%") end,
      desc = "Test File",
    },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test Summary" },
    {
      "<leader>to",
      function() require("neotest").output.open { enter = true } end,
      desc = "Test Output",
    },
  },
  config = function()
    -- Dynamic venv detection
    local function get_python_path()
      local venv = os.getenv "VIRTUAL_ENV"
      if venv then
        return venv .. "/bin/python"
      end

      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      end

      return "python3"
    end

    require("neotest").setup {
      adapters = {
        require "neotest-python" {
          runner = "pytest",
          python = get_python_path(),
        },
      },
    }
  end,
}
