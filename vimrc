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

"Tell Pathogen to bring everything in
execute pathogen#infect()

"Default indentation settings
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent

"Add Go to the runtime path
if !empty($GOROOT)
  set runtimepath+=$GOROOT/misc/vim
endif

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

"Set the color scheme
set background=dark
let base16colorspace=256
colorscheme base16-eighties

"Never *EVER* use modelines on versions of vim which are known to be
"vulnerable to sandbox escaping. The keyword is "known", by the way.
if v:version > 700 || v:version == 700 && has("patch234") && has("patch235")
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

"Always show the tabline
set showtabline=2

"Folding settings
set foldmethod=marker "Fold based on markers
set foldnestmax=3     "Deepest fold is 3 levels
set nofoldenable      "Don't fold by default

"vim-flagship hooks

"Display a warning if fileformat isn't unix
autocmd User Flags call Hoist("buffer", "%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*")

"Display a warning if file encoding isn't utf-8
autocmd User Flags call Hoist("buffer", "%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*")

"display a warning if &et is wrong, or we have mixed-indenting
autocmd User Flags call Hoist("buffer", "%#error#%{StatuslineTabWarning()}%*")

"Display a warning if there is trailing whitespace somewhere
autocmd User Flags call Hoist("buffer", "%#error#%{StatuslineTrailingSpaceWarning()}%*")

"Display a warning if &paste is set
autocmd User Flags call Hoist("buffer", "%#error#%{&paste?'[paste]':''}%*")

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[Trailing \s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[Trailing \s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning = '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction

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
