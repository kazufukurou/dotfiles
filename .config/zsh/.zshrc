setopt prompt_subst
setopt inc_append_history
setopt share_history
autoload -U colors && colors
autoload -U compinit && compinit
autoload -Uz vcs_info
zmodload zsh/complist
zstyle ':completion:*' menu yes select
zstyle ':vcs_info:*' actionformats '%F{11}%b%f%c%u|%a'
zstyle ':vcs_info:*' formats '%F{11}%b%f%c%u'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{2}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{1}-%f'
zstyle ':vcs_info:*' enable git

alias adble='adb logcat "*:E" | grep '
alias adbld='adb logcat "*:D" | grep '
alias adblc='adb logcat -c'
alias flu='fluidsynth -a pulseaudio -m alsa_seq -l -i -s /usr/share/soundfonts/FluidR3_GM.sf2'
alias g='git'
alias gethosts='sudo curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o "/etc/hosts"'
alias gh='git --git-dir=$HOME/.homegit --work-tree=$HOME'
alias grep='grep -E --color=auto'
alias lyrics='python3 ~/Repos/lyric-get/main_cli.py'
alias m='mpvcmd start'
alias mnt='sudo mount -o gid=users,fmask=113,dmask=002'
alias off='sudo poweroff'
alias pkgc="sudo xbps-remove -Oo ; sudo vkpurge rm all"
alias pkgi='sudo xbps-install -S'
alias pkgl='xbps-query -l'
alias pkgr="sudo xbps-remove -R"
alias pkgs='xbps-query -Rs'
alias pkgu='sudo xbps-install -Su'
alias reb='sudo reboot'
alias tunnel='ssh -C2qTnN -D 8080'
alias umnt='sudo umount'
alias v='vim'
alias vg='vim "+Gedit:"'

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
md5dir() { find "$@" -type f -exec md5sum {} \; > "$@.md5" ; }
yaku() { grep "^$@.*" ~/Downloads/edict2u ; }

unoflash() {
    arduino-cli compile -b arduino:avr:uno
    arduino-cli upload -b arduino:avr:uno -p /dev/ttyACM0
}


ssh_auth_sock=~/.ssh/ssh_auth_sock
if [ ! -S $ssh_auth_sock ]; then
    eval $(ssh-agent)
    ln -sf "$SSH_AUTH_SOCK" $ssh_auth_sock
fi
export SSH_AUTH_SOCK=$ssh_auth_sock

mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"
theme="$XDG_CONFIG_HOME/base16-shell/.base16_theme"
[ -n "$DISPLAY" ] && [ -f "$theme" ] && . "$theme"
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    echo -n "Starting WM.." && sleep 1 && exec hikari
fi

