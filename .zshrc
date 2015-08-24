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

precmd () { vcs_info }

PROMPT='
%B%F{4}%~ %f%(1j.%F{10}%j %f.)${vcs_info_msg_0_}
%F{2}%(!.#.$) %f%b'

h2d() {
    echo "ibase=16; $@"|bc
}

d2h() {
    echo "obase=16; $@"|bc
}

pacro() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}
