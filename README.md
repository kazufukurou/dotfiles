# Install

```
$ cd
$ git clone --bare git@github.com:kazufukurou/dotfiles.git .hgit
$ git --git-dir=.hgit --work-tree=$HOME checkout -f
$ echo '*' >> .hgit/info/exclude
```
