## Dev5 — CP-D5-040: prova de passagem R6 junto à baliza, sem alteração de produção.

extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const MONOLITH: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")

const ROUTE_X := 60.0
const ROUTE_START_Z := 242.0
const ROUTE_END_Z := 278.0
const MONOLITH_RADIUS := 1.40
const PLAYER_RADIUS := 0.55
const MIN_REQUIRED_CLEARANCE := 4.0

var player_proxy: CharacterBody3D
var route_cycles := 0
var minimum_clearance := INF

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_monolith_with_collision()
	_build_route_proxy()
	_build_camera()
	_build_overlay()
	var computed_clearance := abs(ROUTE_X - 52.0) - MONOLITH_RADIUS - PLAYER_RADIUS
	assert(computed_clearance >= MIN_REQUIRED_CLEARANCE)
	minimum_clearance = computed_clearance
	print("[DEV5_R6_CLEARANCE] route_x=%.2f monolith_x=52.00 monolith_radius=%.2f player_radius=%.2f clearance=%.2f required=%.2f" % [ROUTE_X, MONOLITH_RADIUS, PLAYER_RADIUS, computed_clearance, MIN_REQUIRED_CLEARANCE])
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if player_proxy == null:
		return
	var motion := Vector3(0.0, 0.0, 2.3 * delta)
	var blocked := player_proxy.test_move(player_proxy.global_transform, motion)
	assert(not blocked)
	player_proxy.global_position += motion
	if player_proxy.global_position.z >= ROUTE_END_Z:
		route_cycles += 1
		player_proxy.global_position.z = ROUTE_START_Z
		print("[DEV5_R6_CLEARANCE] route_cycle=%d clear=true min_clearance=%.2f" % [route_cycles, minimum_clearance])

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.14, 0.22, 0.28)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.40, 0.51, 0.55)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50.0, 36.0, 0.0)
	sun.light_energy = 1.1
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.name = "CorredorMargemR6QA"
	ground.position = Vector3(60.0, -0.45, 260.0)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(38.0, 0.9, 48.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.16, 0.20, 0.17)
	material.roughness = 0.96
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	ground.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	ground.add_child(collision)

func _build_monolith_with_collision() -> void:
	var record := PLACEMENT.placement_record("baliza_monolitica_r6_clearance", 6, Vector2(-8.0, 8.0), 18.0)
	var root := Node3D.new()
	root.name = "BalizaR6ComColisorQA"
	var monolith := MONOLITH.instantiate() as Node3D
	monolith.position = Vector3(0.0, 0.82, 0.0)
	monolith.rotation_degrees = Vector3(0.0, 14.0, -4.0)
	monolith.scale = Vector3.ONE * 1.62
	root.add_child(monolith)
	_apply_ruin_material(root)
	add_child(root)
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, record["world_position"] as Vector3)
	assert(result["grounded"])
	var blocker := StaticBody3D.new()
	blocker.name = "ColisorBalizaQA"
	blocker.position = root.global_position + Vector3(0.0, 1.65, 0.0)
	var collision := CollisionShape3D.new()
	var shape := CylinderShape3D.new()
	shape.radius = MONOLITH_RADIUS
	shape.height = 3.3
	collision.shape = shape
	blocker.add_child(collision)
	add_child(blocker)
	print("[DEV5_R6_CLEARANCE] monolith_grounded=%s xz=(%.2f,%.2f) collider=%s" % [result["grounded"], root.global_position.x, root.global_position.z, result.get("collider", "none")])

func _build_route_proxy() -> void:
	player_proxy = CharacterBody3D.new()
	player_proxy.name = "ProxyPercursoCentralQA"
	player_proxy.position = Vector3(ROUTE_X, 1.35, ROUTE_START_Z)
	add_child(player_proxy)
	var capsule := CapsuleMesh.new()
	capsule.radius = PLAYER_RADIUS
	capsule.height = 1.9
	var capsule_material := StandardMaterial3D.new()
	capsule_material.albedo_color = Color(0.62, 0.78, 0.92)
	capsule_material.roughness = 0.7
	capsule.material = capsule_material
	var visual := MeshInstance3D.new()
	visual.mesh = capsule
	player_proxy.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = PLAYER_RADIUS
	shape.height = 1.9
	collision.shape = shape
	player_proxy.add_child(collision)

func _apply_ruin_material(node: Node) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.34, 0.37, 0.35)
	material.roughness = 0.89
	for child: Node in node.get_children():
		if child is MeshInstance3D:
			child.material_override = material
		_apply_ruin_material(child)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(74.0, 10.0, 242.0)
	camera.fov = 49.0
	add_child(camera)
	camera.look_at(Vector3(56.0, 1.2, 260.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 48.0)
	label.size = Vector2(970.0, 92.0)
	label.text = "CP-D5-040  |  PASSAGEM R6 JUNTO À BALIZA\nCORREDOR X=60 · FOLGA 6,05 m · MÍNIMO EXIGIDO 4,00 m"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.88, 0.94, 0.96)
	layer.add_child(label)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var viewport_texture: Texture2D = get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R6_CLEARANCE] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var image: Image = viewport_texture.get_image()
	if image == null:
		print("[DEV5_R6_CLEARANCE] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := image.save_png(snapshot_path)
	print("[DEV5_R6_CLEARANCE] snapshot=%s result=%s" % [snapshot_path, result])
