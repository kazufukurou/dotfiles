PATH=~/.local/bin:~/android-sdk/tools:~/android-sdk/platform-tools:$PATH

export LANG=en_US.utf8
export LESSCHARSET=utf-8
export EDITOR=vim
export VISUAL=$EDITOR
export BROWSER=vimb
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export GDK_DPI_SCALE=1.5
export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
export ANDROID_HOME="$HOME/android-sdk"
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export _JAVA_AWT_WM_NONREPARENTING=1
export FZF_DEFAULT_OPTS='--color 16'
export FZF_DEFAULT_COMMAND='ag -g ""'
export HISTFILE="$XDG_DATA_HOME/bash/history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="$HOME/.runtime"

alias v='vim'
alias vg='vim "+Gedit:"'
alias grep='grep -E --color=auto'
alias g='git'
alias gh='git --git-dir=$HOME/.homegit --work-tree=$HOME'
alias reb='sudo reboot'
alias off='sudo poweroff'
alias pkgc="sudo xbps-remove -Oo ; sudo vkpurge rm all"
alias pkgi='sudo xbps-install -S'
alias pkgl='xbps-query -l'
alias pkgr="sudo xbps-remove -R"
alias pkgs='xbps-query -Rs'
alias pkgu='sudo xbps-install -Su'
alias mnt='sudo mount -o gid=users,fmask=113,dmask=002'
alias umnt='sudo umount'
alias m='mpvcmd start'
alias adble='adb logcat "*:E" | grep '
alias adbld='adb logcat "*:D" | grep '
alias adblc='adb logcat -c'
alias lyrics='python3 ~/Repos/lyric-get/main_cli.py'
alias flu='fluidsynth -a alsa -m alsa_seq -l -i -s /usr/share/soundfonts/FluidR3_GM.sf2'
alias tunnel='ssh -C2qTnN -D 8080'
alias gethosts='sudo curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o "/etc/hosts"'
alias getgitcompletion='curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o "$XDG_CONFIG_HOME/git/git-completion.bash"'

yaku() { grep "^$@.*" ~/Downloads/edict2u ; }
h2d() { echo "ibase=16; $(echo $@ | tr '[a-z]' '[A-Z]')" | bc ; }
d2h() { echo "obase=16; $@" | bc ; }

git_branch() {
    #git symbolic-ref HEAD --short 2>/dev/null
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_progress() {
  git_dir="$(git rev-parse --git-dir 2> /dev/null)"
  [ -d "$git_dir/rebase-merge" ] || [ -d "$git_dir/rebase-apply" ] && echo " rebase"
  [ -f "$git_dir/MERGE_HEAD" ] && echo " merge"
  [ -f "$git_dir/CHERRY_PICK_HEAD" ] && echo " cherry-pick"
  [ -f "$git_dir/BISECT_LOG" ] && echo " bisect"
  [ -f "$git_dir/REVERT_HEAD" ] && echo " revert"
}

f=$(tput sgr0)
f2=$(tput setaf 2)
f4=$(tput setaf 4)
f5=$(tput setaf 5)
f11=$(tput setaf 11)
PS1='\n${f5}\u@\h ${f4}\w ${f11}$(git_branch)$f$(git_progress)\n$ '

ssh_auth_sock=~/.ssh/ssh_auth_sock
[ ! -S "$ssh_auth_sock" ] && eval $(ssh-agent) && ln -sf "$SSH_AUTH_SOCK" $ssh_auth_sock
export SSH_AUTH_SOCK=$ssh_auth_sock

theme=~/.base16_theme
[ -n "$DISPLAY" ] && [ -f "$theme" ] && . "$theme"

git_completion="$XDG_CONFIG_HOME/git/git-completion.bash"
[ -f "$git_completion" ] && . "$git_completion" && __git_complete g _git
