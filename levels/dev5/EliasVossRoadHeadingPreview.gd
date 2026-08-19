## Dev5 — CP-D5-060: rumo QA Casa Voss→Estrada do Rio, sem alterar módulos de produção.
extends Node3D

const ANCHORS := preload("res://levels/CartographicAnchors.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const OBJECTS := preload("res://levels/dev5/CartographicLandmarkObjects.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const VOSS_XZ := Vector2(-22.0, 8.0)
const ROAD_XZ := Vector2(-21.4, 12.0)
const BRIDGE_XZ := Vector2(-21.4, 28.0)
const ROUTE_X := -18.0
const ROUTE_START_Z := 8.0
const ROUTE_END_Z := 13.0

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var route_cycles := 0
var grounded_count := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_landmarks()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	assert(grounded_count == 2)
	assert(_dynamic_lights() == 1)
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null:
		return
	var motion := Vector3(0.0, 0.0, 1.25 * delta)
	assert(not actor.test_move(actor.global_transform, motion))
	actor.global_position += motion
	if actor.global_position.z >= ROUTE_END_Z:
		var destination := ANCHORS.next_dev1_destination(Vector2(actor.global_position.x, actor.global_position.z))
		assert((destination["anchor_id"] as int) == 2)
		route_cycles += 1
		actor.global_position.z = ROUTE_START_Z
		print("[DEV5_R1R2_HEADING] route_cycle=%d destination=%s id=%d" % [route_cycles, destination["label"], destination["anchor_id"]])

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.14, 0.21, 0.27)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.52, 0.56, 0.52)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-54.0, 28.0, 0.0)
	sun.light_energy = 1.06
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.position = Vector3(-20.0, -0.45, 18.0)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(36.0, 0.9, 54.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.21, 0.14)
	material.roughness = 0.97
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	ground.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	ground.add_child(collision)

func _build_landmarks() -> void:
	var library := OBJECTS.new()
	add_child(library)
	await get_tree().physics_frame
	var voss := library.create_voss_waystation_landmark()
	add_child(voss)
	var voss_result := GROUNDING.snap_to_ground(get_world_3d(), voss, Vector3(VOSS_XZ.x, 15.0, VOSS_XZ.y))
	assert(voss_result["grounded"] and (voss_result["world_xz"] as Vector2).distance_to(VOSS_XZ) < 0.001)
	grounded_count += 1
	var bridge := library.create_stone_bridge_landmark()
	add_child(bridge)
	var bridge_result := GROUNDING.snap_to_ground(get_world_3d(), bridge, Vector3(BRIDGE_XZ.x, 15.0, BRIDGE_XZ.y))
	assert(bridge_result["grounded"] and (bridge_result["world_xz"] as Vector2).distance_to(BRIDGE_XZ) < 0.001)
	grounded_count += 1
	print("[DEV5_R1R2_HEADING] voss_xz=(%.2f,%.2f) road_anchor=(%.2f,%.2f) bridge_xz=(%.2f,%.2f)" % [VOSS_XZ.x, VOSS_XZ.y, ROAD_XZ.x, ROAD_XZ.y, BRIDGE_XZ.x, BRIDGE_XZ.y])

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasVossRoadHeadingQA"
	actor.position = Vector3(ROUTE_X, 0.0, ROUTE_START_Z)
	add_child(actor)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.55
	shape.height = 1.90
	collision.shape = shape
	collision.position.y = 0.95
	actor.add_child(collision)
	elias = ELIAS_PRESENTATION.new()
	elias.enabled_for_preview = true
	actor.add_child(elias)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQAVossRoadHeading"
	camera.position = Vector3(-4.0, 13.0, -8.0)
	camera.fov = 56.0
	add_child(camera)
	camera.look_at(Vector3(-21.0, 1.0, 18.0), Vector3.UP)
	camera.make_current()

func _verify_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	var start_destination := ANCHORS.next_dev1_destination(Vector2(ROUTE_X, ROUTE_START_Z))
	assert((start_destination["anchor_id"] as int) == 2)
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias.follow_camera)
	print("[DEV5_R1R2_HEADING] start=(%.2f,%.2f) destination=%s id=%d elias_camera_current=%s" % [ROUTE_X, ROUTE_START_Z, start_destination["label"], start_destination["anchor_id"], elias.follow_camera.current])

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
	label.size = Vector2(1050.0, 88.0)
	label.text = "CP-D5-060  |  RUMO DE ELIAS: CASA VOSS → ESTRADA DO RIO\nR1=(-22,8) · R2=(-21,4,12) · PONTE MODULAR APROVADA · MAPA É A AUTORIDADE"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R1R2_HEADING] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R1R2_HEADING] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R1R2_HEADING] snapshot=%s result=%s" % [path, result])
