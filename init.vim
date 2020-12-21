" Default settings before we go anywhere
syntax on 
filetype plugin indent on

call plug#begin('~/.vim/plugged') 

" Fugitive gives a simple git interface accessible via :G or :Git
Plug 'tpope/vim-fugitive'

" Creates a startup page to remind me what I was doing
Plug 'mhinz/vim-startify'

" Fuzzy finder for searching various things
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status bar at the bottom containing various useful contextual info 
Plug 'vim-airline/vim-airline'

" Theme
Plug 'joshdick/onedark.vim'

" Alignment 
Plug 'junegunn/vim-easy-align'

" File Tree, :e . 
Plug 'scrooloose/nerdtree'

" LSP 
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}  

" Goyo mode for distraction free writing
Plug 'junegunn/goyo.vim'

" Jump to a spot in the current view 
Plug 'easymotion/vim-easymotion'

" Git gutter to highlight what has changed inside a file
Plug 'airblade/vim-gitgutter'

" Language client 
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }

" Haskell
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'Shougo/unite.vim'
Plug 'ujihisa/unite-haskellimport'  
Plug 'itchyny/lightline.vim'
Plug 'neovimhaskell/haskell-vim'

" JavaScript
Plug 'othree/yajs.vim'

call plug#end()


" -------------------------------------
" 	 CoC configuration 	
" -------------------------------------
let g:coc_global_extensions = [ 'coc-pairs', 'coc-vetur' 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml']

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


" Allow using tab for autocomplete
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" -------------------------------------
" 		Visual 
" -------------------------------------
set fillchars+=vert:│

" Enable non-ugly colours 
set termguicolors

" Set line numbers 
set number

" Set theme
colorscheme onedark 


" -------------------------------------
" 		Fixes 
" -------------------------------------

" Make the mouse work normally
set mouse=a 

" Use spaces and not tabs
set expandtab     
set tabstop=2     " Sets tab character to correspond to x columns.
                  " x spaces are automatically converted to <tab>.
                  " If expandtab option is on each <tab> character is converted to x spaces.
set softtabstop=2 " column offset when PRESSING the tab key or the backspace key.
set shiftwidth=2  " column offset when using keys '>' and '<' in normal mode.

" Allow for documentation lookups  
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunctio

" Get rid of arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


" -------------------------------------
" 		 Terminal & Splits 
" -------------------------------------

" Fix the terminal escape key
:tnoremap <Esc> <C-\><C-n>
" Make it so that when you attempt to swap splits in insert mode it auto-exits
" you from terminal mode
:tnoremap <C-b> <C-\><C-n><C-w>

" Make swapping between splits easier via using the tmux binding
nnoremap <C-b> <C-w>


" -------------------------------------
" 		 Haskell Configuration  
" -------------------------------------
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords


" -------------------------------------
" 		 Alignment  
" -------------------------------------

" Recommended default configuration for vim-easy-align
" Start an alignment with ga 
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" -------------------------------------
" 		 Easy Motion  
" -------------------------------------
" The rest of the bindings are pretty pointless, so f2 basically does
" everything
map <Leader>f <Plug>(easymotion-overwin-f2)


" -------------------------------------
" 		 Vue  
" -------------------------------------
let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }


