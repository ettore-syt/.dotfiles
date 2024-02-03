local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.signcolumn = 'yes'

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.termguicolors = true
opt.cursorline = true

opt.updatetime = 50

opt.colorcolumn = '80'

-- persist undo across sessions
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

