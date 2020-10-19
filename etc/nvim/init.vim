let mapleader=","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'junegunn/goyo.vim'
Plug 'xuhdev/vim-live-latex-preview'
Plug 'preservim/nerdtree'
call plug#end()

" !!COLOURS!!
set bg=dark
set termguicolors
set t_Co=254
syntax on
set laststatus=0
set relativenumber
colorscheme gunmetal

set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus

" autocompletion
set wildmode=longest,list,full
" no commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Goyo plugin for ez reading
map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>
" Spellchecker
map <leader>o :setlocal spell! spelllang=en_GB<CR>
" Use sane splitting options
set splitbelow splitright

" Shortcuts for easy navigation of splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-j>l
" Run xrdb when you update Xresources
autocmd BufWritePost Xresources*,Xdefaults* !zrdb %

if &diff
	highlight! link DiffText MatchParen
endif
