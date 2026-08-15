#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cat /home/ubuntu/origem_v2_root.txt)
GODOT=/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64
OUT=/home/ubuntu/origem_v2_phase166_voss_threshold.png
LOG=/tmp/origem_phase166_voss_threshold.log

rm -f "$OUT" "$LOG"
pkill -f 'Godot_v4.7.1-stable_linux|ffmpeg|Xvfb' || true

xvfb-run -a -s "-screen 0 1280x720x24" bash -c '
  set -euo pipefail
  "$1" --path "$2" --scene res://scenes/main.tscn --rendering-method gl_compatibility --disable-vsync --resolution 1280x720 > "$4" 2>&1 &
  PID=$!
  cleanup() {
    xdotool keyup e 2>/dev/null || true
    kill "$PID" 2>/dev/null || true
  }
  trap cleanup EXIT
  # O carregamento procedimental em llvmpipe pode exceder a janela curta; aguardar o prólogo real antes de enviar E.
  sleep 46
  GAME_WINDOW=$(xdotool search --name "ORIGEM" | tail -n 1)
  test -n "$GAME_WINDOW"
  xdotool windowfocus --sync "$GAME_WINDOW"
  xdotool mousemove --window "$GAME_WINDOW" 640 360
  xdotool click 1
  sleep 1
  # Mantém E durante toda a janela de ativação tardia: o _process da Casa Voss consulta o estado físico da tecla em cada frame.
  xdotool keydown e
  sleep 35
  xdotool keyup e
  sleep 5
  # Depois do salto validado, E abre a porta no limiar físico.
  xdotool key e
  sleep 2
  ffmpeg -y -loglevel error -f x11grab -video_size 1280x720 -i "$DISPLAY.0" -frames:v 1 "$3"
  sleep 8
' bash "$GODOT" "$ROOT" "$OUT" "$LOG"

test -s "$OUT"
printf 'LIMIAR_VOSS=%s\nLOG=%s\n' "$OUT" "$LOG"
