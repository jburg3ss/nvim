return {
	"folke/flash.nvim",
  commit = "fcea7ff883235d9024dc41e638f164a450c14ca2",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
  -- stylua: ignore
  keys = {
    { "zk", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
