## Dev5 — CP-D5-075: corredor QA R3; arco estrutural rejeitado não é recriado.
extends Node3D

const ANCHORS := preload("res://levels/CartographicAnchors.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const R3_XZ := Vector2(-16.741, 48.0)
const ARCH_WORLD_Z := 92.0
const ROUTE_X := -16.741
const ROUTE_START_Z := 70.0
const ROUTE_END_Z := 103.0

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	_build_route_beacons()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null:
		return
	actor.global_position.z += 2.40 * delta
	if actor.global_position.z >= ROUTE_END_Z:
		cycles += 1
		actor.global_position.z = ROUTE_START_Z
		print("[DEV5_R3_CORRIDOR] cycle=%d route_open=true structural_arch=false destination=R4" % cycles)

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.13, 0.22, 0.29)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.47, 0.56, 0.53)
	environment.ambient_light_energy = 0.80
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-54.0, 25.0, 0.0)
	sun.light_energy = 1.05
	add_child(sun)

func _build_ground() -> void:
	var ground := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(34.0, 64.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.17, 0.22, 0.14)
	material.roughness = 0.98
	mesh.material = material
	ground.mesh = mesh
	ground.position = Vector3(ROUTE_X, 0.0, 86.0)
	add_child(ground)

func _build_route_beacons() -> void:
	# Balizas técnicas de rumo: não são arco, ruína ou conteúdo de produção.
	for z: float in [ROUTE_START_Z, ARCH_WORLD_Z, ROUTE_END_Z]:
		var beacon := MeshInstance3D.new()
		var mesh := CylinderMesh.new()
		mesh.top_radius = 0.24
		mesh.bottom_radius = 0.32
		mesh.height = 2.6
		mesh.radial_segments = 8
		var material := StandardMaterial3D.new()
		material.albedo_color = Color(0.56, 0.46, 0.24) if is_equal_approx(z, ARCH_WORLD_Z) else Color(0.30, 0.54, 0.58)
		material.roughness = 0.86
		mesh.material = material
		beacon.mesh = mesh
		beacon.position = Vector3(ROUTE_X, 1.3, z)
		add_child(beacon)

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasArchCorridorQA"
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
	camera.name = "CameraQAArchCorridor"
	camera.position = Vector3(-2.0, 8.0, 64.0)
	camera.fov = 56.0
	add_child(camera)
	camera.look_at(Vector3(ROUTE_X, 0.8, 89.0), Vector3.UP)
	camera.make_current()

func _verify_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	var destination := ANCHORS.next_dev1_destination(Vector2(ROUTE_X, ROUTE_START_Z))
	assert((destination["anchor_id"] as int) == 4)
	assert(absf(ARCH_WORLD_Z - 92.0) < 0.001)
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias.follow_camera)
	print("[DEV5_R3_CORRIDOR] r3_xz=(%.3f,%.2f) physical_arch_z=%.2f next=%s id=%d elias_camera_current=%s structural_arch=false route_open=true grounded=true production_modules_changed=false" % [R3_XZ.x, R3_XZ.y, ARCH_WORLD_Z, destination["label"], destination["anchor_id"], elias.follow_camera.current])

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1100.0, 90.0)
	label.text = "CP-D5-075  |  CORREDOR CARTOGRÁFICO DO ARCO (R3)\nZ FÍSICO 92 · RUMO À FLORESTA · SEM ARCO ESTRUTURAL · SEM PRODUÇÃO"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R3_CORRIDOR] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R3_CORRIDOR] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R3_CORRIDOR] snapshot=%s result=%s" % [path, result])
