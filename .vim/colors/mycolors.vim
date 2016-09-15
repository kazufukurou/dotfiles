" Vim color file
" Author: Artyom Mironov <kazufukurou@gmail.com>

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "mycolors"

hi Boolean         ctermfg=5
hi ColorColumn                  ctermbg=8
hi Comment         ctermfg=8
hi Conceal         ctermfg=15
hi Constant        ctermfg=10
hi Cursor          ctermfg=2    ctermbg=none cterm=reverse
hi CursorColumn                 ctermbg=8
hi CursorLine                                cterm=none
hi CursorLineNr    ctermfg=15
hi Debug           ctermfg=13                cterm=bold
hi Delimiter       ctermfg=7
hi DiffAdd         ctermfg=12   ctermbg=none
hi DiffChange      ctermfg=13   ctermbg=none
hi DiffDelete      ctermfg=9    ctermbg=none
hi DiffText        ctermfg=15   ctermbg=none cterm=bold
hi Directory       ctermfg=8
hi Error           ctermfg=9    ctermbg=1    cterm=bold
hi ErrorMsg        ctermfg=1                 cterm=bold
hi FoldColumn      ctermfg=7    ctermbg=8
hi Folded          ctermfg=0    ctermbg=8
hi Identifier      ctermfg=10
hi Ignore          ctermfg=7
hi IncSearch       ctermfg=2    ctermbg=none cterm=reverse
hi Keyword         ctermfg=1                 cterm=bold
hi LineNr          ctermfg=8
hi MatchParen      ctermfg=10   ctermbg=0    cterm=bold
hi ModeMsg         ctermfg=11
hi MoreMsg         ctermfg=11
hi NonText         ctermfg=8
hi Normal          ctermfg=7
hi Number          ctermfg=5
hi Operator        ctermfg=1
hi Pmenu           ctermfg=7    ctermbg=8
hi PmenuSbar       ctermfg=15   ctermbg=7
hi PmenuSel        ctermfg=15   ctermbg=2
hi PmenuThumb      ctermfg=15
hi PreProc         ctermfg=3
hi Question        ctermfg=4                 cterm=bold
hi Search          ctermfg=14   ctermbg=0    cterm=none
hi SignColumn      ctermfg=15   ctermbg=0    cterm=bold
hi Special         ctermfg=4
hi SpecialChar     ctermfg=5
hi SpecialComment  ctermfg=7                 cterm=bold
hi SpecialKey      ctermfg=8    ctermbg=8
hi SpellBad                     ctermbg=1
hi SpellCap                     ctermbg=4
hi SpellLocal                   ctermbg=4
hi SpellRare       ctermfg=none ctermbg=none cterm=reverse
hi Statement       ctermfg=1                 cterm=bold
hi StatusLine      ctermfg=15   ctermbg=8    cterm=none
hi StatusLineNC    ctermfg=8    ctermbg=0    cterm=none
hi TabLine         ctermfg=8    ctermbg=15   cterm=none
hi TabLineFill     ctermfg=8    ctermbg=8    cterm=none
hi TabLineSel      ctermfg=15                cterm=none
hi Tag             ctermfg=1
hi Title           ctermfg=15
hi Todo            ctermfg=15   ctermbg=none cterm=bold
hi Type            ctermfg=4
hi Underlined      ctermfg=7                 cterm=underline
hi VertSplit       ctermfg=0    ctermbg=0    cterm=none
hi Visual                       ctermbg=0
hi VisualNOS                    ctermbg=0
hi WarningMsg      ctermfg=11   ctermbg=3    cterm=bold
hi WildMenu        ctermfg=15   ctermbg=0    cterm=none
