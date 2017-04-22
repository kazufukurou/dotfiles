# Install

```
$ cd
$ git clone --bare git@github.com:kazufukurou/dotfiles.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude
```

