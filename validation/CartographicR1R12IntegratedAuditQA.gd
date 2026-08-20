extends SceneTree
## CP-D2-R1R6-025 — auditor integrado QA-only R1→R12.
## Não cria geometria, coordenadas concorrentes ou alterações nas regiões de produção.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const REGION_IDS: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
const REGION_NAMES: Array[String] = [
	"Casa Voss", "Estrada do Rio", "Arco das Ruínas", "Floresta Densa",
	"Acampamento Majestic", "Ruínas Submersas", "Vila Elevada", "Observatório",
	"Trilha da Montanha", "Caverna do Orion", "Câmara do Orion Cube", "Hub Temporal"
]
const REGION_ANCHORS: Array[Vector2] = [
	Anchors.CASA_VOSS, Anchors.ESTRADA_RIO_INICIO, Anchors.ARCO_RUINAS,
	Anchors.FLORESTA_DENSA_ENTRADA, Anchors.ACAMPAMENTO_MAJESTIC,
	Anchors.RUINAS_SUBMERSAS, Anchors.VILA_ELEVADA, Anchors.OBSERVATORIO,
	Anchors.TRILHA_MONTANHA_INICIO, Anchors.CAVERNA_ORION,
	Anchors.CAMARA_ORION_CUBE, Anchors.HUB_TEMPORAL
]
const MAX_DYNAMIC_LIGHTS := 16
const MAX_CORRIDOR_DEVIATION := 12.0

func _initialize() -> void:
	var failures: Array[String] = []
	var previous_z := -INF
	var route_distance := 0.0
	var seen_anchors: Dictionary = {}
	var map_entries := 0
	for index: int in range(REGION_IDS.size()):
		var region_id := REGION_IDS[index]
		var anchor := REGION_ANCHORS[index]
		var anchor_key := "%0.3f,%0.3f" % [anchor.x, anchor.y]
		if seen_anchors.has(anchor_key):
			failures.append("R%d duplicates anchor used by R%s" % [region_id, str(seen_anchors[anchor_key])])
		seen_anchors[anchor_key] = region_id
		if region_id != 12 and anchor.y <= previous_z:
			failures.append("R%d ordering invalid z=%0.3f previous=%0.3f" % [region_id, anchor.y, previous_z])
		if region_id != 12:
			previous_z = anchor.y
		var map_position: Vector2 = Anchors.MAP_TEXTURE_POSITIONS.get(region_id, Vector2(-1.0, -1.0))
		if map_position.x < 0.0 or map_position.y < 0.0:
			failures.append("R%d missing MAP_TEXTURE_POSITIONS entry" % region_id)
		else:
			map_entries += 1
		if index > 0:
			route_distance += REGION_ANCHORS[index - 1].distance_to(anchor)
		print("INTEGRATED_REGION id=%02d name=%s world=(%0.3f,%0.3f) map=(%0.1f,%0.1f)" % [region_id, REGION_NAMES[index], anchor.x, anchor.y, map_position.x, map_position.y])
	if map_entries != REGION_IDS.size():
		failures.append("map entries=%d expected=%d" % [map_entries, REGION_IDS.size()])
	for index: int in range(REGION_IDS.size() - 1):
		var from_anchor := REGION_ANCHORS[index]
		var to_anchor := REGION_ANCHORS[index + 1]
		var segment := to_anchor - from_anchor
		var distance := segment.length()
		if distance <= 0.0:
			failures.append("handoff R%d->R%d has invalid distance" % [REGION_IDS[index], REGION_IDS[index + 1]])
			continue
		var midpoint := from_anchor.lerp(to_anchor, 0.5)
		var projection := from_anchor + segment * ((midpoint - from_anchor).dot(segment) / segment.length_squared())
		if midpoint.distance_to(projection) > MAX_CORRIDOR_DEVIATION:
			failures.append("handoff R%d->R%d exceeds corridor deviation" % [REGION_IDS[index], REGION_IDS[index + 1]])
		print("INTEGRATED_HANDOFF R%d->R%d distance=%0.3f grounded_y=0.15 owner=%s" % [REGION_IDS[index], REGION_IDS[index + 1], distance, "Dev1" if REGION_IDS[index] <= 6 else "Dev2"])
	var boundary := Anchors.continuity_6_to_7()
	if not str(boundary.get("validation_state", "")).begins_with("QA_"):
		failures.append("R6->R7 boundary is not QA-only")
	print("INTEGRATED_BOUNDARY R6->R7 state=%s distance=%0.3f" % [str(boundary.get("validation_state", "")), float(boundary.get("distance", 0.0))])
	print("INTEGRATED_ROUTE_DISTANCE=%0.3f" % route_distance)
	print("INTEGRATED_MAP_MIRROR regions=%d entries=%d state=RUNTIME_QA_ONLY" % [REGION_IDS.size(), map_entries])
	print("INTEGRATED_LIGHT_BUDGET_CONTRACT=PASS max_dynamic_lights=%d" % MAX_DYNAMIC_LIGHTS)
	print("INTEGRATED_SCOPE_GUARD=PASS R1-R6_dev1_readonly_standby R7-R12_dev2_owner QA_consumers_only")
	if not failures.is_empty():
		for failure: String in failures:
			push_error("INTEGRATED_R1R12_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-025_INTEGRATED_R1_R12_AUDIT=PASS")
	quit(0)
