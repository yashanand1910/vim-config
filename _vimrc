set nocompatible 
syntax enable
filetype plugin on
set exrc
set hidden
set noerrorbells
set scrolloff=8
set smartcase
set ignorecase
set expandtab
set smartindent
set shiftwidth=4
set tabstop=4 softtabstop=4
set number relativenumber nohls incsearch
set backspace=indent,eol,start " For macOS
set wildmenu

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()

let g:tex_flavor='latex' 
let g:vimtex_view_method = 'skim' 
let g:vimtex_view_skim_sync = 1 
let g:vimtex_view_skim_activate = 1 

" BEGIN INITIAL CONFIGURATION

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" COC:
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" For JSON comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

let test#vim#term_position = "topleft 15"
let test#strategy = "vimterminal"

" END INITIAL CONFIGURATION

" BEGIN KEYBINDS

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
"
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Testing
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>A :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>G :TestVisit<CR>

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
Plug 'pangloss/vim-javascript'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'turbio/bracey.vim'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ayu-theme/ayu-vim'
Plug 'tpope/vim-surround' 
Plug 'vim-test/vim-test'
Plug 'tpope/vim-fugitive'

" END LIST OF PLUGINS

call plug#end()

" BEGIN ADDITIONAL CONFIGURATION

" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" fixes glitch? in colors when using vim with tmux
set background=dark
set t_Co=256
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" END ADDITIONAL CONFIGURATION

