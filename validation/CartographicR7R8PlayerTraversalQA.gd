extends SceneTree
## CP-D2-R7R8-003 — prova física do jogador Vila Elevada → Observatório.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R7R8 player traversal scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(2.6).timeout
	var player: CharacterBody3D = root.get_node_or_null("Player") as CharacterBody3D
	var terrain: Node = root.get_node_or_null("TempleLevel/TerrainPatch")
	var corridor: Node = root.get_node_or_null("TempleLevel/RegiaoVilaMontanhaExploravel/R7R8_HandoffColliders_Dev2")
	var failures: Array[String] = []
	if player == null:
		failures.append("Player missing")
	if terrain == null or not terrain.has_method("height_at"):
		failures.append("TerrainPatch.height_at missing")
	if corridor == null or corridor.get_child_count() != 6:
		failures.append("R7R8 collider corridor must contain 6 segments")
	var route: Array[Vector2] = [Vector2(140.0, 352.0), Vector2(149.0, 360.7), Vector2(158.0, 369.3), Vector2(167.0, 378.0), Vector2(176.0, 386.7), Vector2(185.0, 395.3), Vector2(194.0, 404.0)]
	var clear_segments: int = 0
	if failures.is_empty():
		for index: int in range(route.size() - 1):
			var segment_blocked: bool = false
			for sub_index: int in range(6):
				var t0: float = float(sub_index) / 6.0
				var t1: float = float(sub_index + 1) / 6.0
				var p0: Vector2 = route[index].lerp(route[index + 1], t0)
				var p1: Vector2 = route[index].lerp(route[index + 1], t1)
				var from: Vector3 = Vector3(p0.x, terrain.height_at(p0.x, p0.y) + 1.4, p0.y)
				var to: Vector3 = Vector3(p1.x, terrain.height_at(p1.x, p1.y) + 1.4, p1.y)
				var collision: KinematicCollision3D = null
				if player.test_move(Transform3D(Basis.IDENTITY, from), to - from, collision, 0.05, true):
					segment_blocked = true
					break
			print("R7R8_PLAYER_SEGMENT index=%d start=%s end=%s blocked=%s substeps=6" % [index + 1, str(route[index]), str(route[index + 1]), str(segment_blocked)])
			if segment_blocked:
				failures.append("segment %d blocked" % (index + 1))
			else:
				clear_segments += 1
	if failures.is_empty() and clear_segments == 6:
		print("CP-D2-R7R8-003_PLAYER_TRAVERSAL=PASS segments_clear=%d" % clear_segments)
	else:
		for failure: String in failures:
			print("R7R8_PLAYER_TRAVERSAL_PENDING: " + failure)
		print("CP-D2-R7R8-003_PLAYER_TRAVERSAL=REJECTED segments_clear=%d" % clear_segments)
	root.free()
	await process_frame
	quit(0)
