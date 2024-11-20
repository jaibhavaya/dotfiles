set nocompatible              " Required for Vundle
filetype off                  " Required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle (required)
Plugin 'VundleVim/Vundle.vim'

" Plugins
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

call vundle#end()                  " Required
filetype plugin indent on          " Required

" Theme
 syntax enable
" for vim 7
 set t_Co=256

" for vim 8
 if (has("termguicolors"))
  set termguicolors
 endif

colorscheme OceanicNext

" Basic settings
set number
set hlsearch
syntax on
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

" Key mappings
map - :NERDTreeToggle<CR>          " Toggle NERDTree
nnoremap <silent> <S-CR> :FZF<CR>

" Maximizing/resetting panels
nnoremap <leader>m :mksession! /tmp/vim_session.vim<CR><C-w>o
nnoremap <leader>r :source /tmp/vim_session.vim<CR>

" Commenting
noremap \ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s

