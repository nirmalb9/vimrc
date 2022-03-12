set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" Enable neovim terminal coloring
let g:doom_one_terminal_colors = v:true


" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-sensible'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'yegappan/mru'
Plugin 'solarnz/thrift.vim'
Plugin 'psf/black'
Plugin 'vim-syntastic/syntastic'
Plugin 'fatih/vim-go'
Plugin 'neoclide/coc.nvim'
Plugin 'romgrk/doom-one.vim'
Plugin 'ludovicchabant/vim-gutentags'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

set noerrorbells
set nu
set smartcase
set noswapfile
set incsearch

" Tab settings for python
autocmd FileType python set tabstop=2|set shiftwidth=2|set expandtab

" Tab settings
" On pressing tab, insert two spaces
" set smartindent
" set expandtab 
" Show existing tab with 2 spaces width
" set tabstop=2
" set softtabstop=2
" When indenting with ">", use 2 spaces width
" set shiftwidth=2

highlight ColorColumn ctermbg=0 guibg=lightgrey

" Leader
let leader = '\'

" Enable Folding
set foldmethod=indent
set foldlevel=99

" Enable folding with spacebar
nnoremap <space> za


" Flag unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Delete key
set backspace=indent,eol,start

" UTF-8 Support
set encoding=utf-8

" Syntax Coloring
let python_highlight_all=1

" Colorscheme 
set t_Co=256
" set t_ut=
" colorscheme codedark
colorscheme doom-one
"

" Ag support Silver searcher
"
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

endif

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>


" Paste toggle
set pastetoggle=<F2>

" Clipboard settings
set clipboard=unnamed

" Cursor settings
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"Colorscheme configs
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark

"Powerline fonts
let g:airline_powerline_fonts = 1

"Github Link
function! CopyGitLink()
  let lineNumber = line(".")
  let filename = @%
  let root = "https://github.com/abnormal-security/source/tree/main/"
  let @+ = root . filename . "#L" . lineNumber
  echo "Copied URL into clipboard"
endfunction
nnoremap <leader>y :call CopyGitLink()<CR>

"Copy testing case
function! PytestCommand()
  let filename = @%
  let pieces = split(filename, "/")
  let relativeName = join(pieces[2:-1], "/")
  echo relativeName
  let @+ = "run_pytests --skip-airflow-db --nomigrations " . relativeName
endfunction
nnoremap <leader>p :call PytestCommand()<CR>

"Copy Import Statement
function! CopyImportStatement()
  let filename = @%
  let pieces = split(filename, "/")
  let module = substitute(pieces[-1], ".py", "", "g")
  let path = join(pieces[2:-2], ".")
  let @+ = "from " . path . " import " . module
endfunction
nnoremap <leader>i :call CopyImportStatement()<CR>

"Copy Import All
function! CopyImportAll()
  let filename = @%
  let pieces = split(substitute(filename, ".py$", "", "g"), "/")
  let path = join(pieces[2:-1], ".")
  let @+ = "from " . path . " import *"
endfunction
nnoremap <leader>I :call CopyImportAll()<CR>

" Wildmenu completion: use for file exclusions"
 set wildmenu
 set wildmode=list:longest
 set wildignore+=.hg,.git,.svn " Version Controls"
 set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
 set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
 set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
 set wildignore+=*.spl "Compiled speolling world list"
 set wildignore+=*.sw? "Vim swap files"
 set wildignore+=*.DS_Store "OSX SHIT"
 set wildignore+=*.luac "Lua byte code"
 set wildignore+=migrations "Django migrations"
 set wildignore+=*.pyc "Python Object codes"
 set wildignore+=*.orig "Merge resolution files"
 set wildignore+=*.class "java/scala class files"
 set wildignore+=*/target/* "sbt target directory"

" Ignore some files for CtrlP acceleration
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(aux|out|toc|jpg|bmp|gif|png|jpeg|o|obj|exe|dll|manifest|spl|sw|DS_STORE|luac|pyc|orig|class)$',
  \ }

let g:ctrlp_cache_dir = '~/.cache/ctrlp'

" Relative line numbering
:set relativenumber


" Shortcut for MRU menu
nnoremap <leader>m :MRU <CR>

" Cut from void register, then replace with default register
" TODO: Need something that replace the current line in normal mode
vnoremap <leader>P "_dP

" Black formatter configuration
let g:black_virtualenv = "~/.vim/pack/python/start/black"
" let g:black_virtualenv = "~/.vim/bundle/black"

" Run Black on key press 
nnoremap <leader>f :Black<CR>

" Replace all
nnoremap <leader>a yiw:%s/\<<C-r>"\>//g<left><left>

" Replace within the same line
nnoremap <Leader>s :s/\<<C-r><C-w>\>/

" Replace within a visual block
vnoremap <leader>b :s/<C-r><left>


" Comments
function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\#/
  elseif ext == 'js' || ext == 'scala'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^\#//
  elseif ext == 'js' || ext == 'scala'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction

map <C-a> :call Comment()<CR>
map <C-b> :call Uncomment()<CR>

" Highlight TODO and FIXME
" http://stackoverflow.com/questions/11709965/vim-highlight-the-word-todo-for-every-filetype
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
augroup END


" Autocompletion of braces
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha


" Syntastic
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_pylint_exec = '/Users/nirmalb/opt/anaconda3/envs/abnormal/bin/pylint'
let g:syntastic_python_pylint_args = '--rcfile /Users/nirmalb/source/.pylintrc'

nnoremap <leader>h :SyntasticCheck<CR>


" Vim go setup

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "gofmt"

" Go highlighting defaults
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" NerdTree Bindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" FZF Setup
nnoremap <C-p> :GFiles <CR>

" Gutentags setup
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir = "~/gutentags"

""
