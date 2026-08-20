extends SceneTree
## CP-D2-R1R6-015 — continuidade QA-only R7→R8.
## Dev2 valida R7/R8; Regiões 1–6 permanecem fora de qualquer edição.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const SAMPLE_COUNT := 41
const MAX_LATERAL_DEVIATION := 6.0

func _initialize() -> void:
	var start := Anchors.world_position(Anchors.VILA_ELEVADA, 0.0, 0.15)
	var finish := Anchors.world_position(Anchors.OBSERVATORIO, 0.0, 0.15)
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
			failures.append("sample %d exceeds R7-R8 corridor" % sample)
		previous = current
	if start.distance_to(Anchors.world_position(Anchors.VILA_ELEVADA, 0.0, 0.15)) > 0.001:
		failures.append("R7 origin mismatch")
	if finish.distance_to(Anchors.world_position(Anchors.OBSERVATORIO, 0.0, 0.15)) > 0.001:
		failures.append("R8 destination mismatch")
	print("CONTINUITY_HANDOFF R7->R8 from=Vila_Elevada to=Observatorio distance=%0.3f" % start.distance_to(finish))
	print("CONTINUITY_SAMPLES count=%d travelled=%0.3f" % [SAMPLE_COUNT, travelled])
	print("CONTINUITY_GROUNDING y=0.15")
	print("CONTINUITY_SCOPE_GUARD=PASS R1-R6_production_untouched R7-R8_dev2_owner")
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R7R8_CONTINUITY_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-015_R7_R8_CONTINUITY_QA=PASS")
	quit(0)
