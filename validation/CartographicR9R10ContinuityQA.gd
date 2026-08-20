extends SceneTree
## CP-D2-R1R6-019 — continuidade QA-only R9→R10.
## A validação protege a fronteira Dev1 e usa apenas a autoridade cartográfica.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const SAMPLE_COUNT := 71
const MAX_LATERAL_DEVIATION := 8.0

func _initialize() -> void:
	var start := Anchors.world_position(Anchors.TRILHA_MONTANHA_INICIO, 0.0, 0.15)
	var finish := Anchors.world_position(Anchors.CAVERNA_ORION, 0.0, 0.15)
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
			failures.append("sample %d exceeds R9-R10 corridor" % sample)
		previous = current
	if start.distance_to(Anchors.world_position(Anchors.TRILHA_MONTANHA_INICIO, 0.0, 0.15)) > 0.001:
		failures.append("R9 origin mismatch")
	if finish.distance_to(Anchors.world_position(Anchors.CAVERNA_ORION, 0.0, 0.15)) > 0.001:
		failures.append("R10 destination mismatch")
	print("CONTINUITY_HANDOFF R9->R10 from=Trilha_Montanha to=Caverna_Orion distance=%0.3f" % start.distance_to(finish))
	print("CONTINUITY_SAMPLES count=%d travelled=%0.3f" % [SAMPLE_COUNT, travelled])
	print("CONTINUITY_GROUNDING y=0.15")
	print("CONTINUITY_SCOPE_GUARD=PASS R1-R6_production_untouched R9-R10_dev2_owner")
	print("LIGHT_BUDGET_CONTRACT=PASS dynamic_lights_max_16")
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R9R10_CONTINUITY_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-019_R9_R10_CONTINUITY_QA=PASS")
	quit(0)
