. ~/.bashrc

mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    aplay nothing 2> /dev/null # activate alsa softvol
    amixer set Master 50%
    echo -n "Starting WM.." && sleep 1 && exec sway
fi
