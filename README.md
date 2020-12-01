# Install

```
$ cd
$ git clone --bare git@github.com:kazufukurou/dotfiles.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude
```

# Update submodules
```
gh submodule foreach git pull origin master
```

# Vim plugins

* asyncdo.vim - async task runner
* editorconfig-vim - support editorconfig
* eskk.vim - Japanese input (<C-j>)
* fzf.vim - fuzzy search
* kotlin-vim - Kotlin syntax
* vim-android-sensible - build Android gradle projects
* vim-arduino-syntax - Arduino syntax
* vim-asterisk - improved \*
* vim-commentary - comment stuff (gc gcc)
* vim-cycle - toggle related words (<C-x> <C-a>)
* vim-fugitive - git tools
* vim-java-unused-imports - highlight, remove unused imports (,ih ,id)
* vim-minisnip - snippets
* vim-operator-flashy - flash yanked area
* vim-operator-user - library to define operators, used by vim-operator-flashy
* vim-sandwich - add, delete, replace text surroundings (sae" sd" sr"')
* vim-smartinput - auto input matching braces
* vimport-sort - sort imports (,is)
