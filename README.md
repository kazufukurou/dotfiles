# Install

```
$ cd
$ git clone --bare git@github.com:artyommironov/dotfiles.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude
```

# Vim plugins

* asyncdo.vim - async task runner
* editorconfig-vim - support editorconfig
* coc.nvim - support LSP
* fzf.vim - fuzzy search
* kotlin-vim - Kotlin syntax
* vim-android-sensible - build Android gradle projects
* vim-arduino-syntax - Arduino syntax
* vim-commentary - comment stuff (gc gcc)
* vim-cycle - toggle related words (Ctrl-x Ctrl-a)
* vim-dirvish - file browser (-)
* vim-dirvish-dovish - file operations (dd yy p P a A r)
* vim-godot - godot support
* vim-fugitive - git tools
* vim-java-unused-imports - highlight, remove unused imports (,ih ,id)
* vim-highlightedyank - flash yanked area
* vim-love-efm - lua + love2d support
* vim-sandwich - add, delete, replace text surroundings (sae" sd" sr"')
* vim-smartinput - auto input matching braces
