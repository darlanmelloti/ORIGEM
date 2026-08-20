extends SceneTree
## CP-D2-R11R12-003 — prova do jogador no corredor cartográfico exacto.

const Anchors = preload("res://levels/CartographicAnchors.gd")

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R11R12 player traversal scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(2.8).timeout
	var player: CharacterBody3D = root.get_node_or_null("Player") as CharacterBody3D
	var terrain: Node = root.get_node_or_null("TempleLevel/TerrainPatch")
	var destination: Node = root.get_node_or_null("TempleLevel/DestinosOrionEHubTemporal")
	var corridor: Node = destination.get_node_or_null("CartographicHandoffR11R12") if destination != null else null
	var failures: Array[String] = []
	if player == null:
		failures.append("Player missing")
	if terrain == null or not terrain.has_method("height_at"):
		failures.append("TerrainPatch.height_at missing")
	if corridor == null or corridor.get_child_count() != 8:
		failures.append("Cartographic R11-R12 corridor must contain 8 segments")
	var start: Vector3 = Anchors.world_position(Anchors.CAMARA_ORION_CUBE, 0.0, 0.15)
	var finish: Vector3 = Anchors.world_position(Anchors.HUB_TEMPORAL, 0.0, 0.15)
	var clear_segments: int = 0
	if failures.is_empty():
		for index: int in range(8):
			var t0: float = float(index) / 8.0
			var t1: float = float(index + 1) / 8.0
			var p0: Vector3 = start.lerp(finish, t0)
			var p1: Vector3 = start.lerp(finish, t1)
			var segment_blocked: bool = false
			for sub_index: int in range(8):
				var s0: float = float(sub_index) / 8.0
				var s1: float = float(sub_index + 1) / 8.0
				var q0: Vector3 = p0.lerp(p1, s0)
				var q1: Vector3 = p0.lerp(p1, s1)
				var ground_y0: float = terrain.height_at(q0.x, q0.z)
				var ground_y1: float = terrain.height_at(q1.x, q1.z)
				var from: Vector3 = Vector3(q0.x, ground_y0 + 4.0, q0.z)
				var to: Vector3 = Vector3(q1.x, ground_y1 + 4.0, q1.z)
				var collision: KinematicCollision3D = null
				if player.test_move(Transform3D(Basis.IDENTITY, from), to - from, collision, 0.05, false):
					segment_blocked = true
					break
			if segment_blocked:
				failures.append("segment %d blocked" % (index + 1))
			else:
				clear_segments += 1
			print("R11R12_PLAYER_SEGMENT index=%d blocked=%s substeps=8" % [index + 1, str(segment_blocked)])
	print("R11R12_PLAYER_CONTRACT start=%s finish=%s distance=%0.3f" % [str(start), str(finish), start.distance_to(finish)])
	if failures.is_empty() and clear_segments == 8:
		print("CP-D2-R11R12-003_PLAYER_TRAVERSAL=PASS segments_clear=%d clearance_height=4.0" % clear_segments)
	else:
		for failure: String in failures:
			print("R11R12_PLAYER_TRAVERSAL_PENDING: " + failure)
		print("CP-D2-R11R12-003_PLAYER_TRAVERSAL=REJECTED segments_clear=%d" % clear_segments)
	root.free()
	await process_frame
	quit(0)
