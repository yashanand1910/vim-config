syntax on
:set number relativenumber autochdir hls is
:set termwinsize=12x200

call plug#begin()

" BEGIN LIST OF PLUGINS

Plug 'mattn/emmet-vim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" END LIST OF PLUGINS

" BEGIN INITIAL CONFIGURATION

let g:ale_fixers = {
\	'typescript': ['prettier', 'eslint']
\}	

let g:deoplete#enable_at_startup = 1
let g:ale_lint_delay = 200

"END INITIAL CONFIGURATION

" BEGIN KEYBINDS

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" END KEYBINDS

call plug#end()

" BEGIN ADDITIONAL CONFIGURATION

call deoplete#custom#option('sources', {
\ '_': ['ale']
\})

" END ADDITIONAL CONFIGURATION

