scriptencoding utf-8

let g:airline#themes#custom#palette = {}

let s:N1   = [ '#00005f' , '#dfff00' , 17  , 190 ]
let s:N2   = [ '#ffffff' , '#444444' , 255 , 238 ]
let s:N3   = [ '#9cffd3' , '#202020' , 85  , 234 ]
let g:airline#themes#custom#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let g:airline#themes#custom#palette.normal_modified = {
      \ 'airline_c': [ '#ffffff' , '#5f005f' , 203     , 234      , ''     ] ,
      \ }

let s:I1 = [ '#00005f' , '#00dfff' , 17  , 45  ]
let s:I2 = [ '#ffffff' , '#005fff' , 255 , 27  ]
let s:I3 = [ '#ffffff' , '#000080' , 15  , 17  ]
let g:airline#themes#custom#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#custom#palette.insert_modified = {
      \ 'airline_c': [ '#ffffff' , '#5f005f' , 203     , 234     , ''     ] ,
      \ }
let g:airline#themes#custom#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
      \ }

let g:airline#themes#custom#palette.replace = copy(g:airline#themes#custom#palette.insert)
let g:airline#themes#custom#palette.replace.airline_a = [ s:I2[0]   , '#af0000' , s:I2[2] , 124     , ''     ]
let g:airline#themes#custom#palette.replace_modified = g:airline#themes#custom#palette.insert_modified

let s:V1 = [ '#000000' , '#ffaf00' , 232 , 214 ]
let s:V2 = [ '#000000' , '#ff5f00' , 232 , 203 ]
let s:V3 = [ '#ffffff' , '#5f0000' , 15  , 52  ]
let g:airline#themes#custom#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#custom#palette.visual_modified = {
      \ 'airline_c': [ '#ffffff' , '#5f005f' , 203     , 234      , ''     ] ,
      \ }

let s:IA1 = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
let s:IA2 = [ '#4e4e4e' , '#262626' , 239 , 234 , '' ]
let s:IA3 = [ '#4e4e4e' , '#303030' , 239 , 234 , '' ]
let g:airline#themes#custom#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#custom#palette.inactive_modified = {
      \ 'airline_c': [ '#4e4e4e' , '#303030' , 239 , 234 , '' ] ,
      \ }

let g:airline#themes#custom#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , ''  ]
      \ }
