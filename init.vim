" Vim specific settings

" vim-plug and plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'racer-rust/vim-racer'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dense-analysis/ale'
Plug 'Valloric/YouCompleteMe'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'https://github.com/octol/vim-cpp-enhanced-highlight.git'
Plug 'luisjure/csound-vim'
Plug 'vim-latex/vim-latex'
Plug 'alaviss/nim.nvim'
" Plug 'arakashic/chromatica.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" THEME plugins
" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
" Plug 'drewtempelmeyer/palenight.vim'
" Plug 'ajmwagar/vim-deus'
" Plug 'danilo-augusto/vim-afterglow'
Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()

filetype plugin indent on
syntax on
colorscheme deep-space
let g:airline_theme='deep_space'
highlight clear SignColumn
set termguicolors
set background=dark
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=0
set expandtab
set number
set cursorline
set guicursor=

" Plugin settings
let g:ycm_autoclose_preview_window_after_completion=1

let g:autofmt_autosave=1

let g:rustfmt_autosave=1

" let g:chromatica#libclang_path='/Users/oliver/anaconda3/pkgs/libclang-8.0.1-h770b8ee_1/lib/'
" let g:chromatica#enable_at_startup=1
" let g:chromatica#responsive_mode=1

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=0

" let g:ale_sign_error = '⤫'
let g:ale_sign_error = ' '
" let g:ale_sign_warning = '⚠'
let g:ale_sign_warning = ' '
"hi ALEErrorSign ctermfg=red ctermbg=none
"hi ALEWarningSign ctermfg=yellow ctermbg=none
hi link ALEErrorSign Error
hi link ALEWarningSign Todo
let g:ale_set_loclist = 0
let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_linters = {'go': ['gometalinter', 'gofmt', 'golint', 'govet'], 'rust': ['rls']}
let g:ale_cpp_clang_options = '-std=c++17 -Wall'

let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_decl_highlight=1
let g:cpp_posix_standard=1
let g:cpp_experimental_template_highlight=1
let g:cpp_concepts_highlight=1

let g:go_version_warning = 0

let g:Imap_UsePlaceHolders = 0


cmap W w
" My mappings
" move current line up/down
nmap - VdkP
nmap _ Vdp
" run various file types
" au Filetype rust nmap <buffer> <F5> :!cargo run<return>
" au Filetype python nmap <buffer> <F5> :!./%<return>
" au Filetype go nmap <buffer> <F5> :!go run<return>
nmap <F5> :SkiiRun<return>
" save file
nmap <F1> :w<return>
imap <F1> <esc>:w<return>
" remove trailing whitespace
nnoremap <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><return>
" new tab with netrw
nnoremap <F6> :Texplore<return>

imap jk <Esc>
nmap ss ^f<Space>lC

command! Compose execute "setlocal spell | setlocal linebreak"
command! Decompose execute "setlocal nospell | setlocal nolinebreak"
command! Cheat execute "14sp ~/.config/nvim/cheatsheet.md"
