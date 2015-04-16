" Vundle plugins
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'jlfwong/vim-arcanist'
Plugin 'tpope/vim-eunuch'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'hhvm/vim-hack'
Plugin 'facebook/vim-flow'
Plugin 'luizribeiro/bclose.vim'
Plugin 'regedarek/ZoomWin'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'solarnz/thrift.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-fugitive'
Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'tejr/vim-tmux'
Plugin 'bling/vim-airline'
Plugin 'benmills/vimux'
Plugin 'ervandew/supertab'
Plugin 'Raimondi/delimitMate'
call vundle#end()
filetype plugin indent on

" General settings
set nocompatible
set showcmd
set ruler
set number
set wildmenu
set wildmode=full:longest,full
set laststatus=2
set virtualedit=block
set scrolloff=3
set switchbuf=useopen,split
set history=2000
filetype plugin indent on
let mapleader=","
set showbreak=↪
set ttyfast
set showmatch

" clipboard integration
if !has('nvim')
  " for some reason this only works on regular vim. need to fix my clipboard
  " integration on neovim
  set clipboard=unnamed
endif

" indent settings
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Keyboard/Mouse settings
set backspace=indent,eol,start
set whichwrap=<,>,b,s,[,]

" Syntax highlight settings
syntax on
set synmaxcol=200

" Code completion settings
set completeopt=longest,menuone

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <silent> <esc> :noh<return><esc>

" Colors setup
set t_Co=256
colorscheme molokai

" airline setup
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
let g:airline_inactive_collapse=0
let g:airline_section_x=''
let g:airline_section_y=''
set noshowmode

" lawrencium shows the default branch on the statusline, which is useless
" given my workflow
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
  return substitute(a:name, 'default - ', '', '')
endfunction

" I hate the delay when leaving insert mode on terminal
set ttimeout
set ttimeoutlen=0
if !has('gui_running')
  set timeoutlen=1000
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Highlight tabs, text past 80 chars and trailing spaces
highlight OverLength ctermbg=52 guibg=#592929
autocmd BufNew * match OverLength /\%81v.\+/
syntax match tab display "\t"
highlight link tab Error
match OverLength '\s\+$'

" filetypes that shouldn't highlight text past 80 chars
autocmd FileType startify,qf,unite,hglog match none /\%81v.\+/

" Tags setup
set tags=tags;/

" vim-jsx should be used for *.js too
let g:jsx_ext_required=0

" NERDTree settings
let NERDTreeMinimalUI=1

" Mappings
let g:no_plugin_maps=1
nnoremap <silent> zq ZQ
nnoremap <silent> <leader>db :Bclose<CR>
nnoremap <silent> gn :NERDTreeFocus<CR>
nnoremap <silent> gq :botright copen<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>rd :redraw!<CR>
nnoremap <leader>rall :bufdo! e!<CR>:source $MYVIMRC<CR>
nnoremap < V<
nnoremap > V>

" Startify
nnoremap <silent> <leader>S :Startify<cr>
let g:startify_list_order=['dir', 'files', 'bookmarks', 'sessions']
let g:startify_change_to_dir=0
let g:startify_change_to_vcs_root=1
highlight StartifyBracket ctermfg=240
highlight StartifyFooter ctermfg=240
highlight StartifyHeader ctermfg=114
highlight StartifyNumber ctermfg=215
highlight StartifyPath ctermfg=245
highlight StartifySlash ctermfg=240
highlight StartifySpecial ctermfg=240

" Unite
nnoremap <silent> <leader>b :Unite -buffer-name=buffers -start-insert buffer<cr>

augroup UniteInit
  call unite#custom#profile('default','context', {
    \ 'resize': 0,
    \ 'direction': 'botright',
    \ 'no_split': 1,
    \ })
augroup END

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <buffer> <esc> <c-^>
  match none /\%81v\+/
endfunction

inoremap <esc> <esc>`^
nnoremap S ddO
" I'm tired of going into :ex mode
nnoremap Q <nop>

" Quicker access to command line from normal mode
noremap ; :
vnoremap ; :

" Split windows separator
set fillchars=fold:-,vert:│

noremap gd <C-]>zz
noremap gq :botright copen<CR>

" Create directory if necessary on save
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" auto-correct a few common command typos
function! CommandCabbr(abbreviation, expansion)
  execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
CommandCabbr Ta ta
CommandCabbr TA ta
CommandCabbr E e
CommandCabbr W w
CommandCabbr Wq wq
CommandCabbr WQ wq
CommandCabbr Vsp vsp
CommandCabbr VSp vsp

" My replacement for g], which goes into quickfix
command! -nargs=1 Function call s:Function(<f-args>)
function! s:Function(name)
  " Retrieve tags of the 'f' kind
  let tags = taglist('^'.a:name)
  let tags = filter(tags, 'v:val["kind"] == "f"')

  " Prepare them for inserting in the quickfix window
  let qf_taglist = []
  for entry in tags
    call add(qf_taglist, {
          \ 'pattern':  entry['cmd'],
          \ 'filename': entry['filename'],
          \ })
  endfor

  " Place the tags in the quickfix window, if possible
  call setqflist(qf_taglist)
  if len(qf_taglist) > 0
    botright copen
  else
    echo "No tags found for ".a:name
  endif
endfunction
noremap g] :exe ":Function " . expand("<cword>")<CR>

" Some quickfix settings
autocmd BufReadPost quickfix setlocal cursorline nonumber nowrap

" Better Hack syntax highlighting (I should add this to after/ eventually)
autocmd FileType php syn region phpRegion matchgroup=Delimiter start="<?hh"
    \ end="?>" contains=@phpClTop
autocmd FileType php syn keyword phpStructure use trait

" Hack omni-completion
let g:hack#omnifunc=1
autocmd BufNewFile,BufRead *.php setl omnifunc=hackcomplete#Complete

" Listener/send stuff {{{
function! Send(cmd, param)
  call system('nc localhost 52698', a:cmd.' '.a:param)

  if (0 != v:shell_error)
    echoerr 'Error executing command!'
    return v:shell_error
  endif
  return 0
endfunction

command! Pbcopy call Send("copy", getreg(v:register))

nnoremap <silent> <leader>cf :call Send("copy", expand("%"))<cr>
nnoremap <silent> <leader>y :Pbcopy<cr>
" }}}

nnoremap <leader>n :set relativenumber!<cr>

" I hate plugin mappings
let g:no_plugin_maps = 1

map <C-w>% :sp<cr>
map <C-w>" :vsp<cr>

set splitright
set splitbelow

" make Y behave like other capitals
map Y y$

" better up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" disable paste mode when leaving Insert mode
au InsertLeave * set nopaste

" resize windows when vim is resized
au VimResized * exe "normal! \<c-w>="

" when you forget about sudo
cmap w!! w !sudo tee % >/dev/null

" add require
command! -nargs=+ Require call append(line('.'), "var <args> = require('<args>');")
nnoremap <leader>rq :Require <c-r>=expand("<cword>")<cr><cr>j=$
vnoremap <leader>rq y:Require <c-r><c-"><cr>j=$
CommandCabbr require Require

" add console.log
command! -nargs=+ Clog call append(line('.'), "console.log('<args>', <args>);")
nnoremap <leader>cl :Clog <c-r>=expand("<cword>")<cr><cr>j=$
vnoremap <leader>cl y:Clog <c-r><c-"><cr>j=$
CommandCabbr clog Clog

" handy keymaps
nnoremap <leader>v :vsp<cr>
nnoremap <leader>h :sp<cr>

" vimux
command! -nargs=+ C call VimuxRunCommand(<q-args>)
CommandCabbr c C

" supertab
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLeadingSpaceCompletion = 0
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType ="<c-x><c-o>"

" delimMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
