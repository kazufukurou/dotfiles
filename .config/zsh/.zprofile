. ~/.zshenv

export XDG_RUNTIME_DIR=/tmp/.runtime-${USER}
mkdir -p "${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"

[ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ] && exec startx
