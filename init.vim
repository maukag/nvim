" vim-plug
call plug#begin()
Plug 'psf/black', { 'branch': 'stable' }
Plug 'nvie/vim-flake8'
Plug 'ledger/vim-ledger'
call plug#end()

" Don't run in Vi-compatible mode
set nocompatible

" Restrict to 16 colors.
set t_Co=16

" Turn off line wrapping.
set nowrap

"When splitting, make the new buffer appear below the current one.
set splitbelow

" When splitting vertically, make the new buffer appear to the right.
set splitright  

" Switch on relative line numbering.
set relativenumber

" Switch on line number for current line (as opposed to 0).
set number

" Copy indent from current line when starting a new line. (Typing 
" CTRL-D will delete the indent).
set autoindent

" Define status line.
set statusline=Buffer\ number:\ %n
set statusline+=\ Line\ number:\ %l/%L
set statusline+=\ File\ path:\ %F

" Show status line even when only one window is open.
set laststatus=2

" Open file with folds opened.
set foldlevel=20

" Define the global leader character.
let mapleader = ","

" Define the local leader character as a single backslash.
let maplocalleader = "\\"

" Switch on syntax highlighting.
syntax on

set foldmethod=indent

" Define the colour scheme for syntax highlighting.
colorscheme delek

" BigQuery mappings.
nnoremap <leader>be :split ~/.bigqueryrc<cr>
nnoremap <leader>bl :new<cr>:execute '.!bq ls'<cr>
vnoremap <leader>bq y:new<cr>pggVG:!bq query<cr>
vnoremap <leader>bs y:new<cr>:execute '.!bq show '@"<cr>
vnoremap <leader>bl y:new<cr>:execute '.!bq ls '@"<cr>

" Use <c-l> for window navigation. Aligns with wintermkey.
nnoremap <c-l> <c-w>

" Open terminal in a new split.
nnoremap <leader>t :split<cr>:term<cr>

" Use CTRL+u to uppercase current word.
inoremap <c-u> <esc>viWUEa

" Use double j to enter normal mode. 
inoremap jj <Esc>

" Surround highlighted text in single quotes.
vnoremap <leader>' <esc>a'<esc>`<i'<esc>`>

" Use double j to enter normal mode.
cnoremap jj <C-c>

" netrw configuration
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_bufsettings="noma nomod nu nobl nowrap ro rnu"
let g:netrw_localrmdir='rm -r'

" Enable file type detection.
filetype on

" Consider sqlx files to have the sql file type.
autocmd BufEnter *.sqlx :setlocal filetype=sql

" Vimscript file settings
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal wrap
	autocmd FileType vim nnoremap <buffer> <localleader>c I" <esc>0 
augroup END

" SQL file settings.
augroup filetype_sql
	autocmd!
	autocmd FileType sql setlocal shiftwidth=2
	autocmd FileType sql setlocal tabstop=2
	autocmd FileType sql setlocal expandtab
	autocmd FileType sql setlocal wrap
	autocmd FileType sql nnoremap <buffer> <localleader>c o/*<cr>*/<esc>O
augroup END

" Python file settings.
augroup filetype_python
	autocmd!  
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal expandtab
	autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>0 
	autocmd FileType python nnoremap <buffer> <localleader>f :call flake8#Flake8()<CR>
	autocmd FileType python autocmd BufWritePre <buffer> retab
	autocmd FileType python autocmd BufWritePost <buffer> call flake8#Flake8()
augroup END

" YAML file settings.
augroup filetype_yaml
	autocmd!  
	autocmd FileType yaml setlocal shiftwidth=2
	autocmd FileType yaml setlocal tabstop=2
	autocmd FileType yaml setlocal expandtab
	autocmd FileType yaml nnoremap <buffer> <localleader>c I# <esc>0 
augroup END

" Ledger settings.
let g:ledger_date_format = '%Y-%m-%d'
" Algin commodities in a sane fashion.
let g:ledger_align_commodity = 1
augroup filetype_ledger
	autocmd!
	autocmd FileType ledger setlocal shiftwidth=4
	autocmd FileType ledger setlocal tabstop=4
	autocmd FileType ledger setlocal expandtab
	" Align entire buffer.
	autocmd FileType ledger nnoremap <buffer> <localleader>a :LedgerAlignBuffer<cr>
	" Calculate net worth.
	autocmd FileType ledger nnoremap <buffer> <localleader>nw :Ledger --market --price-db prices.db --pedantic bal ^assets ^liab<cr>
	" Calculate monthly mortgage payment from budget file.
	autocmd FileType ledger nnoremap <buffer> <localleader>m :Ledger --budget --monthly register ^Expenses:Mortgage<cr>
augroup END
