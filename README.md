# Install

```
$ cd
$ git clone --bare git@github.com:kazufukurou/dotfiles.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude
```

Auto-mount external storage
```
$ sudo cp .config/udiskie/50-udiskie.rules /etc/polkit-1/rules.d
$ usermod -aG storage username
```
