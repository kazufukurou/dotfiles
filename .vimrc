syntax on
filetype plugin indent on

color mycolors
set nocompatible
set noundofile "don't create .un~ files
set nobackup nowritebackup "don't create ~ files
set noswapfile "don't create .swp files
set mouse=nv
set hidden "allow to have unwritten changes to a file and open a new file
set scrolloff=4 "keep cursor few lines away edge when scrolling
set nonumber "dont show line numbers
set norelativenumber "line numbers are relative to current current line
set ruler "always show current position
set nocursorline "don't highlight current line
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab "insert 4 spaces when hit tab
set wrap "wrap lines
set smartindent "automatically inserts one extra level of indentation in some cases
set ignorecase "ignore case when searching
set smartcase "a pattern is case sensitive only if it contains an uppercase letter
set gdefault "all matches in a line are substituted instead of one
set showmatch "show matching brackets when text indicator is over them
set nolist "don't show whitespaces
set clipboard=unnamedplus "make yank copy to the global system clipboard
set shortmess+=I "no startup messages
set virtualedit+=block "allow block selection where is no actual characters
set tags+=~/.vim/tags
set wildmode=longest,full "don't show all completions
set wildignore+=*.class
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.apk,*.zip
set wildignore+=*/build/*,*/.gradle/*,*/.idea/*,*/assets/*
set wildignore+=.git,.hg,.gradle

"leader
let mapleader = ' '
let maplocalleader = ' '

"bindings
nnoremap <space> <nop>
nnoremap Q <nop>
inoremap <C-c> <nop>
nnoremap ; :
nnoremap : ;
nnoremap j gj
nnoremap k gk
inoremap <esc> <esc>`^
inoremap jk <esc>`^
inoremap см <esc>`^
inoremap <C-@> <C-x><C-]>
inoremap <C-space> <C-x><C-]>
nnoremap <leader>c :Copen<cr>
nnoremap <leader>dl :diffget 2<cr> :diffup<cr>
nnoremap <leader>db :diffget 3<cr> :diffup<cr>
nnoremap <leader>dr :diffget 4<cr> :diffup<cr>
nnoremap <leader>dn ]c
nnoremap <leader>dN [c
nnoremap <leader>ih :UnusedImports<cr>
nnoremap <leader>ic :UnusedImportsClear<cr>
nnoremap <leader>id :UnusedImportsRemove<cr>
nmap <leader>ii <Plug>JavaInsertImport<cr>
nmap <leader>is <Plug>JavaSortImport<cr>
nmap <leader>ip <Plug>JavaInsertPackage<cr>
nnoremap <leader>l <c-]>
nnoremap <leader>m :Make!<cr>
nnoremap <leader>n :cn<cr>
nnoremap <leader>N :cp<cr>
nnoremap <leader>re :vsplit $MYVIMRC<cr>
nnoremap <leader>rs :source $MYVIMRC<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>t :set expandtab!<cr>:call TabHighlightModeMatch()<cr>
nnoremap <leader>f :FZF<cr>
nnoremap <leader>w :set wrap!<cr>
nnoremap <left> <C-w>h
nnoremap <down> <C-w>j
nnoremap <up> <C-w>k
nnoremap <right> <C-w>l

"save as root
command! SudoWrite :execute ':silent w !sudo tee % > /dev/null' | :edit!

"toggle tab vs space highlight mode
highlight ExtraWhitespace ctermbg=0
function! TabHighlightModeMatch()
    if &expandtab
        match ExtraWhitespace /\t\|\s\+$/
    else
        match ExtraWhitespace /^\t*\zs \+\|\s\+$/
    endif
endfunction
augroup tabHighlight
    autocmd!
    autocmd BufEnter * call TabHighlightModeMatch()
augroup END

"highlight 100th column
highlight OverLength ctermbg=1 ctermfg=15
2match OverLength /\%101v/

"local variable highlighting
let g:TypesFileIncludeLocals = 1

"java-imports
let g:sortedPackage = []
let g:packageSepDepth = 0

"vim-surrond
let g:surround_45 = '«\r»'

"vim-easymotion
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

"incsearch
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#magic = '\v'
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
" map * <Plug>(incsearch-nohl-*)
" map # <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)

"vim-asterisk
map * <Plug>(asterisk-z*)
map # <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

"vim-operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

"Ultisnips
let g:UltiSnipsExpandTrigger = '<c-s>'
let g:UltiSnipsJumpForwardTrigger = '<c-s>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsEditSplit = 'vertical'

"vim-switch
let g:switch_mapping = '-'
let g:switch_custom_definitions =
    \ [
    \   ['LinearLayout', 'RelativeLayout', 'FrameLayout'],
    \   ['View', 'TextView', 'ImageView'],
    \   ['WRAP_CONTENT', 'MATCH_PARENT'],
    \   ['wrap_content', 'match_parent'],
    \   ['HORIZONTAL', 'VERTICAL'],
    \   ['horizontal', 'vertical'],
    \   ['CENTER_VERTICAL', 'CENTER_HORIZONTAL'],
    \   ['center_vertical', 'center_horizontal'],
    \   ['!=', '=='],
    \   ['>', '<'],
    \   ['>=', '<='],
    \   ['var', 'val'],
    \   ['if', 'when'],
    \   ['boolean', 'int', 'long', 'float', 'double'],
    \   ['booleanArrayOf', 'intArrayOf', 'longArrayOf', 'floatArrayOf', 'doubleArrayOf'],
    \   ['Boolean', 'Int', 'Long', 'Float', 'Double', 'String'],
    \   ['BooleanArray', 'IntArray', 'LongArry', 'FloatArry', 'DoubleArray', 'ShortArray'],
    \   ['@Nullable', '@NonNull'],
    \   ['public', 'protected', 'private'],
    \   ['extends', 'implements'],
    \   ['layout_alignTop', 'layout_alignBottom', 'layout_alignLeft', 'layout_alignRight'],
    \   ['layout_above', 'layout_below', 'layout_toLeftOf', 'layout_toRightOf'],
    \   ['layout_marginLeft', 'layout_marginRight', 'layout_marginTop', 'layout_marginBottom'],
    \   ['paddingLeft', 'paddingRight', 'paddingTop', 'paddingBottom'],
    \ ]

"skk
let g:skk_large_jisyo = '~/.vim/SKK-JISYO.L'
let g:skk_ascii_mode_string = 'aA'
let g:skk_hira_mode_string = 'あ'
let g:skk_kata_mode_string = 'ア'
let g:skk_zenei_mode_string = 'Ａ'
let g:skk_abbrev_mode_string = 'aあ'
let g:skk_marker_white = '-'
let g:skk_marker_black = '+'

"status line
set noshowmode
set laststatus=2 "always show the status line

augroup statusline
    autocmd!
    autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave * call <sid>RefreshStatus()
augroup END

function! s:RefreshStatus()
    for nr in range(1, winnr('$'))
        call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
    endfor
endfunction

function! Status(winnum)
    let active = a:winnum == winnr()
    let stat = ''
    if active
        let stat .= '%1* %{Mode()} %0*' "mode
        let stat .= '%3*%( %{fugitive#head()} %)%0*' "vcs branch
    endif
    let stat .= '%4*%( %H%M%R %)%0*' "help, modified, read only flags
    if active && mode() ==# 'i' | let stat .= '%5*' | endif
    let stat .= ' %<%f' "path to the file relative to current directory
    let stat .= '%=' "separation point between left and right items
    if active
        let stat .= '%{SkkGetModeStr()} '
        let stat .= '%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",BOM":"")} ' "encoding
        let stat .= '%4*%{(&wrap?" W ":"")}%0*' "wrap line mode
        let stat .= '%3* %{(&expandtab?"S":"T")} %0*' "expand tab mode
        let stat .= '%2* %-6.(%l:%c%) %P %0*' "line, column, scroll position
    endif
    return stat
endfunction

function! Mode()
    hi User5 ctermbg=4 ctermfg=15
    let l:mode = mode()
    if l:mode ==# 'i'
        hi User2 ctermbg=15 ctermfg=0
        hi User3 ctermbg=12 ctermfg=0
        hi User4 ctermbg=13 ctermfg=0
    else
        hi User2 ctermbg=10 ctermfg=0
        hi User3 ctermbg=14 ctermfg=0
        hi User4 ctermbg=12 ctermfg=0
    endif
    if     l:mode ==# 'i' | redraw | hi User1 ctermbg=15 ctermfg=0 | return 'I'
    elseif l:mode ==# 'n' | redraw | hi User1 ctermbg=10 ctermfg=0 | return 'N'
    elseif l:mode ==# 'R' | redraw | hi User1 ctermbg=9  ctermfg=0 | return 'R'
    elseif l:mode ==# 'v' | redraw | hi User1 ctermbg=13 ctermfg=0 | return 'V'
    elseif l:mode ==# 'V' | redraw | hi User1 ctermbg=13 ctermfg=0 | return 'VL'
    elseif l:mode ==# ''| redraw | hi User1 ctermbg=13 ctermfg=0 | return 'VB'
    else | return l:mode
    endif
endfunction
