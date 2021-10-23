"
"Highlight trailing white spaces
"
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

"
" List of Plugins for vim-plug
"
call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-python'
call plug#end()

"
" General Settings
"
filetype plugin indent on
syntax on
set backspace=indent,eol,start
set nocompatible
set number
set incsearch
set hlsearch
set ruler

"
" netrw file explorer config
"
let g:netrw_winsize = -28                  	" absolute width of netrw window
let g:netrw_banner = 0                     	" do not display info on the top of window
let g:netrw_liststyle = 3                  	" tree-view
let g:netrw_sort_sequence = '[\/]$,*'      	" sort is affecting only: directories on the top, files below
let g:netrw_browse_split = 4               	" use the previous window to open file

"
" Map Leader Key
"
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

"
" Map general keys
"
noremap <F3> :Lexplore <CR>                	" Map a key for file explorer
noremap <F5> :source ~/.vimrc <CR>         	" Run this vimrc - Refresh
noremap <Leader>h :set cursorline! <CR>    	" Toggle highlight cursor line
noremap <Leader>j :%!python -m json.tool <CR> 	" Prettify json
noremap <Leader><BACKSPACE> :%s/\s\+$//e <CR>   " Remove trailing space
"
" Map keys for vim-lsp commands
"
noremap <F8> :LspDocumentDiagnostics <CR>  	" Show pep8 document diagnostics
noremap <Leader><F2> :LspDeclaration <CR>  	" Go to Declaration <Shift> + <F2>
noremap <F2> :LspDefinition <CR>           	" Go to Declaration <Shift> + <F2>
noremap <Leader><Leader> :LspHover <CR>    	" Show hover information
noremap <F7> :LspNextReference <CR>        	" Jump to the next reference of the symbol under table
noremap <F6> :LspPreviousReference <CR>    	" Jump to the previous reference of the symbol under table
noremap <F9> :LspReferences <CR>           	" Find all references

"
" Language specific configs.
"
autocmd Filetype python colorscheme industry
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

"
" Highlight settings for cursor line and line number
"
highlight LineNr term=NONE cterm=NONE ctermbg=NONE ctermfg=grey guibg=NONE guifg=Grey
highlight CursorLine term=NONE cterm=NONE ctermbg=NONE ctermfg=None guibg=NONE guifg=NONE 
highlight CursorLineNr term=bold cterm=bold ctermbg=grey ctermfg=black guibg=Yellow guifg=black 


