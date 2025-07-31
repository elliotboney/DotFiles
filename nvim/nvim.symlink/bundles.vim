" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin()

  Plug 'einars/js-beautify', { 'for': 'javascript' }
  Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
  Plug 'vim-scripts/JavaScript-Indent', { 'for': 'javascript' }
  Plug 'elzr/vim-json', { 'for': 'json' }

  Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
  Plug 'othree/html5.vim', { 'for': 'html' }
  Plug 'stanangeloff/php.vim', { 'for': 'php' }

  " Markdown:
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
  Plug 'tpope/vim-markdown', { 'for': 'markdown' }


  " Color Scheme:
  Plug 'vim-scripts/BusyBee'


  " Color Preview:
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

  " Telescope:
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

  " General Utils:
  Plug 'ctrlpvim/ctrlp.vim' 
  Plug 'scrooloose/syntastic'
  Plug 'gregsexton/MatchTag'
  Plug 'vim-scripts/Tagbar'
  Plug 'itchyny/lightline.vim'
  Plug 'vim-scripts/xterm-color-table.vim'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'romainl/vim-cool' " Gets rid of search highlight after search is over

  " other misc
  Plug 'wfxr/minimap.vim' " needs brew install code-minimap
call plug#end()
