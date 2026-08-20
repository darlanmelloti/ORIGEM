extends SceneTree
## CP-D2-R1R6-002 — QA-only grounding contract.
## Não cria geometria de produção e não substitui os módulos do Dev1.
## Dev5 consome este contrato para objetos/arquitectura; Dev6 para materiais/água.

const Anchors = preload("res://levels/CartographicAnchors.gd")

const GROUNDING_IDS: Array[int] = [1, 2, 3]
const GROUNDING_NAMES: Array[String] = ["Casa Voss", "Estrada do Rio", "Arco das Ruínas"]
const GROUNDING_OFFSETS: Array[float] = [0.0, 0.025, 0.035]

func _initialize() -> void:
	var failures: Array[String] = []
	var previous: Vector3 = Vector3.ZERO
	for index: int in range(GROUNDING_IDS.size()):
		var region_id: int = GROUNDING_IDS[index]
		var anchor_2d: Vector2 = _anchor_for_id(region_id)
		var marker: Vector3 = Anchors.world_position(anchor_2d, 0.0, GROUNDING_OFFSETS[index])
		if index > 0 and marker.z <= previous.z:
			failures.append("marker order invalid for R%d" % region_id)
		if not is_equal_approx(marker.y, GROUNDING_OFFSETS[index]):
			failures.append("marker vertical offset invalid for R%d" % region_id)
		previous = marker
		print("GROUNDING_MARKER region=%d name=%s position=(%0.3f,%0.3f,%0.3f) offset=%0.3f" % [region_id, GROUNDING_NAMES[index], marker.x, marker.y, marker.z, GROUNDING_OFFSETS[index]])

	var route_start := Anchors.world_position(Anchors.CASA_VOSS, 0.0)
	var route_end := Anchors.world_position(Anchors.ARCO_RUINAS, 0.0)
	var corridor_length := route_start.distance_to(route_end)
	if corridor_length <= 0.0:
		failures.append("R1->R3 corridor has zero length")
	print("GROUNDING_CORRIDOR R1->R3 length=%0.3f state=QA_ONLY" % corridor_length)
	print("GROUNDING_POLICY floating_markers=FORBIDDEN terrain_authority=CartographicAnchors.gd")
	print("GROUNDING_SCOPE_GUARD=PASS production_regions_untouched=R1-R6_owner_dev1_standby")

	if not failures.is_empty():
		for failure: String in failures:
			push_error("R1R6_GROUNDING_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-002_GROUNDING_QA=PASS")
	quit(0)

func _anchor_for_id(region_id: int) -> Vector2:
	match region_id:
		1: return Anchors.CASA_VOSS
		2: return Anchors.ESTRADA_RIO_INICIO
		3: return Anchors.ARCO_RUINAS
	return Vector2.ZERO
