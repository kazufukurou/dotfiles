export HISTFILESIZE=100000
export HISTSIZE=100000

[ -f $ZDOTDIR/.base16_theme ] && . $ZDOTDIR/.base16_theme

setopt prompt_subst
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

alias v='$EDITOR'
alias t='tmux'
alias m='mplayercmd start'
alias g='grep -E --color=auto'
alias hgit='git --git-dir=$HOME/.homegit --work-tree=$HOME'
alias adble='adb logcat "*:E"'
alias adbld='adb logcat "*:D"'
alias adblc='adb logcat -c'
alias reb='/usr/bin/reboot'
alias off='/usr/bin/poweroff'
alias lock='slock & sleep 1 && xset dpms force off'
alias java='java -Dawt.useSystemAAFontSettings=on'
alias tunnel='ssh -C2qTnN -D 8080'

precmd () { vcs_info }

bindkey -M viins 'jk' vi-cmd-mode
vim_ins_mode="%F{10}I%f"
vim_cmd_mode="%F{8}N%f"
vim_mode=$vim_ins_mode

zle-keymap-select() {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

zle-line-finish() {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

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
