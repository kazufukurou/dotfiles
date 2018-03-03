# Install

```
$ cd
$ git clone --bare git@github.com:kazufukurou/dotfiles.git .homegit
$ git --git-dir=.homegit --work-tree=$HOME checkout -f
$ echo '*' >> .homegit/info/exclude
```

/etc/polkit-1/rules.d/50-udiskie.rules
```
polkit.addRule(function(action, subject) {
    var YES = polkit.Result.YES;
    var permission = {
        "org.freedesktop.udisks2.filesystem-mount": YES,
        "org.freedesktop.udisks2.encrypted-unlock": YES,
        "org.freedesktop.udisks2.eject-media": YES,
        "org.freedesktop.udisks2.power-off-drive": YES
    };
    if (subject.isInGroup("storage")) {
        return permission[action.id];
    }
});
```

```
usermod -aG storage username
```
