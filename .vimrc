" Common setup
set nu                                  "Line no
set nocp                                "Fix Arrow keys behaviour in insert mode
set mouse=a                             "Mouse support
syntax enable                           "Enable syntax highlighting
set expandtab                           "Use spaces instead of tabs
set smarttab                            "Use smart tabs
set shiftwidth=4                        "1 tab == 4 spaces
set tabstop=4
set wrap                                "Wrap lines
set ai                                  "Auto indent
set si                                  "Smart indent
set noerrorbells                        "No sounds/errors
set novisualbell
set smartcase                           "Smart about cases while searching
set hlsearch                            "Highlight searches
set incsearch
set ruler                               "Show current position
set history=500                         "lines of history vim will remember
set backspace=eol,start,indent          "Backspace to work as expected
set whichwrap+=<,>,h,l
set clipboard+=unnamed                  "Copy to system clipboard
set wildmode=longest,list,full          "Autocomplete filenames using tab like bash
set wildmenu
set textwidth=80

" Set leader
let mapleader = ","

" Clear highlighting on escape in normal mode
nnoremap <Space> :noh<cr>

" Tab to split horizontally
nnoremap <Tab> :sp<cr>

" Quickly open/reload vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Quickly save and close
nnoremap <leader><leader>w :q<CR>

" Quickly close
nnoremap <leader><leader> :q<CR>

" Quickly close all
nnoremap <leader>q :qall<CR>

" Clear trailing whitespace
nnoremap <leader>w :%s/\s\+$//g<CR>

" Tabnew file
nnoremap <leader>t :tabnew<space>

" Move to Next Tab
nnoremap <leader>f gt<CR>

" Move to Previous Tab
nnoremap <leader>d gT<CR>

" Refresh file
nnoremap <leader>r :e!<CR>

" Clear Caches for CtrlP Plugin 
nnoremap <leader>c :CtrlPClearAllCaches<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"PLUGINS - vim-plug
" Set Plugin dir
call plug#begin('~/.vim/plugged')

" Add plugins here
Plug 'chriskempson/base16-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'dracula/vim'
Plug 'tpope/vim-fugitive'
"Yaml syntax highlighting
Plug 'stephpy/vim-yaml'
"Json files syntax
Plug 'elzr/vim-json'
"File search
Plug 'kien/ctrlp.vim'

" Initialize plugin system
call plug#end()

augroup filetypedetect
    " Set .p4 file syntax
    au BufRead,BufNewFile *.p4 set filetype=java
    au BufNewFile,BufRead *.json,*.json.gz set filetype=javascript
    au BufNewFile,BufRead *.yaml,*.yml,*.tfa so ~/.vim/plugged/vim-yaml/after/syntax/yaml.vim
    au BufRead,BufNew *.md set filetype=markdown
augroup END

" CtrlP Plugin settings
let g:ctrlp_working_path_mode = 0 
let g:ctrlp_max_files = 0 
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files'] "Vcs listing commands
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_user_command = ['.hg', 'hg --cwd %s locate -I .']

" Use mouse beyond the 220th column
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

