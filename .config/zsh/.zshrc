alias adble='adb logcat "*:E" | grep '
alias adbld='adb logcat "*:D" | grep '
alias adblc='adb logcat -c'
alias flu='fluidsynth -a pulseaudio -m alsa_seq -l -i -s /usr/share/soundfonts/FluidR3_GM.sf2'
alias c='clear'
alias cp='cp --interactive --verbose'
alias g='git'
alias gethosts='sudo curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o "/etc/hosts"'
alias gh='git --git-dir=$HOME/.homegit --work-tree=$HOME'
alias grep='grep -E --color=auto'
alias ls='ls -v -l --almost-all --group-directories-first --human-readable --color=auto'
alias lyrics='python3 ~/Repos/lyric-get/main_cli.py'
alias k='$EDITOR'
alias kr='$EDITOR $XDG_CONFIG_HOME/kak/kakrc'
alias kz='$EDITOR $ZDOTDIR/.zshrc'
alias kze='$EDITOR $HOME/.zshenv'
alias mkdir='mkdir --parents --verbose'
alias mnt='sudo mount -o gid=users,fmask=113,dmask=002'
alias mv='mv --interactive --verbose'
alias off='sudo poweroff'
alias ping='ping -c 5 8.8.8.8'
alias pkgc="sudo xbps-remove -Oo ; sudo vkpurge rm all"
alias pkgi='sudo xbps-install -S'
alias pkgl='xbps-query -l'
alias pkgr="sudo xbps-remove -R"
alias pkgs='xbps-query -Rs'
alias pkgu='sudo xbps-install -Su'
alias qutebrowserproxy='qutebrowser -s content.proxy socks://localhost:8080'
alias rm='rm --verbose'
alias reb='sudo reboot'
alias tunnel='ssh -C2qTnN -D 8080'
alias umnt='sudo umount'
alias up='gh su foreach git pull origin HEAD'

h2d() { echo $((0x$@)); }
d2h() { echo $(([##16]$@)); }
e() { grep "^$@.*" ~/Downloads/edict2u ; }
f() { fff "$@"; cd "$(cat "$XDG_CACHE_HOME/fff/.fff_d")"; }
md5dir() { find "$@" -type f -exec md5sum {} \; > "$@.md5" ; }

unoflash() {
  arduino-cli compile -b arduino:avr:uno
  arduino-cli upload -b arduino:avr:uno -p /dev/ttyACM0
}

# allow function calls in prompt
setopt prompt_subst

# completion
autoload -U compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu yes select

# history
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt share_history

# search history with up/down arrow keys matcthing aready typed text
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# disable Ctrl+S from pausing the terminal
stty -ixon

# vcs info
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{11}%b%f%c%u|%a'
zstyle ':vcs_info:*' formats '%F{11}%b%f%c%u'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{2}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{1}-%f'
zstyle ':vcs_info:*' enable git
precmd () { vcs_info }

# prompt
PROMPT='
%F{5}%n@%m%f %B%F{4}%~ %f%(1j.%F{2}%j %f.)${vcs_info_msg_0_}
%F{2}%(!.#.$) %f%b'

# init ssh-agent
ssh_auth_sock="$HOME/.ssh/ssh_auth_sock"
if [ ! -S "$ssh_auth_sock" ]; then
  eval $(ssh-agent)
  ln -sf "$SSH_AUTH_SOCK" "$ssh_auth_sock"
fi
export SSH_AUTH_SOCK="$ssh_auth_sock"

# plugins
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
source "/usr/share/doc/fzf/completion.zsh" 2> /dev/null
source "/usr/share/doc/fzf/key-bindings.zsh" 2> /dev/null
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2> /dev/null
# plugins for macOS
source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
source "/usr/local/opt/fzf/shell/key-bindings.zsh" 2> /dev/null
source "/usr/local/opt/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2> /dev/null

# change fzf ALT-C key binding to CTRL-N
zle -N fzf-cd-widget
bindkey '^N' fzf-cd-widget

# start WM
[ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && echo -n "Starting WM.." && sleep 1 && exec wayfire
