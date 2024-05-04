local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.signcolumn = 'yes'

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.cursorline = true

opt.updatetime = 50

opt.colorcolumn = '80'

-- persist undo across sessions
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- spacing
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

vim.opt.scrolloff = 8

opt.wrap = false
opt.smartindent = true

