from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent
checks = []

def check(name: str, condition: bool, detail: str) -> None:
    checks.append((name, condition, detail))

player = (ROOT / "entities/player/Player.gd").read_text()
terrain = (ROOT / "levels/TerrainPatch.gd").read_text()
voss = (ROOT / "levels/VossHouse.gd").read_text()
menu = (ROOT / "ui/menus/MainMenu.gd").read_text()
main_scene = (ROOT / "scenes/main.tscn").read_text()

check("player_floor_max_angle", "floor_max_angle = deg_to_rad(70.0)" in player, "ângulo máximo de solo")
check("player_floor_snap", "floor_snap_length = 0.35" in player, "snap do CharacterBody3D")
check("player_indent", not re.search(r"\n\t{2,}var grounded: bool", player), "indentação da variável grounded")
check("terrain_smooth_shoulder", "shoulder_smooth" in terrain and "valley_rim_smooth" in terrain, "bermas com transição suave")
check("voss_explicit_preload", 'preload("res://levels/CartographicAnchors.gd")' in voss, "resolução explícita de CartographicAnchors")
check("menu_packed_scene", "change_scene_to_packed" in menu and "CACHE_MODE_IGNORE" in menu, "carga robusta de PackedScene")
check("player_uid_matches_sidecar", "uid=\"uid://chgidfkiu6wxn\" path=\"res://entities/player/Player.gd\"" in main_scene, "UID do Player na cena principal")

# Verificação simples de blocos: cada função relevante deve ter corpo indentado.
for path, funcs in [(ROOT / "entities/player/Player.gd", ["func _ready", "func _handle_player"]), (ROOT / "levels/VossHouse.gd", ["func _ready"]), (ROOT / "ui/menus/MainMenu.gd", ["func _on_new_game_pressed"]), (ROOT / "levels/TerrainPatch.gd", ["func height_at", "func _build_terrain"])]:
    text = path.read_text().splitlines()
    for func in funcs:
        indexes = [i for i, line in enumerate(text) if line.startswith(func)]
        check(f"function_present:{path.name}:{func}", bool(indexes), f"função {func}")
        if indexes:
            i = indexes[0]
            following = text[i + 1:i + 4]
            check(f"function_body:{path.name}:{func}", any(line.startswith("\t") for line in following), "corpo indentado")

failed = [item for item in checks if not item[1]]
for name, ok, detail in checks:
    print(f"{name}={'PASS' if ok else 'FAIL'} :: {detail}")
print(f"VALIDATION_TOTAL={len(checks)}")
print(f"VALIDATION_FAILED={len(failed)}")
sys.exit(1 if failed else 0)
