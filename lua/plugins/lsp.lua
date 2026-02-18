return {
  {
    "williamboman/mason-lspconfig.nvim",
    commit = "21c2a84ce368e99b18f52ab348c4c02c32c02fcf",
    dependencies = {
      {
        "williamboman/mason.nvim",
        commit = "44d1e90e1f66e077268191e3ee9d2ac97cc18e65",
      },
      {
        "saghen/blink.cmp",
        commit = "fcea7ff883235d9024dc41e638f164a450c14ca2",
      },
      {
        "b0o/schemastore.nvim",
        commit = "2abb594d69a43c0a48a11b30bb0ef17ad90dceea",
      },
    },
    config = function()
      -- Step 1: Ensure LSP servers are installed
      require("mason-lspconfig").setup {
        ensure_installed = {
          "clangd",
          "bashls",
          "jsonls",
          "html",
          "dockerls",
          "docker_compose_language_service",
          "taplo",
          "lemminx",
          "ltex",
          "basedpyright",
          "ansiblels",
          "marksman",
          "asm_lsp",
        },
        automatic_installation = false,
      }

      -- Step 2: Get capabilities from blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Step 3: Define on_attach for keybindings
      local on_attach = function(client, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Navigation
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)

        -- Information
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        -- Actions
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set(
          "n",
          "<leader>cA",
          function()
            vim.lsp.buf.code_action {
              context = { only = { "source.fixAll" } },
              apply = true,
            }
          end,
          opts
        )
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
      end

      -- Step 4: Default config for all servers
      local default_config = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Step 5: Configure each LSP server

      -- C/C++
      vim.lsp.config.clangd = vim.tbl_extend("force", default_config, {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--clang-tidy-checks=-*,clang-diagnostic-*,clang-analyzer-*,cppcoreguidelines-*",
          "--completion-style=detailed",
          "--header-insertion=never",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = { "compile_commands.json", ".git" },
      })

      -- Assembly
      vim.lsp.config.asm_lsp = vim.tbl_extend("force", default_config, {
        cmd = { "asm-lsp" },
        filetypes = { "asm", "s", "S" },
        root_markers = { "Makefile", ".git" },
      })

      -- Bash
      vim.lsp.config.bashls = vim.tbl_extend("force", default_config, {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
      })

      -- JSON
      vim.lsp.config.jsonls = vim.tbl_extend("force", default_config, {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- HTML
      vim.lsp.config.html = vim.tbl_extend("force", default_config, {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { ".git" },
      })

      -- Docker
      vim.lsp.config.dockerls = vim.tbl_extend("force", default_config, {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { ".git" },
      })

      -- Docker Compose
      vim.lsp.config.docker_compose_language_service = vim.tbl_extend("force", default_config, {
        cmd = { "docker-compose-langserver", "--stdio" },
        filetypes = { "yaml.docker-compose" },
        root_markers = { "docker-compose.yml", "docker-compose.yaml" },
      })

      -- TOML
      vim.lsp.config.taplo = vim.tbl_extend("force", default_config, {
        cmd = { "taplo", "lsp", "stdio" },
        filetypes = { "toml" },
        root_markers = { ".git" },
      })

      -- XML
      vim.lsp.config.lemminx = vim.tbl_extend("force", default_config, {
        cmd = { "lemminx" },
        filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
        root_markers = { ".git" },
      })

      -- LaTeX/Markdown grammar
      vim.lsp.config.ltex = vim.tbl_extend("force", default_config, {
        cmd = { "ltex-ls" },
        filetypes = { "markdown", "text", "tex", "gitcommit" },
        root_markers = { ".git" },
        settings = {
          ltex = {
            language = "en-GB",
          },
        },
      })

      -- Python
      vim.lsp.config.basedpyright = vim.tbl_extend("force", default_config, {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", ".git" },
      })

      -- Ansible
      vim.lsp.config.ansiblels = vim.tbl_extend("force", default_config, {
        cmd = { "ansible-language-server", "--stdio" },
        filetypes = { "yaml.ansible" },
        root_markers = { "ansible.cfg", ".git" },
        settings = {
          ansible = {
            useFullyQualifiedCollectionNames = true,
            validation = {
              enabled = true,
              lint = {
                enabled = true,
                path = "ansible-lint",
              },
            },
          },
        },
      })

      -- Markdown
      vim.lsp.config.marksman = vim.tbl_extend("force", default_config, {
        cmd = { "marksman", "server" },
        filetypes = { "markdown" },
        root_markers = { ".git", ".marksman.toml" },
      })

      vim.lsp.config.cmake = vim.tbl_extend("force", default_config, {
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_markers = { "CMakeLists.txt", ".git" },
        init_options = {
          buildDirectory = "build",
        },
      })

      -- Step 6: Enable all configured servers
      vim.lsp.enable {
        "clangd",
        "asm_lsp",
        "bashls",
        "jsonls",
        "html",
        "dockerls",
        "docker_compose_language_service",
        "taplo",
        "lemminx",
        "ltex",
        "basedpyright",
        "ansiblels",
        "marksman",
      }

      -- Step 7: Optional diagnostics configuration
      vim.diagnostic.config {
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      }

      -- Diagnostic signs
      local signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
}
