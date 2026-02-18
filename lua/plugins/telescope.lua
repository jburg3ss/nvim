return {
  "nvim-telescope/telescope.nvim",
  commit = "ad7d9580338354ccc136e5b8f0aa4f880434dcdc",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      commit = "6e735d3d6633f75d19d6157fcfbc51ccb5d44e43",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      commit = "cf48d4dfce44e0b9a2e19a008d6ec6ea6f01a83b",
    },
  },

  cmd = "Telescope", -- Ensure it can load

  keys = {
    -- Current directory
    {
      "<leader>ff",
      function() require("telescope.builtin").find_files { cwd = vim.fn.expand "%:p:h" } end,
      mode = "n",
      desc = "Find files (current dir)",
    },
    {
      "<leader>fg",
      function() require("telescope.builtin").live_grep { cwd = vim.fn.expand "%:p:h" } end,
      mode = "n",
      desc = "Grep (current dir)",
    },

    -- Project root
    {
      "<leader>fp",
      function()
        local root = vim.fs.root(
          0,
          { ".git", "pyproject.toml", "setup.py", "Cargo.toml", "package.json" }
        ) or vim.fn.getcwd()
        require("telescope.builtin").find_files { cwd = root }
      end,
      mode = "n",
      desc = "Find files (project root)",
    },
    {
      "<leader>gp",
      function()
        local root = vim.fs.root(
          0,
          { ".git", "pyproject.toml", "setup.py", "Cargo.toml", "package.json" }
        ) or vim.fn.getcwd()
        require("telescope.builtin").live_grep { cwd = root }
      end,
      mode = "n",
      desc = "Grep (project root)",
    },

    -- Fixed locations
    {
      "<leader>rf",
      "<cmd>Telescope find_files cwd=$HOME/.Repos<CR>",
      mode = "n",
      desc = "Repos files",
    },
    {
      "<leader>rg",
      "<cmd>Telescope live_grep cwd=$HOME/.Repos<CR>",
      mode = "n",
      desc = "Repos grep",
    },
    {
      "<leader>ef",
      "<cmd>Telescope find_files cwd=$HOME/.config/nvim<CR>",
      mode = "n",
      desc = "Nvim files",
    },
    {
      "<leader>eg",
      "<cmd>Telescope live_grep cwd=$HOME/.config/nvim<CR>",
      mode = "n",
      desc = "Nvim grep",
    },
    { "<leader>hf", "<cmd>Telescope find_files cwd=$HOME<CR>", mode = "n", desc = "Home files" },
    { "<leader>hg", "<cmd>Telescope live_grep cwd=$HOME<CR>", mode = "n", desc = "Home grep" },

    -- Utilities
    {
      "<leader>fr",
      function() require("telescope.builtin").resume() end,
      mode = "n",
      desc = "Resume search",
    },
    {
      "<leader>fo",
      function() require("telescope.builtin").oldfiles() end,
      mode = "n",
      desc = "Recent files",
    },
    {
      "<leader>fw",
      function() require("telescope.builtin").grep_string() end,
      mode = "n",
      desc = "Grep word",
    },
    {
      "<leader>/",
      function() require("telescope.builtin").current_buffer_fuzzy_find() end,
      mode = "n",
      desc = "Search buffer",
    },
    {
      "<leader>fh",
      function() require("telescope.builtin").help_tags() end,
      mode = "n",
      desc = "Help",
    },
    {
      "<leader>fk",
      function() require("telescope.builtin").keymaps() end,
      mode = "n",
      desc = "Keymaps",
    },
    {
      "<leader>bb",
      function() require("telescope.builtin").buffers() end,
      mode = "n",
      desc = "Buffers",
    },

    -- Git
    {
      "<leader>gs",
      function() require("telescope.builtin").git_status() end,
      mode = "n",
      desc = "Git status",
    },
    {
      "<leader>gc",
      function() require("telescope.builtin").git_commits() end,
      mode = "n",
      desc = "Git commits",
    },
    {
      "<leader>gb",
      function() require("telescope.builtin").git_bcommits() end,
      mode = "n",
      desc = "Git commits (buffer)",
    },
    {
      "<leader>fG",
      function() require("telescope.builtin").git_files() end,
      mode = "n",
      desc = "Git files",
    },

    -- LSP
    {
      "gd",
      function() require("telescope.builtin").lsp_definitions() end,
      mode = "n",
      desc = "Go to definition",
    },
    {
      "gi",
      function() require("telescope.builtin").lsp_implementations() end,
      mode = "n",
      desc = "Go to implementation",
    },
    {
      "gr",
      function() require("telescope.builtin").lsp_references { include_declaration = false } end,
      mode = "n",
      desc = "References",
    },
    {
      "<leader>ls",
      function() require("telescope.builtin").lsp_document_symbols() end,
      mode = "n",
      desc = "Document symbols",
    },
    {
      "<leader>lS",
      function() require("telescope.builtin").lsp_workspace_symbols() end,
      mode = "n",
      desc = "Workspace symbols",
    },
  },

  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    telescope.setup {
      defaults = {
        file_ignore_patterns = {
          "^.git/",
          "^node_modules/",
          "^__pycache__/",
          "%.jpg$",
          "%.jpeg$",
          "%.png$",
          "%.gif$",
          "%.pdf$",
          "%.lock$",
          "^%.venv/",
          "^%.uv/",
          "^%.cache/",
          "^%.local/",
          "lazy%-lock%.json",
        },

        layout_strategy = "flex",
        layout_config = {
          flex = { width = 0.9 },
        },

        mappings = {
          i = {
            ["<C-c>"] = actions.close,
            ["<C-v>"] = actions.select_vertical,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-t>"] = actions.select_tab,
          },
          n = {
            ["<Esc>"] = actions.close,
            ["<C-v>"] = actions.select_vertical,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-t>"] = actions.select_tab,
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },

      pickers = {
        colorscheme = { enable_preview = true },
        find_files = {
          hidden = true,
          find_command = {
            "rg",
            "--files",
            "--glob",
            "!{.git/*,.next/*,.svelte-kit/*,target/*,node_modules/*}",
            "--path-separator",
            "/",
          },
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            layout_config = {
              width = 0.8,
              height = 0.4,
            },
          },
        },
      },
    }

    -- Load extensions
    telescope.load_extension "fzf"
    telescope.load_extension "ui-select"
  end,
}
