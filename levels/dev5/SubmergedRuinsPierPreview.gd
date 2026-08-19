class_name SubmergedRuinsPierPreview
extends Node3D

## CP-D5-012: preview autónomo do marco 6; não toca TempleLevel.gd.
const MAP_ANCHOR := Vector2(0.0, 0.0)

func _ready() -> void:
	name = "SubmergedRuinsPierPreview"
	_build_environment()
	var landmarks := CartographicLandmarkObjects.new()
	add_child(landmarks)
	var pier := landmarks.create_submerged_ruins_pier_landmark()
	add_child(pier)
	print("[DEV5_RUINS_QA] landmark=6 submerged=true emissive=false dynamic_lights=0 production_script=false")
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.18, 0.28, 0.31)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.48, 0.62, 0.66)
	environment.ambient_light_energy = 0.72
	world.environment = environment
	add_child(world)
	var sun := DirectionalLight3D.new()
	sun.name = "LuzQARuinas"
	sun.rotation_degrees = Vector3(-54.0, -35.0, 0.0)
	sun.light_energy = 0.92
	sun.shadow_enabled = true
	add_child(sun)
	var camera := Camera3D.new()
	camera.name = "CameraQARuinasMarco6"
	camera.position = Vector3(7.4, 4.7, 8.6)
	camera.fov = 54.0
	camera.look_at_from_position(camera.position, Vector3(0.0, 0.0, 0.0))
	camera.current = true
	add_child(camera)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_RUINS_QA] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var viewport_image := viewport_texture.get_image()
	if viewport_image == null:
		print("[DEV5_RUINS_QA] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := viewport_image.save_png(snapshot_path)
	print("[DEV5_RUINS_QA] snapshot=%s result=%s" % [snapshot_path, result])
