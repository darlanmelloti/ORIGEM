extends Node

const OUTPUT_ENV: String = "ORIGEM_QA_CAPTURE_OUT"
const TELEMETRY_ENV: String = "ORIGEM_QA_TELEMETRY_OUT"
const INLET_POINTS: Array[Vector2] = [
	Vector2(12.6, 163.0),
	Vector2(13.4, 178.0),
	Vector2(17.8, 193.0),
	Vector2(25.6, 208.0),
	Vector2(36.0, 224.0),
]
const R6_LIGHT_NAMES: Array[String] = [
	"PreenchimentoMundialDoLago",
	"PreenchimentoOpostoDoLago",
	"PreenchimentoAzulDaMargem",
	"LuzSubaquaticaCentral",
]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("_run")

func _run() -> void:
	await get_tree().create_timer(2.4).timeout
	var main_scene := get_tree().get_first_node_in_group("main_scene") as Node3D
	if main_scene == null:
		_fail("main_scene_missing")
		return
	var inlet := _find_node(main_scene, "AfluenteCartograficoRioParaBacia") as Node3D
	var water := _find_node(main_scene, "LaminaDoAfluenteCartografico") as MeshInstance3D
	var waypoint_root := _find_node(main_scene, "BalizasDoTrilhoFlorestal") as Node3D
	if inlet == null or water == null or waypoint_root == null:
		_fail("required_nodes inlet=%s water=%s waypoints=%s" % [str(inlet != null), str(water != null), str(waypoint_root != null)])
		return
	var region := inlet.get_parent() as Node
	if region == null or not region.has_method("_path_x") or not region.has_method("_height_at"):
		_fail("region_spatial_api_missing")
		return
	var hidden_canvas_items: Array[Dictionary] = []
	_hide_canvas_items(main_scene, hidden_canvas_items)
	var focus := Vector3(16.4, float(region.call("_height_at", 16.4, 181.0)) + 0.25, 181.0)
	var qa_camera := Camera3D.new()
	qa_camera.name = "QACameraAfluenteR4"
	qa_camera.fov = 66.0
	main_scene.add_child(qa_camera)
	qa_camera.global_position = Vector3(3.6, float(region.call("_height_at", 3.6, 159.0)) + 4.8, 156.5)
	qa_camera.look_at(focus, Vector3.UP)
	qa_camera.make_current()
	await get_tree().create_timer(1.4).timeout
	var output_path := OS.get_environment(OUTPUT_ENV)
	var telemetry_path := OS.get_environment(TELEMETRY_ENV)
	if output_path.is_empty() or telemetry_path.is_empty():
		qa_camera.queue_free()
		_fail("output_or_telemetry_missing")
		return
	var image := get_viewport().get_texture().get_image()
	var save_error := image.save_png(output_path)
	var telemetry_error := _write_telemetry(telemetry_path, region, water, waypoint_root)
	_restore_canvas_items(hidden_canvas_items)
	qa_camera.queue_free()
	if save_error != OK or telemetry_error != OK:
		_fail("save_error=%d telemetry_error=%d" % [save_error, telemetry_error])
		return
	print("[ORIGEM_R4_INLET_SIGHTLINE_OK] points=%d r4_lights=%d r6_lights=%d output=%s telemetry=%s" % [INLET_POINTS.size(), _count_named_lights(main_scene, ["LuzBalizaFlorestalUnica"]), _count_named_lights(main_scene, R6_LIGHT_NAMES), output_path, telemetry_path])
	get_tree().quit(0)

func _write_telemetry(path: String, region: Node, water: MeshInstance3D, waypoint_root: Node3D) -> Error:
	var main_scene := get_tree().get_first_node_in_group("main_scene") as Node3D
	var lines: PackedStringArray = PackedStringArray()
	lines.append("[ORIGEM_R4_INLET_SIGHTLINE]")
	lines.append("production_mutations=0")
	lines.append("inlet_points=%d" % INLET_POINTS.size())
	lines.append("water_aabb_size=(%.3f,%.3f,%.3f)" % [water.get_aabb().size.x, water.get_aabb().size.y, water.get_aabb().size.z])
	for index: int in range(INLET_POINTS.size()):
		var point := INLET_POINTS[index]
		var route_x := float(region.call("_path_x", point.y))
		var route_y := float(region.call("_height_at", route_x, point.y))
		var planar_distance := Vector2(point.x, point.y).distance_to(Vector2(route_x, point.y))
		lines.append("point_%02d=(%.2f,%.2f) route=(%.2f,%.2f,%.2f) planar_distance=%.3f" % [index, point.x, point.y, route_x, route_y, point.y, planar_distance])
	lines.append("waypoints=%d" % waypoint_root.get_child_count())
	lines.append("r4_lights=%d" % _count_named_lights(main_scene, ["LuzBalizaFlorestalUnica"]))
	lines.append("r6_lights=%d" % _count_named_lights(main_scene, R6_LIGHT_NAMES))
	lines.append("r6_light_names=%s" % ",".join(R6_LIGHT_NAMES))
	var telemetry_file := FileAccess.open(path, FileAccess.WRITE)
	if telemetry_file == null:
		return FileAccess.get_open_error()
	telemetry_file.store_string("\n".join(lines) + "\n")
	telemetry_file.close()
	return OK

func _hide_canvas_items(root_node: Node, hidden_items: Array[Dictionary]) -> void:
	for child in root_node.get_children():
		if child is CanvasItem:
			var canvas_item := child as CanvasItem
			hidden_items.append({"node": canvas_item, "visible": canvas_item.visible})
			canvas_item.visible = false
		_hide_canvas_items(child, hidden_items)

func _restore_canvas_items(hidden_items: Array[Dictionary]) -> void:
	for item in hidden_items:
		var canvas_item := item.get("node") as CanvasItem
		if canvas_item != null:
			canvas_item.visible = bool(item.get("visible", false))

func _count_named_lights(root_node: Node, names: Array[String]) -> int:
	var found: int = 0
	for target_name in names:
		var candidate := _find_node(root_node, target_name)
		if candidate is OmniLight3D:
			found += 1
	return found

func _find_node(root_node: Node, target_name: String) -> Node:
	if root_node.name == target_name:
		return root_node
	for child in root_node.get_children():
		var found := _find_node(child, target_name)
		if found != null:
			return found
	return null

func _fail(reason: String) -> void:
	printerr("[ORIGEM_R4_INLET_SIGHTLINE_FAIL] %s" % reason)
	get_tree().quit(2)
