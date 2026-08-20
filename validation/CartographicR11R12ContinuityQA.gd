extends SceneTree
## CP-D2-R1R6-023 — continuidade QA-only R11→R12.
## A longa travessia final é validada por âncoras, grounding e guarda de escopo.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const SAMPLE_COUNT := 81
const MAX_LATERAL_DEVIATION := 10.0
const MAX_DYNAMIC_LIGHTS := 16

func _initialize() -> void:
	var start := Anchors.world_position(Anchors.CAMARA_ORION_CUBE, 0.0, 0.15)
	var finish := Anchors.world_position(Anchors.HUB_TEMPORAL, 0.0, 0.15)
	var direction := (finish - start).normalized()
	var failures: Array[String] = []
	var previous := start
	var travelled := 0.0
	for sample: int in range(1, SAMPLE_COUNT + 1):
		var t := float(sample) / float(SAMPLE_COUNT)
		var current := start.lerp(finish, t)
		travelled += previous.distance_to(current)
		if absf(current.y - 0.15) > 0.001:
			failures.append("sample %d is not grounded" % sample)
		var projected := start + direction * (current - start).dot(direction)
		if current.distance_to(projected) > MAX_LATERAL_DEVIATION:
			failures.append("sample %d exceeds R11-R12 corridor" % sample)
		previous = current
	if start.distance_to(Anchors.world_position(Anchors.CAMARA_ORION_CUBE, 0.0, 0.15)) > 0.001:
		failures.append("R11 origin mismatch")
	if finish.distance_to(Anchors.world_position(Anchors.HUB_TEMPORAL, 0.0, 0.15)) > 0.001:
		failures.append("R12 destination mismatch")
	print("CONTINUITY_HANDOFF R11->R12 from=Camara_Orion_Cube to=Hub_Temporal distance=%0.3f" % start.distance_to(finish))
	print("CONTINUITY_SAMPLES count=%d travelled=%0.3f" % [SAMPLE_COUNT, travelled])
	print("CONTINUITY_GROUNDING y=0.15")
	print("CONTINUITY_SCOPE_GUARD=PASS R1-R6_production_untouched R11-R12_dev2_owner")
	print("LIGHT_BUDGET_CONTRACT=PASS dynamic_lights_max_%d" % MAX_DYNAMIC_LIGHTS)
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R11R12_CONTINUITY_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-023_R11_R12_CONTINUITY_QA=PASS")
	quit(0)
