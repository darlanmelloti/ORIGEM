#!/usr/bin/env bash
set -u
ROOT="/home/ubuntu/origem-godot/ORIGEM_Base/ORIGEM_Integracao_Controlada_recovered"
GODOT="/home/ubuntu/godot-4.7.1/Godot_v4.7.1-stable_linux.x86_64"
OUT="/home/ubuntu/origem-godot/validation/take7-refine-cycle"
mkdir -p "$OUT"
rm -f "$OUT"/take7-refine-gameplay-30s.mp4 "$OUT"/take7-refine-print-1600x900.jpg "$OUT"/f5-take7-refine.log "$OUT"/process-state.txt
export ROOT GODOT OUT
xvfb-run -a -s '-screen 0 1600x900x24' bash -lc '
  set -u
  ffmpeg -y -f x11grab -video_size 1600x900 -framerate 30 -i "$DISPLAY+0,0" -t 30 -c:v libx264 -preset ultrafast -pix_fmt yuv420p "/home/ubuntu/origem-godot/validation/take7-refine-cycle/take7-refine-gameplay-30s.mp4" >/home/ubuntu/origem-godot/validation/take7-refine-cycle/ffmpeg.log 2>&1 &
  CAP=$!
  sleep 2
  ORIGEM_VALIDATION_TAKE=7 timeout 38s "$GODOT" --path "$ROOT" --rendering-method gl_compatibility --rendering-driver opengl3 "$ROOT/scenes/main.tscn" >/home/ubuntu/origem-godot/validation/take7-refine-cycle/f5-take7-refine.log 2>&1 || true
  wait "$CAP" || true
' 
ffmpeg -y -ss 22 -i "$OUT/take7-refine-gameplay-30s.mp4" -frames:v 1 -q:v 2 "$OUT/take7-refine-print-1600x900.jpg" >/dev/null 2>&1 || true
printf 'gameplay=%s\nprint=%s\n' "$OUT/take7-refine-gameplay-30s.mp4" "$OUT/take7-refine-print-1600x900.jpg" > "$OUT/process-state.txt"
