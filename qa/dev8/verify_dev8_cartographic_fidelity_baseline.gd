extends SceneTree

const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

const MAP_CANVAS_SIZE := Vector2(800.0, 600.0)

func _init() -> void:
	var issues: PackedStringArray = PackedStringArray()
	var cases: Array[Dictionary] = [
		{"id": 1, "name": "Casa Voss", "world": CARTOGRAPHIC_ANCHORS.CASA_VOSS, "expected_destination": 2},
		{"id": 2, "name": "Estrada do Rio", "world": CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO, "expected_destination": 2},
		{"id": 3, "name": "Arco das Ruínas", "world": CARTOGRAPHIC_ANCHORS.ARCO_RUINAS, "expected_destination": 3},
		{"id": 4, "name": "Floresta Densa", "world": CARTOGRAPHIC_ANCHORS.FLORESTA_DENSA_ENTRADA, "expected_destination": 4},
		{"id": 5, "name": "Acampamento Majestic", "world": CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC, "expected_destination": 6},
		{"id": 6, "name": "Ruínas Submersas", "world": CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS, "expected_destination": 7}
	]
	for entry: Dictionary in cases:
		_validate_anchor(entry, issues)
	if issues.is_empty():
		print("[ORIGEM_DEV8_CARTOGRAPHIC_BASELINE_OK] anchors=6 production_mutations=0 canvas=800x600")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_DEV8_CARTOGRAPHIC_BASELINE_ERROR] %s" % issue)
	quit(1)

func _validate_anchor(entry: Dictionary, issues: PackedStringArray) -> void:
	var anchor_id: int = int(entry["id"])
	var anchor_name: String = str(entry["name"])
	var world: Vector2 = entry["world"] as Vector2
	var marker_position: Vector2 = CARTOGRAPHIC_ANCHORS.map_texture_position(world)
	var expected_marker: Vector2 = CARTOGRAPHIC_ANCHORS.MAP_TEXTURE_POSITIONS[anchor_id] as Vector2
	if marker_position.distance_to(expected_marker) > 0.01:
		issues.append("%s não conserva posição artística exacta no mapa" % anchor_name)
	if marker_position.x < 0.0 or marker_position.x > MAP_CANVAS_SIZE.x or marker_position.y < 0.0 or marker_position.y > MAP_CANVAS_SIZE.y:
		issues.append("%s gera marcador fora do canvas" % anchor_name)
	var route: Dictionary = CARTOGRAPHIC_ANCHORS.next_dev1_destination(world)
	if int(route.get("anchor_id", -1)) != int(entry["expected_destination"]):
		issues.append("%s devolve destino cartográfico inesperado" % anchor_name)
	if str(route.get("label", "")).is_empty():
		issues.append("%s devolve destino sem legenda" % anchor_name)
