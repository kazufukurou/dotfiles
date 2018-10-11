. ~/.zshenv

export XDG_RUNTIME_DIR=/tmp/.runtime-${USER}
mkdir -p "${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"

if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    #exec startx
    export XKB_DEFAULT_LAYOUT=us
    exec ck-launch-session dbus-launch --sh-syntax --exit-with-session sway
fi
