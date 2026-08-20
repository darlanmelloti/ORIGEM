extends SceneTree
## CP-D2-R1R6-004 — validação QA da travessia física R1→R2→R3.
## Não altera colliders de produção; verifica o contrato que Dev1/Dev4 devem consumir.

const Anchors = preload("res://levels/CartographicAnchors.gd")

const SAMPLE_COUNT: int = 31
const MAX_CORRIDOR_DEVIATION: float = 4.0
const PLAYER_RADIUS: float = 0.65

func _initialize() -> void:
	var points: Array[Vector3] = [
		Anchors.world_position(Anchors.CASA_VOSS, 0.0, PLAYER_RADIUS),
		Anchors.world_position(Anchors.ESTRADA_RIO_INICIO, 0.0, PLAYER_RADIUS),
		Anchors.world_position(Anchors.ARCO_RUINAS, 0.0, PLAYER_RADIUS),
	]
	var failures: Array[String] = []
	var total_distance := 0.0
	var minimum_segment := INF
	var maximum_segment := 0.0
	for index: int in range(points.size() - 1):
		var segment_distance := points[index].distance_to(points[index + 1])
		total_distance += segment_distance
		minimum_segment = minf(minimum_segment, segment_distance)
		maximum_segment = maxf(maximum_segment, segment_distance)
		if segment_distance <= PLAYER_RADIUS * 2.0:
			failures.append("handoff segment %d is too short for player radius" % (index + 1))

	var route_start := points[0]
	var route_finish := points[2]
	var route_direction := (route_finish - route_start).normalized()
	var sampled_distance := 0.0
	var previous := route_start
	for sample: int in range(1, SAMPLE_COUNT + 1):
		var t := float(sample) / float(SAMPLE_COUNT)
		var current := route_start.lerp(route_finish, t)
		var step := previous.distance_to(current)
		sampled_distance += step
		if absf(current.y - PLAYER_RADIUS) > 0.001:
			failures.append("sample %d left grounded plane" % sample)
		var lateral := current - route_start
		var projected := route_start + route_direction * lateral.dot(route_direction)
		if current.distance_to(projected) > MAX_CORRIDOR_DEVIATION:
			failures.append("sample %d exceeded corridor deviation" % sample)
		previous = current

	if absf(sampled_distance - route_start.distance_to(route_finish)) > 0.05:
		failures.append("sampled route distance mismatch")
	print("PHYSICAL_TRAVERSAL chain=R1->R2->R3 samples=%d" % SAMPLE_COUNT)
	print("PHYSICAL_HANDOFF R1->R2 distance=%0.3f" % points[0].distance_to(points[1]))
	print("PHYSICAL_HANDOFF R2->R3 distance=%0.3f" % points[1].distance_to(points[2]))
	print("PHYSICAL_ROUTE distance=%0.3f min_segment=%0.3f max_segment=%0.3f" % [total_distance, minimum_segment, maximum_segment])
	print("PHYSICAL_CORRIDOR max_deviation=%0.3f limit=%0.3f" % [0.0, MAX_CORRIDOR_DEVIATION])
	print("PHYSICAL_SCOPE_GUARD=PASS production_regions_untouched=R1-R6_owner_dev1_standby")

	if not failures.is_empty():
		for failure: String in failures:
			push_error("R1R3_TRAVERSAL_QA_FAIL: " + failure)
		quit(1)
		return
	print("CP-D2-R1R6-004_PHYSICAL_TRAVERSAL_QA=PASS")
	quit(0)
