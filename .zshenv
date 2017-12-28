typeset -U path
path=(~/.local/bin ~/bin ~/android-sdk/tools ~/android-sdk/platform-tools $path)

export LANG=en_US.utf8
export ANDROID_HOME=${HOME}/android-sdk
[ -e /usr/lib/jvm/oracle-jdk ] && export JAVA_HOME=/usr/lib/jvm/oracle-jdk || export JAVA_HOME=/usr/lib/jvm/openjdk
export EDITOR=vim
export VISUAL=$EDITOR
export CLASSPATH=/usr/share/java/bsh.jar
export FZF_DEFAULT_OPTS='--color 16'
export FZF_DEFAULT_COMMAND='ag -g ""'
export JavaScriptCoreUseJIT=0
export GDK_DPI_SCALE=1.5
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
