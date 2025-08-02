-- Modern Neovim options
-- This replaces the old 'set' statements from legacy config

local opt = vim.opt

-- Display options
opt.number = true
opt.numberwidth = 6
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 5
opt.laststatus = 2
opt.showcmd = true
opt.title = true
opt.termguicolors = true

-- Search options
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indentation
opt.tabstop = 3
opt.shiftwidth = 3
opt.softtabstop = 3
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Folding
opt.foldmethod = 'marker'
opt.foldmarker = '{,}'
opt.foldcolumn = '3'
opt.foldlevelstart = 2

-- Mouse
opt.mouse = 'a'
opt.mousehide = true

-- Backup and undo
opt.backup = true
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000

-- Create directories if they don't exist
local data_dir = vim.fn.stdpath('data')
vim.fn.system('mkdir -p ' .. data_dir .. '/backup')
vim.fn.system('mkdir -p ' .. data_dir .. '/swap') 
vim.fn.system('mkdir -p ' .. data_dir .. '/undo')

opt.backupdir = data_dir .. '/backup//'
opt.directory = data_dir .. '/swap//'
opt.undodir = data_dir .. '/undo//'

-- Misc
opt.swapfile = false
opt.wildmenu = true
opt.wildignore = {
  '*.a', '*.pyc', '*.o', '*.orig',
  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.jpeg', '*.png',
  '.DS_Store', '.git', '.hg', '.svn',
  '*~', '*.sw?', '*.tmp'
}
opt.shortmess:append('filmnrxoOtT')
opt.ttyfast = true
opt.errorbells = false
opt.showmatch = true
opt.backspace = '2'
opt.history = 4000
opt.fileformats = 'unix'
opt.encoding = 'utf-8'
opt.matchtime = 2

-- Disable netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1