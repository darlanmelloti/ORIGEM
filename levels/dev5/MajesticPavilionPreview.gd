## Dev5 — Cena QA isolada do pavilhão do marco 5: Acampamento Majestic.
## Não é carregada pelo mundo principal; valida somente volume, materiais e colisores próprios.

extends Node3D

const LANDMARK_LIBRARY: Script = preload("res://levels/dev5/CartographicLandmarkObjects.gd")

func _ready() -> void:
	name = "MajesticPavilionPreview"
	_build_environment()
	_build_ground()
	_build_pavilion()
	_build_camera()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.18, 0.27, 0.23)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.61, 0.68, 0.57)
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.08
	sun.rotation_degrees = Vector3(-48.0, 26.0, 0.0)
	add_child(sun)

func _build_ground() -> void:
	var ground := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(18.0, 18.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.10, 0.17, 0.085)
	material.roughness = 0.98
	mesh.material = material
	ground.mesh = mesh
	add_child(ground)
	var route := MeshInstance3D.new()
	var route_mesh := BoxMesh.new()
	route_mesh.size = Vector3(2.1, 0.06, 7.4)
	var route_material := StandardMaterial3D.new()
	route_material.albedo_color = Color(0.25, 0.20, 0.12)
	route_material.roughness = 0.98
	route_mesh.material = route_material
	route.mesh = route_mesh
	route.position = Vector3(0.0, 0.03, 3.30)
	add_child(route)

func _build_pavilion() -> void:
	var library: CartographicLandmarkObjects = LANDMARK_LIBRARY.new()
	add_child(library)
	var pavilion: Node3D = library.create_majestic_pavilion_landmark()
	pavilion.name = "PavilhaoMajestic_QA"
	pavilion.position = Vector3(0.0, 0.12, 0.0)
	add_child(pavilion)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraPavilhaoMajesticQA"
	camera.position = Vector3(6.2, 3.45, 7.2)
	camera.fov = 52.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 1.15, 0.0), Vector3.UP)
	camera.make_current()

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var image := get_viewport().get_texture().get_image()
	var result := image.save_png(snapshot_path)
	print("[DEV5_MAJESTIC_QA] snapshot=%s result=%s" % [snapshot_path, result])
