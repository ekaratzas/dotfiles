" tabs and whatnot
set tabstop=4 shiftwidth=4 expandtab
set nofixendofline

" used to port managed C++ to C#
function FixmcppFunc()
    :%s/\^//g
    :%s/->/./g
    :%s/nullptr/null/g
    :%s/::/./g
    :%s/unsigned long/ulong/g
    :%s/unsigned int/uint/g
    :%s/String/string/g
endfunction

" options for the days we're on windows
if has('win32')
    " mostly use vim on windows so set basic cosmetics here
    set termguicolors
    set background=dark
    colorscheme gruvbox
    " apparently backspace by default on vim doesnt do much
    set backspace=indent,eol,start
endif

let mapleader = " "

"
" custom commands
"
:command Fixmcpp call FixmcppFunc()
:command Whitespace :%s/\s\+$//g
:command Nonumbers set nonumber norelativenumber
:command Maximize :tabedit %

"
" remaps
"
" buffers
:nnoremap <C-l> :bn<CR>
:nnoremap <C-h> :bp<CR>
:nnoremap <leader>q :bw<Enter>
:nnoremap <leader>w :bw!<Enter>
" nnoremap <leader>b :buffer<space>
" nnoremap <leader>b :ls<cr>:b<space>
:nnoremap <leader>b :Buffers<CR>
:nnoremap <F9> <C-6>
" jump around
:nnoremap <C-d> <C-d>zz
:nnoremap <C-u> <C-u>zz
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap <C-n> :noh<CR>
:nnoremap W w
:nnoremap B b
:vnoremap W w
:vnoremap B b
map w  <Plug>(smartword-w)
map b  <Plug>(smartword-b)
map e  <Plug>(smartword-e)
map ge  <Plug>(smartword-ge)
:nnoremap <C-w> <C-w>w
" explore
map <leader>pv :Ex<CR>
" clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
" turn off recording
map q <Nop>
" git stuff
nnoremap <F3> :let bn = expand('%') <bar> execute 'tabnew' <bar> execute 'r !git blame ' . shellescape(bn)<CR>
nnoremap <F4> :let bn = expand('%') <bar> execute 'tabnew' <bar> execute 'r !git log ' . shellescape(bn)<CR>
"map <F3> :!git blame % > /tmp/git.blame<CR>:vsplit /tmp/git.blame<CR>
"map <F4> :!git log --abbrev-commit % > /tmp/git.log<CR>:vsplit /tmp/git.log<CR>
" reload all files from disk
nnoremap <F5> :bufdo e!

"
" search options
"
set ignorecase
set smartcase
set nohlsearch

"
" line numbers and such
"
set laststatus=2
set number
set relativenumber
set title
set scrolloff=10

"
" vim-cpp-modern plugin stuff
"
" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

" set cwd to current file's dir
set autochdir

" random stuff
"
" escape from insert to command mode is slow without this due to /usr/share/vim/vim82/debian.vim
" however, some termindal key codes or F keys will not function with a
" value this low, see
" https://vi.stackexchange.com/questions/16148/slow-vim-escape-from-insert-mode
set timeoutlen=1000
set ttimeoutlen=50

" assembly syntax highlighting
let asmsyntax="nasm"

" remove scratch buffer when using auto-complete
set completeopt-=preview

" use this alongside-> export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g \"\"'
" in .bashrc. File fuzzy finder will search from the git root if we're in a git repo
" C+P for file fuzzy finder
map <C-P> :GFiles <CR>

" syntax_cmd on debian* can affect the highlighting. The idea here is to use
" whatever colorscheme the terminal emulator has instead of whatever the
" debian package thinks we should use.
" on/enable/reset/skip
" Refer to /usr/share/vim/v*/syntax/syncolor.vim 
" However on nvim using catppucin plugin this doesn't seem to be required.
" Leaving it here just in case.
syntax on
let syntax_cmd="enable"

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

" make clipboard copy/paste work
" replacing set clipboard+=unnamed with the following seems to improve startup
" time for initial session in wsl. might also wanna just replace xsel with
" clip and be done with it.
if executable('xsel')
    let g:clipboard = {
            \ "name": "xsel - bin",
            \ "copy": {
            \   '+': '/usr/bin/xsel -i -b',
            \   '*': '/usr/bin/xsel -i -p',
            \   },
            \ "paste": {
            \   '+': '/usr/bin/xsel -b',
            \   '*': '/usr/bin/xsel -p',
            \   },
            \ 'cache_enabled': 0,
        \ }
endif
