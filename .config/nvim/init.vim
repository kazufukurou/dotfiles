call plug#begin()
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'Raimondi/delimitMate'
Plug 'haya14busa/incsearch.vim'
Plug 'osyo-manga/vim-over'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'SirVer/ultisnips'
Plug 'EasyMotion'
Plug 'kazufukurou/vim-android'
Plug g:plug_home.'/eclim'
call plug#end()

color mycolorscheme
syntax on "enable syntax highlighting
set hidden "allow to have unwritten changes to a file and open a new file
set nobackup nowritebackup noswapfile "don't keep backups
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
set wildmode=longest,full "don't show all completions
set wildignore+=*.class
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.apk,*.zip
set wildignore+=*/build/*,*/.gradle/*,*/.idea/*,*/assets/*
set wildignore+=.git,.hg,.gradle

"leader
let mapleader = ' '
let maplocalleader = ' '

"unwanded keys
nnoremap : <nop>
nnoremap <space> <nop>
nnoremap Q <nop>
inoremap <C-c> <nop>

"don't skip wrapped lines
nnoremap j gj
nnoremap k gk

"better omnicomplete
inoremap <C-@> <C-x><C-o>

"easy command line mode
nnoremap ; :

"don't move cursor then exit insert mode
inoremap <esc> <esc>`^
inoremap jk <esc>`^

"turn off Vim's crazy default regex characters
"nnoremap / /\v

"easy window navigation
nnoremap <left> <C-w>h
nnoremap <down> <C-w>j
nnoremap <up> <C-w>k
nnoremap <right> <C-w>l

"wrap lines
nnoremap <silent><leader>w :set wrap!<CR>

"vimrc editing
nnoremap <leader>re :vsplit $MYVIMRC<cr>
nnoremap <leader>rs :source $MYVIMRC<cr>

"quick saving
nnoremap <leader>s :w<cr>

"save as root
command! SudoWrite :execute ':silent w !sudo tee % > /dev/null' | :edit!

"toggle tab vs space highlight mode
highlight ExtraWhitespace ctermbg=0 guibg=0
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
nnoremap <leader>t :set expandtab!<cr>:call TabHighlightModeMatch()<cr>

"highlight 80th column
highlight OverLength ctermbg=1 ctermfg=15
match OverLength /\%81v/

"local variable highlighting
let g:TypesFileIncludeLocals = 1

"vim-over
nnoremap <leader>o :OverCommandLine<cr>

"vim-surrond
let g:surround_45 = "«\r»"

"CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_map = '<leader>p'
let g:ctrlp_status_func = { 'main': 'CtrlP_Statusline_1', 'prog': 'CtrlP_Statusline_2', }
function! CtrlP_Statusline_1(...)
    let focus = '%2* '.a:1.' %*'
    let byfname = '%2* '.a:2.' %*'
    let regex = a:3 ? '%2* regex %*' : ''
    let prv = ' '.a:4.' '
    let item = '%#WildMenu# '.a:5.' %*'
    let nxt = ' '.a:6.' '
    let marked = ' '.a:7.' '
    let dir = ' %=%< '.getcwd().' '
    return focus.byfname.regex.prv.item.nxt.marked.dir
endfunction
function! CtrlP_Statusline_2(...)
    let len = '%2* '.a:1.' %*'
    let dir = ' %=%< '.getcwd().' '
    return len.dir
endfunction

"incsearch
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Ultisnips
let g:UltiSnipsExpandTrigger = '<c-s>'
let g:UltiSnipsJumpForwardTrigger = '<c-s>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsEditSplit = 'vertical'

"Eclim
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimJavaSearchSingleResult = 'edit'
let g:EclimJavaCompilerAutoDetect = 0
nnoremap <silent> <leader>ec :JavaCorrect<cr>
nnoremap <silent> <leader>es :JavaSearch<cr>
nnoremap <silent> <leader>ed :JavaDocPreview<cr>
nnoremap <silent> <leader>eo :JavaImpl<cr>
nnoremap <silent> <leader>ei :JavaImport<cr>
nnoremap <silent> <leader>eg :JavaGet<cr>
nnoremap <silent> <leader>egs :JavaGetSet<cr>

"status line
set noshowmode
set laststatus=2 "always show the status line

augroup statusline
    autocmd!
    autocmd BufEnter,FileChangedShell,CursorHold * call SetBranch()
    autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave * :RefreshStatus
augroup END

function! s:RefreshStatus()
    for nr in range(1, winnr('$'))
        call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
    endfor
endfunction

command! RefreshStatus :call <SID>RefreshStatus()

function! Status(winnum)
    let active = a:winnum == winnr()
    let stat = ''
    if active
        let stat .= '%1* %{Mode()} %0*' "mode
        let stat .= '%3*%( %{g:branch} %)%0*' "vcs branch
    endif
    let stat .= '%4*%( %H%M%R %)%0*' "help, modified, read only flags
    if active && mode() ==# "i" | let stat .= '%5*' | endif
    let stat .= ' %<%f' "path to the file relative to current directory
    let stat .= '%=' "separation point between left and right items
    if active
        let stat .= '%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",BOM":"")} ' "encoding
        let stat .= '%4*%{(&wrap?" W ":"")}%0*' "wrap line mode
        let stat .= '%3* %{(&expandtab?"S":"T")} %0*' "expand tab mode
        let stat .= '%2* %-6.(%l:%c%) %P %0*' "line, column, scroll position
    endif
    return stat
endfunction

let g:branch = ''
function! SetBranch()
    let l:branch = substitute(system("hg branch"), '\n', '', '')
    if l:branch !~ 'abort'
        let g:branch = l:branch
    else
        let l:branch = substitute(system("git name-rev --name-only HEAD"), '\n', '', '')
        if l:branch !~ 'fatal'
            let g:branch = l:branch
        endif
    endif
endfunction

function! Mode()
    hi User5 ctermbg=4 ctermfg=15
    let l:mode = mode()
    if l:mode ==# "i"
        hi User2 ctermbg=15 ctermfg=0
        hi User3 ctermbg=12 ctermfg=0
        hi User4 ctermbg=13 ctermfg=0
    else
        hi User2 ctermbg=10 ctermfg=0
        hi User3 ctermbg=14 ctermfg=0
        hi User4 ctermbg=12 ctermfg=0
    endif
    if     l:mode ==# "i" | redraw | hi User1 ctermbg=15 ctermfg=0 | return "I"
    elseif l:mode ==# "n" | redraw | hi User1 ctermbg=10 ctermfg=0 | return "N"
    elseif l:mode ==# "R" | redraw | hi User1 ctermbg=9  ctermfg=0 | return "R"
    elseif l:mode ==# "v" | redraw | hi User1 ctermbg=13 ctermfg=0 | return "V"
    elseif l:mode ==# "V" | redraw | hi User1 ctermbg=13 ctermfg=0 | return "VL"
    elseif l:mode ==# ""| redraw | hi User1 ctermbg=13 ctermfg=0 | return "VB"
    else | return l:mode
    endif
endfunction
