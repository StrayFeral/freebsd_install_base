set nocompatible

if has("mouse")
    set mouse=a
endif

set hlsearch
set ignorecase
set incsearch
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set autoindent
set shiftwidth=4
"set softtabstop=4
set tabstop=4
set expandtab
set nu
set nobackup

filetype plugin on

" ALE configuration for Python
packadd! ale
let g:ale_linters = {'python': ['flake8', 'mypy', 'bandit']}
let g:ale_fixers = {'python': ['black', 'isort']}
let g:ale_linters = {'perl': ['perl', 'perlcritic']}
let g:ale_fixers = {'perl': ['perltidy']}
let g:ale_fix_on_save = 1
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"
" EVG: Display Perl::Critic errors as warnings
let g:ale_type_map = {'perl':{'ES':'WS'}, 'perlcritic':{'ES':'WS', 'E':'W'}}
nmap z :ALENext<cr>
nmap Z :ALEPrevious<cr>

