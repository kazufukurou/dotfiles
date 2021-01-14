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
alias ls='ls -l --almost-all --group-directories-first --human-readable --color=auto'
alias lyrics='python3 ~/Repos/lyric-get/main_cli.py'
alias m='mpvcmd start'
alias mkdir='mkdir --parents --verbose'
alias mnt='sudo mount -o gid=users,fmask=113,dmask=002'
alias mv='mv --interactive --verbose'
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
alias vv='vim $XDG_CONFIG_HOME/vim/vimrc'
alias vz='vim $ZDOTDIR/.zshrc'
alias vze='vim $HOME/.zshenv'

h2d() { echo "ibase=16; $(echo $@ | tr '[a-z]' '[A-Z]')" | bc }
d2h() { echo "obase=16; $@" | bc }
md5dir() { find "$@" -type f -exec md5sum {} \; > "$@.md5" ; }
yaku() { grep "^$@.*" ~/Downloads/edict2u ; }

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

# vim mode
vim_ins_mode="%F{10}I%f"
vim_cmd_mode="%F{8}N%f"
vim_mode=$vim_ins_mode

# register functions for updating vim mode
zle -N zle-keymap-select
zle -N zle-line-finish

# update vim mode
zle-keymap-select() {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}

# set vim insert mode on after line read
zle-line-finish() {
  vim_mode=$vim_ins_mode
}

# set vim insert mode on ^C
TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

# prompt
PROMPT='
%F{5}%n@%m%f %B%F{4}%~ %f%(1j.%F{2}%j %f.)${vcs_info_msg_0_}
${vim_mode} %F{2}%(!.#.$) %f%b'

# init ssh-agent
ssh_auth_sock="$HOME/.ssh/ssh_auth_sock"
if [ ! -S "$ssh_auth_sock" ]; then
  eval $(ssh-agent)
  ln -sf "$SSH_AUTH_SOCK" "$ssh_auth_sock"
fi
export SSH_AUTH_SOCK="$ssh_auth_sock"

# fix clearing base16 theme colors
if [ "$TERM" != "linux" ] && infocmp $TERM | grep --silent 'oc='; then
  tmp_terminfo=$(mktemp)
  infocmp $TERM | sed -r 's/oc=[^,]+, ?//' > $tmp_terminfo
  tic $tmp_terminfo
  rm $tmp_terminfo
fi

# theme
[ -n "$DISPLAY" ] && source "$XDG_CONFIG_HOME/base16-shell/.base16_theme" 2> /dev/null

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

# start WM
mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"
[ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ] && echo -n "Starting WM.." && sleep 1 && exec hikari
