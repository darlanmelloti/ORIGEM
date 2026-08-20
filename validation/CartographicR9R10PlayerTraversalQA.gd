extends SceneTree
## CP-D2-R9R10-003 — prova física do jogador Trilha → Caverna do Orion.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R9R10 player traversal scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(2.8).timeout
	var player: CharacterBody3D = root.get_node_or_null("Player") as CharacterBody3D
	var terrain: Node = root.get_node_or_null("TempleLevel/TerrainPatch")
	var destination: Node = root.get_node_or_null("TempleLevel/DestinosOrionEHubTemporal")
	var handoff: Node = destination.get_node_or_null("CPD2007_HandoffFisico_Regiao09_10_11") if destination != null else null
	var r9_body: Node = handoff.get_node_or_null("ColliderCPD2007_ENTRADA_TRILHA_09") if handoff != null else null
	var r10_marker: Node = handoff.get_node_or_null("CPD2007_LIMIAR_CAVERNA_10") if handoff != null else null
	var failures: Array[String] = []
	if player == null:
		failures.append("Player missing")
	if terrain == null or not terrain.has_method("height_at"):
		failures.append("TerrainPatch.height_at missing")
	if r9_body == null or r10_marker == null:
		failures.append("CPD2007 R9/R10 endpoints missing")
	var route: Array[Vector2] = [Vector2(-112.0, 532.0), Vector2(-114.0, 538.0), Vector2(-116.0, 544.0), Vector2(-116.0, 548.0)]
	var clear_segments: int = 0
	if failures.is_empty():
		for index: int in range(route.size() - 1):
			var segment_blocked: bool = false
			for sub_index: int in range(8):
				var t0: float = float(sub_index) / 8.0
				var t1: float = float(sub_index + 1) / 8.0
				var p0: Vector2 = route[index].lerp(route[index + 1], t0)
				var p1: Vector2 = route[index].lerp(route[index + 1], t1)
				var from: Vector3 = Vector3(p0.x, terrain.height_at(p0.x, p0.y) + 4.0, p0.y)
				var to: Vector3 = Vector3(p1.x, terrain.height_at(p1.x, p1.y) + 4.0, p1.y)
				var collision: KinematicCollision3D = null
				if player.test_move(Transform3D(Basis.IDENTITY, from), to - from, collision, 0.05, false):
					segment_blocked = true
					break
			print("R9R10_PLAYER_SEGMENT index=%d start=%s end=%s blocked=%s substeps=8" % [index + 1, str(route[index]), str(route[index + 1]), str(segment_blocked)])
			if segment_blocked:
				failures.append("segment %d blocked" % (index + 1))
			else:
				clear_segments += 1
	if failures.is_empty() and clear_segments == 3:
		print("CP-D2-R9R10-003_PLAYER_TRAVERSAL=PASS segments_clear=%d clearance_height=4.0" % clear_segments)
	else:
		for failure: String in failures:
			print("R9R10_PLAYER_TRAVERSAL_PENDING: " + failure)
		print("CP-D2-R9R10-003_PLAYER_TRAVERSAL=REJECTED segments_clear=%d" % clear_segments)
	root.free()
	await process_frame
	quit(0)
