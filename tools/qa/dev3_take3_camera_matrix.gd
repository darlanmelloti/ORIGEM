extends SceneTree

## Sonda Dev3: lê a câmara e as luzes no projecto real sem editar qualquer módulo regional.
## Executar: Godot --headless --path <root> --script tools/qa/dev3_take3_camera_matrix.gd

func _init() -> void:
	call_deferred("_run_matrix")

func _run_matrix() -> void:
	var packed: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if packed == null:
		printerr("[DEV3_TAKE3] cena principal indisponível")
		quit(2)
		return
	var world: Node = packed.instantiate()
	root.add_child(world)
	await create_timer(3.0).timeout
	var camera: Camera3D = _first_camera(root)
	var lights: Array[Light3D] = _visible_lights(root)
	var payload: Dictionary = {
		"probe": "CINE-PAIR-14A",
		"camera_found": camera != null,
		"camera_position": camera.global_position if camera != null else Vector3.ZERO,
		"camera_rotation": camera.global_rotation if camera != null else Vector3.ZERO,
		"camera_fov": camera.fov if camera != null else -1.0,
		"visible_lights": lights.size(),
		"light_names": lights.map(func(light: Light3D) -> String: return light.name),
		"scope": "Dev3 QA; leitura somente; Regiões 7–12"
	}
	print("[DEV3_TAKE3_MATRIX] %s" % JSON.stringify(payload))
	quit(0)

func _first_camera(node: Node) -> Camera3D:
	if node is Camera3D and (node as Camera3D).current:
		return node as Camera3D
	for child: Node in node.get_children():
		var found: Camera3D = _first_camera(child)
		if found != null:
			return found
	return null

func _visible_lights(node: Node) -> Array[Light3D]:
	var result: Array[Light3D] = []
	for raw: Node in node.find_children("*", "Light3D", true, false):
		var light: Light3D = raw as Light3D
		if light != null and light.visible:
			result.append(light)
	return result
