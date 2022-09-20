set nocompatible 
syntax enable
filetype plugin on
set expandtab
set shiftwidth=4
:set tabstop=4
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
" colorscheme PaperColor

" BEGIN INITIAL CONFIGURATION

let g:ale_fixers = {
\	'typescript': ['prettier', 'eslint'],
\	'javascript': ['prettier', 'eslint'],
\	'html': ['prettier'],
\	'scss': ['prettier', 'stylelint'],
\   'tex': ['latexindent']
\}	
let g:ale_linters = {
\   'c': ['clang'],
\   'cpp': ['clang', 'g++'],
\	'html': ['prettier'],
\	'scss': ['stylelint'],
\   'tex': ['latexindent']
\}

" let g:ale_cpp_gcc_options = '-std=c++11'
let g:ale_completion_enabled = 1
let g:ale_lint_delay = 200
let g:ale_fix_on_save = 1

" END INITIAL CONFIGURATION

" BEGIN KEYBINDS

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>c :Commits<CR>
nnoremap <silent> <Leader>s :GFiles?<CR>
nnoremap <silent> <Leader>p :Files<CR>

" END KEYBINDS

call plug#begin()

" BEGIN LIST OF PLUGINS

Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'turbio/bracey.vim'
Plug 'puremourning/vimspector'

" END LIST OF PLUGINS

call plug#end()

" BEGIN ADDITIONAL CONFIGURATION

" END ADDITIONAL CONFIGURATION

