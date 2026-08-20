extends SceneTree
## CP-D2-R1R6-012 — captura dinâmica QA-only R5→R6.
## Mantém a autoridade de CartographicAnchors.gd e não altera produção.

const Anchors = preload("res://levels/CartographicAnchors.gd")
var qa_root: Node3D

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R5R6CaptureQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#94b2bd")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#d2dddd")
	world.ambient_light_energy = 0.95
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-46.0, -26.0, 0.0)
	sun.light_energy = 1.1
	qa_root.add_child(sun)
	var ground := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(300.0, 280.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color("#304f4b")
	ground_material.roughness = 0.94
	plane.material = ground_material
	ground.mesh = plane
	ground.position = Vector3(-10.0, -0.06, 220.0)
	qa_root.add_child(ground)
	var start := Anchors.world_position(Anchors.ACAMPAMENTO_MAJESTIC, 0.0, 0.2)
	var finish := Anchors.world_position(Anchors.RUINAS_SUBMERSAS, 0.0, 0.2)
	_add_marker(start, "R5 ACAMPAMENTO MAJESTIC", Color("#f3bd6d"), true)
	_add_marker(finish, "R6 RUÍNAS SUBMERSAS", Color("#63d6da"), true)
	var corridor := MeshInstance3D.new()
	var corridor_mesh := BoxMesh.new()
	corridor_mesh.size = Vector3(2.4, 0.10, start.distance_to(finish))
	var corridor_material := StandardMaterial3D.new()
	corridor_material.albedo_color = Color("#c69b57")
	corridor_mesh.material = corridor_material
	corridor.mesh = corridor_mesh
	corridor.position = (start + finish) * 0.5
	corridor.look_at_from_position(corridor.position, finish, Vector3.UP)
	qa_root.add_child(corridor)
	var camera := Camera3D.new()
	camera.name = "R5R6DynamicCamera"
	camera.current = true
	camera.fov = 82.0
	qa_root.add_child(camera)
	await process_frame
	var duration := 31.0
	var override_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not override_seconds.is_empty():
		duration = maxf(float(override_seconds), 1.0)
	var frame_count := maxi(30, ceili(duration * 10.0))
	var stable_target := start.lerp(finish, 0.5)
	for frame: int in range(frame_count):
		var progress := float(frame) / float(frame_count - 1)
		var target := start.lerp(finish, progress)
		camera.look_at_from_position(target + Vector3(-64.0, 48.0, -92.0), stable_target + Vector3(0.0, 2.0, 0.0), Vector3.UP)
		if frame % 30 == 0:
			print("R5R6_DYNAMIC progress=%0.2f" % progress)
		await create_timer(duration / float(frame_count)).timeout
	print("CP-D2-R1R6-012_R5_R6_DYNAMIC_CAPTURE=PASS")
	quit(0)

func _add_marker(position: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 1.0 if larger else 0.85
	sphere.height = 2.0 if larger else 1.7
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.22
	sphere.material = material
	marker.mesh = sphere
	marker.position = position
	qa_root.add_child(marker)
	var label := Label3D.new()
	label.text = title
	var is_r6 := title.begins_with("R6")
	label.position = position + (Vector3(-13.0, 7.0, 0.0) if is_r6 else Vector3(-10.0, 5.0, 0.0))
	label.font_size = 88 if is_r6 else 68
	label.pixel_size = 0.055 if is_r6 else 0.042
	label.outline_size = 8
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)
