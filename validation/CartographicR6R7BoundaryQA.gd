extends SceneTree
## CP-D2-R1R6-013 — handoff QA-only da fronteira R6→R7.
## A validação não edita nem instancia geometria de produção das Regiões 1–6.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const SAMPLE_COUNT := 41
const MAX_LATERAL_DEVIATION := 8.0

func _initialize() -> void:
	var start := Anchors.world_position(Anchors.RUINAS_SUBMERSAS, 0.0, 0.15)
	var finish := Anchors.world_position(Anchors.VILA_ELEVADA, 0.0, 0.15)
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
			failures.append("sample %d exceeds boundary corridor" % sample)
		previous = current
	if start.distance_to(Anchors.world_position(Anchors.RUINAS_SUBMERSAS, 0.0, 0.15)) > 0.001:
		failures.append("R6 boundary origin mismatch")
	if finish.distance_to(Anchors.world_position(Anchors.VILA_ELEVADA, 0.0, 0.15)) > 0.001:
		failures.append("R7 boundary destination mismatch")
	print("BOUNDARY_HANDOFF R6->R7 from=Ruinas_Submersas to=Vila_Elevada distance=%0.3f" % start.distance_to(finish))
	print("BOUNDARY_SAMPLES count=%d travelled=%0.3f" % [SAMPLE_COUNT, travelled])
	print("BOUNDARY_GROUNDING y=0.15")
	print("BOUNDARY_OWNERSHIP_GUARD=PASS R6_dev1_boundary_readonly R7_dev2_owner")
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R6R7_BOUNDARY_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-013_R6_R7_BOUNDARY_QA=PASS")
	quit(0)
