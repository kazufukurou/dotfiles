##Install

```
$ cd
$ git clone --bare https://github.com/kazufukurou/dotfiles.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude
```

