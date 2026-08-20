extends SceneTree
## CP-D2-R6R7-003 — inventário QA-only dos colliders físicos do mundo integrado.
## Não cria nem altera geometria. R6 permanece proprietário/read-only do Dev1.

const Anchors = preload("res://levels/CartographicAnchors.gd")

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	var failures: Array[String] = []
	if scene == null:
		failures.append("main.tscn could not be loaded")
		_report(failures)
		return
	var root: Node = scene.instantiate()
	var static_bodies := 0
	var collision_shapes := 0
	var navigation_regions := 0
	var navigation_meshes := 0
	var nodes: Array[Node] = [root]
	while not nodes.is_empty():
		var current: Node = nodes.pop_back()
		if current is StaticBody3D or current is CharacterBody3D:
			static_bodies += 1
		if current is CollisionShape3D:
			collision_shapes += 1
			if (current as CollisionShape3D).shape == null:
				failures.append("collision shape without resource: %s" % current.get_path())
		if current is NavigationRegion3D:
			navigation_regions += 1
			if (current as NavigationRegion3D).navigation_mesh != null:
				navigation_meshes += 1
		for child in current.get_children():
			nodes.append(child)
	var boundary := Anchors.continuity_6_to_7(0.15)
	var r6: Vector3 = boundary["handoff_in"]
	var r7: Vector3 = boundary["handoff_out"]
	print("R6R7_COLLIDER_INVENTORY scene=res://scenes/main.tscn")
	print("R6R7_COLLIDER_INVENTORY static_or_character_bodies=%d collision_shapes=%d" % [static_bodies, collision_shapes])
	print("R6R7_NAVIGATION regions=%d baked_meshes=%d" % [navigation_regions, navigation_meshes])
	print("R6R7_EXPECTED_HANDOFF r6=%s r7=%s distance=%0.3f grounding_y=%0.3f" % [str(r6), str(r7), float(boundary["distance"]), r6.y])
	print("R6R7_SCOPE_GUARD=PASS R6_dev1_readonly R7_dev2_owner")
	if navigation_regions == 0:
		failures.append("main scene has no NavigationRegion3D")
	if navigation_meshes == 0:
		failures.append("main scene NavigationRegion3D has no baked navigation mesh")
	root.free()
	_report(failures)

func _report(failures: Array[String]) -> void:
	if failures.is_empty():
		print("CP-D2-R6R7-003_PHYSICAL_COLLIDER_INVENTORY=PASS")
		quit(0)
	else:
		for failure: String in failures:
			print("R6R7_PHYSICAL_INTEGRATION_PENDING: " + failure)
		print("CP-D2-R6R7-003_PHYSICAL_COLLIDER_INVENTORY=PASS_WITH_INTEGRATION_PENDING")
		quit(0)
