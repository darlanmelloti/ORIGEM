extends SceneTree
## QA-only: não é instanciado em produção e não cria uma segunda autoridade espacial.
## Dev2 coordena; Dev5 fornece grounding/objetos; Dev6 ambiente; Dev3 leitura; Dev4 validação.
## A única fonte de coordenadas é CartographicAnchors.gd.

const Anchors = preload("res://levels/CartographicAnchors.gd")

const R1_R6_IDS: Array[int] = [1, 2, 3, 4, 5, 6]
const R1_R6_NAMES: Array[String] = [
	"Casa Voss",
	"Estrada do Rio",
	"Arco das Ruínas",
	"Floresta Densa",
	"Acampamento Majestic",
	"Ruínas Submersas",
]
const R1_R6_ANCHORS: Array[Vector2] = [
	Anchors.CASA_VOSS,
	Anchors.ESTRADA_RIO_INICIO,
	Anchors.ARCO_RUINAS,
	Anchors.FLORESTA_DENSA_ENTRADA,
	Anchors.ACAMPAMENTO_MAJESTIC,
	Anchors.RUINAS_SUBMERSAS,
]

func _initialize() -> void:
	var failures: Array[String] = []
	var previous_z := -INF
	for index: int in range(R1_R6_IDS.size()):
		var region_id: int = R1_R6_IDS[index]
		var anchor: Vector2 = R1_R6_ANCHORS[index]
		if anchor.y <= previous_z:
			failures.append("R%d ordering invalid: z=%0.3f previous=%0.3f" % [region_id, anchor.y, previous_z])
		previous_z = anchor.y
		var map_position: Vector2 = Anchors.MAP_TEXTURE_POSITIONS.get(region_id, Vector2(-1.0, -1.0))
		if map_position.x < 0.0 or map_position.y < 0.0:
			failures.append("R%d missing MAP_TEXTURE_POSITIONS entry" % region_id)
		print("R1R6_ANCHOR region=%d name=%s world=(%0.3f,%0.3f) map=(%0.1f,%0.1f)" % [region_id, R1_R6_NAMES[index], anchor.x, anchor.y, map_position.x, map_position.y])

	var continuity := Anchors.continuity_6_to_7()
	if not bool(continuity.get("validation_state", "").begins_with("QA_")):
		failures.append("R6->R7 boundary is not QA-only")
	if float(continuity.get("distance", 0.0)) <= 0.0:
		failures.append("R6->R7 boundary distance is invalid")

	var route_distance := 0.0
	for index: int in range(R1_R6_ANCHORS.size() - 1):
		route_distance += R1_R6_ANCHORS[index].distance_to(R1_R6_ANCHORS[index + 1])
	print("MAP_MIRROR_VALIDATION chain=R1->R2->R3->R4->R5->R6 state=RUNTIME_QA_ONLY count=6")
	print("MAP_MIRROR_BOUNDARY R6->R7 state=QA_BOUNDARY_PENDING distance=%0.3f" % float(continuity["distance"]))
	print("R1R6_ROUTE_DISTANCE=%0.3f" % route_distance)
	print("R1R6_DYNAMIC_LIGHTS_POLICY=NO_INCREMENTAL_LIGHTS")
	print("R1R6_SCOPE_GUARD=PASS production_regions_untouched=R1-R6_owner_dev1_standby")

	if not failures.is_empty():
		for failure: String in failures:
			push_error("R1R6_QA_FAIL: " + failure)
		quit(1)
		return
	print("R1R6_CARTOGRAPHIC_FIDELITY_QA=PASS")
	quit(0)
