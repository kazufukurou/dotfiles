export HISTFILESIZE=100000
export HISTSIZE=100000

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

alias v='nvim'
alias hgit='git --git-dir=$HOME/.homegit --work-tree=$HOME'
alias adble='adb logcat "*:E"'
alias adbld='adb logcat "*:D"'
alias adblc='adb logcat -c'

precmd () { vcs_info }

bindkey -M viins 'jk' vi-cmd-mode
vim_ins_mode="%F{10}I%f"
vim_cmd_mode="%F{8}N%f"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

PROMPT='
%B%F{4}%~ %f%(1j.%F{10}%j %f.)${vcs_info_msg_0_}
${vim_mode} %F{2}%(!.#.$) %f%b'

h2d() {
    echo "ibase=16; $@"|bc
}

d2h() {
    echo "obase=16; $@"|bc
}
