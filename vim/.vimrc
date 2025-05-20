"Reloads your vim config Plugin Manager Setup
call plug#begin('~/.vim/plugged')

" UI & Theme
Plug 'morhetz/gruvbox'

" Editing Enhancements
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

" LSP & Syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'othree/html5.vim'
Plug 'tailwindlabs/tailwindcss-intellisense',
Plug 'pangloss/vim-javascript'
Plug 'yuezk/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'evanleck/vim-svelte'
Plug 'wuelnerdotexe/vim-astro'
Plug 'elzr/vim-json'
Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' }

Plug 'ryanoasis/vim-devicons'

" File Explorer & Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'

" Git Integration
Plug 'tpope/vim-fugitive'

" Utilities
Plug 'brooth/far.vim'

call plug#end()

" Leader Keys
let mapleader = " "
let maplocalleader = ","

" UI Settings
syntax on
set number
set relativenumber
set background=dark
set clipboard=unnamedplus
set backspace=2
set nocompatible
filetype on
filetype plugin indent on

" Highlight Search
set hlsearch

if has('termguicolors')
  set termguicolors
endif

colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Indentation
set smartindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Gruvbox Customization
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_improved_warnings = 1
" let g:gruvbox_improved_strings = 1

" NerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Filetype Detection
augroup FiletypeDetection
  autocmd!
  autocmd BufRead,BufNewFile *.html set filetype=html
  autocmd BufRead,BufNewFile *.css set filetype=css
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
  autocmd BufRead,BufNewFile *.astro set filetype=astro
  autocmd BufRead,BufNewFile *.svelte set filetype=svelte
augroup END

" Whitespace Cleanup
autocmd BufWritePre * :%s/\s\+$//e

" Keymaps
inoremap jk <ESC>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>g :Rg<CR>

" Yank to system clipboard
vnoremap y "+y
nnoremap y "+y
nnoremap Y "+Y

" Paste from system clipboard
nnoremap p "+p
nnoremap P "+P

" Clear Highlight
nnoremap <leader>ch :nohlsearch<CR>

" Replace selection without overwriting register
xnoremap p "_dP

" Comment
xmap gc <Plug>NERDCommenterToggle
nmap gc <Plug>NERDCommenterToggle

" Reloads vim config
nnoremap <leader>rl :source $MYVIMRC \| echo "Vim config reloaded ✅"<CR>

" Plug keymaps
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

" Open Coc config
nnoremap <leader>cf :CocConfig<CR>

" " CoC (Completion & Formatting)
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr> <C-Space> coc#refresh()
autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx :silent! call CocAction('format')
