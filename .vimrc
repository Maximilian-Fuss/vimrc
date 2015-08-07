" Basic settings --------------------{{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" The bundles you install will be listed here
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Bundle 'Valloric/YouCompleteMe'

Bundle 'davidhalter/jedi-vim'

Bundle 'shime/vim-livedown'

" Next activates Pathogen
call pathogen#infect()
call pathogen#helptags()

let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw
set timeout ttimeoutlen=50

" The rest of the config starts here
filetype plugin indent on
syntax enable
let g:solarized_termcolors=256
colorscheme solarized
set background=dark

set number
set guifont=Monospace\ 13
set incsearch 
set cursorline

" automatically resize windows to have the active buffer bigger than the
" others
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set hlsearch
set autoindent
set encoding=utf-8
set fileencoding=utf-8

set colorcolumn=80

set backspace=2 " make backspace work like most other apps

" this setting makes the shell interactive so that aliases can be used from
" within vim
" This causes vim to stop after executing some commands (i.e. 'fg" needs to be
" sent to shell in order to bring vim back to foreground) This is kindof
" annoying, so I need to fix this at some point.
set shellcmdflag=-ic

" Syntax highlighting mapping
map <F11>  :sp tags<CR>:%s/^\([^	:]*:\)\=\([^	]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
map <F12>  :so tags.vim<CR>


" make vim remember the position of the cursor when the file was last edited
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  endif

" include autotags
source ~/.vim/autotag.vim

" CTAGS: execute ctags in current directory, whenever the file is saved
" autocmd BufWritePost * silent :!rm tags; ctags src/*; ctags -a tests/*;

" tags: include petsc tags
set tags=./tags,./TAGS,tags,TAGS,/usr/lib/petscdir/3.6.0/CTAGS

" Save fold views
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" }}}

" Latex-suite settings --------------------{{{
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype on
filetype indent on
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" Note s.o.: having this option turned on in win64 can cause crashes.
" can be called correctly.
" set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" Next sets autocompletion of Latex to unicode
let g:latex_to_unicode_auto = 1


" There is something wrong with the debugging mode. This turns it off
" update 18.4.2015: The Issue seems to be resolved so this line is now
" commented out. Uncomment in case the issue comes up again.
" let g:Tex_GotoError=0

" Changing default output format to pdf
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_Flavor='pdflatex'
" }}}

" Mappings not specific to filetypes --------------------{{{
" The following lines are from the book 'learning vimscript the hard way'
"
" set mapleader to comma
let mapleader = ","

" Map the - and _ key to move a line up and down in the file
" Careful: when moving the top line, it will now be deleted. 
" This is a bug and i haven't figured it out yet as this behaviour doesn't
" occur, when pressing ddkP as a normal sequence. update: I think this has
" something to do with the way that vim behaves when the mapping {rhs}
" includes a command that can't be executed for some reason. E.g. when the
" cursor is on the top line and 'k' is pressed. In that case, vim seems to
" abort the mapping.
nnoremap <leader>- ddp
nnoremap <leader>_ ddkP

" map <leader><c-u> in insert mode to turn the current word to uppercase and move the
" abort the mapping.
nnoremap <leader>- ddp
nnoremap <leader>_ ddkP

" map <leader><c-u> in insert mode to turn the current word to uppercase and move the
" cursor to the end of the word. So in the end the cursor (marked by =) will
" be as follows: WORD= . Will leave the editor in insert mode after finishing
" the command
inoremap <leader><c-u> <esc>viwUea

" map the spacekey to highlight (visual) the current word
nnoremap <leader><space> viw

" create mapping to edit and source vimrc quickly
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" mapping to edit my notes file quickly
nnoremap <leader>en :split Desktop/notes.tex<cr>

" surround a word in double qoutes while in normal mode
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" mapping that encloses a selected visual area in double quotes
vnoremap <leader>" <esc>`<i"<esc>`>a"

" mappping H and L to go to beginning and end of line. Note that the default
" values for H and L are to go to bottom and top of window
nnoremap H 0
nnoremap L $

" mapping to get out of insertmode easier
inoremap jk <esc>

" show NERDTREE (mnemonics: 's'how 'n'erdtree)
nnoremap <leader>sn :NERDTree<cr>

" compile and run whatever file is currently being edited. Note that this
" functionality depends on the filetype, but the shortcut is universal to all
" filetypes.
" Mnemonics: 'r'un 'f'ile
"autocmd FileType python nnoremap <buffer> <leader>rf :!python %<cr>

" close all buffers except the current one.
" uses the script below
" Mnemonics: 'c'lose 'e'xcept
nnoremap <leader>ce :BufOnly<cr>


" mapping <leader>s to save a file. ':w' is annoying. Works in many modes. Mnemonics:
" 's'ave
inoremap <leader>s <esc>:w<cr>a
vnoremap <leader>s <esc>:w<cr>
nnoremap <leader>s :w<cr>

" Mapping to go to next placeholder
" Mnemonics: none, its just easy to type
" inoremap <leader>mm <esc>/<++><cr>:nohlsearch<cr>cf>

" Mapping to run Doxygen
nnoremap <leader>do :!doxygen Doxyfile; ln -s doc/html/index.html doc.html<cr>
" }}}

" Matlab file settings --------------------{{{
augroup filetype_matlab
  autocmd!
  autocmd FileType matlab nnoremap <buffer> <leader>c I%<space><esc>
augroup END

" Next is necessary for Matlab
source $VIMRUNTIME/macros/matchit.vim
autocmd BufEnter *.m    compiler mlint

" }}}

" C file settings -------------------{{{

" First one simply appends an error-check at the given position (i-mode)
" or at the end of the line (n-mode)
" Mnemonics: 'err'or check
autocmd FileType c inoremap <leader>err CHKERRQ(ierr);
autocmd FileType c nnoremap <leader>err $aCHKERRQ(ierr);<esc>

" shortcut to wrap whole line with error check
" Mnemonics: 'w'rap 'err' check
autocmd FileType c nnoremap <leader>werr :call CHKERRQToggle()<cr>

" Shortcut to edit c syntax file quickly
autocmd FileType c nnoremap <leader>es :sp ~/.vim/after/syntax/c.vim<cr>

" Shortcut to edit a header file
" Mnemonics: 'e'dit 'h'eader
autocmd Filetype c nnoremap <leader>eh :split %<.h<cr>

" This function is responsible for toggling the CHKERRQ macro, see above
" autocmd
function CHKERRQToggle()
  " first mark current position and return to start of line
  normal! ma
  normal! ^
  " then check if the first word is 'ierr'
  if expand("<cword>") == "ierr"
    normal! d2w$dFCd$`a
  else
    execute "normal! iierr = \<esc>$aCHKERRQ(ierr);\<esc>`a"
  endif
endfunction
" }}}

" Vimscript file settings --------------------{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim nnoremap <buffer> <leader>c I"<space><esc>
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Python filetype mappings user-created{{{

" Mapping to create print-statement. 
" Mnemonics: 'c'reate 'p'rint
autocmd FileType python inoremap <leader>cp print<space>""<space>%<space>(<++>)<++><esc>F"i
" }}}

" Abbreviations not specific to filetypes --------------------{{{

iabbrev ssig Viele Grüße<cr>Sebastian Otten
" }}}

" close all buffers except this one {{{
" BufOnly.vim - Delete all the buffers except the current/named buffer.
"
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license. See ":help license".
"
" Usage:
"
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer]
"
" Without any arguments the current buffer is kept. With an argument the
" buffer name/number supplied is kept.
command! -nargs=? -complete=buffer -bang Bonly
command! -nargs=? -complete=buffer -bang BufOnly
\ :call BufOnly('<args>', '<bang>')
function! BufOnly(buffer, bang)
if a:buffer == ''
" No buffer provided, use the current buffer.
let buffer = bufnr('%')
elseif (a:buffer + 0) > 0
" A buffer number was provided.
let buffer = bufnr(a:buffer + 0)
else
" A buffer name was provided.
let buffer = bufnr(a:buffer)
endif
if buffer == -1
echohl ErrorMsg
echomsg "No matching buffer for" a:buffer
echohl None
return
endif
let last_buffer = bufnr('$')
let delete_count = 0
let n = 1
while n <= last_buffer
if n != buffer && buflisted(n)
if a:bang == '' && getbufvar(n, '&modified')
echohl ErrorMsg
echomsg 'No write since last change for buffer'
\ n '(add ! to override)'
echohl None
else
silent exe 'bdel' . a:bang . ' ' . n
if ! buflisted(n)
let delete_count = delete_count+1
endif
endif
endif
let n = n+1
endwhile
if delete_count == 1
echomsg delete_count "buffer deleted"
elseif delete_count > 1
echomsg delete_count "buffers deleted"
endif
endfunction
" }}}

" Cleanup routines{{{

"clean up any searchhighlights
nohlsearch

" }}}

" Gundo settings {{{
nnoremap <leader>gu :GundoToggle<cr>

let g:gundo_width = 25
let g:gundo_preview_height = 20
" }}}

" Powerline settings {{{
" Powerline setup
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256
" }}}

" autohighlight script {{{

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
   else
     augroup auto_highlight
       au!
       au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
     augroup end
     setl updatetime=500
     echo 'Highlight current word: ON'
     return 1
   endif
 endfunction
 " }}}
 
 " YouCompleteMe Settings ----------------------{{{
 let g:ycm_confirm_extra_conf=0
 " }}}
 
 " Livedown settings"{{{
 " make sure that livedown is always run when entering a new buffer (i.e. the
 " preview needs to be kept up to date) and that browser window is opened the
 " first time, when vim is launched
let g:livedown_autorun=1
let g:livedown_open=1

" after vim is launched, turn off the automatic opening of windows or else
" there will be hundreds of windows
autocmd VimEnter *.markdown let g:livedown_open=0
 "}}}
