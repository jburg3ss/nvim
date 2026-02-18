  return {
   "maskudo/devdocs.nvim",
   commit = "e27a8f7680dc460eda9ccd5ab2fa0e8f835f736a",
    lazy = false,
    dependencies = {
      "folke/snacks.nvim",
      commit = "fe7cfe9800a182274d0f868a74b7263b8c0c020b",
    },
    cmd = { "DevDocs" },
    keys = {
      {
        "<leader>ho",
        mode = "n",
        "<cmd>DevDocs get<cr>",
        desc = "Get Devdocs",
      },
      {
        "<leader>hi",
        mode = "n",
        "<cmd>DevDocs install<cr>",
        desc = "Install Devdocs",
      },
      {
        "<leader>hv",
        mode = "n",
        function()
          local devdocs = require("devdocs")
          local installedDocs = devdocs.GetInstalledDocs()
          vim.ui.select(installedDocs, {}, function(selected)
            if not selected then
              return
            end
            local docDir = devdocs.GetDocDir(selected)
            -- prettify the filename as you wish
            Snacks.picker.files({ cwd = docDir })
          end)
        end,
        desc = "Get Devdocs",
      },
      {
        "<leader>hd",
        mode = "n",
        "<cmd>DevDocs delete<cr>",
        desc = "Delete Devdoc",
      }
    },
    opts = {
  previewer_cmd = "glow",
  cmd_args = { "-s", "dark", "-w", "80" },
  ensure_installed = { ... },
},
  }
