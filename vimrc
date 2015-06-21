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
