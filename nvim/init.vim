"
" NeoVim Settings
" Oliver C. Sandli 2021
"

" +---------+
" | PLUGINS |
" +---------+

call plug#begin(stdpath('data') . '/plugged')

" general
Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vimwiki/vimwiki'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'psf/black', {'branch': 'stable'}
Plug 'kovisoft/slimv'

" ncm2
Plug 'ncm2/ncm2'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neoinclude.vim'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-syntax'
Plug 'filipekiss/ncm2-look.vim'
Plug 'ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'

" themes
Plug 'sainnhe/gruvbox-material'

call plug#end()


" +----------+
" | SETTINGS |
" +----------+

" themes
if has('termguicolors')
  set termguicolors
endif

set background=dark

" let g:gruvbox_material_palette = 'original'
let g:gruvbox_material_background='hard'
let g:gruvbox_material_enable_italic=1
let g:gruvbox_material_enable_bold=1

colorscheme gruvbox-material

let g:airline_theme='gruvbox_material'

" general
set tabstop=4
set shiftwidth=4
set expandtab
set number
set hidden
filetype plugin indent on

" airline
" let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#ale#enabled=1
let g:airline_powerline_fonts=1

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:NERDSpaceDelims=1
let g:NERDTrimTrailingWhitespace=1

" nerdcommenter
let g:NERDSpaceDelims=1

" ale
let g:ale_sign_error = ' '
let g:ale_sign_warning = ' '
hi link ALEErrorSign Error
hi link ALEWarningSign Todo
let g:ale_python_flake8_options="--max-line-length=88"
let g:ale_cpp_clang_options="-std=c++17 -Wall"

" black
autocmd BufWritePre *.py execute ':Black'

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <c-c> <ESC>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:ncm2_pyclang#library_path='/usr/lib/libclang.so'


" +----------+
" | COMMANDS |
" +----------+

command! Compose execute "setlocal spell | setlocal linebreak | syntax sync fromstart"
command! Decompose execute "setlocal nospell | setlocal nolinebreak"


" +----------+
" | MAPPINGS |
" +----------+

inoremap jk <esc>
nnoremap tt :NERDTree<return>

" +-------------------+
" | FILETYPE SETTINGS |
" +-------------------+

augroup latexfilesettings
  autocmd!
  autocmd FileType tex let b:ncm2_look_enabled = 1
  autocmd FileType tex nnoremap <leader>]] :w<return>:!make<return>
  autocmd FileType tex let &colorcolumn=join(range(91,999),",")
  autocmd FileType tex set textwidth=90
  autocmd FileType tex Compose
augroup END

augroup markdownsettings
  autocmd!
  autocmd FileType markdown let b:ncm2_look_enabled = 1
  autocmd FileType markdown nnoremap <leader>]] :!grip "%"<return>
augroup END

augroup csettings
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END
