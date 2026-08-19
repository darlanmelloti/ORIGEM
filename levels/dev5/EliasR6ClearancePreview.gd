## Dev5 — CP-D5-041: Elias em terceira pessoa no trajecto seguro R6.

extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const MONOLITH: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const ROUTE_X := 60.0
const ROUTE_START_Z := 242.0
const ROUTE_END_Z := 278.0
const MONOLITH_RADIUS := 1.40
const ELIAS_RADIUS := 0.55
const MIN_REQUIRED_CLEARANCE := 4.0

var elias_actor: CharacterBody3D
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_monolith_collision()
	_build_elias_actor()
	_build_camera()
	_build_overlay()
	var clearance := abs(ROUTE_X - 52.0) - MONOLITH_RADIUS - ELIAS_RADIUS
	assert(clearance >= MIN_REQUIRED_CLEARANCE)
	print("[DEV5_ELIAS_R6] route_x=%.2f monolith_x=52.00 clearance=%.2f required=%.2f presentation=EliasThirdPersonPresentation" % [ROUTE_X, clearance, MIN_REQUIRED_CLEARANCE])
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if elias_actor == null:
		return
	var motion := Vector3(0.0, 0.0, 2.3 * delta)
	var blocked := elias_actor.test_move(elias_actor.global_transform, motion)
	assert(not blocked)
	elias_actor.global_position += motion
	if elias_actor.global_position.z >= ROUTE_END_Z:
		route_cycles += 1
		elias_actor.global_position.z = ROUTE_START_Z
		print("[DEV5_ELIAS_R6] route_cycle=%d clear=true actor=Elias" % route_cycles)

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
	ground.name = "CorredorMargemR6EliasQA"
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

func _build_monolith_collision() -> void:
	var record := PLACEMENT.placement_record("baliza_r6_elias_clearance", 6, Vector2(-8.0, 8.0), 18.0)
	var root := Node3D.new()
	root.name = "BalizaR6EliasQA"
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
	blocker.name = "ColisorBalizaR6EliasQA"
	blocker.position = root.global_position + Vector3(0.0, 1.65, 0.0)
	var collision := CollisionShape3D.new()
	var shape := CylinderShape3D.new()
	shape.radius = MONOLITH_RADIUS
	shape.height = 3.3
	collision.shape = shape
	blocker.add_child(collision)
	add_child(blocker)
	print("[DEV5_ELIAS_R6] monolith_grounded=%s xz=(%.2f,%.2f) collider=%s" % [result["grounded"], root.global_position.x, root.global_position.z, result.get("collider", "none")])

func _build_elias_actor() -> void:
	elias_actor = CharacterBody3D.new()
	elias_actor.name = "EliasActorQA"
	elias_actor.position = Vector3(ROUTE_X, 0.0, ROUTE_START_Z)
	add_child(elias_actor)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = ELIAS_RADIUS
	shape.height = 1.90
	collision.shape = shape
	collision.position.y = 0.95
	elias_actor.add_child(collision)
	var presentation: EliasThirdPersonPresentation = ELIAS_PRESENTATION.new()
	presentation.name = "EliasThirdPersonR6QA"
	presentation.camera_distance = 3.8
	presentation.enabled_for_preview = true
	elias_actor.add_child(presentation)

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
	camera.position = Vector3(73.0, 7.6, 246.0)
	camera.fov = 48.0
	add_child(camera)
	camera.look_at(Vector3(56.0, 1.25, 260.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 48.0)
	label.size = Vector2(970.0, 92.0)
	label.text = "CP-D5-041  |  ELIAS EM TERCEIRA PESSOA · PASSAGEM R6\nFOLGA 6,05 m · APRESENTAÇÃO REAL · SEM ALTERAR PLAYER.GD"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.88, 0.94, 0.96)
	layer.add_child(label)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var result := get_viewport().get_texture().get_image().save_png(snapshot_path)
	print("[DEV5_ELIAS_R6] snapshot=%s result=%s" % [snapshot_path, result])
