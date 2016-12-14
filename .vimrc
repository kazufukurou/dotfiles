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
nnoremap <leader>c :call asyncrun#quickfix_toggle(8)<cr>
nnoremap <leader>ih :UnusedImports<cr>
nnoremap <leader>ic :UnusedImportsClear<cr>
nnoremap <leader>id :UnusedImportsRemove<cr>
nmap <leader>ii <Plug>JavaInsertImport<cr>
nmap <leader>is <Plug>JavaSortImport<cr>
nmap <leader>ip <Plug>JavaInsertPackage<cr>
nnoremap <leader>l <c-]>
nnoremap <leader>L :tnext<cr>
nnoremap <leader>m :call MakeAndroid()<cr>
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

"build and install android project
function! MakeAndroid()
    let l:buildGradle = gradle#findGradleFile()
    let l:line = system('sed -n "/productFlavors/,/}/p" '.l:buildGradle.' | tr -s "\n {" ":" | cut -d: -f3')
    let l:flavor = substitute(l:line, '\n', '', '')
    execute 'AsyncRun -program=make '.l:flavor
endfunction

"toggle tab vs space highlight mode
highlight ExtraWhitespace ctermbg=0
function! TabHighlightModeMatch()
    if &expandtab | match ExtraWhitespace /\t\|\s\+$/
    else | match ExtraWhitespace /^\t*\zs \+\|\s\+$/
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

"translit
let g:translit_toggle_keymap = ''
inoremap <C-t> <C-o>:ToggleTranslit<cr><C-o>:DelimitMateSwitch<cr>
nnoremap <C-t> :ToggleTranslit<cr>:DelimitMateSwitch<cr>

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
    \   ['+', '-', '*', '/'],
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

"status line
set noshowmode
set laststatus=2 "always show the status line

augroup statusline
    autocmd!
    autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave * call <sid>RefreshStatus()
augroup END

function! s:RefreshStatus()
    for nr in range(1, winnr('$'))
        call setwinvar(nr, '&statusline', '%!Status('.nr.')')
    endfor
endfunction

function! Status(winnum)
    if a:winnum == winnr()
        redraw
        let l:mode = mode()
        let l:stat = '%1* ' "mode start
        if l:mode ==# 'i'
            hi User1 ctermbg=15 ctermfg=0
            hi User2 ctermbg=15 ctermfg=0
            hi User3 ctermbg=12 ctermfg=0
            hi User4 ctermbg=13 ctermfg=0
            let l:skk = substitute(SkkGetModeStr(),'\[SKK:\(.*\)\]','\1','')
            if l:skk == ' ' | let l:stat .= 'I' | else | let l:stat .= l:skk | endif
        else
            if     l:mode ==# 'n'  | hi User1 ctermbg=10 ctermfg=0 | let l:stat .= 'N'
            elseif l:mode ==# 'R'  | hi User1 ctermbg=9  ctermfg=0 | let l:stat .= 'R'
            elseif l:mode ==# 'v'  | hi User1 ctermbg=13 ctermfg=0 | let l:stat .= 'V'
            elseif l:mode ==# 'V'  | hi User1 ctermbg=13 ctermfg=0 | let l:stat .= 'VL'
            elseif l:mode ==# '' | hi User1 ctermbg=13 ctermfg=0 | let l:stat .= 'VB'
            endif
            hi User2 ctermbg=10 ctermfg=0
            hi User3 ctermbg=14 ctermfg=0
            hi User4 ctermbg=12 ctermfg=0
        endif
        hi User5 ctermbg=4 ctermfg=15
        hi User6 ctermbg=8 ctermfg=10
        hi User7 ctermbg=8 ctermfg=9
        let l:stat .= ' %0*' "mode end
        let l:stat .= '%3*%( %{fugitive#head()} %)%0*' "vcs branch
        let l:stat .= '%4*%( %H%M%R %)%0*' "help, modified, read only flags
        if l:mode ==# 'i' | let l:stat .= '%5*' | endif "change bg in insert mode
        let l:stat .= ' %<%f %=' "path to the file relative to current directory, end of left part
        if     g:asyncrun_status == 'running' | let l:stat .= '%6*▶ %0*'
        elseif g:asyncrun_status == 'success' | let l:stat .= '%6*● %0*'
        elseif g:asyncrun_status == 'failure' | let l:stat .= '%7*■ %0*'
        endif
        let l:stat .= '%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",BOM":"")} ' "encoding
        let l:stat .= '%4*%{(&wrap?" W ":"")}%0*' "wrap line mode
        let l:stat .= '%3* %{(&expandtab?"S":"T")} %0*' "expand tab mode
        let l:stat .= '%2* %-6.(%l:%c%) %P %0*' "line, column, scroll position
        return l:stat
    else | return ' %<%f' | endif
endfunction
