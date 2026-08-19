## Dev5 — Cena QA isolada do anexo da Casa Voss (marco 1).
## Nunca é carregada pelo mundo de produção; valida apenas geometria, colisores e leitura cartográfica.

extends Node3D

const LANDMARK_LIBRARY: Script = preload("res://levels/dev5/CartographicLandmarkObjects.gd")

func _ready() -> void:
	name = "VossWaystationPreview"
	_build_environment()
	_build_ground()
	_build_waystation()
	_build_camera()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.29, 0.39, 0.50)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.72, 0.68, 0.60)
	environment.ambient_light_energy = 0.78
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.15
	sun.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	add_child(sun)

func _build_ground() -> void:
	var ground := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(20.0, 20.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.14, 0.20, 0.10)
	material.roughness = 0.98
	mesh.material = material
	ground.mesh = mesh
	add_child(ground)
	var path := MeshInstance3D.new()
	var path_mesh := BoxMesh.new()
	path_mesh.size = Vector3(2.0, 0.07, 8.0)
	var path_material := StandardMaterial3D.new()
	path_material.albedo_color = Color(0.34, 0.28, 0.19)
	path_material.roughness = 0.96
	path_mesh.material = path_material
	path.mesh = path_mesh
	path.position = Vector3(0.0, 0.02, 3.20)
	add_child(path)

func _build_waystation() -> void:
	var library: CartographicLandmarkObjects = LANDMARK_LIBRARY.new()
	add_child(library)
	var waystation: Node3D = library.create_voss_waystation_landmark()
	waystation.name = "AnexoCasaVoss_QA"
	waystation.position = Vector3(0.0, 0.16, 0.0)
	add_child(waystation)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraAnexoCasaVossQA"
	camera.position = Vector3(5.6, 3.55, 6.8)
	camera.fov = 53.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 1.05, 0.0), Vector3.UP)
	camera.make_current()

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
if viewport_texture == null:
	print("[DEV5_VOSS_QA] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
	return
var image := viewport_texture.get_image()
if image == null:
	print("[DEV5_VOSS_QA] snapshot_unavailable=headless_image path=%s" % snapshot_path)
	return
	var result := image.save_png(snapshot_path)
	print("[DEV5_VOSS_QA] snapshot=%s result=%s" % [snapshot_path, result])
