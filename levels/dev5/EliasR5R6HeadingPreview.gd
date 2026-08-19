## Dev5 — CP-D5-057: rumo QA Elias R5→R6, sem alterar navegação de produção.
extends Node3D

const ANCHORS := preload("res://levels/CartographicAnchors.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const START_WORLD := Vector3(-80.0, 0.0, 190.0)
const END_WORLD := Vector3(60.0, 0.0, 252.0)
const SPEED := 5.50

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var heading_label: Label
var completed := false

func _ready() -> void:
	_build_environment()
	_build_ground()
	_build_anchor_marker("Majestic", ANCHORS.ACAMPAMENTO_MAJESTIC, Color(0.72, 0.50, 0.20))
	_build_anchor_marker("Ruinas", ANCHORS.RUINAS_SUBMERSAS, Color(0.40, 0.58, 0.65))
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_heading_contract()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null or completed:
		return
	var target := Vector3(END_WORLD.x, actor.position.y, END_WORLD.z)
	actor.position = actor.position.move_toward(target, SPEED * delta)
	if actor.position.distance_to(target) < 0.08:
		completed = true
		var destination := ANCHORS.next_dev1_destination(Vector2(actor.position.x, actor.position.z))
		assert((destination["anchor_id"] as int) == 7)
		print("[DEV5_HEADING] arrival_r6=true next_anchor=%d label=%s" % [destination["anchor_id"], destination["label"]])

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.12, 0.20, 0.27)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.48, 0.56, 0.57)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-55.0, 24.0, 0.0)
	sun.light_energy = 1.04
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.position = Vector3(-14.0, -0.45, 215.0)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(240.0, 0.9, 150.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.12, 0.21, 0.14)
	material.roughness = 0.98
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	ground.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	ground.add_child(collision)

func _build_anchor_marker(marker_name: String, anchor: Vector2, color: Color) -> void:
	var marker := MeshInstance3D.new()
	marker.name = marker_name + "CartographicAnchor"
	var mesh := CylinderMesh.new()
	mesh.top_radius = 0.55
	mesh.bottom_radius = 0.78
	mesh.height = 7.2
	mesh.radial_segments = 8
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.82
	mesh.material = material
	marker.mesh = mesh
	marker.position = Vector3(anchor.x, 3.6, anchor.y)
	add_child(marker)

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasR5R6HeadingQA"
	actor.position = START_WORLD
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
	camera.name = "CameraQAHeadingR5R6"
	camera.position = Vector3(-14.0, 112.0, 132.0)
	camera.fov = 64.0
	add_child(camera)
	camera.look_at(Vector3(-14.0, 0.0, 215.0), Vector3.UP)
	camera.make_current()

func _verify_heading_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	var at_r5 := ANCHORS.next_dev1_destination(Vector2(START_WORLD.x, START_WORLD.z))
	assert((at_r5["anchor_id"] as int) == 6)
	var map_start := ANCHORS.map_texture_position(Vector2(START_WORLD.x, START_WORLD.z))
	var map_r6 := ANCHORS.MAP_TEXTURE_POSITIONS[6] as Vector2
	assert(map_start.distance_to(map_r6) < 260.0)
	print("[DEV5_HEADING] start_xz=(%.2f,%.2f) destination=%s id=%d map_start=(%.1f,%.1f) map_r6=(%.1f,%.1f) elias_camera_current=%s" % [START_WORLD.x, START_WORLD.z, at_r5["label"], at_r5["anchor_id"], map_start.x, map_start.y, map_r6.x, map_r6.y, elias.follow_camera.current])

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	heading_label = Label.new()
	heading_label.position = Vector2(52.0, 46.0)
	heading_label.size = Vector2(1100.0, 90.0)
	heading_label.text = "CP-D5-057  |  RUMO CARTOGRÁFICO DE ELIAS: MAJESTIC → RUÍNAS\nÂNCORAS R5=(-88,178) · R6=(60,252) · MAPA CONTINUA A AUTORIDADE ESPACIAL"
	heading_label.add_theme_font_size_override("font_size", 18)
	heading_label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(heading_label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_HEADING] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_HEADING] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_HEADING] snapshot=%s result=%s" % [path, result])
