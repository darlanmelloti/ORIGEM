extends Node

const OUTPUT_ENV: String = "ORIGEM_QA_CAPTURE_OUT"
const TARGET_NAMES: Array[String] = [
	"MesaDeCartografiaMajestic",
	"MapaDaExpedicaoMajestic",
	"RoloDeCampoMajestic_01",
	"RoloDeCampoMajestic_02",
	"RoloDeCampoMajestic_03",
	"LonaDeChegadaMajestic_01",
	"LonaDeChegadaMajestic_02",
]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("_run")

func _run() -> void:
	await get_tree().create_timer(2.2).timeout
	var main_scene := get_tree().get_first_node_in_group("main_scene") as Node3D
	if main_scene == null:
		_fail("main_scene_missing")
		return
	var targets: Array[Node3D] = []
	for target_name in TARGET_NAMES:
		var target := _find_node3d(main_scene, target_name)
		if target != null:
			targets.append(target)
	if targets.size() != TARGET_NAMES.size():
		_fail("targets=%d expected=%d" % [targets.size(), TARGET_NAMES.size()])
		return
	var focus := Vector3.ZERO
	for target in targets:
		focus += target.global_position
	focus /= float(targets.size())
	var qa_camera := Camera3D.new()
	qa_camera.name = "QACameraComposicaoMajestic"
	qa_camera.fov = 63.0
	main_scene.add_child(qa_camera)
	qa_camera.global_position = focus + Vector3(3.8, 2.7, 5.2)
	qa_camera.look_at(focus + Vector3(0.0, 0.65, 0.0), Vector3.UP)
	qa_camera.make_current()
	await get_tree().create_timer(1.2).timeout
	var output_path := OS.get_environment(OUTPUT_ENV)
	if output_path.is_empty():
		_fail("output_missing")
		return
	var image := get_viewport().get_texture().get_image()
	var save_error := image.save_png(output_path)
	qa_camera.queue_free()
	if save_error != OK:
		_fail("save_error=%d" % save_error)
		return
	print("[ORIGEM_R5_COMPOSITION_CAPTURE_OK] targets=%d focus=(%.2f,%.2f,%.2f) output=%s" % [targets.size(), focus.x, focus.y, focus.z, output_path])
	get_tree().quit(0)

func _fail(reason: String) -> void:
	printerr("[ORIGEM_R5_COMPOSITION_CAPTURE_FAIL] %s" % reason)
	get_tree().quit(2)

func _find_node3d(root_node: Node, target_name: String) -> Node3D:
	if root_node.name == target_name and root_node is Node3D:
		return root_node as Node3D
	for child in root_node.get_children():
		var found := _find_node3d(child, target_name)
		if found != null:
			return found
	return null
