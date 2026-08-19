## Dev5 — Comparação QA: ponte GLB leve de 252 triângulos no marco 2.
## Não é carregada pelo mundo principal.

extends Node3D

const PLACEMENT: Script = preload("res://levels/dev5/CartographicPlacementSystem.gd")
const BRIDGE_SCENE: PackedScene = preload("res://assets/models_cc0/bridge_stone.glb")

func _ready() -> void:
	_build_environment()
	_build_water_and_banks()
	_build_glb_bridge()
	_build_camera()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.17, 0.25, 0.33)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.58, 0.66, 0.70)
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.35
	sun.rotation_degrees = Vector3(-48.0, -32.0, 0.0)
	add_child(sun)

func _build_water_and_banks() -> void:
	var water := MeshInstance3D.new()
	var water_mesh := PlaneMesh.new()
	water_mesh.size = Vector2(18.0, 18.0)
	var water_material := StandardMaterial3D.new()
	water_material.albedo_color = Color(0.045, 0.20, 0.27)
	water_material.roughness = 0.42
	water_mesh.material = water_material
	water.mesh = water_mesh
	water.position.y = -0.56
	add_child(water)
	for side: float in [-1.0, 1.0]:
		var bank := MeshInstance3D.new()
		var bank_mesh := BoxMesh.new()
		bank_mesh.size = Vector3(9.6, 0.58, 3.5)
		var bank_material := StandardMaterial3D.new()
		bank_material.albedo_color = Color(0.11, 0.16, 0.09)
		bank_material.roughness = 0.96
		bank_mesh.material = bank_material
		bank.mesh = bank_mesh
		bank.position = Vector3(0.0, -0.32, side * 2.65)
		add_child(bank)

func _build_glb_bridge() -> void:
	var record: Dictionary = PLACEMENT.placement_record("bridge_glb_qa", 2, Vector2(0.0, 16.0), 0.0)
	assert(PLACEMENT.assert_anchor_distance(record))
	var bridge := BRIDGE_SCENE.instantiate()
	bridge.name = "PonteGLBMarco2_QA"
	bridge.scale = Vector3(2.1, 2.1, 2.1)
	bridge.rotation_degrees.y = 90.0
	bridge.position = Vector3(0.0, 0.02, 0.0)
	add_child(bridge)
	var body := StaticBody3D.new()
	body.name = "ColisaoTabuleiroPonteGLB"
	var shape := CollisionShape3D.new()
	var box := BoxShape3D.new()
	box.size = Vector3(7.8, 0.48, 2.0)
	shape.shape = box
	shape.position = Vector3(0.0, 1.0, 0.0)
	body.add_child(shape)
	add_child(body)
	print("[DEV5_BRIDGE_GLB_QA] anchor=2 world_xz=%s offset=%s triangles=252 collision=tabuleiro_continuo" % [record["world_xz"], record["local_offset_xz"]])

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(6.2, 4.3, 7.0)
	camera.fov = 54.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 0.35, 0.0), Vector3.UP)
	camera.make_current()

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_BRIDGE_GLB] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_BRIDGE_GLB] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := image.save_png(snapshot_path)
	print("[DEV5_BRIDGE_GLB_QA] snapshot=%s result=%s" % [snapshot_path, result])
