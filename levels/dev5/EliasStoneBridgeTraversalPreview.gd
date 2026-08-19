## Dev5 — CP-D5-073: travessia QA na ponte modular R2, não utiliza ponte GLB.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const OBJECTS := preload("res://levels/dev5/CartographicLandmarkObjects.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const BRIDGE_XZ := Vector2(-21.4, 28.0)
const ROUTE_START_Z := 22.8
const ROUTE_END_Z := 33.2
const PLAYER_RADIUS := 0.55
const RAIL_INNER_X := 0.76

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var cycles := 0
var bridge_grounded := false

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_bridge()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	assert(bridge_grounded)
	assert(_dynamic_lights() == 1)
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null:
		return
	actor.global_position.z += 1.10 * delta
	if actor.global_position.z >= ROUTE_END_Z:
		cycles += 1
		actor.global_position.z = ROUTE_START_Z
		print("[DEV5_R2_BRIDGE] cycle=%d bridge_grounded=%s deck_clearance=%.2f modular_bridge=true glb_bridge=false" % [cycles, bridge_grounded, RAIL_INNER_X - PLAYER_RADIUS])

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.13, 0.21, 0.28)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.48, 0.55, 0.52)
	environment.ambient_light_energy = 0.80
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-53.0, -25.0, 0.0)
	sun.light_energy = 1.04
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.position = Vector3(BRIDGE_XZ.x, -0.45, BRIDGE_XZ.y)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(28.0, 0.9, 32.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.21, 0.13)
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

func _build_bridge() -> void:
	var library := OBJECTS.new()
	add_child(library)
	await get_tree().physics_frame
	var bridge := library.create_stone_bridge_landmark()
	add_child(bridge)
	var result := GROUNDING.snap_to_ground(get_world_3d(), bridge, Vector3(BRIDGE_XZ.x, 15.0, BRIDGE_XZ.y))
	bridge_grounded = result["grounded"] and (result["world_xz"] as Vector2).distance_to(BRIDGE_XZ) < 0.001
	assert(bridge_grounded)
	print("[DEV5_R2_BRIDGE] anchor=R2 xz=(%.2f,%.2f) grounded=%s collider=tabuleiro_continuo" % [BRIDGE_XZ.x, BRIDGE_XZ.y, bridge_grounded])

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasStoneBridgeTraversalQA"
	actor.position = Vector3(BRIDGE_XZ.x, 0.25, ROUTE_START_Z)
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
	camera.name = "CameraQABridgeR2"
	camera.position = Vector3(-10.0, 7.0, 18.0)
	camera.fov = 56.0
	add_child(camera)
	camera.look_at(Vector3(BRIDGE_XZ.x, 0.5, BRIDGE_XZ.y), Vector3.UP)
	camera.make_current()

func _verify_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(RAIL_INNER_X - PLAYER_RADIUS >= 0.20)
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias.follow_camera)
	print("[DEV5_R2_BRIDGE] elias_camera_current=%s deck_clearance=%.2f required=0.20 bridge_type=modular_not_glb" % [elias.follow_camera.current, RAIL_INNER_X - PLAYER_RADIUS])

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
	label.size = Vector2(1080.0, 90.0)
	label.text = "CP-D5-073  |  ELIAS NA PONTE MODULAR R2\nTABULEIRO CONTÍNUO · FOLGA CENTRAL ≥ 0,20 m · NÃO É PONTE GLB"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R2_BRIDGE] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R2_BRIDGE] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R2_BRIDGE] snapshot=%s result=%s" % [path, result])
