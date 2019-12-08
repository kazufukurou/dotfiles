setopt prompt_subst
setopt inc_append_history
setopt share_history
autoload -U colors && colors
autoload -U compinit && compinit
autoload -Uz vcs_info
zmodload zsh/complist
zstyle ':completion:*' menu yes select
zstyle ':vcs_info:*' actionformats '%F{1}%s%f %F{11}%b%f%c%u|%a'
zstyle ':vcs_info:*' formats '%F{1}%s%f %F{11}%b%f%c%u'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{2}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{1}-%f'
zstyle ':vcs_info:*' enable hg git

alias v='vim'
alias vg='vim "+Gedit:"'
alias m='mpvcmd start'
alias lyrics='python3 ~/Repos/lyric-get/main_cli.py'
alias grep='grep -E --color=auto'
alias g='git'
alias gh='git --git-dir=$HOME/.homegit --work-tree=$HOME'
alias adble='adb logcat "*:E" | grep '
alias adbld='adb logcat "*:D" | grep '
alias adblc='adb logcat -c'
alias reb='sudo reboot'
alias off='sudo poweroff'
alias lock='slock & sleep 1 && xset dpms force off'
alias tunnel='ssh -C2qTnN -D 8080'
alias pkgc="sudo xbps-remove -Oo ; sudo vkpurge rm all"
alias pkgi='sudo xbps-install -S'
alias pkgl='xbps-query -l'
alias pkgr="sudo xbps-remove -R"
alias pkgs='xbps-query -Rs'
alias pkgu='sudo xbps-install -Su'
alias mnt='sudo mount -o gid=users,fmask=113,dmask=002'
alias umnt='sudo umount'

precmd () { vcs_info }

vim_ins_mode="%F{10}I%f"
vim_cmd_mode="%F{8}N%f"
vim_mode=$vim_ins_mode

zle-keymap-select() {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}

zle-line-finish() {
    vim_mode=$vim_ins_mode
}

zle -N zle-keymap-select
zle -N zle-line-finish

# set INSERT mode on ^C
TRAPINT() {
    vim_mode=$vim_ins_mode
    return $(( 128 + $1 ))
}

PROMPT='
%F{5}%n@%m%f %B%F{4}%~ %f%(1j.%F{2}%j %f.)${vcs_info_msg_0_}
${vim_mode} %F{2}%(!.#.$) %f%b'

stty -ixon

h2d() { echo "ibase=16; $(echo $@ | tr '[a-z]' '[A-Z]')" | bc }
d2h() { echo "obase=16; $@" | bc }

export HISTFILESIZE=100000
export HISTSIZE=100000
export KEYTIMEOUT=1

ssh_auth_sock=~/.ssh/ssh_auth_sock
if [ ! -S $ssh_auth_sock ]; then
    eval $(ssh-agent)
    ln -sf "$SSH_AUTH_SOCK" $ssh_auth_sock
fi
export SSH_AUTH_SOCK=$ssh_auth_sock

mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"
[ -n "$DISPLAY" ] && [ -f "$ZDOTDIR/.base16_theme" ] && . "$ZDOTDIR/.base16_theme"
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    aplay nothing 2> /dev/null # activate alsa softvol
    amixer set Master 50%
    echo -n "Starting WM.." && sleep 1 && exec sway
fi


