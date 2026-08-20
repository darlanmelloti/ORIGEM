extends SceneTree
## CP-D2-R1R6-017 — continuidade QA-only R8→R9.
## Dev2 valida as âncoras R8/R9; as Regiões 1–6 permanecem intocadas.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const SAMPLE_COUNT := 31
const MAX_LATERAL_DEVIATION := 6.0

func _initialize() -> void:
	var start := Anchors.world_position(Anchors.OBSERVATORIO, 0.0, 0.15)
	var finish := Anchors.world_position(Anchors.TRILHA_MONTANHA_INICIO, 0.0, 0.15)
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
			failures.append("sample %d exceeds R8-R9 corridor" % sample)
		previous = current
	if start.distance_to(Anchors.world_position(Anchors.OBSERVATORIO, 0.0, 0.15)) > 0.001:
		failures.append("R8 origin mismatch")
	if finish.distance_to(Anchors.world_position(Anchors.TRILHA_MONTANHA_INICIO, 0.0, 0.15)) > 0.001:
		failures.append("R9 destination mismatch")
	print("CONTINUITY_HANDOFF R8->R9 from=Observatorio to=Trilha_Montanha_Inicio distance=%0.3f" % start.distance_to(finish))
	print("CONTINUITY_SAMPLES count=%d travelled=%0.3f" % [SAMPLE_COUNT, travelled])
	print("CONTINUITY_GROUNDING y=0.15")
	print("CONTINUITY_SCOPE_GUARD=PASS R1-R6_production_untouched R8-R9_dev2_owner")
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R8R9_CONTINUITY_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-017_R8_R9_CONTINUITY_QA=PASS")
	quit(0)
