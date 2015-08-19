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
call plug#end()

color mycolorscheme
syntax on "enable syntax highlighting
set noshowmode
set scrolloff=4
set hidden "allow to have unwritten changes to a file and open a new file
set nonumber "dont show line numbers
set norelativenumber "line numbers are relative to current current line
set ruler "always show current position
set cursorline "highlight current line
set laststatus=2 "always show the status line
set visualbell "flash its screen instead of sounding a beep
set tabstop=4 "1 tab=4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab "replace tabs with spaces
set nobackup "don't keep backups after close
set nowritebackup
set noswapfile
set ignorecase "ignore case when searching
set smartcase "if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not
set gdefault "all matches in a line are substituted instead of one
set showmatch "show matching brackets when text indicator is over them
set smartindent "automatically inserts one extra level of indentation in some cases
set wrap "wrap lines
set nolist "don't show whitespaces
set clipboard=unnamedplus "make yank copy to the global system clipboard
set shortmess+=I "no startup messages
set virtualedit+=block "allow block selection where is no actual characters
set wildmode=longest,full "don't show all completions
set wildignore+=*.class
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.apk,*.zip
set wildignore+=*/build/*,*/.gradle/*,*/.idea/*
set wildignore+=.git,.hg,.gradle

if has('gui_running')
    set guioptions-=m "hide menu bar
    set guioptions-=T "hide toolbar
    color elflord
endif

"leader
let mapleader=' '
let maplocalleader=' '

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
inoremap hh <esc>`^

"turn off Vim's crazy default regex characters
"nnoremap / /\v

"easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"move text with arrows
"nnoremap <Left> <<
"nnoremap <Right> >>
"vnoremap <Left> <gv
"vnoremap <Right> >gv
"nmap <Up> [e
"nmap <Down> ]e
"vmap <Up> [egv
"vmap <Down> ]egv

"wrap lines
nnoremap <silent><leader>w :set wrap!<CR>

"vimrc editing
nnoremap <leader>re :vsplit $MYVIMRC<cr>
nnoremap <leader>rs :source $MYVIMRC<cr>

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
call TabHighlightModeMatch()
nnoremap <leader>t :set expandtab!<cr>:call TabHighlightModeMatch()<cr>

"local variable highlighting
let g:TypesFileIncludeLocals=1

"vim-over
nnoremap <leader>o :OverCommandLine<cr>

"vim-surrond
let g:surround_45 = "«\r»"

"CtrlP
let g:ctrlp_show_hidden=1
let g:ctrlp_use_caching=0
let g:ctrlp_map='<leader>p'

"Eclim
let g:EclimCompletionMethod='omnifunc'
let g:EclimJavaSearchSingleResult='edit'
nnoremap <silent> <leader>ec :JavaCorrect<cr>
nnoremap <silent> <leader>es :JavaSearch<cr>
nnoremap <silent> <leader>ed :JavaDocSearch<cr>
nnoremap <silent> <leader>eo :JavaImpl<cr>
nnoremap <silent> <leader>ei :JavaImport<cr>
nnoremap <silent> <leader>eg :JavaGet<cr>
nnoremap <silent> <leader>egs :JavaGetSet<cr>

"incsearch
let g:incsearch#auto_nohlsearch=1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"status line
if has('statusline')
    augroup statusline
        autocmd!
        au BufEnter,FileChangedShell,CursorHold * call SetBranch()
    augroup END

    let g:branch=''
    function! SetBranch()
        let l:branch=substitute(system("hg branch"), '\n', '', '')
        if l:branch!~'abort'
            let g:branch=l:branch
        else
            let l:branch=substitute(system("git name-rev --name-only HEAD"), '\n', '', '')
            if l:branch!~'fatal'
                let g:branch=l:branch
            endif
        endif
    endfunction

    let g:last_mode=''
    function! Mode()
        redraw
        let l:mode=mode()
        if     mode ==# "n"  | exec 'hi User1 ctermbg=10 ctermfg=0' | return "N"
        elseif mode ==# "i"  | exec 'hi User1 ctermbg=0 ctermfg=15' | return "I"
        elseif mode ==# "R"  | exec 'hi User1 ctermbg=9 ctermfg=0'  | return "R"
        elseif mode ==# "v"  | exec 'hi User1 ctermbg=13 ctermfg=0' | return "V"
        elseif mode ==# "V"  | exec 'hi User1 ctermbg=13 ctermfg=0' | return "VL"
        elseif mode ==# "" | exec 'hi User1 ctermbg=13 ctermfg=0' | return "VB"
        else                 | return l:mode
        endif
    endfunction

    hi User2 ctermbg=10 ctermfg=0
    hi User3 ctermbg=14 ctermfg=0
    hi User4 ctermbg=12 ctermfg=0

    set statusline=%1*\ %{Mode()}\ %0* "mode
    set statusline+=%3*%(\ %{g:branch}\ %)%0* "vcs branch
    set statusline+=%4*%(\ %H%M%R\ %)%0* "help, modified, read only flags
    set statusline+=\ %<%f "path to the file relative to current directory
    set statusline+=%= "separation point between left and right items
    set statusline+=\ %l:%c\ %P\ %0* "line, column, scroll position
    set statusline+=%4*%{(&wrap?\"\ W\ \":\"\")}%0* "wrap line mode
    set statusline+=%3*\ %{(&expandtab?\"S\":\"T\")}\ %0* "expand tab mode
    set statusline+=%2*\ %{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\")}\ %0* "encoding
endif
