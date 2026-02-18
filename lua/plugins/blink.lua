return {
  "saghen/blink.cmp",
  lazy = false,
  commit = "485c03400608cb6534bbf84da8c1c471fc4808c0",
  dependencies = {
    {
      "onsails/lspkind.nvim",
      commit = "c7274c48137396526b59d86232eabcdc7fed8a32",
    },
    {
      "nvim-tree/nvim-web-devicons",
      commit = "746ffbb17975ebd6c40142362eee1b0249969c5c",
    },
    {
      "rafamadriz/friendly-snippets",
      commit = "43727343264a0ff0d8ce9fe2d8f06332d3f0fd34",
    },
  },
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      ["<C-e>"] = { "fallback" },
    },
    appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = "mono" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        snippets = {
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath "config" .. "/snippets" },
          },
        },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = "rounded",
        scrollbar = true,
        draw = {
          gap = 1,
          treesitter = { enabled = true },
          columns = {
            { "kind_icon", gap = 1 },
            { "label", "label_description", gap = 2 },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon = require("lspkind").symbol_map[ctx.kind] or ""
                return kind_icon .. " "
              end,
            },
            label = {
              width = { fill = true, max = 60 },
            },
            label_description = {
              width = { max = 30 },
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- Blink.cmp highlights for Moonfly theme
    local hl = vim.api.nvim_set_hl

    hl(0, "BlinkCmpMenu", { link = "Pmenu" })
    hl(0, "BlinkCmpMenuBorder", { fg = "#44546a", bg = "NONE" })
    hl(0, "BlinkCmpMenuSelection", { fg = "#ffffff", bg = "#474e69", bold = true })

    hl(0, "BlinkCmpLabel", { fg = "#c3ccdc", bold = false })
    hl(0, "BlinkCmpLabelDeprecated", { fg = "#9ca3af", strikethrough = true })
    hl(0, "BlinkCmpLabelMatch", { fg = "#80dff7", bold = true })
    hl(0, "BlinkCmpLabelDescription", { fg = "#8697a9" })

    hl(0, "BlinkCmpGhostText", { fg = "#6b7a8f", italic = true })

    hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
    hl(0, "BlinkCmpDocBorder", { fg = "#44546a", bg = "NONE" })

    hl(0, "BlinkCmpKindSnippet", { fg = "#a0d468", bold = true })
  end,
}
