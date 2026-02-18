-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  commit = "c2526f1cde528a66e086ab1668e996d162c75f4f",
  event = { "BufWritePre" },
  config = function()
    require("conform").setup {
      formatters = {
        shfmt = {
          command = "shfmt",
          args = { "-i", "2", "-sr", "-ci", "-s", "-" },
          stdin = true,
        },

        ["clang-format"] = {
          command = "clang-format",
          args = function()
            return {
              "--style=file",
              "--assume-filename",
              vim.fn.stdpath "config" .. "/formatters/.clang-format",
            }
          end,
          stdin = true,
        },

        ["cmake_format"] = {
          command = "cmake-format",
          args = function()
            return {
              "--config-files",
              vim.fn.stdpath "config" .. "/formatters/.cmake-format.yaml",
              "-",
            }
          end,
          stdin = true,
        },

        yamlfmt = { command = "yamlfmt" },
        htmlbeautifier = { command = "htmlbeautifier" },
        stylua = {
          command = "stylua",
          args = {
            "--config-path",
            vim.fn.stdpath "config" .. "/formatters/stylua.toml",
            "-",
          },
          stdin = true,
        },
        asmfmt = { command = "asmfmt" },
        jq = { command = "jq", args = { "." }, stdin = true },
        tidy_xml = {
          command = "tidy",
          args = { "-xml", "-indent", "-quiet", "-wrap", "0", "-" },
          stdin = true,
        },
        shellharden = { command = "shellharden", args = { "--transform" } },
        docformatter = {
          command = "docformatter",
          args = {
            "--black",
            "--wrap-summaries",
            "88",
            "--wrap-descriptions",
            "88",
            "--make-summary-multi-line",
            "--close-quotes-on-newline",
            "--blank",
            "-",
          },
          stdin = true,
        },
        ruff_organize_imports = {
          command = "ruff",
          args = {
            "check",
            "--select",
            "I",
            "--fix",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
        },
        ruff_fix = {
          command = "ruff",
          args = {
            "check",
            "--fix",
            "--exit-zero",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
        },
        ruff_format = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt", "shellharden" },
        bash = { "shfmt", "shellharden" },
        c = { "clang-format" },
        json = { "jq" },
        yaml = { "yamlfmt" },
        html = { "htmlbeautifier" },
        python = {
          "docformatter",
          "ruff_organize_imports",
          "ruff_fix",
          "ruff_format",
        },
        asm = { "asmfmt" },
        xml = { "tidy_xml" },
        markdown = {
          "prettierd",
          "prettier",
          "injected",
          stop_after_first = true,
        },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    }

    vim.keymap.set(
      "n",
      "<leader>f",
      function() require("conform").format { async = true } end,
      { desc = "Format buffer" }
    )
  end,
}
