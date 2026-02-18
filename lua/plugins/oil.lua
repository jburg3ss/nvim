return {
	"stevearc/oil.nvim",
  commit = "f55b25e493a7df76371cfadd0ded5004cb9cd48a",
	dependencies = { 
    "nvim-tree/nvim-web-devicons",
    commit = "746ffbb17975ebd6c40142362eee1b0249969c5c"
  },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["-"] = "actions.parent",
				["g."] = "actions.toggle_hidden",
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
