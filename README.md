# Install

```
$ cd
$ git clone --bare git@github.com:kazufukurou/dotfiles.git .hgit
$ git --git-dir=.hgit --work-tree=$HOME checkout -f
$ echo '*' >> .hgit/info/exclude
```

Auto-mount external storage
```
$ sudo cp .config/udiskie/50-udiskie.rules /etc/polkit-1/rules.d
$ usermod -aG storage username
```
