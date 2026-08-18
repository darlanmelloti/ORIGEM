## Cena QA Dev5: prova visual isolada de Elias em terceira pessoa.

extends Node3D

const ELIAS_PRESENTATION: Script = preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

func _ready() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.16, 0.22, 0.29)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.60, 0.68, 0.78)
	environment.ambient_light_energy = 0.65
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.2
	sun.rotation_degrees = Vector3(-48.0, -35.0, 0.0)
	add_child(sun)
	var floor_mesh := MeshInstance3D.new()
	var floor := PlaneMesh.new()
	floor.size = Vector2(16.0, 16.0)
	var floor_material := StandardMaterial3D.new()
	floor_material.albedo_color = Color(0.13, 0.18, 0.12)
	floor_material.roughness = 0.94
	floor.material = floor_material
	floor_mesh.mesh = floor
	add_child(floor_mesh)
	var elias: Node3D = ELIAS_PRESENTATION.new()
	elias.name = "Elias"
	elias.set("enabled_for_preview", true)
	add_child(elias)
	var camera := Camera3D.new()
	camera.name = "CameraQA"
	camera.position = Vector3(2.75, 1.85, 4.15)
	add_child(camera)
	camera.fov = 52.0
	camera.look_at(Vector3(0.0, 1.18, 0.0), Vector3.UP)
	camera.make_current()
	call_deferred("_force_preview_camera_qa")
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _force_preview_camera_qa() -> void:
	await get_tree().process_frame
	var elias: Node3D = get_node_or_null("Elias") as Node3D
	if elias != null:
		var internal_camera: Camera3D = elias.get_node_or_null("PivotCameraElias/BracoCameraElias/CameraTerceiraPessoaElias") as Camera3D
		if internal_camera != null:
			internal_camera.current = false
	var preview_camera: Camera3D = get_node_or_null("CameraQA") as Camera3D
	if preview_camera != null:
		preview_camera.make_current()
	var active_camera: Camera3D = get_viewport().get_camera_3d()
	print("[DEV5_ELIAS_QA] active_camera=%s" % (active_camera.get_path() if active_camera != null else NodePath("<none>")))

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var active_camera: Camera3D = get_viewport().get_camera_3d()
	print("[DEV5_ELIAS_QA] capture_camera=%s" % (active_camera.get_path() if active_camera != null else NodePath("<none>")))
	var image: Image = get_viewport().get_texture().get_image()
	var result := image.save_png(snapshot_path)
	print("[DEV5_ELIAS_QA] snapshot=%s result=%s" % [snapshot_path, result])
