filetype plugin on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set copyindent
:nmap <silent> <C-k> :NERDTreeToggle<CR>
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'

call plug#end()

"FZF"
map <C-f> <Esc><Esc>:Files!<CR>
inoremap <C-f> <Esc><Esc>:BLines!<CR>
map <C-g> <Esc><Esc>:BCommits!<CR>

"Line numbers
:set number relativenumber
:set nu rnu
