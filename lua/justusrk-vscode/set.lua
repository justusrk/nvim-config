-- vim.opt.guicursor = ""

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

-- netrw : Vim's Default File Explorer
vim.g.loaded_netrw = 1 -- tell neovim we already have netrw and thus don't load the default netrw
vim.g.loaded_netrwPlugin = 1 -- same as above
vim.g.netrw_browse_split = 0 -- open netrw in the current window
vim.g.netrw_banner = 0 -- disable netrw banner
vim.g.netrw_winsize = 25 -- set the window size to 25
