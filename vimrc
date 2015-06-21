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
