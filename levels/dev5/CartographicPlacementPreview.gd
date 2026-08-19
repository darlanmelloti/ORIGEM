## Dev5 — QA de colocação cartográfica 1–6.
## Visualiza objectos de teste nas coordenadas derivadas das âncoras oficiais.

extends Node3D

const PLACEMENT: Script = preload("res://levels/dev5/CartographicPlacementSystem.gd")

func _ready() -> void:
	_build_environment()
	_build_anchor_prototypes()
	_build_camera()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.045, 0.08, 0.10)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.44, 0.54, 0.60)
	environment.ambient_light_energy = 0.84
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-56.0, 22.0, 0.0)
	sun.light_energy = 1.05
	add_child(sun)

func _build_anchor_prototypes() -> void:
	var ground := MeshInstance3D.new()
	var ground_mesh := PlaneMesh.new()
	ground_mesh.size = Vector2(190.0, 290.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color(0.10, 0.17, 0.12)
	ground_material.roughness = 1.0
	ground_mesh.material = ground_material
	ground.mesh = ground_mesh
	ground.position = Vector3(-15.0, 0.0, 130.0)
	add_child(ground)
	for anchor_data: Dictionary in PLACEMENT.supported_anchor_summary():
		var anchor_id: int = anchor_data["anchor_id"] as int
		var record: Dictionary = PLACEMENT.placement_record("QA_Marco_%d" % anchor_id, anchor_id, Vector2.ZERO, 0.0)
		assert(PLACEMENT.assert_anchor_distance(record))
		var marker := MeshInstance3D.new()
		marker.name = "Marco%02d_%s" % [anchor_id, record["anchor_name"]]
		var mesh := CylinderMesh.new()
		mesh.top_radius = 0.85
		mesh.bottom_radius = 1.10
		mesh.height = 4.0 + float(anchor_id) * 0.24
		mesh.radial_segments = 8
		var material := StandardMaterial3D.new()
		material.albedo_color = Color(0.36 + float(anchor_id) * 0.035, 0.26, 0.12 + float(anchor_id) * 0.028)
		material.roughness = 0.88
		mesh.material = material
		marker.mesh = mesh
		marker.position = (record["world_position"] as Vector3) + Vector3(0.0, mesh.height * 0.5, 0.0)
		add_child(marker)
		print("[DEV5_PLACEMENT_QA] anchor=%d name=%s world_xz=%s map_canvas=%s" % [anchor_id, record["anchor_name"], record["world_xz"], record["map_canvas"]])

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(-62.0, 94.0, 228.0)
	camera.fov = 53.0
	add_child(camera)
	camera.look_at(Vector3(-15.0, 0.0, 130.0), Vector3.UP)
	camera.make_current()

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_PLACEMENT_QA] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_PLACEMENT_QA] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := image.save_png(snapshot_path)
	print("[DEV5_PLACEMENT_QA] snapshot=%s result=%s" % [snapshot_path, result])
