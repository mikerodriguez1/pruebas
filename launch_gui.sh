#!/usr/bin/env bash
set -e
APPDIR="$(cd "$(dirname "$0")" && pwd)"
cd "$APPDIR"
PORT="${TELESTREAM_PORT:-8787}"
URL="http://127.0.0.1:${PORT}"

# Si ya está abierto, solamente mostrarlo.
if curl -fsS "$URL/api/status" >/dev/null 2>&1; then
  xdg-open "$URL" >/dev/null 2>&1 &
  exit 0
fi

if [ ! -x "$APPDIR/.venv/bin/python" ]; then
  zenity --error --title="TeleStream" --text="TeleStream todavía no está instalado. Ejecuta una sola vez: Instalar_TeleStream.sh" 2>/dev/null || true
  exit 1
fi

nohup "$APPDIR/.venv/bin/python" "$APPDIR/app.py" >"$APPDIR/telestream.log" 2>&1 &
echo $! > "$APPDIR/telestream.pid"

for i in $(seq 1 50); do
  if curl -fsS "$URL/api/status" >/dev/null 2>&1; then
    xdg-open "$URL" >/dev/null 2>&1 &
    exit 0
  fi
  sleep 0.2
done

zenity --error --title="TeleStream" --text="No se pudo iniciar TeleStream. Revisa el archivo telestream.log." 2>/dev/null || true
exit 1
