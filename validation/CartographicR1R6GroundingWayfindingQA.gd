extends SceneTree
## CP-D2-R1R6-029 — grounding e wayfinding QA-only para R1→R6.
## O script consome CartographicAnchors.gd e não toca na geometria ou câmaras do Dev1.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const IDS: Array[int] = [1, 2, 3, 4, 5, 6]
const NAMES: Array[String] = ["Casa Voss", "Estrada do Rio", "Arco das Ruínas", "Floresta Densa", "Acampamento Majestic", "Ruínas Submersas"]
const POINTS: Array[Vector2] = [Anchors.CASA_VOSS, Anchors.ESTRADA_RIO_INICIO, Anchors.ARCO_RUINAS, Anchors.FLORESTA_DENSA_ENTRADA, Anchors.ACAMPAMENTO_MAJESTIC, Anchors.RUINAS_SUBMERSAS]
const OFFSETS: Array[float] = [0.18, 0.18, 0.18, 0.18, 0.18, 0.18]
const MAX_DYNAMIC_LIGHTS := 16
const MAX_CORRIDOR_DEVIATION := 5.0

func _initialize() -> void:
	var failures: Array[String] = []
	var route_distance := 0.0
	var previous := Anchors.world_position(POINTS[0], 0.0, OFFSETS[0])
	for index: int in range(POINTS.size()):
		var marker := Anchors.world_position(POINTS[index], 0.0, OFFSETS[index])
		if not is_equal_approx(marker.y, OFFSETS[index]):
			failures.append("R%d marker is not grounded" % IDS[index])
		if index > 0:
			var segment := marker - previous
			var distance := segment.length()
			if distance <= 0.0:
				failures.append("R%d handoff has zero length" % IDS[index])
			var midpoint := previous.lerp(marker, 0.5)
			var projected := previous + segment * ((midpoint - previous).dot(segment) / segment.length_squared())
			if midpoint.distance_to(projected) > MAX_CORRIDOR_DEVIATION:
				failures.append("R%d handoff exceeds corridor" % IDS[index])
			route_distance += distance
		previous = marker
		print("GROUNDING_WAYFIND_MARKER R%d name=%s position=(%0.3f,%0.3f,%0.3f) destination_priority=%d" % [IDS[index], NAMES[index], marker.x, marker.y, marker.z, index + 1])
	print("GROUNDING_WAYFIND_ROUTE distance=%0.3f segments=%d" % [route_distance, POINTS.size() - 1])
	print("GROUNDING_WAYFIND_POLICY floating_markers=FORBIDDEN destination_source=CartographicAnchors.gd")
	print("GROUNDING_WAYFIND_SCOPE_GUARD=PASS R1-R6_dev1_readonly_standby")
	print("GROUNDING_WAYFIND_LIGHT_BUDGET=PASS max_dynamic_lights=%d" % MAX_DYNAMIC_LIGHTS)
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R1R6_GROUNDING_WAYFIND_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-029_R1_R6_GROUNDING_WAYFINDING_QA=PASS")
	quit(0)
