set cursorline " highlight current line
set gdefault " all matches in a line are substituted instead of one
set guicursor= " disable cursor styling
set hidden " allow open new file while having unwritten changes in opened file
set ignorecase " ignore case when searching
set laststatus=2 " always show the status line
set mouse=nv
set nobackup nowritebackup " don't create ~ files
set nolist " don't show whitespaces
set nomodeline " modeline is not secure
set nonumber " hide line numbers
set norelativenumber " hide line numbers relative to current current line
set noshowmode " don't show mode on last line
set noswapfile " don't create .swp files
set nowrap " don't wrap lines
set rtp+=/usr/local/opt/fzf " support fzf on macOS
set ruler " always show current position
set scrolloff=4 " keep cursor few lines away edge when scrolling
set shortmess+=c " hide insert completion messages
set shortmess+=I " hide intro message
set showmatch " show matching brackets when text indicator is over them
set signcolumn=yes " show signcolumn
set smartcase " search is case sensitive only if it contains an uppercase letter
set splitbelow " split new window below current window
set splitright " split new window to the right of current window
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab " insert 2 spaces when hit tab
set timeout timeoutlen=3000 ttimeoutlen=100
set updatetime=300
set virtualedit+=block " allow block selection where is no actual characters
set wildignore+=*.apk,*.zip,*.so,*.jar
set wildignore+=*.class
set wildignore+=*.mkv,*.avi,*mp3,*.flac,*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*/build/*,*/.gradle/*,*/.idea/*,*/assets/*
set wildignore+=.git,.hg,.gradle
set wildignore+=mapping*.txt
set wildmode=longest,full " don't show all completions

" make yank copy to the global system clipboard
let &clipboard = system('uname -s') =~ "Darwin" ? 'unnamed' : 'unnamedplus'

syntax on
let base16colorspace = 256
colorscheme base16-terminal

" leader
let mapleader = ','
let maplocalleader = ','

" bindings
nnoremap <space> <nop>
inoremap <c-c> <nop>
nnoremap Q @q
nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap > >>
nnoremap < <<
inoremap <esc> <esc>`^
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <leader>. :call ToggleQf()<cr>
nnoremap <leader>b :Buffers!<cr>
nnoremap <leader>f :Files!<cr>
nnoremap <leader>g :MyRg!<cr>
nnoremap <leader>ih :UnusedImports<cr>
nnoremap <leader>id :UnusedImportsRemove<cr>
nnoremap <leader>h :help<space>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>cf  <Plug>(coc-format-selected)
xmap <leader>cf  <Plug>(coc-format-selected)
nnoremap <leader>l :Lines!<cr>
nnoremap <leader>tn :tnext<cr>
nnoremap <leader>tp :tnext<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprev<cr>
nnoremap <leader>rf :call MakeLintFormat()<cr>
nnoremap <leader>rr :call MakeRun()<cr>
nnoremap <leader>rt :call MakeTest()<cr>
nnoremap <leader>rl :call MakeLint()<cr>
nnoremap <leader>sp :set paste!<cr>
nnoremap <leader>sw :set wrap!<cr>
nnoremap <leader>w :wa<cr>
nnoremap <leader>q :qa!<cr>
nnoremap <leader>z :wqa!<cr>
nnoremap <up> <c-w>k
nnoremap <down> <c-w>j
nnoremap <left> <c-w>h
nnoremap <right> <c-w>l

fun! ToggleQf()
  let nr = winnr("$")
  cwindow
  let nr2 = winnr("$")
  if nr == nr2 | cclose | endif
endfun

fun! MakeAsync(args)
  call asyncdo#run(0, &makeprg, a:args)
  call UpdateAsyncDoProgress()
endfun

fun! MakeRun()
  if (&filetype == "kotlin")
    call MakeAndroid('install', 'Debug')
  else
    call MakeAsync('')
  endif
endfun

fun! MakeLint()
  if (&filetype == "kotlin")
    MakeAndroid('ktlintCheck', '')
  else
    call MakeAsync('')
  endif
endfun

fun! MakeLint()
  if (&filetype == "kotlin")
    MakeAndroid('ktlintFormat', '')
  else
    call MakeAsync('')
  endif
endfun

fun! MakeTest()
  if (&filetype == "kotlin")
    call MakeAndroid('test', '')
  else
    call MakeAsync('')
  endif
endfun

" run gradle task in Android project
fun! MakeAndroid(task, buildType)
  let l:buildGradle = gradle#findGradleFile()
  let l:line = system('sed -n "/^ *productFlavors/,/}/p" ' . l:buildGradle . ' | tr -s "\n {" ":" | cut -d: -f3')
  let l:flavor = substitute(l:line, '\n', '', '')
  call MakeAsync(a:task . l:flavor . a:buildType)
endfun

" open vim help on right of current window
augroup vimrcHelp
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" highilght tabs and trailing spaces
highlight ExtraWhitespace ctermbg=19
augroup tabHighlight
  autocmd!
  autocmd BufEnter * if &readonly | match none | else | match ExtraWhitespace /\t\|\s\+$/ | endif
augroup END

" fzf
command! -bang -nargs=* MyRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- "
  \ .shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" vim-java-unused-imports
highlight link unusedimport Comment

" editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" local variable highlighting
let g:TypesFileIncludeLocals = 1

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 300
highlight HighlightedyankRegion ctermbg=2 ctermfg=0

" vim-cycle
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
  \ [['true', 'false']],
  \ [['width', 'height']],
  \ [['horizontal', 'vertical']],
  \ [['left', 'right', 'top', 'bottom']]]

" coc.nvim

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Make <CR> auto-select the first completion item and notify coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

fun! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfun

" vim-dirvish, vim-dirvish-dovish
let g:loaded_netrwPlugin = 1 " disable netrw
let g:dirvish_mode = ':sort ,^.*[\/],' " sort directories on top

augroup dirvishConfig
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> p
  autocmd FileType dirvish nmap <buffer> h <Plug>(dirvish_up)
  autocmd FileType dirvish nnoremap <silent> <buffer> l :<C-U>.call dirvish#open("edit", 0)<cr>
  autocmd FileType dirvish nmap <buffer><silent> p <Plug>(dovish_copy)
  autocmd FileType dirvish nmap <buffer><silent> P <Plug>(dovish_move)
  autocmd FileType dirvish nnoremap <buffer><silent> i :call dirvish#open("p", 1)<cr>
  autocmd FileType dirvish nnoremap <buffer><silent> x :silent :execute '!opener "' . getline('.') . '"'<cr>
  autocmd FileType dirvish nmap <nowait><buffer> m <Plug>(dirvish_arg)
  autocmd FileType dirvish xmap <nowait><buffer> m <Plug>(dirvish_arg)
augroup END

augroup statusLine
  autocmd!
  autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave,QuickFixCmdPost * call <sid>UpdateStatus()
augroup END

fun! s:UpdateStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfun

let s:asyncdoProgress = ''
fun! UpdateAsyncDoProgress()
  if exists("g:asyncdo")
    let l:progressChars = ['-', '\', '|', '/']
    let l:progress = index(progressChars, s:asyncdoProgress)
    let l:progress = l:progress < len(l:progressChars) - 1 ? l:progress + 1 : 0
    let s:asyncdoProgress = l:progressChars[l:progress]
    call timer_start(300, { tid -> execute('call UpdateAsyncDoProgress()') })
  else
    let s:asyncdoProgress = ''
  endif
  call <sid>UpdateStatus()
endfun

fun! Status(winnum)
  let l:path = '%<%f %=' " path to the file relative to current directory, end of left part
  if a:winnum != winnr() | return ' ' . l:path | endif
  redraw
  let l:modes = { 'i': '1*I', 'n': '2*N', 'R': '6*R', 'v': '4*v', 'V': '4*V', "\<C-V>": '4*ʌ' }
  let l:mode = ' %' . get(l:modes, mode(), '3*∙') . '%0* '
  let l:flags = '%6*%(%H%M%R %)%0*'
  let l:branch = '%5*%(%{fugitive#head()} %)%0*'
  let l:progress = '%7*%(' . s:asyncdoProgress . ' %)%0*'
  let l:coc = '%{coc#status()} '
  let l:wrap = &wrap ? 'wrap ' : ''
  let l:lineColScroll = '%l:%c %P '
  let l:encoding = &fenc == "" ? &enc : &fenc
  let l:bom = exists("+bomb") && &bomb ? '+BOM ' : ' '
  let l:format = &ff . ' '
  return l:mode . l:flags . l:branch . l:path . l:progress . l:coc . l:wrap . l:lineColScroll . l:encoding . l:bom . l:format
endfun

highlight User1 ctermbg=19 ctermfg=15
highlight User2 ctermbg=19 ctermfg=8
highlight User3 ctermbg=19 ctermfg=9
highlight User4 ctermbg=19 ctermfg=13
highlight User5 ctermbg=19 ctermfg=12
highlight User6 ctermbg=19 ctermfg=11
highlight User7 ctermbg=19 ctermfg=14
