extends Node

# Captura QA Dev7: executada apenas por injeção da cena de jogo.
# Não altera recursos, cenas, ancoragens, luzes, água, colisores, rota ou câmara do jogador.
const OUTPUT_ENV: String = "ORIGEM_QA_R6_ARCHAEOLOGY_CAPTURE_OUT"
const MODE_ENV: String = "ORIGEM_QA_R6_ARCHAEOLOGY_CAPTURE_MODE"
const TARGET_PREFIXES: Array[String] = [
	"EstelaDaChegada",
	"MarcoRuinaEmergente_",
	"PilarSubmerso_",
	"AfloramentoChegadaRuinas_",
]
const R6_LIGHT_NAMES: Array[String] = [
	"PreenchimentoMundialDoLago",
	"PreenchimentoOpostoDoLago",
	"PreenchimentoAzulDaMargem",
	"LuzSubaquaticaCentral",
]
const QA_ALBEDO_TARGET: Color = Color(0.62, 0.56, 0.43, 1.0)
const QA_ALBEDO_WEIGHT: float = 0.20
const QA_ROUGHNESS_DELTA: float = 0.08

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("_run")

func _run() -> void:
	DisplayServer.window_set_size(Vector2i(1600, 900))
	await get_tree().create_timer(2.8).timeout
	var mode := OS.get_environment(MODE_ENV).strip_edges().to_lower()
	if mode != "baseline" and mode != "override":
		_fail("mode_invalid=%s" % mode)
		return
	var output_path := OS.get_environment(OUTPUT_ENV)
	if output_path.is_empty():
		_fail("output_missing")
		return
	var main_scene := get_tree().get_first_node_in_group("main_scene") as Node3D
	if main_scene == null:
		_fail("main_scene_missing")
		return
	var targets: Array[MeshInstance3D] = []
	for prefix in TARGET_PREFIXES:
		var target := _find_mesh_by_prefix(main_scene, prefix)
		if target == null:
			_fail("target_missing=%s" % prefix)
			return
		targets.append(target)
	var exact_r6_lights := _count_exact_r6_lights(main_scene)
	if exact_r6_lights != R6_LIGHT_NAMES.size():
		_fail("r6_lights=%d expected=%d" % [exact_r6_lights, R6_LIGHT_NAMES.size()])
		return
	var total_lights_before := _count_lights(main_scene)
	var transforms_before: Array[Transform3D] = []
	var original_overrides: Array = []
	for target in targets:
		transforms_before.append(target.global_transform)
		original_overrides.append(target.material_override)
	var qa_override_count := 0
	if mode == "override":
		for target in targets:
			var source := target.get_active_material(0)
			if not source is StandardMaterial3D:
				_restore_overrides(targets, original_overrides)
				_fail("standard_material_missing=%s" % target.name)
				return
			var temporary := (source as StandardMaterial3D).duplicate() as StandardMaterial3D
			if temporary == null:
				_restore_overrides(targets, original_overrides)
				_fail("material_duplicate_failed=%s" % target.name)
				return
			temporary.resource_local_to_scene = true
			temporary.albedo_color = temporary.albedo_color.lerp(QA_ALBEDO_TARGET, QA_ALBEDO_WEIGHT)
			temporary.roughness = clampf(temporary.roughness + QA_ROUGHNESS_DELTA, 0.0, 1.0)
			temporary.emission_enabled = false
			target.material_override = temporary
			qa_override_count += 1
	var focus := Vector3.ZERO
	for target in targets:
		focus += target.global_position
	focus /= float(targets.size())
	var qa_ui_visibility := _hide_canvas_items(get_tree().root)
	var qa_camera := Camera3D.new()
	qa_camera.name = "QACameraDev7ArchaeologyOverride"
	qa_camera.fov = 57.0
	main_scene.add_child(qa_camera)
	qa_camera.global_position = focus + Vector3(28.0, 16.0, 34.0)
	qa_camera.look_at(focus + Vector3(0.0, 2.0, 0.0), Vector3.UP)
	qa_camera.make_current()
	await get_tree().create_timer(1.4).timeout
	var image := get_viewport().get_texture().get_image()
	var source_size := image.get_size()
	image.resize(1600, 900, Image.INTERPOLATE_LANCZOS)
	var save_error := image.save_png(output_path)
	qa_camera.queue_free()
	_restore_canvas_items(qa_ui_visibility)
	_restore_overrides(targets, original_overrides)
	var transforms_unchanged := _transforms_unchanged(targets, transforms_before)
	var exact_r6_lights_after := _count_exact_r6_lights(main_scene)
	var total_lights_after := _count_lights(main_scene)
	if save_error != OK:
		_fail("save_error=%d" % save_error)
		return
	if not transforms_unchanged:
		_fail("target_transforms_changed")
		return
	if exact_r6_lights_after != exact_r6_lights or total_lights_after != total_lights_before:
		_fail("light_inventory_changed before=%d/%d after=%d/%d" % [exact_r6_lights, total_lights_before, exact_r6_lights_after, total_lights_after])
		return
	print("[ORIGEM_DEV7_R6_ARCHAEOLOGY_CAPTURE_OK] mode=%s targets=%d qa_overrides=%d r6_lights=%d all_lights=%d transforms_unchanged=true route=forest_to_ruins production_mutations=0 viewport=%dx%d saved=1600x900 output=%s" % [mode, targets.size(), qa_override_count, exact_r6_lights_after, total_lights_after, source_size.x, source_size.y, output_path])
	get_tree().quit(0)

func _hide_canvas_items(root_node: Node) -> Dictionary:
	var visibility: Dictionary = {}
	if root_node is CanvasItem:
		var item := root_node as CanvasItem
		visibility[item] = item.visible
		item.visible = false
	for child in root_node.get_children():
		visibility.merge(_hide_canvas_items(child), true)
	return visibility

func _restore_canvas_items(visibility: Dictionary) -> void:
	for item_variant in visibility.keys():
		var item := item_variant as CanvasItem
		if is_instance_valid(item):
			item.visible = bool(visibility[item_variant])

func _restore_overrides(targets: Array[MeshInstance3D], original_overrides: Array) -> void:
	for index in range(mini(targets.size(), original_overrides.size())):
		targets[index].material_override = original_overrides[index] as Material

func _transforms_unchanged(targets: Array[MeshInstance3D], transforms_before: Array[Transform3D]) -> bool:
	if targets.size() != transforms_before.size():
		return false
	for index in range(targets.size()):
		if not targets[index].global_transform.is_equal_approx(transforms_before[index]):
			return false
	return true

func _count_exact_r6_lights(root_node: Node) -> int:
	var count := 0
	for light_name in R6_LIGHT_NAMES:
		if _find_node_by_name(root_node, light_name) is Light3D:
			count += 1
	return count

func _count_lights(root_node: Node) -> int:
	var count := 0
	if root_node is Light3D:
		count += 1
	for child in root_node.get_children():
		count += _count_lights(child)
	return count

func _find_mesh_by_prefix(root_node: Node, prefix: String) -> MeshInstance3D:
	if root_node.name.begins_with(prefix):
		if root_node is MeshInstance3D:
			return root_node as MeshInstance3D
		for child in root_node.get_children():
			var nested := _find_mesh_by_prefix(child, "")
			if nested != null:
				return nested
	for child in root_node.get_children():
		var found := _find_mesh_by_prefix(child, prefix)
		if found != null:
			return found
	return null

func _find_node_by_name(root_node: Node, target_name: String) -> Node:
	if root_node.name == target_name:
		return root_node
	for child in root_node.get_children():
		var found := _find_node_by_name(child, target_name)
		if found != null:
			return found
	return null

func _fail(reason: String) -> void:
	printerr("[ORIGEM_DEV7_R6_ARCHAEOLOGY_CAPTURE_FAIL] %s" % reason)
	get_tree().quit(2)
