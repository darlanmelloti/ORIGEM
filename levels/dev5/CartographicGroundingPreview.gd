## Dev5 — CP-D5-022: prova QA de aterramento por âncora cartográfica.

extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const OBJECTS := preload("res://levels/dev5/CartographicLandmarkObjects.gd")

var library: CartographicLandmarkObjects
var pending: Array[Dictionary] = []

func _ready() -> void:
	_build_environment()
	_build_sloped_ground()
	library = OBJECTS.new()
	add_child(library)
	await get_tree().physics_frame
	_spawn_candidates_above_ground()
	await get_tree().physics_frame
	_ground_candidates()
	_build_camera()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.35, 0.45, 0.52)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.58, 0.63, 0.67)
	environment.ambient_light_energy = 0.8
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-55.0, -22.0, 0.0)
	sun.light_energy = 1.05
	add_child(sun)

func _build_sloped_ground() -> void:
	var root := Node3D.new()
	root.name = "TerrenoFisicoQA"
	root.rotation_degrees.z = 7.0
	add_child(root)
	var surface := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(65.0, 0.8, 70.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.17, 0.25, 0.14)
	material.roughness = 0.95
	mesh.material = material
	surface.mesh = mesh
	surface.position = Vector3(-20.0, -0.48, 30.0)
	root.add_child(surface)
	var body := StaticBody3D.new()
	body.name = "TerrenoColisorQA"
	var shape := CollisionShape3D.new()
	var box := BoxShape3D.new()
	box.size = Vector3(65.0, 0.8, 70.0)
	shape.shape = box
	body.add_child(shape)
	body.position = surface.position
	root.add_child(body)

func _spawn_candidates_above_ground() -> void:
	var voss_record := PLACEMENT.placement_record("ground_voss", 1, Vector2.ZERO, 15.0)
	var house := library.create_voss_waystation_landmark()
	add_child(house)
	pending.append({"id": "anexo_casa_voss", "node": house, "desired": voss_record["world_position"]})
	var bridge_record := PLACEMENT.placement_record("ground_bridge", 2, Vector2(0.0, 1.6), 18.0)
	var bridge := library.create_stone_bridge_landmark()
	add_child(bridge)
	pending.append({"id": "ponte_marco_2", "node": bridge, "desired": bridge_record["world_position"]})

func _ground_candidates() -> void:
	for item: Dictionary in pending:
		var candidate := item["node"] as Node3D
		var desired := item["desired"] as Vector3
		var result := GROUNDING.snap_to_ground(get_world_3d(), candidate, desired)
		var preserved_xz := (result["world_xz"] as Vector2).distance_to(Vector2(desired.x, desired.z)) < 0.001
		print("[DEV5_GROUNDING] id=%s grounded=%s desired_y=%.2f impact_y=%.2f xz_preserved=%s collider=%s" % [item["id"], result["grounded"], result["desired_y"], result["impact_y"], preserved_xz, result.get("collider", "none")])
		assert(result["grounded"] and preserved_xz)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(-2.0, 13.0, -8.0)
	camera.fov = 62.0
	add_child(camera)
	camera.look_at(Vector3(-21.0, 0.0, 12.0), Vector3.UP)
	camera.make_current()

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_GROUNDING] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_GROUNDING] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := image.save_png(snapshot_path)
	print("[DEV5_GROUNDING] snapshot=%s result=%s" % [snapshot_path, result])
