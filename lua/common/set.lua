

vim.opt.shell = os.getenv('SHELL')

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true    -- ignore case in searches by default
vim.opt.smartcase = true     -- make casesensitive if uppercase is entered

vim.opt.termguicolors = true


vim.opt.foldmethod = 'indent'
