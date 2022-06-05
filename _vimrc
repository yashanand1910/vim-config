set nocompatible 
syntax enable
filetype plugin on

:set number relativenumber hls is
:set backspace=indent,eol,start " For macOS
set wildmenu

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()

set t_Co=256
set background=dark
set number
set laststatus=2
let g:PaperColor_Theme_Options = {
\	'theme': {
\		'default': {
\			'transparent_background': 1
\		}
\	}
\}
colorscheme PaperColor

" BEGIN INITIAL CONFIGURATION

let g:ale_fixers = {
\	'typescript': ['prettier', 'eslint'],
\	'html': ['prettier', 'eslint'],
\	'scss': ['prettier', 'stylelint']
\}	
let g:ale_linters = {
\	'html': ['eslint'],
\	'scss': ['stylelint']
\}

let g:ale_completion_enabled = 1
let g:ale_lint_delay = 200
let g:ale_fix_on_save = 1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" END INITIAL CONFIGURATION

" BEGIN KEYBINDS

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" END KEYBINDS

call plug#begin()

" BEGIN LIST OF PLUGINS

Plug 'mattn/emmet-vim'
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
" Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'

" END LIST OF PLUGINS

call plug#end()

" BEGIN ADDITIONAL CONFIGURATION

" END ADDITIONAL CONFIGURATION
