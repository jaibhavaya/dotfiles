filetype plugin on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set copyindent
:nmap <silent> <C-k> :NERDTreeToggle<CR>
call plug#begin()
Plug 'thecodesmith/vim-groovy', {'for': 'kotlin'}
Plug 'udalov/kotlin-vim', {'for': 'kotlin'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'relastle/bluewery.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'BurntSushi/ripgrep'
Plug 'mileszs/ack.vim'
call plug#end()

"FZF"
map <C-f> <Esc><Esc>:Files!<CR>
inoremap <C-f> <Esc><Esc>:BLines!<CR>
map <C-g> <Esc><Esc>:BCommits!<CR>

"Line numbers
:set number relativenumber
:set nu rnu

"Theme
colorscheme bluewery-light
let g:lightline = { 'colorscheme': 'bluewery_light' }

" Prefer rg > ag > ack
if executable('rg')
    let g:ackprg = 'rg -S --no-heading --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
nnoremap \ :Ack<SPACE>
