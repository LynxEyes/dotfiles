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
set clipboard=unnamedplus
set fileformat=unix
set hidden " allows for unsaved buffers to be hidden

" ------------------------------------
"  GUI options
if has("gui_running")
  set go-=T " no toolbar
  set go-=r " no scrollbar on right
  set go-=L " no scrollbar on left
  set guifont=InputMono
  colorscheme twilight
else
  set t_Co=256
  colorscheme twilight256
endif

" set term=xterm
"
" set dir=~/.vimswap//,/var/tmp//,/tmp//,.
set dir=$VIMSWPPATH,.
set pastetoggle=<F2>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" duplicate the current line
nnoremap <C-D> :t.<cr>
inoremap <C-D> <ESC>:t.<cr>i
inoremap <C-L> <ESC>O

" Tab and S-Tab identation in visual mode
vnoremap <Tab>    >gV
vnoremap <S-Tab>  <gV
vnoremap <C-Up>   :m '<-2<CR>gv
vnoremap <C-Down> :m '>+1<CR>gv

au BufRead,BufNewFile * if &modifiable | set fileformat=unix | endif
autocmd FileType gitcommit setlocal spell spelllang=en_us
autocmd FileType markdown setlocal spell spelllang=en_us
" autocmd FileType mail setlocal spell spelllang=pt_pt

fun! SetupSpellPT()
  setlocal spell spelllang=pt_pt,en
  hi clear SpellBad
  hi clear SpellLocal
  hi SpellBad ctermfg=darkred
  hi SpellLocal cterm=underline ctermfg=yellow
endfun
autocmd FileType mail call SetupSpellPT()
" nnoremap f8 :call Sethl()<cr>

" z= to see suggestions
" zg to add word as valid spell to the whitelist (added to spellfile)
" zug to remove
" zw to add word as invalid spell
" zuw to remove

" command W w
" command Q q

" -------------------------------------
" HEREDOC SQL highlight
" ~/.vim/after/syntax/ruby.vim

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

" ---------------------------------------
" Mouse stuff
set mousehide " hides mouse when typing
set mouse=a   " allows mouse in all modes

" --------------------------------------
" Misc Stuff...

fun! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType mail,md,markdown let b:noStripWhitespace=1

" Match trailing whitespace and paint it darkgray
highlight ExtraWhitespace ctermbg=darkgray
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

highlight SignColumn ctermbg=none
highlight SignColumn guibg=none

" autocmd BufWritePre * :%s/\s\+$//e " Remove all trailing whitespace on save

autocmd FileType ruby let b:surround_35 = "#{\r}"
autocmd FileType ruby let b:surround_58 = ":\r"
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.hamljs,*.hamlc set filetype=haml
au BufRead,BufNewFile *.god,*.supergod set ft=ruby
au BufRead,BufNewFile Capfile set ft=ruby
au BufRead,BufNewFile *.jbuilder set ft=ruby
au BufRead,BufNewFile *.dust set ft=dustjs
au BufRead,BufNewFile *.slim set ft=slim
au BufRead,BufNewFile *.ejs set ft=jst
au BufRead,BufNewFile *.coffee set ft=coffee
au BufRead,BufNewFile *.rs set ft=rust
au BufRead,BufNewFile *.ex set ft=elixir
au BufRead,BufNewFile *.exs set ft=elixir
au BufRead,BufNewFile *.hbs set ft=handlebars

" code folding - manual
" to toggle a fold on command mode use _
" to toggle a fold on insert mode use C-_
set foldmethod=indent
set foldlevel=100
nnoremap _ za
nnoremap f1 :set foldlevel=1<cr>
nnoremap f2 :set foldlevel=2<cr>
nnoremap f3 :set foldlevel=3<cr>
nnoremap f4 :set foldlevel=4<cr>
nnoremap f5 :set foldlevel=5<cr>
nnoremap f6 :set foldlevel=6<cr>
nnoremap f0 :set foldlevel=100<cr>

inoremap <C-_> <C-O>za


autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
autocmd FileType conf,fstab,yaml  let b:comment_leader = '# '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,# :<C-B>silent <C-E>s/^\( *\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,! :<C-B>silent <C-E>s/^\( *\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>


" -------------------------------------
" CTags
" " T - navigate to (normal and visual modes)
" " B - navigate back (normal and visual modes)
set tags+=.tags
nnoremap T <C-]>
nnoremap N :tn<CR>
nnoremap M :tp<CR>
nnoremap B <C-T>
vnoremap T <C-]>
vnoremap B <C-T>
vnoremap N :tn<CR>
vnoremap M :tp<CR>

nnoremap <C-f> :grep

" regenerate ctags everytime a file is saved!
autocmd BufWritePost *.rb,*.js,*.css,*.sass,*.scss,*.coffee silent !ctags -R -f .tags 2>/dev/null &


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
inoremap <C-Up>   <ESC>:m .-2<CR>==i
inoremap <C-Down> <ESC>:m .+1<CR>==i

" moving caret between panes
nnoremap <S-Down> <C-W><C-J>
nnoremap <S-Up> <C-W><C-K>
nnoremap <S-Right> <C-W><C-L>
nnoremap <S-Left> <C-W><C-H>

" resizing panes
nnoremap <leader><Left> :vertical resize -2<CR>
nnoremap <leader><Right> :vertical resize +2<CR>
nnoremap <leader><Up> :resize -2<CR>
nnoremap <leader><Down> :resize +2<CR>

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
Bundle 'terryma/vim-multiple-cursors'
Bundle 'MattesGroeger/vim-bookmarks'
Bundle 'wesQ3/vim-windowswap'
Bundle 'ecomba/vim-ruby-refactoring'

" All of these are for the snippets!!
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'


" Language plugins...
Bundle 'jnwhiteh/vim-golang'
Bundle 'rust-lang/rust.vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'plasticboy/vim-markdown'
Bundle 'briancollins/vim-jst'
Bundle 'groenewege/vim-less'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-rails'
Bundle 'kchmck/vim-coffee-script'
Bundle 'guns/vim-clojure-highlight'
Bundle 'nono/vim-handlebars'
Bundle 'mxw/vim-jsx'

" Bundle 'ngmy/vim-rubocop'
Bundle 'scrooloose/syntastic'

" Plugin Configs...
let g:gitgutter_override_sign_column_highlight = 0

let g:airline_powerline_fonts = 1

let g:ctrlp_working_path_mode = '0'

" au VimEnter * NERDTree
" au BufWinEnter * NERDTreeMirror
nmap <silent> <F12> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize = 22
" let g:NERDTreeDirArrows = 0
let g:NERDTreeMouseMode = 2
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" let g:NERDTreeHighlightCursorline=1

" Setup YCM key to C-TAB in order to be compatible with vim-snipmate
" SuperTab will call C-TAB when snipmate doesn't answer to it..
let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-TAB>'
let g:ycm_min_num_of_chars_for_completion = 4

" let g:ctrlspace_use_mouse_and_arrows_in_term = 1
" let g:ctrlspace_save_workspace_on_exit = 1
" let g:ctrlspace_load_last_workspace_on_start = 1
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1


" Popup menu color config...
highlight Pmenu ctermfg=0 ctermbg=4 guifg=#ffffff guibg=#0000ff

" let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<c-t>'],
"     \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
"     \ }

nmap <script> <silent> <F7> :call ToggleLocationList()<CR>
nmap <script> <silent> <F8> :call ToggleQuickfixList()<CR>

let g:multi_cursor_start_key='<F6>'
" let g:multi_cursor_start_key='g<C-m>'
let g:multi_cursor_start_word_key='<C-m>'
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-u>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'


let g:syntastic_ruby_checkers = ['rubocop']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_manage_per_buffer = 1

" Finds the Git super-project directory.
function! g:BMWorkDirFileLocation()
    let filename = 'bookmarks'
    let location = ''
    if isdirectory('.git')
        " Current work dir is git's work tree
        let location = getcwd().'/.git'
    else
        " Look upwards (at parents) for a directory named '.git'
        let location = finddir('.git', '.;')
    endif
    if len(location) > 0
        return location.'/'.filename
    else
        return getcwd().'/.'.filename
    endif
endfunction
