syntax on
filetype plugin indent on

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
set nocompatible
set noundofile "don't create .un~ files
set nobackup nowritebackup "don't create ~ files
set noswapfile "don't create .swp files
set mouse=nv
set hidden "allow to have unwritten changes to a file and open a new file
set hlsearch "highlight search
set scrolloff=4 "keep cursor few lines away edge when scrolling
set nonumber "dont show line numbers
set norelativenumber "line numbers are relative to current current line
set ruler "always show current position
set cursorline "highlight current line
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
set wildignore+=mapping*.txt
set wildignore+=*/build/*,*/.gradle/*,*/.idea/*,*/assets/*
set wildignore+=.git,.hg,.gradle

"netrw
let g:netrw_banner = 0 "hide help
let g:netrw_preview = 1 "open previews vertically
let g:netrw_winsize = 20
let g:netrw_browse_split = 4
let g:netrw_altv = 1

"leader
let mapleader = ','
let maplocalleader = ','

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
inoremap <C-@> <C-x><C-]>
inoremap <C-space> <C-x><C-]>
nnoremap <leader>c :call ToggleQf()<cr>
nnoremap <Plug>ToggleQf :call <SID>ToggleQf()<cr>
nnoremap <leader>e :Lexplore<cr>
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP
nnoremap <leader>ih :UnusedImports<cr>
nnoremap <leader>ic :UnusedImportsClear<cr>
nnoremap <leader>id :UnusedImportsRemove<cr>
nmap <leader>ii <Plug>JavaInsertImport<cr>
nmap <leader>is <Plug>JavaSortImport<cr>
nmap <leader>ip <Plug>JavaInsertPackage<cr>
nnoremap <leader>l <C-]>
nnoremap <leader>L :tnext<cr>
nnoremap <leader>cn ]c
nnoremap <leader>cN [c
nnoremap <leader>m :call MakeAndroid()<cr>
nnoremap <leader>n :cn<cr>
nnoremap <leader>N :cp<cr>
nnoremap <leader>re :vsplit $MYVIMRC<cr>
nnoremap <leader>rs :source $MYVIMRC<cr>
nnoremap <leader>s :wa<cr>
nnoremap <leader>t :set expandtab!<cr>:call TabHighlightModeMatch()<cr>
nnoremap <leader>f :FZF<cr>
nnoremap <leader>w :set wrap!<cr>
nnoremap <left> <C-w>h
nnoremap <down> <C-w>j
nnoremap <up> <C-w>k
nnoremap <right> <C-w>l

"save as root
command! SudoWrite :execute ':silent w !sudo tee % > /dev/null' | :edit!

function! ToggleQf()
    for buffer in tabpagebuflist()
        if bufname(buffer) == ''
            cclose
            return
        endif
    endfor
    copen
endfunction

"build and install android project
command! -bang -nargs=* Make call asyncdo#run(<bang>0, &makeprg, <f-args>)
function! MakeAndroid()
    let l:buildGradle = gradle#findGradleFile()
    let l:line = system('sed -n "/^ *productFlavors/,/}/p" '.l:buildGradle.' | tr -s "\n {" ":" | cut -d: -f3')
    let l:flavor = substitute(l:line, '\n', '', '')
    " execute 'make '.l:flavor
    call asyncdo#run(0, &makeprg, l:flavor)
endfunction

"toggle tab vs space highlight mode
highlight ExtraWhitespace ctermbg=19
function! TabHighlightModeMatch()
    if &expandtab | match ExtraWhitespace /\t\|\s\+$/
    else | match ExtraWhitespace /^\t*\zs \+\|\s\+$/
    endif
endfunction
augroup tabHighlight
    autocmd!
    autocmd BufEnter * call TabHighlightModeMatch()
augroup END

"highlight 120th column
highlight OverLength ctermbg=1 ctermfg=15
2match OverLength /\%121v/

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

"vim-sneak
let g:sneak#label = 1
" let g:sneak#s_next = 1
hi Sneak ctermfg=15 ctermbg=5
hi SneakScope ctermfg=14 ctermbg=5

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
let g:operator#flashy#group = 'Visual'
let g:operator#flashy#flash_time = 200

"vim-minisnip
let g:minisnip_trigger = '<C-s>'

"vim-cycle
nmap <silent> <C-a> <Plug>CycleNext
nmap <silent> <C-x> <Plug>CyclePrev
noremap <silent> <Plug>CycleFallbackNext <C-a>
noremap <silent> <Plug>CycleFallbackPrev <C-x>
let g:cycle_default_groups = [
    \ [['+', '-', '*', '/']],
    \ [['<', '>']],
    \ [['<=', '>=']],
    \ [['on', 'off']],
    \ [['yes', 'no']],
    \ [['var', 'val']],
    \ [['if', 'when']],
    \ [['true', 'false']],
    \ [['width', 'height']],
    \ [['horizontal', 'vertical']],
    \ [['extends', 'implements']],
    \ [['public', 'protected', 'private']],
    \ [['left', 'right', 'top', 'bottom']],
    \ [['@Nullable', '@NonNull'], 'hard_case'],
    \ [['View', 'TextView', 'ImageView'], 'hard_case'],
    \ [['LinearLayout', 'RelativeLayout', 'FrameLayout'], 'hard_case'],
    \ [['wrap_content', 'match_parent'], 'hard_case', 'match_case'],
    \ [['WRAP_CONTENT', 'MATCH_PARENT'], 'hard_case', 'match_case'],
    \ [['center_vertical', 'center_horizontal'], 'hard_case', 'match_case'],
    \ [['CENTER_VERTICAL', 'CENTER_HORIZONTAL'], 'hard_case', 'match_case'],
    \ [['isEmpty', 'isNotEmpty', 'isBlank', 'isNotBlank'], 'hard_case'],
    \ [['boolean', 'int', 'long', 'float', 'double']],
    \ [['Boolean', 'Int', 'Long', 'Float', 'Double', 'String'], 'hard_case', 'match_case'],
    \ [['booleanArrayOf', 'intArrayOf', 'longArrayOf', 'floatArrayOf', 'doubleArrayOf'], 'hard_case', 'match_case'],
    \ [['BooleanArray', 'IntArray', 'LongArry', 'FloatArry', 'DoubleArray', 'ShortArray'], 'hard_case', 'match_case'],
    \ [['layout_alignTop', 'layout_alignBottom', 'layout_alignLeft', 'layout_alignRight'], 'hard_case'],
    \ [['layout_above', 'layout_below', 'layout_toLeftOf', 'layout_toRightOf'], 'hard_case'],
    \ [['layout_marginLeft', 'layout_marginRight', 'layout_marginTop', 'layout_marginBottom']],
    \ [['paddingLeft', 'paddingRight', 'paddingTop', 'paddingBottom']]]

"skk
let g:skk_large_jisyo = '~/.vim/SKK-JISYO.L'
let g:skk_auto_save_jisyo = -1

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
        let l:skk = substitute(SkkGetModeStr(),'\[SKK:\(.*\)\]','\1','')
        let l:stat = '' "mode start
        if l:mode ==# 'i' | let l:stat .= '%1* '.(l:skk == ' ' ? 'I' : l:skk)
        elseif l:mode ==# 'n' | let l:stat .= '%2* N'
        elseif l:mode ==# 'R' | let l:stat .= '%3* R'
        elseif l:mode ==# 'v' | let l:stat .= '%4* V'
        elseif l:mode ==# 'V' | let l:stat .= '%4* VL'
        elseif l:mode ==# '' | let l:stat .= '%4* VB'
        endif
        let l:stat .= ' %0*' "mode end
        let l:stat .= '%5*%( %{fugitive#head()} %)%0*' "vcs branch
        let l:stat .= '%6*%( %H%M%R %)%0*' "help, modified, read only flags
        let l:stat .= ' %<%f %=' "path to the file relative to current directory, end of left part
        if exists("g:asyncdo") | let l:stat .= '%7* ▶ %0*' | endif "async job indicator
        let l:stat .= (&fenc == "" ? &enc : &fenc).((exists("+bomb") && &bomb) ? '+BOM' : '').' ' "encoding
        if &wrap | let l:stat .=  '%6* W %0*' | endif "wrap line mode
        if !&expandtab | let l:stat .= '%5* T %0*' | endif "expand tab mode
        let l:stat .= '%2* %-6.(%l:%c%) %P %0*' "line, column, scroll position
        return l:stat
    else | return ' %<%f' | endif
endfunction

highlight User1 ctermbg=15 ctermfg=0
highlight User2 ctermbg=10 ctermfg=0
highlight User3 ctermbg=9  ctermfg=0
highlight User4 ctermbg=13 ctermfg=0
highlight User5 ctermbg=14 ctermfg=0
highlight User6 ctermbg=12 ctermfg=0
highlight User7 ctermbg=19 ctermfg=14
