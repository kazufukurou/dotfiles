. ~/.bashrc

mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    echo -n "Starting WM.." && sleep 1 && exec hikari
fi
