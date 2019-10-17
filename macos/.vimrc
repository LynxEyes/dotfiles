" -----------------------------------------
" General stuff
set encoding=utf-8
set nocompatible
set number
set incsearch
set hlsearch
set expandtab
set smarttab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set nowrap
set grepprg=gawk
set grepformat=%f:%l:%m
set textwidth=0
set wrapmargin=0
set clipboard=unnamed
set fileformat=unix
set hidden " allows for unsaved buffers to be hidden
set backspace=2
set colorcolumn=81,121
set cursorline

" ------------------------------------
"  GUI options
if has("gui_running")
  set go-=T " no toolbar
  set go-=r " no scrollbar on right
  set go-=L " no scrollbar on left
  set guifont=InputMono:h13
  colorscheme onedark
else
  set t_Co=256
  " colorscheme twilight256
  colorscheme onedark
endif

" set term=xterm
"
" set dir=~/.vimswap//,/var/tmp//,/tmp//,.
silent exec "! makevimswp"
set dir=$VIMSWPPATH,./.git/vimswp/,.
set pastetoggle=<F2>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Tab and S-Tab identation in visual mode
vnoremap <Tab>    >gV
vnoremap <S-Tab>  <gV

au BufRead,BufNewFile * if &modifiable | set fileformat=unix | endif
autocmd FileType gitcommit setlocal spell spelllang=en_us
autocmd FileType markdown setlocal spell spelllang=en_us
" autocmd FileType mail setlocal spell spelllang=pt_pt

" fun! SetupSpellPT()
"   setlocal spell spelllang=pt_pt,en
"   hi clear SpellBad
"   hi clear SpellLocal
"   hi SpellBad ctermfg=darkred
"   hi SpellLocal cterm=underline ctermfg=yellow
" endfun
" autocmd FileType mail call SetupSpellPT()
nnoremap zz 1z=
inoremap <C-Z> <ESC>1z=i
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
" highlight SignColumn guibg=none

" autocmd BufWritePre * :%s/\s\+$//e " Remove all trailing whitespace on save

autocmd FileType ruby let b:surround_35 = "#{\r}"
autocmd FileType ruby let b:surround_58 = ":\r"
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.ru set filetype=ruby
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
au BufRead,BufNewFile *.conf.erb set ft=nginx
au BufRead,BufNewFile *.conf set ft=nginx

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

autocmd FileType c,cpp,java,scala,javascript,typescript let b:comment_leader = '// '
autocmd FileType conf,fstab,yaml  let b:comment_leader = '# '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType clojure          let b:comment_leader = '; '
noremap <silent> ,# :<C-B>silent <C-E>s/^\( *\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,! :<C-B>silent <C-E>s/^\( *\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>


" -------------------------------------
" CTags
" " T - navigate to (normal and visual modes)
" " B - navigate back (normal and visual modes)
set tags+=.git/.tags
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
" autocmd BufWritePost *.rb,*.js,*.css,*.sass,*.scss,*.coffee silent !ctags -R --exclude=@.ctagsignore -f .git/.tags 2>/dev/null &
" autocmd BufWritePost *.rb,*.js,*.css,*.sass,*.scss,*.coffee silent !ctags -R --tag-relative=yes -f ./.git/.tags 2>/dev/null &
command CT execute '!ctags -R --tag-relative=yes --exclude=@$HOME/.ctagsignore -f ./.git/.tags 2>/dev/null'

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
" nnoremap <C-Up> :m .-2<CR>==
" nnoremap <Esc><Esc>[A :m .-2<CR>==
" nnoremap <Esc><Esc>[B :m .+1<CR>==
" vnoremap <Esc><Esc>[A :m '<-2<CR>gv
" vnoremap <Esc><Esc>[B :m '>+1<CR>gv
inoremap <S-C-Up>   <ESC>:m .-2<CR>==i
inoremap <S-C-Down> <ESC>:m .+1<CR>==i
nnoremap <S-C-Up>   :m .-2<CR>
nnoremap <S-C-Down> :m .+1<CR>
vnoremap <S-C-Up>   :m '<-2<CR>gv
vnoremap <S-C-Down> :m '>+1<CR>gv

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

nnoremap <C-t> :terminal ++rows=25<CR><C-w>r

" ------------------------------------
" Vundle!
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'L9'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/vim-easy-align'
Plugin 'ajh17/VimCompletesMe'
Plugin 'szw/vim-ctrlspace'
" Plugin 'milkypostman/vim-togglelist'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'wesQ3/vim-windowswap'
Plugin 'editorconfig/editorconfig-vim'
" Plugin 'ecomba/vim-ruby-refactoring'

Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

" All of these are for the snippets!!
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" lugin 'honza/vim-snippets'


" Language plugins...
" Plugin 'jnwhiteh/vim-golang'
Plugin 'elixir-lang/vim-elixir'
Plugin 'plasticboy/vim-markdown'
" Plugin 'briancollins/vim-jst'
" Plugin 'groenewege/vim-less'
Plugin 'slim-template/vim-slim'
" Plugin 'tpope/vim-rails'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'guns/vim-clojure-highlight'
" Plugin 'nono/vim-handlebars'
Plugin 'pangloss/vim-javascript'
" Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'chr4/nginx.vim'
" Plugin 'leafgarland/typescript-vim'
" Plugin 'digitaltoad/vim-pug'
" Plugin 'rhysd/vim-crystal'

" Plugin 'scrooloose/syntastic'

call vundle#end()            " required
filetype plugin indent on
" Plugin Configs...
let g:gitgutter_override_sign_column_highlight = 0
autocmd BufWritePost * GitGutter

let g:airline_powerline_fonts = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'r'
set wildignore+=*/node_modules/*,*/dist/*

" au VimEnter * NERDTree
" au BufWinEnter * NERDTreeMirror
nmap <silent> <F12> :NERDTreeFind %<CR>:NERDTreeMirror<CR>
nmap <silent> <F10> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize = 32
" let g:NERDTreeDirArrows = 0
let g:NERDTreeMouseMode = 2
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowHidden=1
" let g:NERDTreeHighlightCursorline=1

" Setup YCM key to C-TAB in order to be compatible with vim-snipmate
" SuperTab will call C-TAB when snipmate doesn't answer to it..
let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
let g:ycm_min_num_of_chars_for_completion = 4

let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1


" Popup menu color config...
highlight Pmenu ctermfg=0 ctermbg=4 guifg=#ffffff guibg=#0000ff

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
" let g:syntastic_typescript_checkers = ['tslint']

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
"

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
