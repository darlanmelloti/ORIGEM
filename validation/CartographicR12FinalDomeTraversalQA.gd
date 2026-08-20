extends SceneTree
## CP-D2-R12-002 — prova física Hub Temporal → Cúpula Final.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R12 final dome traversal scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(3.0).timeout
	var player: CharacterBody3D = root.get_node_or_null("Player") as CharacterBody3D
	var terrain: Node = root.get_node_or_null("TempleLevel/TerrainPatch")
	var destination: Node = root.get_node_or_null("TempleLevel/DestinosOrionEHubTemporal")
	var approach: Node = destination.get_node_or_null("TransicaoHubParaCupulaFinal") if destination != null else null
	var dome: Node = destination.get_node_or_null("CupulaFinal") if destination != null else null
	var failures: Array[String] = []
	if player == null:
		failures.append("Player missing")
	if terrain == null or not terrain.has_method("height_at"):
		failures.append("TerrainPatch.height_at missing")
	if approach == null or dome == null:
		failures.append("R12 approach or dome missing")
	var route: Array[Vector2] = [Vector2(164.0, 210.0), Vector2(164.0, 203.0), Vector2(164.0, 199.5), Vector2(162.5, 196.0), Vector2(165.0, 192.5), Vector2(163.0, 189.0), Vector2(165.0, 185.5), Vector2(164.0, 181.5)]
	var clear_segments: int = 0
	if failures.is_empty():
		for index: int in range(route.size() - 1):
			var blocked: bool = false
			for sub_index: int in range(8):
				var t0: float = float(sub_index) / 8.0
				var t1: float = float(sub_index + 1) / 8.0
				var p0: Vector2 = route[index].lerp(route[index + 1], t0)
				var p1: Vector2 = route[index].lerp(route[index + 1], t1)
				var from: Vector3 = Vector3(p0.x, terrain.height_at(p0.x, p0.y) + 4.0, p0.y)
				var to: Vector3 = Vector3(p1.x, terrain.height_at(p1.x, p1.y) + 4.0, p1.y)
				var collision: KinematicCollision3D = null
				if player.test_move(Transform3D(Basis.IDENTITY, from), to - from, collision, 0.05, false):
					blocked = true
					break
			print("R12_DOME_PLAYER_SEGMENT index=%d blocked=%s substeps=8" % [index + 1, str(blocked)])
			if blocked:
				failures.append("segment %d blocked" % (index + 1))
			else:
				clear_segments += 1
	if failures.is_empty() and clear_segments == 7:
		print("CP-D2-R12-002_FINAL_DOME_TRAVERSAL=PASS segments_clear=%d endpoint=(164,181.5)" % clear_segments)
	else:
		for failure: String in failures:
			print("R12_FINAL_DOME_TRAVERSAL_PENDING: " + failure)
		print("CP-D2-R12-002_FINAL_DOME_TRAVERSAL=REJECTED segments_clear=%d" % clear_segments)
	root.free()
	await process_frame
	quit(0)
