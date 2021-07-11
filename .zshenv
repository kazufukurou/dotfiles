# force path to have unique values
typeset -U path
path=(~/.local/bin ~/android-sdk/tools ~/android-sdk/platform-tools $path)

export ANDROID_HOME="$HOME/android-sdk"
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export BROWSER=qutebrowser
export EDITOR=kak
export FFF_COL2=0
export FFF_COL5=7
export FFF_HIDDEN=1
export FFF_OPENER="$HOME/.local/bin/opener"
export FZF_DEFAULT_OPTS="--color 16,bg+:-1,fg:8,fg+:-1,info:3,border:8"
export FZF_DEFAULT_COMMAND="fd --hidden --type f --exclude .git"
export GDK_DPI_SCALE=1.5
export HISTFILESIZE=100000
export HISTSIZE=100000
export KEYTIMEOUT=1
export JavaScriptCoreUseJIT=0
export LANG=en_US.utf8
export LC_ALL=en_US.UTF-8
export LESSCHARSET=utf-8
export VISUAL=$EDITOR
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export TERM_RESULT="$XDG_CACHE_HOME/term_result"
export WAYFIRE_CONFIG_FILE="$XDG_CONFIG_HOME/wayfire/wayfire.conf"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export GTK_CSD=0
export LD_PRELOAD="/usr/lib/libgtk3-nocsd.so.0"
[ -e /usr/lib/jvm/oracle-jdk ] && export JAVA_HOME=/usr/lib/jvm/oracle-jdk
[ -e /usr/lib/jvm/openjdk ] && export JAVA_HOME=/usr/lib/jvm/openjdk
[ -e /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home)
[ -n "$SSH_TTY" ] && export TERM=xterm-256color
