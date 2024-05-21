"Matteo Panella's vimrc. Here be dragons...

"First order of business: we're not running plain vi
set nocompatible

"Second order of business: FIX THE DAMN HOME AND END KEYS
if !has('gui_running') && ($TERM =~ '^screen-256color')
  map <Esc>OH <Home>
  map! <Esc>OH <Home>
  map <Esc>OF <End>
  map! <Esc>OF <End>
endif

"Default indentation settings
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent

"Tab completion handling
set wildmode=list:full
set wildignore=*.o,*.obj,*~

"Viminfo settings
if has('viminfo')
  if !empty($SUDO_USER) && $USER !=# $SUDO_USER
    " NEVER EVER use .viminfo if we're running under sudo
    set viminfo=
  else
    set viminfo=!,'20,<50,s10,h
  endif
endif

"24 bit color support overrides for tmux
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Enable 24 bit color support
if has('termguicolors')
  set termguicolors
endif

"Set the color scheme
syntax on
colorscheme onedark

"Never *EVER* use modelines on versions of vim which are known to be
"vulnerable to sandbox escaping. The keyword is "known", by the way.
if v:version > 810 || v:version == 810 && has("patch1365")
  set modeline
  set modelines=5
else
  set nomodeline
  set modelines=0
endif

"Show current mode
set showmode

"Highlight parenthesis/braces matches
set showmatch

"Use incremental+highlight search
set incsearch
set hlsearch

"Show line numbers
set number

"Enable wrapping
set showbreak=...
set wrap linebreak

"Set line wrapping options
set formatoptions+=l

"Set text width to a sane value
set textwidth=78

"Also, default to UTF-8
set encoding=utf-8

"Highlight "problematic" whitespace
set list
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
  let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  let &fillchars = "vert:\u259a,fold:\u00b7"
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif

"Folding settings
set foldmethod=marker "Fold based on markers
set foldnestmax=3     "Deepest fold is 3 levels
set nofoldenable      "Don't fold by default

"Key bindings

"Navigate through display lines
nmap <Down> gj
nmap <Up> gk

"Don't exit to Ex mode, I fucked up too many times with this...
noremap Q gq

"Use <Tab> and <S-Tab> to navigate through (guess what?) tabs
nmap <Tab> gt
nmap <S-Tab> gT

"Quickfix keybindings
map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

"Tagbar keybindings
map <Leader>t :TagbarToggle<CR>
map <F8> :TagbarToggle<CR>

"Plugin configuration

"vim-airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1

"vim-json
let g:vim_json_syntax_conceal = 0   "Don't hide double quotes in JSON files

"Python (builtin)
let g:python_highlight_builtins=1   "Highlight Python builtins

"vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_interfaces = 1

"diffchar
let g:DiffUnit="Word1"

"vim-test
let test#strategy = "dispatch"

"Misc

"Jump back to the last position when opening a file except when writing commit
"messages
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  endif
endfunction
