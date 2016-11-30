let s:darkestgreen = ['#005f00', 22]
let s:brightgreen = ['#afdf00', 148]
let s:white = ['#ffffff', 231]
let s:bg = ['#282828', 234]
let s:gray0 = ['#4e4e4e', 233]
let s:gray1 = ['#262626', 235]
let s:gray2 = ['#303030', 236]
let s:gray3 = ['#4e4e4e', 239]
let s:gray4 = ['#585858', 240]
let s:gray5 = ['#606060', 241]
let s:gray7 = ['#8a8a8a', 247]
let s:gray8 = ['#9e9e9e', 245]
let s:gray9 = ['#bcbcbc', 250]
let s:gray10 = ['#d0d0d0', 252]
let s:darkestcyan = ['#005f5f', 23]
let s:mediumcyan = ['#87dfff', 117]
let s:darkblue = ['#0087af', 31]
let s:darkestblue = ['#005f87', 24]
let s:brightred = ['#df0000', 160]
let s:brightestred = ['#ff0000', 196]
let s:darkred = ['#870000', 88]
let s:brightorange = ['#ff8700', 208]
let s:yellow = ['#b58900', 136]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [s:darkestgreen, s:brightgreen, 'bold'], [s:white, s:gray4] ]
let s:p.normal.right = [ [s:gray5, s:gray10], [s:gray9, s:gray4], [s:gray8, s:gray2] ]
let s:p.inactive.right = [ [s:gray4, s:bg], [s:gray4, s:bg], [s:gray4, s:bg] ]
let s:p.inactive.left = copy(s:p.inactive.right[1:])
let s:p.insert.left = [ [s:darkestcyan, s:white, 'bold'], [s:white, s:darkblue] ]
let s:p.insert.right = [ [ s:darkestcyan, s:mediumcyan ], [ s:mediumcyan, s:darkblue ], [ s:mediumcyan, s:darkestblue ] ]
let s:p.replace.left = [ [s:white, s:brightred, 'bold'], [s:white, s:gray4] ]
let s:p.visual.left = [ [s:darkred, s:brightorange, 'bold'], [s:white, s:gray4] ]
let s:p.normal.middle = [ [ s:gray7, s:bg ] ]
let s:p.insert.middle = [ [ s:mediumcyan, s:darkestblue ] ]
let s:p.replace.middle = copy(s:p.normal.middle)
let s:p.replace.right = copy(s:p.normal.right)
let s:p.tabline.left = [ [ s:gray9, s:gray4 ] ]
let s:p.tabline.tabsel = [ [ s:gray9, s:gray1 ] ]
let s:p.tabline.middle = [ [ s:gray2, s:gray8 ] ]
let s:p.tabline.right = [ [ s:gray9, s:gray3 ] ]
let s:p.normal.error = [ [ s:gray9, s:brightestred ] ]
let s:p.normal.warning = [ [ s:gray1, s:yellow ] ]

let g:lightline#colorscheme#custom#palette = lightline#colorscheme#flatten(s:p)
