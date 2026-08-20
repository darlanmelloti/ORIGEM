extends SceneTree
## CP-D2-R1R6-016 — captura dinâmica QA-only R7→R8.
## A cena deriva posições de CartographicAnchors.gd e não altera produção.

const Anchors = preload("res://levels/CartographicAnchors.gd")
var qa_root: Node3D

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R7R8CaptureQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#9bb5bf")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#d4dddd")
	world.ambient_light_energy = 0.95
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-45.0, -30.0, 0.0)
	sun.light_energy = 1.1
	qa_root.add_child(sun)
	var ground := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(190.0, 180.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color("#34574f")
	ground_material.roughness = 0.93
	plane.material = ground_material
	ground.mesh = plane
	ground.position = Vector3(170.0, -0.06, 378.0)
	qa_root.add_child(ground)
	var start := Anchors.world_position(Anchors.VILA_ELEVADA, 0.0, 0.2)
	var finish := Anchors.world_position(Anchors.OBSERVATORIO, 0.0, 0.2)
	_add_marker(start, "R7 VILA ELEVADA", Color("#d89cff"), false)
	_add_marker(finish, "R8 OBSERVATÓRIO", Color("#f3c16c"), true)
	var corridor := MeshInstance3D.new()
	var corridor_mesh := BoxMesh.new()
	corridor_mesh.size = Vector3(2.3, 0.10, start.distance_to(finish))
	var corridor_material := StandardMaterial3D.new()
	corridor_material.albedo_color = Color("#c69b57")
	corridor_mesh.material = corridor_material
	corridor.mesh = corridor_mesh
	corridor.position = (start + finish) * 0.5
	corridor.look_at_from_position(corridor.position, finish, Vector3.UP)
	qa_root.add_child(corridor)
	var camera := Camera3D.new()
	camera.name = "R7R8DynamicCamera"
	camera.current = true
	camera.fov = 78.0
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
		camera.look_at_from_position(target + Vector3(-50.0, 38.0, -70.0), stable_target + Vector3(0.0, 2.0, 0.0), Vector3.UP)
		if frame % 30 == 0:
			print("R7R8_DYNAMIC progress=%0.2f" % progress)
		await create_timer(duration / float(frame_count)).timeout
	print("CP-D2-R1R6-016_R7_R8_DYNAMIC_CAPTURE=PASS")
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
	label.position = position + (Vector3(-12.0, 6.0, 0.0) if larger else Vector3(-9.0, 4.0, 0.0))
	label.font_size = 84 if larger else 58
	label.pixel_size = 0.052 if larger else 0.036
	label.outline_size = 8
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)
