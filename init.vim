" Default settings before we go anywhere
syntax on
filetype plugin indent on
set conceallevel=0
set guifont="Fira Nerd Code"
set showtabline=0

call plug#begin('~/.vim/plugged')

" Fugitive gives a simple git interface accessible via :G or :Git
Plug 'tpope/vim-fugitive'

" Useful plugin for managing surroundings and so on
Plug 'tpope/vim-surround'

" Creates a startup page to remind me what I was doing
Plug 'mhinz/vim-startify'

" Fuzzy finder for searching various things
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'monkoose/fzf-hoogle.vim'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'artanikin/vim-synthwave84'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Alignment
Plug 'junegunn/vim-easy-align'

" File Tree, :e .
Plug 'scrooloose/nerdtree'

" LSP
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Jump to a spot in the current view
Plug 'easymotion/vim-easymotion'

" Git gutter to highlight what has changed inside a file
Plug 'airblade/vim-gitgutter'

" Language client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }

" Rooter, helps locate the project root for use with the fuzzy finder
Plug 'airblade/vim-rooter'

" Syntax Range, for defining a region in which the syntax is different
Plug 'inkarkat/vim-SyntaxRange'

" Haskell
Plug 'Shougo/unite.vim'
Plug 'ujihisa/unite-haskellimport'
Plug 'neovimhaskell/haskell-vim'
Plug 'jaspervdj/stylish-haskell'
Plug 'itchyny/vim-haskell-indent'

" JavaScript
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'

" Vue
Plug 'leafoftree/vim-vue-plugin'

" Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()


" -------------------------------------
" 	 CoC configuration
" -------------------------------------
let g:coc_global_extensions = [ 'coc-vetur', 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml']

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Rename word in open buffers
nmap <leader>rr <Plug>(coc-rename)

" Open a buffer containing all the instances of the word the cursor is on
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Allow using tab for autocomplete
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunctio

nmap <leader>t <Plug>(coc-codelens-action)

" -------------------------------------
" 		Visual
" -------------------------------------
set fillchars+=vert:│

" Enable non-ugly colours
set termguicolors

" Set line numbers
set relativenumber
set number

" Set theme
colorscheme synthwave84

" Enable the status line
let g:airline#extensions#tabline#enabled = 1

" Set airline theme
let g:airline_theme='bubblegum'

" Set airline icons
let g:airline_powerline_fonts = 1

" Start NerdTree and move the cursor back
autocmd VimEnter * NERDTree | wincmd p

" -------------------------------------
" 		Fixes & Useful bindings
" -------------------------------------
" Ignore stuff ignored by .gitignore
let $FZF_DEFAULT_COMMAND = 'rg --files'

" Stop startify from messing with project roots, which allows rooter to work
let g:startify_change_to_dir = 0

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

" Get rid of arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Define command to navigate to .init
command! -nargs=0 Econf :e $MYVIMRC

" Define another command to reload it
command! -nargs=0 Rconf :source $MYVIMRC

" Define a command to delete the current file
command! -nargs=0 Delcurrent :!rm %

" Define shortcuts for fuzzy finding like VSCode

" Files:
nnoremap <C-p> :FZF<CR>

" Text:
nnoremap <C-f> :Lines<CR>

" Allow rooter to find project roots
let g:rooter_patterns = ['.git', 'package.json', 'stack.yaml']

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
" 		 Haskell Configuration
" -------------------------------------
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Map stylish haskell file-formatting to CTRL + Shift + L
nmap <C-S-l> :%!stylish-haskell<CR>

" Define region block for SyntaxRange
call SyntaxRange#Include('\[hsx|', '|\]', 'html', 'NonText')

" -------------------------------------
" 		 Vue
" -------------------------------------
let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

" -------------------------------------
" 		 Trim Whitespace
" -------------------------------------

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Make a command for trimming whitespace
command! TrimWhitespace call TrimWhitespace()

" Automatically call this function on save.
autocmd BufWritePre * :call TrimWhitespace()
