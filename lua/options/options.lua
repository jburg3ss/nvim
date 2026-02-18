local opt = vim.opt
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.inccommand = "split"

opt.smartcase = true
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true
opt.spell = true
vim.opt.spelllang = "en_us"

opt.number = true
opt.relativenumber = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.clipboard = "unnamedplus"
opt.foldmethod = "manual"
opt.title = true
opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftwidth = 4

-- Clear search highlighting with Esc
opt.updatetime = 50
opt.wildmode = "longest,list"
opt.colorcolumn = "100"
opt.cursorline = true
opt.ttyfast = true
opt.termguicolors = true
opt.splitright = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.modifiable = true
opt.guicursor = ""

