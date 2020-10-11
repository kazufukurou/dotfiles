typeset -U path
path=(~/.local/bin ~/android-sdk/tools ~/android-sdk/platform-tools $path)

export ANDROID_HOME="$HOME/android-sdk"
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export BROWSER=vimb
export EDITOR=vim
export FZF_DEFAULT_OPTS='--color 16'
export FZF_DEFAULT_COMMAND='ag -g ""'
export GDK_DPI_SCALE=1.5
export HISTFILESIZE=100000
export HISTSIZE=100000
export KEYTIMEOUT=1
export JavaScriptCoreUseJIT=0
export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
export LANG=en_US.utf8
export LESSCHARSET=utf-8
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export VISUAL=$EDITOR
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="$HOME/.runtime"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
