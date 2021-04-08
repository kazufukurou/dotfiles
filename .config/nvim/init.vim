set nobackup nowritebackup " don't create ~ files
set noswapfile " don't create .swp files
set nomodeline " modeline is not secure
set mouse=nv
set timeout timeoutlen=3000 ttimeoutlen=100
set hidden " allow open new file while having unwritten changes in opened file
set scrolloff=4 " keep cursor few lines away edge when scrolling
set nonumber " hide line numbers
set norelativenumber " hide line numbers relative to current current line
set ruler " always show current position
set cursorline " highlight current line
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab " insert 2 spaces when hit tab
set nowrap " don't wrap lines
set ignorecase " ignore case when searching
set smartcase " search is case sensitive only if it contains an uppercase letter
set gdefault " all matches in a line are substituted instead of one
set showmatch " show matching brackets when text indicator is over them
set nolist " don't show whitespaces
set shortmess+=I " hide intro message
set noshowmode " don't show mode on last line
set laststatus=2 " always show the status line
set guicursor= " disable cursor styling
set virtualedit+=block " allow block selection where is no actual characters
set wildmode=longest,full " don't show all completions
set wildignore+=*.class
set wildignore+=*.mkv,*.avi,*mp3,*.flac,*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.apk,*.zip,*.so,*.jar
set wildignore+=mapping*.txt
set wildignore+=*/build/*,*/.gradle/*,*/.idea/*,*/assets/*
set wildignore+=.git,.hg,.gradle
set rtp+=/usr/local/opt/fzf " support fzf on macOS

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
inoremap <C-c> <nop>
nnoremap Q @q
nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap Y y$
inoremap <esc> <esc>`^
inoremap <C-space> <C-x><C-]>
nnoremap <leader>. :call ToggleQf()<cr>
nnoremap <leader>f :Files!<cr>
nnoremap <leader>g :MyRg!<cr>
nnoremap <leader>ih :UnusedImports<cr>
nnoremap <leader>id :UnusedImportsRemove<cr>
nnoremap <leader>d <C-]>
nnoremap <leader>tn :tnext<cr>
nnoremap <leader>tp :tnext<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprev<cr>
nnoremap <leader>rf :call MakeAndroid('ktlintFormat', '')<cr>
nnoremap <leader>rr :call MakeAndroid('install', 'Debug')<cr>
nnoremap <leader>rt :call MakeAndroid('test', '')<cr>
nnoremap <leader>rl :call MakeAndroid('ktlintCheck', '')<cr>
nnoremap <leader>sp :set paste!<cr>
nnoremap <leader>sw :set wrap!<cr>
nnoremap <leader>w :wa<cr>
nnoremap <leader>q :qa!<cr>
nnoremap <leader>z :wqa!<cr>
nnoremap <up> <C-w>k
nnoremap <down> <C-w>j
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l

" save as root
command! SudoWrite :execute ':silent w !sudo tee % > /dev/null' | :edit!

fun! ToggleQf()
  let nr = winnr("$")
  cwindow
  let nr2 = winnr("$")
  if nr == nr2 | cclose | endif
endfun

" build and install android project
fun! MakeAndroid(task, buildType)
  if filereadable("tags") && a:task == 'install' | call system('ctagsup') | endif
  let l:buildGradle = gradle#findGradleFile()
  let l:line = system('sed -n "/^ *productFlavors/,/}/p" ' . l:buildGradle . ' | tr -s "\n {" ":" | cut -d: -f3')
  let l:flavor = substitute(l:line, '\n', '', '')
  call asyncdo#run(0, &makeprg, a:task . l:flavor . a:buildType)
  let s:statusProgressTimer = timer_start(200, { tid -> execute('call UpdateStatusProgress()')}, { 'repeat': -1 })
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

" vim-dirvish
let g:loaded_netrwPlugin = 1 " disable netrw
let g:dirvish_mode = ':sort ,^.*[\/],'

augroup dirvishConfig
  autocmd!
  autocmd FileType dirvish nnoremap <buffer><silent> x :call DirvishOpen()<cr>
  autocmd FileType dirvish nmap <nowait><buffer> m <Plug>(dirvish_arg)
  autocmd FileType dirvish xmap <nowait><buffer> m <Plug>(dirvish_arg)
augroup END

fun! DirvishOpen()
  exec '!x "' . getline('.') . '"'
endfun

augroup statusLine
  autocmd!
  autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave,QuickFixCmdPost * call <sid>UpdateStatus()
augroup END

fun! s:UpdateStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfun

let s:statusProgress = 0
let s:statusProgressTimer = 0
let s:statusProgressChars = ['⠦', '⠖', '⠲', '⠴']
let s:statusProgressChar = ''
fun! UpdateStatusProgress()
  if exists("g:asyncdo")
    let s:statusProgress = s:statusProgress < len(s:statusProgressChars) - 1 ? s:statusProgress + 1 : 0
    let s:statusProgressChar = s:statusProgressChars[s:statusProgress]
  else
    let s:statusProgressChar = ''
    call timer_stop(s:statusProgressTimer)
  endif
  call <sid>UpdateStatus()
endfun

fun! Status(winnum)
  let l:path = '%<%f %=' " path to the file relative to current directory, end of left part
  if a:winnum != winnr() | return ' ' . l:path | endif
  redraw
  let l:modes = { 'i': '1*∙', 'n': '2*∙', 'R': '6*∙', 'v': '4*⡾', 'V': '4*⠶', "\<C-V>": '4*⣿' }
  let l:mode = ' %' . get(l:modes, mode(), '3*∙') . '%0* '
  let l:flags = '%6*%(%H%M%R %)%0*'
  let l:branch = '%5*%(%{fugitive#head()} %)%0*'
  let l:progress = '%7*%(' . s:statusProgressChar . ' %)%0*'
  let l:wrap = &wrap ? 'wrap ' : ''
  let l:lineColScroll = '%l:%c %P '
  let l:encoding = &fenc == "" ? &enc : &fenc
  let l:bom = exists("+bomb") && &bomb ? '+BOM ' : ' '
  let l:format = &ff . ' '
  return l:mode . l:flags . l:branch . l:path . l:progress . l:wrap . l:lineColScroll . l:encoding . l:bom . l:format
endfun

highlight User1 ctermbg=19 ctermfg=15
highlight User2 ctermbg=19 ctermfg=8
highlight User3 ctermbg=19 ctermfg=9
highlight User4 ctermbg=19 ctermfg=13
highlight User5 ctermbg=19 ctermfg=12
highlight User6 ctermbg=19 ctermfg=11
highlight User7 ctermbg=19 ctermfg=14
