Arch linux, programmer dvorak, bspwm, zsh, vim

Install

$ cd
$ git clone --bare git@github.com:kazufukurou/homedir.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude

