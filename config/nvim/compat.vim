set tabstop=4 shiftwidth=4 expandtab
set nofixendofline

function FixmcppFunc()
    :%s/\^//g
    :%s/->/./g
    :%s/nullptr/null/g
    :%s/::/./g
    :%s/unsigned long/ulong/g
    :%s/unsigned int/uint/g
endfunction

:command Fixmcpp call FixmcppFunc()
:command Whitespace :%s/\s\+$//g

map <C-Right> :bn<CR>
map <C-Left> :bp<CR>
map <C-l> :bn<CR>
map <C-h> :bp<CR>

" use this alongside-> export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g \"\"'
" search from the git root if we're in a git repo
function! FZFProjectRoot()
    let project_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if strlen(project_root) > 0
        call fzf#run(fzf#wrap('FZFProjectRoot', {'dir': project_root}))
    else
        call fzf#run(fzf#wrap('FZFProjectRoot'))
    endif
endfunction

:set tags=~/tags
nmap <F8> :TagbarToggle<CR>
:nnoremap <C-w> <C-w>w
let g:vista_default_executive = 'ctags'

map <C-P> :call FZFProjectRoot()<CR>

" lightline + cosmetic stuff
" syntax_cmd on debian* can affect the highlighting. The idea here is to use
" whatever colorscheme the terminal emulator has instead of whatever the
" debian package thinks we should use.
" on/enable/reset/skip
" Refer to /usr/share/vim/v*/syntax/syncolor.vim 
syntax on
let syntax_cmd="enable"

set laststatus=2
set number
set relativenumber
command Nonumbers set nonumber norelativenumber
set title

" check :highlight in vim to see what's what
":highlight LineNr ctermfg=darkgrey
"hi Visual ctermfg=Yellow ctermbg=NONE cterm=bold,underline
"hi Search cterm=bold,underline ctermfg=grey ctermbg=NONE
"hi Constant ctermfg=red
"hi Statement ctermfg=yellow
"hi Delimeter ctermfg=yellow
"hi Special ctermfg=red
"hi NonText ctermfg=red
"set guicursor+=a:ver1
" work pc doesnt like background dark
"set background=light

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0

  " bind \ (backward slash) to grep shortcut
   command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
   nnoremap \ :Ag<SPACE>
endif
:set autochdir

" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

set ignorecase
set smartcase
set hlsearch
:nnoremap <C-n> :noh<CR>

:nnoremap <C-d> <C-d>zz
:nnoremap <C-u> <C-u>zz
:nnoremap n nzz
:nnoremap N Nzz

let asmsyntax="nasm"

" escape from insert to command mode is slow without this due to /usr/share/vim/vim82/debian.vim
" however, some termindal key codes or F keys will not function with a
" value this low, see
" https://vi.stackexchange.com/questions/16148/slow-vim-escape-from-insert-mode
set timeoutlen=1000
set ttimeoutlen=50

" remove scratch buffer when using auto-complete
set completeopt-=preview
