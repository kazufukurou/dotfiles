typeset -U path
path=(~/.local/bin ~/android-sdk/tools ~/android-sdk/platform-tools $path)

export LANG=en_US.utf8
export EDITOR=vim
export VISUAL=$EDITOR

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="$HOME/.runtime"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

export ANDROID_HOME="$HOME/android-sdk"
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
[ -e /usr/lib/jvm/oracle-jdk ] && export JAVA_HOME=/usr/lib/jvm/oracle-jdk || export JAVA_HOME=/usr/lib/jvm/openjdk
export CLASSPATH=/usr/share/java/bsh.jar
export JavaScriptCoreUseJIT=0
export GDK_DPI_SCALE=1.5
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export FZF_DEFAULT_OPTS='--color 16'
export FZF_DEFAULT_COMMAND='ag -g ""'
