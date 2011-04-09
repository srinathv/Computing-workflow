"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
"filetype plugin indent on
filetype plugin on
"
"" Switch syntax highlighting on, when the terminal has colors
"" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
syntax on
"
"
"
" Only do this part when compiled with support for autocommands.
if has("autocmd")
" Replace tabs by spaces for some files
"autocmd FileType c,cpp,html,pre,mac,f90,F90,f,F,sh,py: 
"autocmd FileType c,cpp,html,pre,mac,sh: set expandtab
  autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab
  autocmd FileType make setlocal noexpandtab

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

"  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Turn off any automatic indenting
set nosmartindent
set noautoindent
set indentexpr=

"set case insensitivity with smartcaseing
set ic
set scs


"fortran stuff
let s:extfname = expand("%:e")
if s:extfname ==? "f90""
  let fortran_free_source=1
  unlet! fortran_fixed_source
elseif s:extfname ==? "F90""
  let fortran_free_source=1
  unlet! fortran_fixed_source
else
  let fortran_fixed_source=1
  unlet! fortran_free_source
endif

:nnoremap <F8> :setl noai nocin nosi inde=<CR>



let g:miniBufExplSplitBelow=1
set laststatus=2                   " Display a status-bar.
"       statusline:  customize contents of the windows' status line.
"       Show the current buffer number and filename with info on
"       modification, read-only, and whether it is a help buffer
"       (show only when applied).
"       On right side, show current position with line+column+virtual_column:
 set   statusline=[%n]\ %f\ %(\ %M%R%H)%)%=%l\,%c%V\ %P

let s:extfname = expand("%:e")
if s:extfname ==? "otl"
    set background=light
else
    set background=dark
endif 

hi LineNr guifg=#552A7B guibg=Grey5 
"set gfn=Courier:h14
"set gfn=Courier:h16
"set gfn=AndaleMono:h16
set gfn=Monaco:h16
" For all text files set 'textwidth' to 78 characters.
set textwidth=120



" seting up use with tags:
set tags=.tags,../.tags,../../.tags
let Tlist_Ctags_Cmd='/opt/local/bin/ctags' 



map <unique> <Leader>ws1 <ESC>:highlight WhiteSpaceEol ctermbg=darkgreen guibg=lightgreen<CR><ESC>:match WhiteSpaceEOL /\(^\s*\)\@<=\ \\|\s\+$/<cr>
map <unique> <Leader>ws2 <ESC>:highlight WhiteSpaceEol ctermbg=darkgreen guibg=lightgreen<CR><ESC>:match WhiteSpaceEOL /^\ \+\\|\s\+$\\|\ \+\ze\t\\|\t\zs\ \+/<cr> 



map <unique> <Leader>wf <ESC>:highlight WhiteSpaceEol NONE<CR>


" lhs comments 

map ,# :s/^/#/<CR> 
map ,/ :s/^/\/\//<CR> 
map ,> :s/^/> /<CR> 
map ," :s/^/\"/<CR> 
map ,% :s/^/%/<CR> 
map ,! :s/^/!/<CR> 
map ,7 :s/^/c/<CR> 
map ,; :s/^/;/<CR> 
map ,- :s/^/--/<CR> 
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;c]//<CR> 

" wrapping comments 
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR> 
map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR> 
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR> 
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>


"change highlighting (space to get rid of after search)
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

