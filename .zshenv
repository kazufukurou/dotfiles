typeset -U path
path=(~/bin ~/android-sdk/tools ~/android-sdk/platform-tools $path)

export LANG=en_US.utf8
export ANDROID_HOME=${HOME}/android-sdk
export JAVA_HOME=/usr/lib/java
export EDITOR=vim
export VISUAL=$EDITOR
export CLASSPATH=/usr/share/java/bsh.jar
export FZF_DEFAULT_OPTS='--color 16'
export FZF_DEFAULT_COMMAND='pt --nocolor -l -g=""'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export JavaScriptCoreUseJIT=0
