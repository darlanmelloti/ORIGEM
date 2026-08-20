extends SceneTree
## CP-D2-R6R7-007 — prova física de movimento do jogador R6→R7.
## Usa os anchors cartográficos e a altitude real do TerrainPatch.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R6R7 player traversal scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(2.6).timeout
	var player: CharacterBody3D = root.get_node_or_null("Player") as CharacterBody3D
	var terrain: Node = root.get_node_or_null("TempleLevel/TerrainPatch")
	var arrival: Area3D = root.get_node_or_null("TempleLevel/RegiaoVilaMontanhaExploravel/VilaElevada/EstelaChegadaRegiao7_Area") as Area3D
	var route: Array[Vector2] = [Vector2(60.0, 252.0), Vector2(70.0, 264.5), Vector2(80.0, 277.0), Vector2(90.0, 289.5), Vector2(100.0, 302.0), Vector2(110.0, 314.5), Vector2(125.0, 333.0), Vector2(140.0, 352.0)]
	var failures: Array[String] = []
	var clear_segments: int = 0
	if player == null:
		failures.append("Player missing")
	if terrain == null or not terrain.has_method("height_at"):
		failures.append("TerrainPatch.height_at missing")
	if arrival == null:
		failures.append("R7 arrival trigger missing")
	if failures.is_empty():
		for index: int in range(route.size() - 1):
			var a2: Vector2 = route[index]
			var b2: Vector2 = route[index + 1]
			var segment_blocked: bool = false
			var substeps: int = 6
			for sub_index: int in range(substeps):
				var t0: float = float(sub_index) / float(substeps)
				var t1: float = float(sub_index + 1) / float(substeps)
				var p0: Vector2 = a2.lerp(b2, t0)
				var p1: Vector2 = a2.lerp(b2, t1)
				var from: Vector3 = Vector3(p0.x, terrain.height_at(p0.x, p0.y) + 1.4, p0.y)
				var to: Vector3 = Vector3(p1.x, terrain.height_at(p1.x, p1.y) + 1.4, p1.y)
				var collision: KinematicCollision3D = null
				if player.test_move(Transform3D(Basis.IDENTITY, from), to - from, collision, 0.05, true):
					segment_blocked = true
					break
			print("R6R7_PLAYER_SEGMENT index=%d start=%s end=%s blocked=%s substeps=%d" % [index + 1, str(a2), str(b2), str(segment_blocked), substeps])
			if segment_blocked:
				failures.append("segment %d blocked" % (index + 1))
			else:
				clear_segments += 1
	if failures.is_empty() and clear_segments == 7:
		print("CP-D2-R6R7-007_PLAYER_TRAVERSAL=PASS segments_clear=%d arrival_trigger=true" % clear_segments)
	else:
		for failure: String in failures:
			print("R6R7_PLAYER_TRAVERSAL_PENDING: " + failure)
		print("CP-D2-R6R7-007_PLAYER_TRAVERSAL=REJECTED segments_clear=%d" % clear_segments)
	root.free()
	await process_frame
	quit(0)
