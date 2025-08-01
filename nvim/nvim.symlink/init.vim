" Use Bundles Config: {
if filereadable(expand("~/.config/nvim/bundles.vim"))
   source ~/.config/nvim/bundles.vim
endif


" NEW STUFF 2025-07 {
map("v", "<leader>y", '"+y', opts)

" }



" Telescope: {
lua << EOF
require('telescope').setup{
   defaults = {
      layout_config = {
         vertical = { width = 1 }
      }
   },
   pickers = {
    find_files = {
      theme = "cursor",
    }
  }
}

EOF

" }




" LeaderKeys Platforms Backups Undos: {
" Leader: {
let mapleader = ","
let g:mapleader=","
" }
" Identify platform {
silent function! OSX()
return has('macunix')
endfunction
silent function! LINUX()
return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
return  (has('win16') || has('win32') || has('win64'))
endfunction
" }
" Setup Clipboard: {
if has('clipboard')
   if has('unnamedplus')  " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
   else         " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
   endif
endif
"}
" Autosource Vimrc Edits And Snippets: {
augroup vimfiles
   au! BufWritePost init.vim nested source %
   au! BufWritePost bundles.vim source %
   au! BufWritePost *.vim colorscheme BusyBee
augroup END
" }
" Persistent Undo: {
set backup                  " Backups are nice ...
if has('persistent_undo')
   " Create directories if they don't exist
   silent !mkdir -p ~/.local/share/nvim/backup
   silent !mkdir -p ~/.local/share/nvim/swap
   silent !mkdir -p ~/.local/share/nvim/undo
   
   set backupdir=~/.local/share/nvim/backup//
   set directory=~/.local/share/nvim/swap//
   set undodir=~/.local/share/nvim/undo//
   set undofile                " So is persistent undo ...
   set undolevels=1000         " Maximum number of changes that can be undone
   set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif
" }
" }

" KeyBindings: {
" Clipboard: {
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>py
map <F7> mzgg=G`z<CR>
map <F6> <Plug>HexManager
" }
" Control Key Bindings: {
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
" ==== Control S for Saving ====
noremap  <C-S> :update<CR>
"vnoremap <C-S> <C-C>:update<CR>
"inoremap <C-S> <C-O>:update<CR>
"inoremap <c-s> <Esc>:update<CR>

" Keys Just Like In Bash:
cnoremap <C-A>      <Home>
noremap <C-E>      <End>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

noremap <C-t> !tidy --replace-color y --indent 'auto' --indent-attributes y --indent-cdata y --indent-spaces '2' --wrap '90100' --clean y -html -mi %<CR>

" Select ALL:
map <C-A> ggVG
" }
" Telescope: {
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" }
" Folding: {
" Space to toggle folds.
nnoremap <space> za
vnoremap <space> za
" }
" Navigation: {
" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" Faster viewport scrolling (3 lines at a time)
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>
"}
" Leader Key Commands: {

" Fast Edits:"{
nmap <silent> <leader>v :e ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>vv :e ~/.config/nvim/bundles.vim<CR>
"}
" Tidy HTML:"{
nmap <silent> <leader>x :%!tidy -q -i --show-errors 0 -w 100<CR>
"}
" Toggle Search Highlighting:"{
nmap <silent> <leader>/ :noh<CR>
"}
" Code Folding:"{
nmap <leader>f0 :set foldlevelstart=0<CR>
nmap <leader>f1 :set foldlevelstart=1<CR>
nmap <leader>f2 :set foldlevelstart=2<CR>
nmap <leader>f3 :set foldlevelstart=3<CR>
nmap <leader>f4 :set foldlevelstart=4<CR>
nmap <leader>f5 :set foldlevelstart=5<CR>
nmap <leader>f6 :set foldlevelstart=6<CR>
nmap <leader>f7 :set foldlevelstart=7<CR>
nmap <leader>f8 :set foldlevelstart=8<CR>
nmap <leader>f9 :set foldlevelstart=9<CR>
"}

" Fix Windows Endlines:"{
nmap <silent> <leader>fw :%s/\r/<CR>
"}
" Remove Trailing Whitespaces:"{
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
"}
" Switch Between The Last Two Files:"{
nnoremap <leader><leader> <c-^>
"}
" Source Visual Selection:"{
nnoremap <leader>L ^vg_y:execute @@<cr>
"}
" Easy Buffer Navigation:"{
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>
"}
" }
" Other Random Bindings: {
" Fix Stupid Caps Mistakes I Always Make:
cmap W w
cmap Q q

" Change Indent Continuously:
vmap < <gv
vmap > >gv
nmap \ ,

" Elevated Write PostOpen:
cmap w!! w !sudo tee % >/dev/null

" Access To NERDTree:
nmap ,e :NERDTreeToggle<CR>
nmap F10 :NERDTreeToggle<CR>

" Add New Line Without Entering Insert Mode:
noremap <CR> o<Esc>
" Highlight Search Word Under Cursor Without Jumping To Next:
nnoremap <leader>h *<C-O>
" }
" }

" Set Statements: {
" Color Scheme: {
set background=dark
colorscheme BusyBee "}
" Search Stuff: {
set hlsearch
set incsearch
set ignorecase    " Ignore case when searching
set smartcase     " Ignore case unless capital
" }
" Display: {
if has("gui")
   set gfn=Inconsolata-DZ\ for\ Powerline:h11
endif
set nowrap              " turn off wrap
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compat
set virtualedit=onemore " Allow for cursor beyond last character
set foldcolumn=3
set t_Co=256            " Enable full-color support
set title               " Set the title of the window in the terminal to the file
set laststatus=2        " Always show the status line
set scrolloff=5         " When the page starts to scroll, keep the cursor 5 lines
set autoread
set cursorline          " highlight the line the cursor is on
set showcmd             " Show the command as it's being typed in the lower right
set linespace=0
set formatoptions-=o    "dont continue comments when pushing o/O
"}
" Folding:"{
set foldmarker={,}
set foldmethod=marker
"set foldtext=substitute(getline(v:foldstart),'{.*','{...}',) "}
" set foldcolumn=4
set foldlevelstart=2
"}
" Indentation:"{
set tabstop=3
set shiftwidth=3
set sts=3
set softtabstop=3
set expandtab
set autoindent
set smartindent
set copyindent
set shiftround
"}
" The Mouse:"{
set mouse=a
set mousehide
"}
" Navigation:"{
set nostartofline       " When moving around kept the cursor on the same
" column if possible
"}
" Misc Sheet: {
set noswapfile " Turn Off Swap Files:
set wildmenu       " Enable command-line completion in an enhanced
" mode (by hitting <TAB> in command mode, it will
" show the possible matches just above the command
" line with the first match highlighted)

"set wildmode=list:longest,full " Command <Tab> completion
if has ("wildignore")
   set wildignore+=*.a,*.pyc,*.o,*.orig
   set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
   set wildignore+=.DS_Store,.git,.hg,.svn
   set wildignore+=*~,*.sw?,*.tmp
endif
set number
set numberwidth=6
set shortmess+=filmnrxoOtT  " Abbrev. of messages (avoids 'hit enter')
set ttyfast                 " Enable fast terminal connection (more characters
" will be send to the screen for redrawing)
set noerrorbells            " Disable error bells
set showmatch
set backspace=2
set hi=4000         " command history length
set fileformats=unix
set iskeyword+=\$,-   " Add extra characters that are valid parts of variables^
" Necessary for multiple encodings
set encoding=utf-8
set mat=2

"Directories for swp files
"set backupdir=~/.backups
"set directory=~/.backups

" }
" }

" File specific syntax settings: {
au BufNewFile,BufRead *dircolors set filetype=dircolors

" }

" File Settings: {
" Autocmd Statements:"{
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd BufRead,BufNewFile /etc/php-fpm.conf set syntax=dosini
autocmd BufRead,BufNewFile /etc/php-fpm.d/*.conf set syntax=dosini
"}
" Nuts Sytnax: {
au FileType javascript setl conceallevel=2 concealcursor=nc
let g:syntax_js=['function', 'return']
"}
" Js Syntax Stuff: {
let g:used_javascript_libs='underscore,backbone,jquery'
" }
"}

" Settings For Bundles: "{
" NerdTree: {
if(!exists('vimrc_already_sourced'))
   command Nt NERDTree
   command Nc NERDTreeClose
   "nerd tree and tag list
   nmap <silent> <leader>T :TagbarToggle<CR>
   let NERDTreeShowHidden=1
endif
"}
" Markdown Plugin: {
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
         \ if &ft =~# '^\%(conf\|modula2\)$' |
         \   set ft=markdown |
         \ else |
         \   setf markdown |
         \ endif
"}
" JsBeautify: {
map <c-j> :call JsBeautify()<cr>
"}
" Powerline: {
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set noshowmode     " Don't show the mode since Powerline shows it
"}
" Folding Settings: {
if has("unix")
   set fcs=vert:\↕,fold:⋱
endif
" Custom Foldtext Function: {
set foldtext=MyFoldText()
if(!exists('vimrc_already_sourced'))
   function! MyFoldText()
      let line = getline(v:foldstart)
      if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
         let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
         let linenum = v:foldstart + 1
         while linenum < v:foldend
            let line = getline( linenum )
            let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
            if comment_content != ''
               break
            endif
            let linenum = linenum + 1
         endwhile
         let sub = initial . ' ' . comment_content
      else
         let sub = line " {
         let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
         if startbrace == '{'
            let line = getline(v:foldend)
            let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
            if endbrace == '}'
               let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
            endif
         endif
      endif
      let n = v:foldend - v:foldstart + 1
      let info = " " . n . " lines"
      let sub = sub . "                                                                                                                  "
      let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
      let fold_w = getwinvar( 0, '&foldcolumn' )
      let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
      return sub . info
   endfunction
endif
" }
" Align: {
" align on equals
nmap <silent> <leader>A <esc>VAA
" }
" Ctrlp: {
let g:ctrlp_extensions=['funky']
let g:ctrlp_follow_symlinks=1
let g:ctrlp_working_path_mode=0
let g:ctrlp_custom_ignore={
         \ 'dir':  '\.git$\|node_modules\|bin\|dist\|bower_components',
         \ 'file': '\.exe$\|\.so$\|\.dat$'
         \ }
" }
" Funky Files: {
let g:ctrlp_funky_syntax_highlight=1
"}
" YCM Completion: {
let g:ycm_add_preview_to_completeopt=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_cache_omnifunc=1
"}
" Tern: {
" let g:tern_show_signature_in_pum=1
" let g:tern_is_show_argument_hints_enabled=1
" dont pop up preview window, ycm is enough
set completeopt-=preview
"}
" Funky Action: {
nnoremap <Leader>f :CtrlPFunky<Cr>
nnoremap <Leader>F :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
" }
" Tern Stuff: {
" nmap <silent> <F12> :TernDef<CR>
" nmap <silent> <c-s> :TernType<CR>
" }
" Syntastic: {
let g:syntastic_always_populate_loc_list=1
"}

" Helper Functions: "{
" Visual
function! VisualSelection(direction) range
   let l:saved_reg = @"
   execute "normal! vgvy"

   let l:pattern = escape(@", '\\/.*$^~[]')
   let l:pattern = substitute(l:pattern, "\n$", "", "")

   if a:direction == 'b'
      execute "normal ?" . l:pattern . "^M"
   elseif a:direction == 'gv'
      call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
   elseif a:direction == 'replace'
      call CmdLine("%s" . '/'. l:pattern . '/')
   elseif a:direction == 'f'
      execute "normal /" . l:pattern . "^M"
   endif

   let @/ = l:pattern
   let @" = l:saved_reg
endfunction
function! CmdLine(str)
   exe "menu Foo.Bar :" . a:str
   emenu Foo.Bar
   unmenu Foo
endfunction
"}

let vimrc_already_sourced = 1

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
