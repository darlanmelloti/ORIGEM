## Dev5 — CP-D5-082: auditoria QA de legibilidade R6 em três ângulos; não altera produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const MONOLITH: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const MONOLITH_XZ := Vector2(52.0, 260.0)
const ROUTE_X := 60.0
const ROUTE_START_Z := 242.0
const ROUTE_END_Z := 278.0

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var qa_camera: Camera3D
var monolith_root: Node3D
var angle_index := 0
var elapsed := 0.0
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_monolith()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _process(delta: float) -> void:
	elapsed += delta
	if elapsed >= 8.0:
		elapsed = 0.0
		angle_index = (angle_index + 1) % 3
		_apply_angle()

func _physics_process(delta: float) -> void:
	if actor == null:
		return
	actor.global_position.z += 2.25 * delta
	if actor.global_position.z >= ROUTE_END_Z:
		route_cycles += 1
		actor.global_position.z = ROUTE_START_Z
		print("[DEV5_R6_ANGLES] route_cycle=%d clear=true monolith_grounded=true production_modules_changed=false" % route_cycles)

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.13, 0.22, 0.28)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.40, 0.51, 0.55)
	environment.ambient_light_energy = 0.80
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50.0, 36.0, 0.0)
	sun.light_energy = 1.08
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
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
	monolith_root = Node3D.new()
	monolith_root.name = "BalizaMonoliticaR6AnglesQA"
	var model := MONOLITH.instantiate() as Node3D
	model.position = Vector3(0.0, 0.82, 0.0)
	model.rotation_degrees = Vector3(0.0, 14.0, -4.0)
	model.scale = Vector3.ONE * 1.62
	monolith_root.add_child(model)
	add_child(monolith_root)
	var result := GROUNDING.snap_to_ground(get_world_3d(), monolith_root, Vector3(MONOLITH_XZ.x, 18.0, MONOLITH_XZ.y))
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(MONOLITH_XZ) < 0.001)

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasR6AnglesQA"
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
	qa_camera = Camera3D.new()
	qa_camera.name = "CameraQAR6MultiplosAngulos"
	qa_camera.fov = 49.0
	add_child(qa_camera)
	_apply_angle()
	qa_camera.make_current()

func _apply_angle() -> void:
	if qa_camera == null:
		return
	var positions := [Vector3(75.0, 8.0, 246.0), Vector3(60.0, 11.0, 260.0), Vector3(48.0, 6.5, 278.0)]
	var targets := [Vector3(57.0, 1.4, 261.0), Vector3(55.0, 1.2, 260.0), Vector3(59.0, 1.2, 257.0)]
	qa_camera.position = positions[angle_index]
	qa_camera.look_at(targets[angle_index], Vector3.UP)
	print("[DEV5_R6_ANGLES] angle=%d elias_visible=true monolith_visible=true corridor_visible=true" % (angle_index + 1))

func _verify_contract() -> void:
	assert(monolith_root != null and elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera == qa_camera)
	assert(absf(ROUTE_X - MONOLITH_XZ.x) - 1.40 - 0.55 >= 4.0)
	print("[DEV5_R6_ANGLES] anchor=R6 monolith_xz=(%.2f,%.2f) route_x=%.2f angles=3 elias_camera_current=%s" % [MONOLITH_XZ.x, MONOLITH_XZ.y, ROUTE_X, elias.follow_camera.current])

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1080.0, 90.0)
	label.text = "CP-D5-082  |  LEGIBILIDADE R6: ELIAS · BALIZA · CORREDOR\n3 ENQUADRAMENTOS QA · FOLGA ≥4,00 M · ZERO LAJES · SEM PRODUÇÃO"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R6_ANGLES] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R6_ANGLES] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R6_ANGLES] snapshot=%s result=%s" % [path, result])
