## Dev5 — CP-D5-065: prova QA de handoff R6→R7; não cria conteúdo Dev2.
extends Node3D

const ANCHORS := preload("res://levels/CartographicAnchors.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const R6_XZ := Vector2(60.0, 252.0)
const R7_XZ := Vector2(140.0, 352.0)
const SPEED := 5.40

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var reached_handoff := false

func _ready() -> void:
	_build_environment()
	_build_ground()
	_build_marker("R6Ruinas", R6_XZ, Color(0.35, 0.58, 0.68), 6.6)
	_build_marker("R7HandoffOnly", R7_XZ, Color(0.72, 0.48, 0.18), 7.8)
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null or reached_handoff:
		return
	var target := Vector3(R7_XZ.x, actor.position.y, R7_XZ.y)
	actor.position = actor.position.move_toward(target, SPEED * delta)
	if actor.position.distance_to(target) < 0.12:
		reached_handoff = true
		print("[DEV5_R6R7_HANDOFF] reached_marker_r7=true dev2_geometry_created=false production_modules_changed=false")

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.11, 0.20, 0.27)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.47, 0.56, 0.56)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-53.0, 30.0, 0.0)
	sun.light_energy = 1.04
	add_child(sun)

func _build_ground() -> void:
	var ground := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(160.0, 190.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.12, 0.22, 0.14)
	material.roughness = 1.0
	mesh.material = material
	ground.mesh = mesh
	ground.position = Vector3(100.0, 0.0, 302.0)
	add_child(ground)

func _build_marker(marker_name: String, anchor: Vector2, color: Color, height: float) -> void:
	var marker := MeshInstance3D.new()
	marker.name = marker_name
	var mesh := CylinderMesh.new()
	mesh.top_radius = 0.60
	mesh.bottom_radius = 0.84
	mesh.height = height
	mesh.radial_segments = 8
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.84
	mesh.material = material
	marker.mesh = mesh
	marker.position = Vector3(anchor.x, height * 0.5, anchor.y)
	add_child(marker)

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasR6R7HandoffQA"
	actor.position = Vector3(R6_XZ.x, 0.0, R6_XZ.y)
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
	camera.name = "CameraQAR6R7Handoff"
	camera.position = Vector3(101.0, 105.0, 254.0)
	camera.fov = 58.0
	add_child(camera)
	camera.look_at(Vector3(100.0, 0.0, 302.0), Vector3.UP)
	camera.make_current()

func _verify_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	var destination := ANCHORS.next_dev1_destination(R6_XZ)
	assert((destination["anchor_id"] as int) == 7)
	assert(destination["anchor"] == ANCHORS.VILA_ELEVADA)
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias.follow_camera)
	print("[DEV5_R6R7_HANDOFF] r6_xz=(%.2f,%.2f) next=%s id=%d r7_xz=(%.2f,%.2f) elias_camera_current=%s marker_only=true" % [R6_XZ.x, R6_XZ.y, destination["label"], destination["anchor_id"], R7_XZ.x, R7_XZ.y, elias.follow_camera.current])

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1120.0, 92.0)
	label.text = "CP-D5-065  |  HANDOFF CARTOGRÁFICO: RUÍNAS → VILA ELEVADA\nR6=(60,252) · R7=(140,352) · BALIZA QA, NÃO GEOMETRIA DEV2"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R6R7_HANDOFF] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R6R7_HANDOFF] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R6R7_HANDOFF] snapshot=%s result=%s" % [path, result])
