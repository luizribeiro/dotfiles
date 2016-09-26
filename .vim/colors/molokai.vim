" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" Customized by: Luiz Ribeiro <luizribeiro@gmail.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear

set background=dark

let g:colors_name="molokai"

hi Normal                   ctermbg=235
hi CursorLine               ctermbg=235   cterm=none
hi Boolean         ctermfg=135
hi Character       ctermfg=144
hi Number          ctermfg=135
hi String          ctermfg=144
hi Conditional     ctermfg=161               cterm=bold
hi Constant        ctermfg=135               cterm=bold
hi Cursor          ctermfg=16  ctermbg=253
hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=81
hi Delimiter       ctermfg=241

hi DiffAdd         ctermfg=234 ctermbg=112
hi DiffDelete      ctermfg=234 ctermbg=1
hi DiffChange      ctermfg=181 ctermbg=236
hi DiffText                    ctermbg=237 cterm=bold

hi SignifySignAdd    ctermfg=82  ctermbg=235
hi SignifySignChange ctermfg=240 ctermbg=235
hi SignifySignDelete ctermfg=1   ctermbg=235

hi Directory       ctermfg=118               cterm=bold
hi Error           ctermfg=219 ctermbg=89
hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
hi Exception       ctermfg=118               cterm=bold
hi Float           ctermfg=135
hi FoldColumn      ctermfg=240  ctermbg=235
hi Folded          ctermfg=245  ctermbg=235
hi Function        ctermfg=118
hi Identifier      ctermfg=208               cterm=none
hi Ignore          ctermfg=244 ctermbg=232
hi IncSearch       ctermfg=193 ctermbg=16

hi Keyword         ctermfg=161               cterm=bold
hi Label           ctermfg=229               cterm=none
hi Macro           ctermfg=193
hi SpecialKey      ctermfg=81

hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
hi ModeMsg         ctermfg=229
hi MoreMsg         ctermfg=229
hi Operator        ctermfg=161

" complete menu
hi Pmenu           ctermfg=250 ctermbg=233
hi PmenuSel        ctermfg=7   ctermbg=27
hi PmenuSbar                   ctermbg=235
hi PmenuThumb                  ctermbg=237

hi PreCondit       ctermfg=118               cterm=bold
hi PreProc         ctermfg=118
hi Question        ctermfg=81
hi Repeat          ctermfg=161               cterm=bold
hi Search          ctermfg=253 ctermbg=60

" marks column
hi SignColumn      ctermfg=118 ctermbg=235
hi SpecialChar     ctermfg=161               cterm=bold
hi SpecialComment  ctermfg=245               cterm=bold
hi Special         ctermfg=81  ctermbg=232

hi Statement       ctermfg=161               cterm=bold
hi StatusLine      ctermfg=238 ctermbg=253
hi StatusLineNC    ctermfg=244 ctermbg=232
hi StorageClass    ctermfg=208
hi Structure       ctermfg=81
hi Tag             ctermfg=161
hi Title           ctermfg=166
hi Todo            ctermfg=231 ctermbg=232   cterm=bold

hi Typedef         ctermfg=81
hi Type            ctermfg=81                cterm=none
hi Underlined      ctermfg=244               cterm=underline

hi VertSplit       ctermfg=244 ctermbg=bg    cterm=none
hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=235
hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
hi WildMenu        ctermfg=81  ctermbg=16

hi Comment         ctermfg=242
hi CursorColumn                ctermbg=235
hi ColorColumn                 ctermbg=235
hi LineNr          ctermfg=250 ctermbg=236
hi NonText         ctermfg=59
hi SpecialKey      ctermfg=59

" tab bar
hi TabLineFill ctermfg=235 ctermbg=235
hi TabLine ctermfg=245 ctermbg=235 cterm=none
hi TabLineSel ctermfg=255 ctermbg=235 cterm=bold
