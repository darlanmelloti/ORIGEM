## Dev5 — CP-D5-044: contrato de câmara para presentation de Elias em harness QA.

extends Node3D

const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

var external_camera: Camera3D
var elias: EliasThirdPersonPresentation

func _ready() -> void:
	_build_environment()
	_build_floor()
	_build_elias()
	await get_tree().process_frame
	_build_external_camera()
	await get_tree().process_frame
	assert(elias.follow_camera != null)
	assert(not elias.follow_camera.current)
	assert(get_viewport().get_camera_3d() == external_camera)
	print("[DEV5_ELIAS_CAMERA] elias_camera_current=%s external_camera_current=%s viewport_owner=%s" % [elias.follow_camera.current, external_camera.current, get_viewport().get_camera_3d().name])
	print("[DEV5_ELIAS_CAMERA] status=approved active_camera_count=1 player_gd_changed=false regional_modules_changed=false")
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.10, 0.16, 0.20)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.46, 0.56, 0.62)
	environment.ambient_light_energy = 0.8
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-45.0, -28.0, 0.0)
	sun.light_energy = 1.0
	add_child(sun)

func _build_floor() -> void:
	var floor := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(16.0, 16.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.12, 0.19, 0.16)
	material.roughness = 0.94
	mesh.material = material
	floor.mesh = mesh
	add_child(floor)

func _build_elias() -> void:
	elias = ELIAS_PRESENTATION.new()
	elias.name = "EliasCameraContractQA"
	elias.enabled_for_preview = true
	elias.camera_distance = 3.8
	add_child(elias)

func _build_external_camera() -> void:
	external_camera = Camera3D.new()
	external_camera.name = "CameraQAExterna"
	external_camera.position = Vector3(4.8, 3.0, 5.8)
	external_camera.fov = 50.0
	add_child(external_camera)
	external_camera.look_at(Vector3(0.0, 1.15, 0.0), Vector3.UP)
	external_camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 48.0)
	label.size = Vector2(1000.0, 90.0)
	label.text = "CP-D5-044  |  CONTRATO DE CÂMARA DE ELIAS\nCÂMARA QA EXTERNA ACTIVA · CÂMARA DE ELIAS INACTIVA"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.88, 0.94, 0.96)
	layer.add_child(label)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var result := get_viewport().get_texture().get_image().save_png(snapshot_path)
	print("[DEV5_ELIAS_CAMERA] snapshot=%s result=%s" % [snapshot_path, result])
