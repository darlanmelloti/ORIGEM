#!/usr/bin/env bash
# QA-POST-PROLOGUE-INPUT-060 — gameplay real por 60 s após o prólogo.
# Usa eventos X11 reais (xdotool); não utiliza Input.action_press nem injeta ações Godot.
# Uso: GODOT_BIN=/caminho/Godot_v4.x QA_OUTPUT_DIR=/caminho/evidencias ./tools/qa/verify_post_prologue_input_gameplay.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GODOT_BIN="${GODOT_BIN:-godot}"
OUTPUT_DIR="${QA_OUTPUT_DIR:-$ROOT/qa_evidence_post_prologue_input_060}"
PROBE_ID="QA-POST-PROLOGUE-INPUT-060"
mkdir -p "$OUTPUT_DIR"

inside_xvfb() {
  local log="$OUTPUT_DIR/post_prologue_input_060.log"
  local pid=""
  cleanup() {
    xdotool keyup w 2>/dev/null || true
    xdotool keyup a 2>/dev/null || true
    xdotool keyup s 2>/dev/null || true
    xdotool keyup d 2>/dev/null || true
    xdotool keyup e 2>/dev/null || true
    if [[ -n "${pid:-}" ]]; then
      kill "$pid" 2>/dev/null || true
      wait "$pid" 2>/dev/null || true
    fi
  }
  trap cleanup EXIT

  env \
    ORIGEM_QA_AUTOSTART_NEW_GAME=1 \
    ORIGEM_QA_POST_PROLOGUE_INPUT=1 \
    ORIGEM_QA_SKIP_OPENING=1 \
    GODOT_SILENCE_ROOT_WARNING=1 \
    "$GODOT_BIN" --audio-driver Dummy --rendering-driver opengl3 --path "$ROOT" >"$log" 2>&1 &
  pid=$!

  # Foco na janela. O harness chama o mesmo handoff pós-prólogo de VossHouse no frame seguinte
  # para não converter o custo de renderização do prólogo em tempo de teste; a medição só começa
  # depois de a câmara e a posição pós-prólogo de Elias estarem ativas.
  sleep 5
  local wid
  wid=$(xdotool search --name "ORIGEM" 2>/dev/null | tail -n 1 || true)
  if [[ -z "$wid" ]]; then
    echo "[$PROBE_ID-FAIL] janela ORIGEM não encontrada" >>"$log"
    exit 2
  fi
  xdotool windowactivate "$wid" 2>/dev/null || true
  xdotool mousemove --window "$wid" 640 360 click 1 2>/dev/null || true
  sleep 1

  # A prova só inicia depois de VossHouse executar o handoff canónico e devolver câmara e controlo a Elias.
  local deadline=$((SECONDS + 25))
  until grep -q "\[$PROBE_ID-START\]" "$log"; do
    if (( SECONDS >= deadline )); then
      echo "[$PROBE_ID-FAIL] handoff pós-prólogo não ocorreu dentro de 25 s" >>"$log"
      exit 3
    fi
    sleep 1
  done
  ffmpeg -y -loglevel error -f x11grab -video_size 1600x900 -i "$DISPLAY" -frames:v 1 "$OUTPUT_DIR/00_start_hud.png"

  # Roteiro assimétrico e contínuo: avanço pela estrada, deslocamentos laterais e novo avanço.
  # Cada evento abaixo é enviado ao SO/janela, tal como uma sessão de teclado normal.
  xdotool keydown w; sleep 18; xdotool keyup w
  xdotool keydown d; sleep 8; xdotool keyup d
  xdotool keydown w; sleep 14; xdotool keyup w
  ffmpeg -y -loglevel error -f x11grab -video_size 1600x900 -i "$DISPLAY" -frames:v 1 "$OUTPUT_DIR/40_mid_hud.png"
  xdotool keydown a; sleep 8; xdotool keyup a
  xdotool keydown s; sleep 4; xdotool keyup s
  xdotool keydown w; sleep 8; xdotool keyup w

  # O runner GDScript encerra 2 s após a marca de 60 s. Espera um único limite amplo.
  deadline=$((SECONDS + 15))
  until grep -q "\[$PROBE_ID-RESULT\]" "$log"; do
    if (( SECONDS >= deadline )); then
      echo "[$PROBE_ID-FAIL] resultado ausente após os 60 s de gameplay" >>"$log"
      exit 4
    fi
    sleep 1
  done
  ffmpeg -y -loglevel error -f x11grab -video_size 1600x900 -i "$DISPLAY" -frames:v 1 "$OUTPUT_DIR/60_result_hud.png"
  wait "$pid" || true
  pid=""

  if grep -Eqi 'Parse Error|SCRIPT ERROR|Invalid access|Failed loading resource|Cannot load resource|Segmentation fault' "$log"; then
    cat "$log"
    exit 5
  fi
  if ! grep -q "\[$PROBE_ID-RESULT\].*\"passed\":true" "$log"; then
    cat "$log"
    exit 6
  fi
  printf '%s aprovado\nEvidências: %s\n' "$PROBE_ID" "$OUTPUT_DIR"
}

if [[ "${1:-}" == "--inside-xvfb" ]]; then
  inside_xvfb
  exit 0
fi

command -v "$GODOT_BIN" >/dev/null 2>&1 || test -x "$GODOT_BIN"
command -v xvfb-run >/dev/null
command -v xdotool >/dev/null
command -v ffmpeg >/dev/null
rm -f "$OUTPUT_DIR/post_prologue_input_060.log" "$OUTPUT_DIR"/*_hud.png
xvfb-run -a -s '-screen 0 1600x900x24' env GODOT_BIN="$GODOT_BIN" QA_OUTPUT_DIR="$OUTPUT_DIR" "$0" --inside-xvfb
