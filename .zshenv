typeset -U path
path=(~/bin ~/android-sdk/tools ~/android-sdk/platform-tools $path)

export LANG=en_US.utf8
export ANDROID_HOME=${HOME}/android-sdk
export JAVA_HOME=$(dirname $(dirname $(readlink -e /usr/bin/javac)))
export EDITOR=vim
export VISUAL=$EDITOR
export CLASSPATH=/usr/share/java/bsh.jar
export FZF_DEFAULT_OPTS='--color 16'
export FZF_DEFAULT_COMMAND='pt --nocolor -l -g=""'
export JavaScriptCoreUseJIT=0
export GDK_DPI_SCALE=1.5
