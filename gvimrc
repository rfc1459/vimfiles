"Addendum for gVim

"Tell base16 the "terminal" has 256 colors
set t_Co=256

"Set a sane(r) font on Windows
if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
endif
