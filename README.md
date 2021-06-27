# Install

```
$ cd
$ git clone --bare git@github.com:artyommironov/dotfiles.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude
```

