" -----------------------------------------
" General stuff
set nocompatible
set number
set incsearch
set hlsearch
set expandtab
set smarttab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set nowrap
set grepprg=ack
set grepformat=%f:%l:%m
set textwidth=0
set wrapmargin=0
set t_Co=256
set clipboard=unnamedplus
set fileformat=unix
set hidden " allows for unsaved buffers to be hidden

" ----------------------------------------
" Visual stuff
set showmatch " show matching brackets
set mat=5     " blinking
set novisualbell
set noerrorbells
set laststatus=2
syntax on
filetype on
filetype plugin on
filetype plugin indent on

colorscheme twilight256

" ---------------------------------------
" Mouse stuff
set mousehide " hides mouse when typing
set mouse=a   " allows mouse in all modes

" --------------------------------------
" Whitespace trim - mail and markdown files are not to be trimmed!
fun! StripTrailingWhitespace()
  if exists('b:noStripWhitespace')
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType maili,markdown let b:noStripWhitespace=1

" Match trailing whitespace and paint it darkgray
highlight ExtraWhitespace ctermbg=darkgray
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" autocmd BufWritePre * :%s/\s\+$//e " Remove all trailing whitespace on save

" -------------------------------------
" Custom file extension - file type mappings
autocmd FileType ruby let b:surround_35 = "#{\r}"
autocmd FileType ruby let b:surround_58 = ":\r"
au BufRead,BufNewFile *.go set ft=go
au BufRead,BufNewFile *.md set ft=markdown
au BufRead,BufNewFile *.hamljs,*.hamlc set ft=haml
au BufRead,BufNewFile *.god,*.supergod,Capfile set ft=ruby

" -------------------------------------
" Code folding
" * to toggle a fold on command mode use _
" * to toggle a fold on insert mode use C-_
"
" Fold mode is set to indent (making fold automatic) and the fold level is set
" to 100. This makes folding behave like 'manual' but using the codes indentation!
set foldmethod=indent
set foldlevel=100
nnoremap _ za
inoremap <C-_> <C-O>za

nnoremap f1 :set foldlevel=1<cr>
nnoremap f2 :set foldlevel=2<cr>
nnoremap f3 :set foldlevel=3<cr>
nnoremap f4 :set foldlevel=4<cr>
nnoremap f5 :set foldlevel=5<cr>
nnoremap f6 :set foldlevel=6<cr>
nnoremap f0 :set foldlevel=100<cr>


" -------------------------------------
" CTags
" * T - navigate to (normal and visual modes)
" * B - navigate back (normal and visual modes)
" * N - jump to the next match
" * P - jump to the previous match
set tags+=.tags
nnoremap T <C-]>
nnoremap N :tn<CR>
nnoremap P :tp<CR>
nnoremap B <C-T>
vnoremap T <C-]>
vnoremap B <C-T>
vnoremap N :tn<CR>
vnoremap P :tp<CR>

" regenerate ctags everytime a file is saved!
autocmd BufWritePost *.rb,*.js,*.css,*.sass,*.scss,*.coffee silent !ctags -R -f .tags 2>/dev/null &

" -----------------------------------
" tmux compatibility stuff..
if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

"-------------------------------------
" Key Mappings

" moving lines up and down
nnoremap <C-Up> :m .-2<CR>==
nnoremap <C-Down> :m .+1<CR>==

" moving caret between panes
nnoremap <S-Down> <C-W><C-J>
nnoremap <S-Up> <C-W><C-K>
nnoremap <S-Right> <C-W><C-L>
nnoremap <S-Left> <C-W><C-H>

" buffer navigation...
map gd :bd<CR>
map gn :bn<cr>
map gp :bp<cr>

" ------------------------------------
" Vundle!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'L9'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
" Bundle 'FuzzyFinder'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'junegunn/vim-easy-align'
Bundle 'Valloric/YouCompleteMe'
Bundle 'szw/vim-ctrlspace'
Bundle 'milkypostman/vim-togglelist'

" All of these are for the snippets!!
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

" Language plugins...
Bundle 'jnwhiteh/vim-golang'
Bundle 'plasticboy/vim-markdown'

" Plugin Configs...

" au VimEnter * NERDTree
" au BufWinEnter * NERDTreeMirror
nmap <silent> <F12> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize = 22
let g:NERDTreeDirArrows = 0

" Setup YCM key to C-TAB in order to be compatible with vim-snipmate
" SuperTab will call C-TAB when snipmate doesn't answer to it..
let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-TAB>'
let g:ycm_min_num_of_chars_for_completion = 4

let g:ctrlspace_use_mouse_and_arrows_in_term = 1
let g:ctrlspace_save_workspace_on_exit = 1
let g:ctrlspace_load_last_workspace_on_start = 1

" Popup menu color config...
highlight Pmenu ctermfg=0 ctermbg=4 guifg=#ffffff guibg=#0000ff

" let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<c-t>'],
"     \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
"     \ }

" -----------------------------------
" Find in Project
" * C-f starts the grep (be sure to have ack-grep installed)
" * Results get stored on the Quickfix List, F6 toggles that list on and off
nnoremap <C-f> :grep
nmap <script> <silent> <F7> :call ToggleLocationList()<CR>
nmap <script> <silent> <F6> :call ToggleQuickfixList()<CR>


" ---------------------------------------
" Required Debian Packages
"
" sudo apt-get install ack-grep
" sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

