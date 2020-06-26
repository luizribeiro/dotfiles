scriptencoding utf-8

call plug#begin('~/.vim/bundle')
" UI quality of life
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
Plug 'farmergreg/vim-lastplace'

" Integration with tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'benmills/vimux'

" Integration with other tools
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'jlfwong/vim-arcanist', { 'on': 'ArcInlines' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Mappings
Plug 'Lokaltog/vim-easymotion'
Plug 'luizribeiro/bclose.vim'
Plug 'regedarek/ZoomWin'

" Auto-complete
Plug 'luizribeiro/ale'
Plug 'liuchengxu/vista.vim'

" JavaScript
Plug 'luizribeiro/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Hack / PHP
Plug 'hhvm/vim-hack', { 'for': 'php' }

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" Other filetypes
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'solarnz/thrift.vim', { 'for': 'thrift' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }
Plug 'cmcaine/vim-uci'
Plug 'tmatilai/vim-monit'
Plug 'chr4/nginx.vim'
Plug 'pearofducks/ansible-vim'
Plug 'HiPhish/jinja.vim'
Plug 'cespare/vim-toml'
Plug 'junegunn/vader.vim'
Plug 'beyondmarc/hlsl.vim'

" Misc
Plug 'jamessan/vim-gnupg'
Plug 'lambdalisue/suda.vim'

call plug#end()

" disable for terminal buffers in neovim
if has('nvim')
  augroup LengthmattersFix
    autocmd! TermOpen * LengthmattersDisable
  augroup END
endif

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
set switchbuf=useopen
set history=2000
filetype plugin indent on
let g:mapleader=","
nmap <space> ,
set showbreak=↪
set ttyfast
set showmatch
set signcolumn=yes
augroup SignColumn
  autocmd! TermOpen * setlocal signcolumn=no
augroup END

" disable backup and swap files
set nobackup
set noswapfile

" clipboard integration
if has('nvim')
  set clipboard=
  let g:clipboard = {
        \   'name': 'myClipboard',
        \   'copy': {
        \     '+': 'clipsync',
        \     '*': 'clipsync',
        \   },
        \   'paste': {
        \      '+': '+',
        \      '*': '*',
        \   },
        \   'cache_enabled': 1,
        \ }
endif

" vim-pencil settings
let g:pencil#autoformat = 0
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
augroup END

" indent settings
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
let g:indentLine_char='¦'
let g:indentLine_color_term=236
let g:indentLine_fileTypeExclude = ['help', 'man', 'startify']
let g:indentLine_bufTypeExclude = ['terminal', 'startify', 'vader-result']


" signify settings
let g:signify_vcs_list=['hg', 'git']

" folding settings
set foldmethod=indent
set foldlevelstart=99
nnoremap <silent> <leader>F0 :set foldlevel=0<cr>
nnoremap <silent> <leader>F1 :set foldlevel=1<cr>
nnoremap <silent> <leader>F2 :set foldlevel=2<cr>
nnoremap <silent> <leader>F3 :set foldlevel=3<cr>
nnoremap <silent> <leader>F4 :set foldlevel=4<cr>

" page up and page down as ctrl+u and ctrl+d
noremap <silent> <PageUp> <c-u>
noremap <silent> <PageDown> <c-d>

" Keyboard/Mouse settings
set backspace=indent,eol,start
set whichwrap=<,>,b,s,[,]
set mouse=a

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
nnoremap <silent> <esc> :noh<cr>:echo<cr><esc>

" Colors setup
set t_Co=256
colorscheme molokai

" vim-ale settings
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_symbols = {
  \ "text": "\ue612 ",
  \ "method": "\uf794 ",
  \ "function": "\uf794 ",
  \ "constructor": "\uf0ad ",
  \ 'field': "\uf30b ",
  \ "variable": "\uf71b ",
  \ 'class': "\uf0e8 ",
  \ 'interface': "\uf7fe ",
  \ 'module': "\uf136 ",
  \ 'property': "\ufab6 ",
  \ "unit": "unit ",
  \ "value": "val ",
  \ 'enum': "\uf702 ",
  \ "keyword": "\uf805 ",
  \ "snippet": " ",
  \ "color": "\ue22b ",
  \ "file": "\uf15b ",
  \ "reference": "\uf061 ",
  \ "folder": "\ue5ff ",
  \ "enum member": "\uf702 ",
  \ 'constant': "\uf8fe ",
  \ 'struct': "\uf318 ",
  \ "event": "event ",
  \ "operator": "\uf457 ",
  \ 'type_parameter': "\uf278 ",
  \ "<default>": "\uf29c "
  \ }
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%]% [code]% %s'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
\   'c': ['clangd'],
\   'cs': ['omnisharp'],
\   'hack': ['hack', 'hhast'],
\   'javascript': ['flow-language-server'],
\   'python': ['pyls', 'pyre'],
\   'yaml': ['yamllint'],
\   'vim': ['vint'],
\}
let g:ale_fixers = {
\   'c': ['clang-format'],
\   'css': ['prettier'],
\   'graphql': ['prettier'],
\   'hack': ['hackfmt'],
\   'javascript': ['prettier'],
\   'python': ['black'],
\   'yaml': ['prettier'],
\}
let g:ale_sign_error = "●"
let g:ale_sign_warning = "●"
let g:ale_c_clangd_executable = '/usr/local/Cellar/llvm/9.0.1/bin/clangd'
let g:ale_cs_omnisharp_executable = '/usr/local/opt/omnisharp-mono/libexec/OmniSharp.exe'
highlight ALEError ctermbg=235
highlight ALEErrorSign ctermfg=196 ctermbg=235 cterm=bold
highlight ALEWarning ctermbg=235
highlight ALEWarningSign ctermfg=220 ctermbg=235 cterm=bold
autocmd FileType hack let b:ale_fix_on_save = 0
autocmd FileType graphql let b:ale_javascript_prettier_options = '--parser graphql'
nnoremap <silent> <leader>F :ALEFindReferences<CR>
nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>

" vista settings
let g:vista_default_executive = 'ale'
let g:vista_blink = [0, 0]
nnoremap <silent> <leader>V :Vista<cr>

" auto-completion settings
set pumheight=10
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#manual_complete()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" lightline setup
highlight FilenameHighlight ctermfg=250
let g:lightline = {
      \ 'enable': {
      \   'statusline': 1,
      \   'tabline': 0
      \ },
      \ 'colorscheme': 'custom',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'modified' ],
      \             [ 'relativepath_highlight' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'dash', 'paste' ],
      \             [ 'readonly', 'modified' ],
      \             [ 'relativepath' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"\uf023":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"\uf023"}',
      \   'relativepath_highlight': '%<%{expand("%:h")}/%#FilenameHighlight#%{expand("%:t")}',
      \   'relativepath': '%<%{expand("%:h")}/%{expand("%:t")}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'component_function': {
      \   'dash': 'LightlineDash'
      \ },
      \ 'mode_map': {
      \   'c': 'NORMAL'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }
function! LightlineDash()
  return '------'
endfunction
set noshowmode

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

" Tags setup
set tags=tags;/

" vim-jsx should be used for *.js too
let g:jsx_ext_required=0

" Mappings
let g:no_plugin_maps=1
nnoremap <silent> zq ZQ
nnoremap <silent> <leader>db :Bclose<CR>
nnoremap <silent> <leader>DB :1,1000bd<cr>
nnoremap <silent> gq :botright copen<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>rd :redraw!<CR>
nnoremap <leader>rall :bufdo! e!<CR>:source $MYVIMRC<CR>
nnoremap <leader>KA :bufdo! bd!<CR>
nnoremap < V<
nnoremap > V>

" Startify
nnoremap <silent> <leader>S :Startify<cr>
let g:startify_custom_header=[]
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
if has('nvim')
  autocmd! TabNewEntered * if bufname("%") == "" | Startify | endif
endif

" fzf
if has('nvim-0.4.0')
  let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

  function! FloatingFZF()
    let height = float2nr(&lines - (&lines * 1 / 10))
    let width = float2nr(&columns - (&columns * 1 / 10))
    let col_offset = &columns / 20
    let row_offset = &lines / 20
    let opts = {
          \ 'relative': 'editor',
          \ 'row': row_offset,
          \ 'col': col_offset,
          \ 'width': width,
          \ 'height': height,
          \ }
    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhl', '')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
else
  let g:fzf_layout = { 'down': '~20%' }
endif
let g:fzf_nvim_statusline = 0
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>m :History<cr>
nnoremap <silent> <leader>f :call RepoFiles(bufnr('%'))<cr>
nnoremap <silent> <leader>R :Rg <c-r><c-w><cr>
nnoremap <silent> <leader><leader>f :Files %:p:h<cr>
command! -bang -nargs=? -complete=dir HGFiles call fzf#run({
  \ 'source': "hg status -n --rev '.^'",
  \ 'sink': 'e',
  \ })

function! RepoFiles(buffer) abort
  let l:repo_type = GetRepoType(a:buffer)
  if l:repo_type ==# 'git'
    GitFiles
  elseif l:repo_type ==# 'hg'
    HGFiles
  else
    Files
  endif
endfunction

function! GetRepoType(buffer) abort
  if FindNearestDir(a:buffer, '.git') !=# ''
    return 'git'
  endif
  if FindNearestDir(a:buffer, '.hg') !=# ''
    return 'hg'
  endif
  return ''
endfunction

function! FindNearestDir(buffer, dirname) abort
  let l:buffer_filename = fnamemodify(bufname(a:buffer), ':p')
  let l:buffer_filename = fnameescape(l:buffer_filename)

  let l:relative_path = finddir(a:dirname, l:buffer_filename . ';')

  if !empty(l:relative_path)
      return fnamemodify(l:relative_path, ':p')
  endif

  return ''
endfunction

nmap <Leader>H :HGFiles<CR>

inoremap <esc> <esc>`^
nnoremap S ddO
" I'm tired of going into :ex mode
nnoremap Q <nop>

" Quicker access to command line from normal mode
noremap ; :
vnoremap ; :

" Split windows separator
set fillchars=fold:-,vert:│

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
CommandCabbr hs HS
CommandCabbr Hs HS
CommandCabbr rg Rg

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

augroup QuickfixSettings
  autocmd BufReadPost quickfix setlocal cursorline nonumber nowrap
augroup END

" Hack omni-completion
augroup HackTweaks
  " Better Hack syntax highlighting (I should add this to after/ eventually)
  autocmd FileType php syn region phpRegion matchgroup=Delimiter start="<?hh"
      \ end="?>" contains=@phpClTop
  autocmd FileType php syn keyword phpStructure use trait
augroup END

augroup PHPSettings
  autocmd FileType php setlocal iskeyword+=$
augroup END

" flow/hack settings
let g:flow#autoclose=1
let g:hack#autoclose=1
let g:flow#showquickfix = 0

" python settings
augroup PythonSettings
  autocmd!
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd FileType python setlocal textwidth=120
  autocmd FileType python setlocal omnifunc=ale#completion#OmniFunc
augroup END

augroup CSharpSettings
  autocmd!
  autocmd FileType cs setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" objective c settings
augroup ObjCSettings
  autocmd!
  autocmd FileType objc setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd FileType objc LengthmattersDisable
augroup END

" other Hack stuff
nmap <leader>T :HackType<cr>
nmap <leader>F :HackFormat<cr>
command! -nargs=? -bang HS call hack#search('<bang>' == '!', <q-args>)

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

" add require
command! -nargs=+ Require call append(line('.'), "const <args> = require('<args>');")
nnoremap <leader>rq :Require <c-r>=expand("<cword>")<cr><cr>j=$
vnoremap <leader>rq y:Require <c-r><c-"><cr>j=$
CommandCabbr require Require

" add console.log
command! -nargs=+ Clog call append(line('.'), "console.log('<args>', <args>);")
nnoremap <leader>cl :Clog <c-r>=expand("<cword>")<cr><cr>j=$
vnoremap <leader>cl y:Clog <c-r><c-"><cr>j=$
CommandCabbr clog Clog

" keymaps for manipulating splits and tabs
nnoremap <silent> <leader>v :vsp<cr>
nnoremap <silent> <leader>h :sp<cr>
nnoremap <silent> <leader>t :tab split<cr>
nnoremap <silent> <C-w>% :sp<cr>
nnoremap <silent> <C-w>" :vsp<cr>

" vimux
nnoremap <silent> <leader>! :call VimuxRunCommand('!!')<cr>
nnoremap <silent> <leader>O :call VimuxRunCommand('clear')<cr>
command! -nargs=+ C call VimuxRunCommand(<q-args>)
CommandCabbr c C

" delimMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" toggle between .h and .m
nnoremap <silent> _ :call ToggleHeader()<cr>
function! ToggleHeader()
  let l:extension = expand('%:e')
  let l:file_without_extension = expand('%:r')
  let l:file_candidates = []

  if l:extension == 'h'
    call add(l:file_candidates, l:file_without_extension . '.m')
    call add(l:file_candidates, l:file_without_extension . '.mm')
    call add(l:file_candidates, l:file_without_extension . '.c')
    call add(l:file_candidates, l:file_without_extension . '.cpp')
  elseif l:extension != ''
    call add(l:file_candidates, l:file_without_extension . '.h')
  endif

  for l:candidate in l:file_candidates
    if file_readable(l:candidate)
      execute 'edit' l:candidate
      return
    endif
  endfor

  echom "Header file not found"
endfunction

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
