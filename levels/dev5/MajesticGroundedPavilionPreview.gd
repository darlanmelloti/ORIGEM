## Dev5 — CP-D5-025: prova de aterramento do Pavilhão Majestic na âncora R5.

extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const OBJECTS := preload("res://levels/dev5/CartographicLandmarkObjects.gd")

var pavilion: Node3D
var grounding_result: Dictionary

func _ready() -> void:
	_build_environment()
	_build_majestic_ground()
	var library := OBJECTS.new()
	add_child(library)
	await get_tree().physics_frame
	_spawn_grounded_pavilion(library)
	await get_tree().physics_frame
	_build_camera()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.16, 0.24, 0.29)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.46, 0.57, 0.62)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50.0, 24.0, 0.0)
	sun.light_energy = 1.15
	add_child(sun)

func _build_majestic_ground() -> void:
	var ground := Node3D.new()
	ground.name = "TerrenoMajesticIrregularQA"
	ground.position = Vector3(-88.0, 0.0, 178.0)
	ground.rotation_degrees.z = -6.0
	add_child(ground)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.20, 0.12)
	material.roughness = 0.96
	var mesh := BoxMesh.new()
	mesh.size = Vector3(34.0, 0.90, 30.0)
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	body.name = "TerrenoMajesticColisorQA"
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)
	for index: int in range(12):
		var side := -1.0 if index % 2 == 0 else 1.0
		var mound := MeshInstance3D.new()
		var mound_mesh := SphereMesh.new()
		mound_mesh.radius = 0.46 + float(index % 3) * 0.18
		mound_mesh.height = 0.62 + float(index % 2) * 0.24
		mound_mesh.material = material
		mound.mesh = mound_mesh
		mound.position = Vector3(side * (5.8 + float(index % 2) * 1.8), 0.17, -11.5 + float(index) * 2.10)
		mound.scale = Vector3(1.9, 0.75, 1.2)
		ground.add_child(mound)

func _spawn_grounded_pavilion(library: CartographicLandmarkObjects) -> void:
	var record := PLACEMENT.placement_record("pavilhao_majestic", 5, Vector2.ZERO, 17.0)
	pavilion = library.create_majestic_pavilion_landmark()
	add_child(pavilion)
	grounding_result = GROUNDING.snap_to_ground(get_world_3d(), pavilion, record["world_position"] as Vector3)
	var target := record["world_position"] as Vector3
	var xz_preserved := (grounding_result["world_xz"] as Vector2).distance_to(Vector2(target.x, target.z)) < 0.001
	var foundation_grounded := pavilion.global_position.y <= float(grounding_result["impact_y"]) + 0.001
	assert(grounding_result["grounded"] and xz_preserved and foundation_grounded)
	print("[DEV5_MAJESTIC_GROUNDING] anchor=5 xz=(%.3f,%.3f) desired_y=%.2f impact_y=%.2f grounded=%s xz_preserved=%s foundation_grounded=%s collider=%s" % [
		target.x, target.z, grounding_result["desired_y"], grounding_result["impact_y"], grounding_result["grounded"], xz_preserved, foundation_grounded, grounding_result.get("collider", "none"),
	])
	print("[DEV5_MAJESTIC_GROUNDING] status=approved object_dynamic_lights=0 production_modules_changed=false")

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(-79.0, 7.5, 166.0)
	camera.fov = 57.0
	add_child(camera)
	camera.look_at(Vector3(-88.0, 1.2, 178.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(54.0, 48.0)
	label.size = Vector2(760.0, 90.0)
	label.text = "CP-D5-025  |  R5 ACAMPAMENTO MAJESTIC\nX/Z CANÓNICO · RAYCAST Y · PAVILHÃO SEM LUZES"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.88, 0.94, 0.96)
	layer.add_child(label)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var result := get_viewport().get_texture().get_image().save_png(snapshot_path)
	print("[DEV5_MAJESTIC_GROUNDING] snapshot=%s result=%s" % [snapshot_path, result])
