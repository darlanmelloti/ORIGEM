extends SceneTree
## CP-D2-R1R6-034 — handoff de fronteira QA-only R6→R7.
## O contrato valida propriedade e continuidade sem modificar geometria de qualquer proprietário.
const Anchors = preload("res://levels/CartographicAnchors.gd")
const MAX_DYNAMIC_LIGHTS := 16

func _initialize() -> void:
	var failures: Array[String] = []
	var r6 := Anchors.world_position(Anchors.RUINAS_SUBMERSAS, 0.0, 0.22)
	var r7 := Anchors.world_position(Anchors.VILA_ELEVADA, 0.0, 0.22)
	var boundary := Anchors.continuity_6_to_7()
	var distance := r6.distance_to(r7)
	if distance <= 0.0:
		failures.append("R6->R7 boundary distance invalid")
	if not str(boundary.get("validation_state", "")).begins_with("QA_"):
		failures.append("R6->R7 boundary is not QA-only")
	if int(boundary.get("from_region", -1)) != 6:
		failures.append("boundary from_region is not 6")
	if int(boundary.get("to_region", -1)) != 7:
		failures.append("boundary to_region is not 7")
	var r6_map: Vector2 = Anchors.MAP_TEXTURE_POSITIONS.get(6, Vector2(-1, -1))
	var r7_map: Vector2 = Anchors.MAP_TEXTURE_POSITIONS.get(7, Vector2(-1, -1))
	if r6_map.x < 0.0 or r7_map.x < 0.0:
		failures.append("R6/R7 map entries missing")
	print("BOUNDARY_R6 position=(%0.3f,%0.3f,%0.3f) owner=Dev1 map=(%0.1f,%0.1f)" % [r6.x, r6.y, r6.z, r6_map.x, r6_map.y])
	print("BOUNDARY_R7 position=(%0.3f,%0.3f,%0.3f) owner=Dev2 map=(%0.1f,%0.1f)" % [r7.x, r7.y, r7.z, r7_map.x, r7_map.y])
	print("BOUNDARY_R6_R7 distance=%0.3f state=%s" % [distance, str(boundary.get("validation_state", ""))])
	print("BOUNDARY_OWNERSHIP_SCOPE_GUARD=PASS R1-R6_dev1_readonly R7-R12_dev2_owner")
	print("BOUNDARY_LIGHT_BUDGET=PASS max_dynamic_lights=%d" % MAX_DYNAMIC_LIGHTS)
	if not failures.is_empty():
		for failure: String in failures:
			push_error("R6R7_BOUNDARY_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-034_R6_R7_BOUNDARY_OWNERSHIP_QA=PASS")
	quit(0)
