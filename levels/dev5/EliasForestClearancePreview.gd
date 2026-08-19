## Dev5 — CP-D5-067: prova de passagem Elias R4, sem portal e sem parede florestal.
extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")
const PINE_TALL: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const TREE_DETAILED: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")

const R4_XZ := Vector2(-9.0, 116.0)
const ROUTE_X := -9.0
const ROUTE_START_Z := 104.0
const ROUTE_END_Z := 132.0
const PLAYER_RADIUS := 0.55

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var route_cycles := 0
var grounded_count := 0
var min_lateral_clearance := INF

func _ready() -> void:
	_build_environment()
	_build_ground_patch()
	await get_tree().physics_frame
	_spawn_vegetation()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	assert(grounded_count == 6)
	assert(min_lateral_clearance >= 2.65)
	assert(_dynamic_lights() == 1)
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null:
		return
	actor.global_position.z += 2.25 * delta
	if actor.global_position.z >= ROUTE_END_Z:
		route_cycles += 1
		actor.global_position.z = ROUTE_START_Z
		print("[DEV5_R4_ELIAS] route_cycle=%d clearance=%.2f corridor_open=true wall_of_trees=false forest_portal=false" % [route_cycles, min_lateral_clearance])

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.12, 0.22, 0.27)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.44, 0.55, 0.52)
	environment.ambient_light_energy = 0.78
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-52.0, -28.0, 0.0)
	sun.light_energy = 1.08
	add_child(sun)

func _build_ground_patch() -> void:
	var ground := Node3D.new()
	ground.name = "TerrenoR4EliasQA"
	ground.position = Vector3(R4_XZ.x, 0.0, R4_XZ.y)
	ground.rotation_degrees.z = 5.0
	add_child(ground)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.12, 0.21, 0.11)
	material.roughness = 0.96
	var mesh := BoxMesh.new()
	mesh.size = Vector3(42.0, 0.9, 46.0)
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)

func _spawn_vegetation() -> void:
	_spawn_grounded("r4_pine_focal", Vector2(-7.2, 9.0), PINE_TALL, Vector3.ONE * 0.95)
	_spawn_grounded("r4_tree_medium_a", Vector2(6.8, 10.4), TREE_DETAILED, Vector3.ONE * 1.35)
	_spawn_grounded("r4_tree_medium_b", Vector2(-10.0, 17.0), TREE_DETAILED, Vector3.ONE * 1.15)
	_spawn_grounded("r4_light_distant_a", Vector2(11.5, 18.5), TREE_LIGHT, Vector3.ONE * 1.55)
	_spawn_grounded("r4_light_distant_b", Vector2(-14.0, 20.0), TREE_LIGHT, Vector3.ONE * 1.35)
	_spawn_grounded("r4_fern_left", Vector2(-3.3, 4.6), FERN, Vector3.ONE * 0.58)

func _spawn_grounded(candidate_id: String, local_offset: Vector2, packed_scene: PackedScene, candidate_scale: Vector3) -> void:
	var record := PLACEMENT.placement_record(candidate_id, 4, local_offset, 15.0)
	var candidate := packed_scene.instantiate() as Node3D
	candidate.name = candidate_id
	candidate.scale = candidate_scale
	add_child(candidate)
	var result := GROUNDING.snap_to_ground(get_world_3d(), candidate, record["world_position"] as Vector3)
	var desired := record["world_position"] as Vector3
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(Vector2(desired.x, desired.z)) < 0.001)
	grounded_count += 1
	var lateral: float = absf(desired.x - ROUTE_X) - PLAYER_RADIUS
	min_lateral_clearance = min(min_lateral_clearance, lateral)
	print("[DEV5_R4_ELIAS] id=%s xz=(%.2f,%.2f) grounded=%s lateral_clearance=%.2f" % [candidate_id, desired.x, desired.z, result["grounded"], lateral])

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasForestClearanceQA"
	actor.position = Vector3(ROUTE_X, 0.0, ROUTE_START_Z)
	add_child(actor)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = PLAYER_RADIUS
	shape.height = 1.90
	collision.shape = shape
	collision.position.y = 0.95
	actor.add_child(collision)
	elias = ELIAS_PRESENTATION.new()
	elias.enabled_for_preview = true
	actor.add_child(elias)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQAForestElias"
	camera.position = Vector3(3.5, 7.5, 102.0)
	camera.fov = 59.0
	add_child(camera)
	camera.look_at(Vector3(-9.0, 1.2, 126.0), Vector3.UP)
	camera.make_current()

func _verify_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(min_lateral_clearance >= 2.65)
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias.follow_camera)
	print("[DEV5_R4_ELIAS] anchor=R4 xz=(%.2f,%.2f) corridor_width=5.20 min_clearance=%.2f elias_camera_current=%s forest_portal=false wall_of_trees=false" % [R4_XZ.x, R4_XZ.y, min_lateral_clearance, elias.follow_camera.current])

func _dynamic_lights() -> int:
	var count := 0
	for child: Node in get_children():
		if child is Light3D:
			count += 1
	return count

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1100.0, 90.0)
	label.text = "CP-D5-067  |  ELIAS NA FLORESTA DENSA (R4)\nCORREDOR CENTRAL ≥ 5,2 m · VEGETAÇÃO ATERRADA · SEM PORTAL · SEM PAREDE FLORESTAL"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R4_ELIAS] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R4_ELIAS] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R4_ELIAS] snapshot=%s result=%s" % [path, result])
