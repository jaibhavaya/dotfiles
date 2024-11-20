" Vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'          " Fuzzy finder for Vim
Plugin 'preservim/nerdtree'        " Filesystem tree explorer
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Shougo/neocomplete.vim'
Plugin 'tpope/vim-commentary'
Plugin 'mhartington/oceanic-next'

call vundle#end()
filetype plugin indent on

" Theme
 syntax enable

" for vim 8
 if (has("termguicolors"))
  set termguicolors
 endif

colorscheme OceanicNext


" Basic settings
set number
set hlsearch
syntax on

" Key mappings
map - :NERDTreeToggle<CR>          " Toggle NERDTree
nnoremap <silent> <S-CR> :FZF<CR>

" Maximizing/resetting panels
nnoremap <leader>m :mksession! /tmp/vim_session.vim<CR><C-w>o
nnoremap <leader>r :source /tmp/vim_session.vim<CR>

" Commenting
noremap \ :Commentary<CR>

" Ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal commentstring=#\ %s
