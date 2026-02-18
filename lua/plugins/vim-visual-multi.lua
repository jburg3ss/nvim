return {
	"mg979/vim-visual-multi",
  commit = "a6975e7c1ee157615bbc80fc25e4392f71c344d4",
	branch = "master",
	event = "VeryLazy",
	init = function()
		vim.g.VM_default_mappings = 0
		
		vim.g.VM_maps = {
			["Find Under"] = "<C-n>",          
      ["Find Subword Under"] = "<C-n>",
			
			["Visual All"] = "<C-n>",
			["Visual Cursors"] = "<C-Down>",
			
			["Skip Region"] = "<C-x>",
			["Remove Region"] = "<C-p>",
			
			["Undo"] = "u",
			["Redo"] = "<C-r>",
		}
		
		-- Better UX
		vim.g.VM_mouse_mappings = 0  -- Disable mouse (cleaner)
		vim.g.VM_set_statusline = 0  -- Don't mess with statusline
		vim.g.VM_silent_exit = 1     -- Less noise when exiting
	end,
}
