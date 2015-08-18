" Vim color file
" Author: Artyom Mironov <kazufukurou@gmail.com>

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="mycolorscheme"

hi ColorColumn                  ctermbg=8
hi Conceal         ctermfg=15
hi Cursor                                    cterm=none
hi CursorColumn                 ctermbg=8
hi CursorLine                                cterm=none
hi CursorLineNr    ctermfg=15
hi Directory       ctermfg=8
hi DiffAdd         ctermfg=15   ctermbg=4
hi DiffChange      ctermfg=15   ctermbg=5
hi DiffDelete      ctermfg=9    ctermbg=1
hi DiffText        ctermfg=0    ctermbg=15   cterm=reverse,bold
hi ErrorMsg        ctermfg=1                 cterm=bold
hi Folded          ctermfg=15   ctermbg=8
hi FoldColumn      ctermfg=7    ctermbg=8
hi IncSearch       ctermfg=10
hi LineNr          ctermfg=8
hi MatchParen      ctermfg=0    ctermbg=11   cterm=bold
hi ModeMsg         ctermfg=11
hi MoreMsg         ctermfg=11
hi NonText         ctermfg=8
hi Normal          ctermfg=7
hi Pmenu           ctermfg=7    ctermbg=8
hi PmenuSbar       ctermfg=15   ctermbg=7
hi PmenuSel        ctermfg=15   ctermbg=2
hi PmenuThumb      ctermfg=15
hi Question        ctermfg=4                 cterm=bold
hi Search          ctermfg=15   ctermbg=6    cterm=bold
hi SignColumn      ctermfg=15   ctermbg=0    cterm=bold
hi SpecialKey      ctermfg=8    ctermbg=8
hi SpellBad                     ctermbg=1
hi SpellCap                     ctermbg=4
hi SpellLocal                   ctermbg=4
hi SpellRare       ctermfg=none ctermbg=none cterm=reverse
hi StatusLine      ctermfg=8    ctermbg=15   cterm=reverse
hi StatusLineNC    ctermfg=8    ctermbg=0    cterm=reverse
hi TabLine         ctermfg=15   ctermbg=8    cterm=none
hi TabLineFill     ctermfg=8    ctermbg=8    cterm=none
hi TabLineSel      ctermfg=15                cterm=none
hi Title           ctermfg=15
hi VertSplit       ctermfg=8                 cterm=bold
hi Visual                       ctermbg=0
hi VisualNOS                    ctermbg=0
hi WarningMsg      ctermfg=11                cterm=bold
hi WildMenu        ctermfg=15   ctermbg=8    cterm=bold

" syntax highlighting groups
hi Boolean         ctermfg=5
hi Comment         ctermfg=8
hi Constant        ctermfg=10
hi Debug           ctermfg=13                cterm=bold
hi Delimiter       ctermfg=7
hi Identifier      ctermfg=10
hi Ignore          ctermfg=7
hi Keyword         ctermfg=1                 cterm=bold
hi Number          ctermfg=5
hi Operator        ctermfg=1
hi PreProc         ctermfg=3
hi Special         ctermfg=4
hi SpecialChar     ctermfg=5
hi SpecialComment  ctermfg=7                 cterm=bold
hi Statement       ctermfg=1                 cterm=bold
hi Tag             ctermfg=1
hi Todo            ctermfg=11   ctermbg=none cterm=bold
hi Type            ctermfg=4
hi Underlined      ctermfg=7                 cterm=underline
hi Error           ctermfg=9    ctermbg=1
