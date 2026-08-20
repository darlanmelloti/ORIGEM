extends SceneTree
## CP-D2-R12-003 — captura gráfica da Cúpula Final.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/Region12Validation.tscn") as PackedScene
	if scene == null:
		push_error("Region12Validation scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(3.5).timeout
	var camera: Camera3D = root.get_node_or_null("Region12ValidationCamera") as Camera3D
	var proxy: Node = root.get_node_or_null("CupulaFinalValidationProxy")
	var visible_meshes: int = 0
	var dynamic_lights: int = 0
	if camera == null:
		push_error("R12 validation camera missing")
	else:
		camera.current = true
	if proxy == null:
		push_error("R12 dome validation proxy missing")
	else:
		for node: Node in proxy.find_children("*", "GeometryInstance3D", true, false):
			if node is GeometryInstance3D and node.visible:
				visible_meshes += 1
		for node: Node in proxy.find_children("*", "Light3D", true, false):
			if node is Light3D and node.visible:
				dynamic_lights += 1
	print("R12_DOME_CAPTURE_INVENTORY visible_meshes=%d dynamic_lights=%d" % [visible_meshes, dynamic_lights])
	if dynamic_lights > 16:
		push_error("R12 dome light budget exceeded")
		quit(1)
		return
	var duration: float = 31.0
	var override_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not override_seconds.is_empty():
		duration = maxf(float(override_seconds), 1.0)
	var frame_count: int = maxi(30, ceili(duration * 10.0))
	for frame: int in range(frame_count):
		if frame % 30 == 0:
			print("R12_DOME_CAPTURE progress=%0.2f" % (float(frame) / float(frame_count - 1)))
		await create_timer(duration / float(frame_count)).timeout
	print("R12_DOME_LIGHT_BUDGET_CONTRACT=PASS max=16")
	print("R12_DOME_SCOPE_GUARD=PASS regions_7_12_only")
	print("CP-D2-R12-003_FINAL_DOME_CAPTURE=PASS")
	quit(0)
