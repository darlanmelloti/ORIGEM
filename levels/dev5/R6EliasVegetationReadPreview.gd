## Dev5 — CP-D5-053: leitura QA R6 sem cais de lajes nem alterações de produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const MONOLITH: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")

const MONOLITH_XZ := Vector2(52.0, 260.0)
const ROUTE_X := 60.0
const ROUTE_START_Z := 242.0
const ROUTE_END_Z := 278.0
const MONOLITH_RADIUS := 1.40
const ELIAS_RADIUS := 0.55
const MIN_CLEARANCE := 4.0

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var route_cycles := 0
var grounded_count := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_monolith()
	_build_vegetation()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_camera_contract()
	_build_overlay()
	var clearance := abs(ROUTE_X - MONOLITH_XZ.x) - MONOLITH_RADIUS - ELIAS_RADIUS
	assert(clearance >= MIN_CLEARANCE)
	assert(grounded_count == 4)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R6_READ] status=approved monolith_xz=(%.2f,%.2f) route_x=%.2f clearance=%.2f vegetation=3 pier_slabs=0 wall_of_trees=false" % [MONOLITH_XZ.x, MONOLITH_XZ.y, ROUTE_X, clearance])
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null:
		return
	var motion := Vector3(0.0, 0.0, 2.3 * delta)
	assert(not actor.test_move(actor.global_transform, motion))
	actor.global_position += motion
	if actor.global_position.z >= ROUTE_END_Z:
		route_cycles += 1
		actor.global_position.z = ROUTE_START_Z
		print("[DEV5_R6_READ] route_cycle=%d clear=true actor=Elias" % route_cycles)

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.13, 0.22, 0.28)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.40, 0.51, 0.55)
	environment.ambient_light_energy = 0.80
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50.0, 36.0, 0.0)
	sun.light_energy = 1.08
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.name = "MargemR6LeituraQA"
	ground.position = Vector3(60.0, -0.45, 260.0)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(42.0, 0.9, 48.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.20, 0.16)
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

func _build_monolith() -> void:
	var root := Node3D.new()
	root.name = "BalizaMonoliticaR6LeituraQA"
	var monolith := MONOLITH.instantiate() as Node3D
	monolith.position = Vector3(0.0, 0.82, 0.0)
	monolith.rotation_degrees = Vector3(0.0, 14.0, -4.0)
	monolith.scale = Vector3.ONE * 1.62
	root.add_child(monolith)
	_apply_ruin_material(root)
	add_child(root)
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, Vector3(MONOLITH_XZ.x, 18.0, MONOLITH_XZ.y))
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(MONOLITH_XZ) < 0.001)
	var blocker := StaticBody3D.new()
	blocker.name = "ColisorBalizaR6LeituraQA"
	blocker.position = root.global_position + Vector3(0.0, 1.65, 0.0)
	var collision := CollisionShape3D.new()
	var shape := CylinderShape3D.new()
	shape.radius = MONOLITH_RADIUS
	shape.height = 3.3
	collision.shape = shape
	blocker.add_child(collision)
	add_child(blocker)
	grounded_count += 1
	print("[DEV5_R6_READ] monolith_grounded=%s xz=(%.2f,%.2f)" % [result["grounded"], root.global_position.x, root.global_position.z])

func _build_vegetation() -> void:
	# Um elemento leve distante e um feto por lado; todos fora do corredor central X=60.
	_spawn_grounded("tree_light_right", Vector3(73.0, 18.0, 271.0), TREE_LIGHT, Vector3.ONE * 1.30)
	_spawn_grounded("fern_left", Vector3(53.5, 18.0, 250.0), FERN, Vector3.ONE * 0.55)
	_spawn_grounded("fern_right", Vector3(68.0, 18.0, 267.0), FERN, Vector3.ONE * 0.54)

func _spawn_grounded(candidate_id: String, target: Vector3, packed: PackedScene, candidate_scale: Vector3) -> void:
	var candidate := packed.instantiate() as Node3D
	candidate.name = candidate_id
	candidate.scale = candidate_scale
	add_child(candidate)
	var result := GROUNDING.snap_to_ground(get_world_3d(), candidate, target)
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(Vector2(target.x, target.z)) < 0.001)
	grounded_count += 1
	print("[DEV5_R6_READ] grounded=%s xz=(%.2f,%.2f) y=%.2f" % [candidate_id, target.x, target.z, result["impact_y"]])

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasR6LeituraQA"
	actor.position = Vector3(ROUTE_X, 0.0, ROUTE_START_Z)
	add_child(actor)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = ELIAS_RADIUS
	shape.height = 1.90
	collision.shape = shape
	collision.position.y = 0.95
	actor.add_child(collision)
	elias = ELIAS_PRESENTATION.new()
	elias.camera_distance = 3.8
	elias.enabled_for_preview = true
	actor.add_child(elias)

func _apply_ruin_material(node: Node) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.34, 0.37, 0.35)
	material.roughness = 0.89
	for child: Node in node.get_children():
		if child is MeshInstance3D:
			child.material_override = material
		_apply_ruin_material(child)

func _verify_camera_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias.follow_camera)
	print("[DEV5_R6_READ] elias_camera_current=%s viewport_owner=%s production_modules_changed=false" % [elias.follow_camera.current, viewport_camera.name])

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQAR6Leitura"
	camera.position = Vector3(75.0, 8.0, 246.0)
	camera.fov = 49.0
	add_child(camera)
	camera.look_at(Vector3(57.0, 1.4, 261.0), Vector3.UP)
	camera.make_current()

func _dynamic_lights() -> int:
	var count := 0
	for node: Node in get_children():
		if node is Light3D:
			count += 1
	return count

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1080.0, 88.0)
	label.text = "CP-D5-053  |  LEITURA R6: ELIAS · BALIZA · VEGETAÇÃO RIBEIRINHA\nCORREDOR X=60 · FOLGA ≥4,00 M · 3 ELEMENTOS ATERRADOS · ZERO LAJES DE CAIS"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R6_READ] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R6_READ] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R6_READ] snapshot=%s result=%s" % [path, result])
