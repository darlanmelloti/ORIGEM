extends SceneTree
## CP-D2-R6R7-006 — verificação runtime dos colliders e chegada R7.
## A auditoria não modifica geometrias nem toca nos módulos Dev1.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R6R7 runtime scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(2.2).timeout
	var corridor: Node = root.get_node_or_null("TempleLevel/RegiaoVilaMontanhaExploravel/R6R7_HandoffColliders_Dev2")
	var arrival: Node = root.get_node_or_null("TempleLevel/RegiaoVilaMontanhaExploravel/VilaElevada/EstelaChegadaRegiao7_Area")
	var segment_count: int = corridor.get_child_count() if corridor != null else 0
	print("R6R7_TRAVERSAL_RUNTIME corridor_present=%s segments=%d arrival_trigger=%s" % [str(corridor != null), segment_count, str(arrival != null)])
	print("R6R7_TRAVERSAL_RUNTIME expected_segments=8 expected_arrival_trigger=true")
	var failures: Array[String] = []
	if corridor == null:
		failures.append("R6R7_HandoffColliders_Dev2 missing")
	if segment_count != 8:
		failures.append("expected 8 collider segments, got %d" % segment_count)
	if arrival == null:
		failures.append("R7 arrival trigger missing")
	if failures.is_empty():
		print("CP-D2-R6R7-006_TRAVERSAL_RUNTIME=PASS")
	else:
		for failure: String in failures:
			print("R6R7_TRAVERSAL_PENDING: " + failure)
		print("CP-D2-R6R7-006_TRAVERSAL_RUNTIME=REJECTED")
	root.free()
	await process_frame
	quit(0)
