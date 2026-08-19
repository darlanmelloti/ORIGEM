## Dev5 — Cena QA isolada da Ponte de Pedra do marco 2.
## Não é carregada pelo mundo principal; valida somente leitura, materiais e colisores da ponte modular.

extends Node3D

const LANDMARK_LIBRARY: Script = preload("res://levels/dev5/CartographicLandmarkObjects.gd")

func _ready() -> void:
	name = "StoneBridgeLandmarkPreview"
	_build_environment()
	_build_water_test_bed()
	_build_bridge()
	_build_camera()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.19, 0.27, 0.35)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.58, 0.66, 0.70)
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.35
	sun.rotation_degrees = Vector3(-48.0, -32.0, 0.0)
	add_child(sun)

func _build_water_test_bed() -> void:
	var water := MeshInstance3D.new()
	water.name = "AguaQA"
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(18.0, 18.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.045, 0.20, 0.27)
	material.metallic = 0.12
	material.roughness = 0.42
	mesh.material = material
	water.mesh = mesh
	water.position.y = -0.56
	add_child(water)
	for side: float in [-1.0, 1.0]:
		var bank := MeshInstance3D.new()
		var bank_mesh := BoxMesh.new()
		bank_mesh.size = Vector3(3.5, 0.58, 9.6)
		var bank_material := StandardMaterial3D.new()
		bank_material.albedo_color = Color(0.11, 0.16, 0.09)
		bank_material.roughness = 0.96
		bank_mesh.material = bank_material
		bank.mesh = bank_mesh
		bank.position = Vector3(side * 2.65, -0.32, 0.0)
		add_child(bank)

func _build_bridge() -> void:
	var library: CartographicLandmarkObjects = LANDMARK_LIBRARY.new()
	add_child(library)
	var bridge: Node3D = library.create_stone_bridge_landmark()
	bridge.name = "PonteMarco2_QA"
	bridge.rotation_degrees.y = 90.0
	bridge.position = Vector3(0.0, 0.18, 0.0)
	add_child(bridge)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraPonteQA"
	camera.position = Vector3(5.8, 4.1, 6.5)
	camera.fov = 54.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 0.0, 0.0), Vector3.UP)
	camera.make_current()

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var viewport_texture: Texture2D = get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_BRIDGE_QA] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var image: Image = viewport_texture.get_image()
	if image == null:
		print("[DEV5_BRIDGE_QA] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := image.save_png(snapshot_path)
	print("[DEV5_BRIDGE_QA] snapshot=%s result=%s" % [snapshot_path, result])
