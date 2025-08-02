-- Modern Neovim autocommands
-- This modernizes and organizes autocommands from legacy config

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Vimfiles group (from legacy config)
local vimfiles = augroup('vimfiles', { clear = true })
autocmd('BufWritePost', {
  group = vimfiles,
  pattern = 'init.lua',
  command = 'source %',
  desc = 'Auto-source init.lua on save'
})

autocmd('BufWritePost', {
  group = vimfiles,
  pattern = 'legacy.vim',
  command = 'source %',
  desc = 'Auto-source legacy.vim on save'
})

autocmd('BufWritePost', {
  group = vimfiles,
  pattern = '*.vim',
  command = 'colorscheme BusyBee',
  desc = 'Apply colorscheme after vim file changes'
})

-- File type specific settings (from legacy config)
local filetypes = augroup('filetypes', { clear = true })

-- Omnifunc settings
autocmd('FileType', {
  group = filetypes,
  pattern = 'javascript',
  command = 'set omnifunc=javascriptcomplete#CompleteJS'
})

autocmd('FileType', {
  group = filetypes,
  pattern = 'html',
  command = 'set omnifunc=htmlcomplete#CompleteTags'
})

autocmd('FileType', {
  group = filetypes,
  pattern = 'css',
  command = 'set omnifunc=csscomplete#CompleteCSS'
})

autocmd('FileType', {
  group = filetypes,
  pattern = 'xml',
  command = 'set omnifunc=xmlcomplete#CompleteTags'
})

autocmd('FileType', {
  group = filetypes,
  pattern = 'php',
  command = 'set omnifunc=phpcomplete#CompletePHP'
})

-- PHP-FPM config syntax
autocmd({'BufRead', 'BufNewFile'}, {
  group = filetypes,
  pattern = '/etc/php-fpm.conf',
  command = 'set syntax=dosini'
})

autocmd({'BufRead', 'BufNewFile'}, {
  group = filetypes,
  pattern = '/etc/php-fpm.d/*.conf',
  command = 'set syntax=dosini'
})

-- Dircolors syntax
autocmd({'BufNewFile', 'BufRead'}, {
  group = filetypes,
  pattern = '*dircolors',
  command = 'set filetype=dircolors'
})

-- JavaScript concealment (from legacy config)
autocmd('FileType', {
  group = filetypes,
  pattern = 'javascript',
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = 'nc'
  end
})

-- Markdown file detection (from legacy config)
autocmd({'BufNewFile', 'BufRead'}, {
  group = filetypes,
  pattern = '*.markdown,*.md,*.mdown,*.mkd,*.mkdn',
  callback = function()
    if vim.bo.filetype:match('^conf') or vim.bo.filetype:match('^modula2') then
      vim.bo.filetype = 'markdown'
    else
      vim.cmd('setf markdown')
    end
  end
})

-- Highlight groups (from legacy config)
local highlights = augroup('highlights', { clear = true })
autocmd('ColorScheme', {
  group = highlights,
  callback = function()
    vim.cmd('highlight clear SignColumn')
    vim.cmd('highlight clear LineNr')
  end
})

-- Modern additions
local modern = augroup('modern', { clear = true })

-- Remove trailing whitespace on save for certain filetypes
autocmd('BufWritePre', {
  group = modern,
  pattern = '*.lua,*.js,*.ts,*.jsx,*.tsx,*.py,*.php,*.html,*.css,*.scss',
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
  desc = 'Remove trailing whitespace on save'
})

-- Auto-create directories when saving files
autocmd('BufWritePre', {
  group = modern,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
  desc = 'Auto-create directories when saving files'
})