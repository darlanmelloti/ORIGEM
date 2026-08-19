## Dev5 — CP-D5-043: Elias em terceira pessoa junto ao Pavilhão Majestic R5.

extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const OBJECTS := preload("res://levels/dev5/CartographicLandmarkObjects.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const ROUTE_X := -80.0
const ROUTE_START_Z := 163.0
const ROUTE_END_Z := 198.0
const PAVILION_HALF_WIDTH := 2.0
const ELIAS_RADIUS := 0.55
const MIN_REQUIRED_CLEARANCE := 4.0

var elias_actor: CharacterBody3D
var elias_presentation: EliasThirdPersonPresentation
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_pavilion_collision()
	_build_elias_actor()
	_build_camera()
	await get_tree().process_frame
	_verify_camera_contract()
	_build_overlay()
	var clearance := abs(ROUTE_X - -88.0) - PAVILION_HALF_WIDTH - ELIAS_RADIUS
	assert(clearance >= MIN_REQUIRED_CLEARANCE)
	print("[DEV5_ELIAS_MAJESTIC] route_x=%.2f pavilion_x=-88.00 clearance=%.2f required=%.2f presentation=EliasThirdPersonPresentation" % [ROUTE_X, clearance, MIN_REQUIRED_CLEARANCE])
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
		print("[DEV5_ELIAS_MAJESTIC] route_cycle=%d clear=true actor=Elias" % route_cycles)

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.15, 0.24, 0.29)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.44, 0.56, 0.54)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50.0, -28.0, 0.0)
	sun.light_energy = 1.08
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.name = "CorredorMajesticEliasQA"
	ground.position = Vector3(-84.0, -0.45, 180.0)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(34.0, 0.9, 48.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.20, 0.12)
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

func _build_pavilion_collision() -> void:
	var library := OBJECTS.new()
	add_child(library)
	var record := PLACEMENT.placement_record("pavilhao_majestic_elias_clearance", 5, Vector2.ZERO, 17.0)
	var pavilion := library.create_majestic_pavilion_landmark()
	add_child(pavilion)
	var result := GROUNDING.snap_to_ground(get_world_3d(), pavilion, record["world_position"] as Vector3)
	assert(result["grounded"])
	var blocker := StaticBody3D.new()
	blocker.name = "ColisorPavilhaoMajesticEliasQA"
	blocker.position = pavilion.global_position + Vector3(0.0, 1.4, 0.0)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(PAVILION_HALF_WIDTH * 2.0, 2.8, PAVILION_HALF_WIDTH * 2.0)
	collision.shape = shape
	blocker.add_child(collision)
	add_child(blocker)
	print("[DEV5_ELIAS_MAJESTIC] pavilion_grounded=%s xz=(%.2f,%.2f) collider=%s" % [result["grounded"], pavilion.global_position.x, pavilion.global_position.z, result.get("collider", "none")])

func _build_elias_actor() -> void:
	elias_actor = CharacterBody3D.new()
	elias_actor.name = "EliasMajesticActorQA"
	elias_actor.position = Vector3(ROUTE_X, 0.0, ROUTE_START_Z)
	add_child(elias_actor)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = ELIAS_RADIUS
	shape.height = 1.90
	collision.shape = shape
	collision.position.y = 0.95
	elias_actor.add_child(collision)
	elias_presentation = ELIAS_PRESENTATION.new()
	elias_presentation.name = "EliasThirdPersonMajesticQA"
	elias_presentation.enabled_for_preview = true
	elias_actor.add_child(elias_presentation)

func _verify_camera_contract() -> void:
	assert(elias_presentation != null and elias_presentation.follow_camera != null)
	elias_presentation.follow_camera.current = false
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias_presentation.follow_camera)
	print("[DEV5_ELIAS_CAMERA_AUDIT] harness=EliasMajesticClearancePreview elias_camera_current=%s viewport_owner=%s" % [elias_presentation.follow_camera.current, viewport_camera.name])

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(-68.0, 7.4, 165.0)
	camera.fov = 48.0
	add_child(camera)
	camera.look_at(Vector3(-84.0, 1.2, 180.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 48.0)
	label.size = Vector2(970.0, 92.0)
	label.text = "CP-D5-043  |  ELIAS · PAVILHÃO MAJESTIC R5\nFOLGA 5,45 m · CORREDOR X=-80 · SEM ALTERAR PRODUÇÃO"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.88, 0.94, 0.96)
	layer.add_child(label)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_ELIAS_MAJESTIC] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_ELIAS_MAJESTIC] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := image.save_png(snapshot_path)
	print("[DEV5_ELIAS_MAJESTIC] snapshot=%s result=%s" % [snapshot_path, result])
