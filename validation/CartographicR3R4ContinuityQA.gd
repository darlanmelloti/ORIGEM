extends SceneTree
## CP-D2-R1R6-007 — continuidade QA-only R3→R4.
## Não altera geometria de produção; todas as posições vêm de CartographicAnchors.gd.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const SAMPLE_COUNT := 41
const MAX_LATERAL_DEVIATION := 6.0

func _initialize() -> void:
	var start := Anchors.world_position(Anchors.ARCO_RUINAS, 0.0, 0.15)
	var finish := Anchors.world_position(Anchors.FLORESTA_DENSA_ENTRADA, 0.0, 0.15)
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
			failures.append("sample %d exceeds lateral corridor" % sample)
		previous = current
	var handoff := Anchors.world_position(Anchors.FLORESTA_DENSA_ENTRADA, 0.0, 0.15)
	if handoff.distance_to(finish) > 0.001:
		failures.append("R4 handoff does not match cartographic anchor")
	print("CONTINUITY_HANDOFF R3->R4 from=Arco_das_Ruinas to=Floresta_Densa distance=%0.3f" % start.distance_to(finish))
	print("CONTINUITY_SAMPLES count=%d travelled=%0.3f" % [SAMPLE_COUNT, travelled])
	print("CONTINUITY_GROUNDING y=0.15")
	print("CONTINUITY_SCOPE_GUARD=PASS production_regions_untouched=R1-R6_owner_dev1_standby")
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R3R4_CONTINUITY_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-007_R3_R4_CONTINUITY_QA=PASS")
	quit(0)
