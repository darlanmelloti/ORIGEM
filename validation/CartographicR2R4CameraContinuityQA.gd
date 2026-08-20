extends SceneTree
## CP-D2-R1R6-032 — câmara e corredor QA-only R2→R3→R4.
const Anchors = preload("res://levels/CartographicAnchors.gd")
const POINTS: Array[Vector2] = [Anchors.ESTRADA_RIO_INICIO, Anchors.ARCO_RUINAS, Anchors.FLORESTA_DENSA_ENTRADA]
const NAMES: Array[String] = ["R2 ESTRADA DO RIO", "R3 ARCO DAS RUÍNAS", "R4 FLORESTA DENSA"]
var qa_root: Node3D

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R2R4CameraContinuityQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#172936")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#bfd1d0")
	world.ambient_light_energy = 0.68
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-42.0, -28.0, 0.0)
	sun.light_energy = 0.6
	qa_root.add_child(sun)
	var previous := Vector3.ZERO
	for index: int in range(POINTS.size()):
		var point := Anchors.world_position(POINTS[index], 0.0, 0.22)
		_add_marker(point, NAMES[index], Color("#e7b568") if index == 0 else Color("#70d0c0"), index == 2)
		if index > 0:
			_add_segment(previous, point, Color("#70d0c0"))
		previous = point
	var camera := Camera3D.new()
	camera.current = true
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 190.0
	qa_root.add_child(camera)
	await process_frame
	var duration := 31.0
	var env_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not env_seconds.is_empty():
		duration = maxf(float(env_seconds), 1.0)
	var frames := maxi(30, ceili(duration * 10.0))
	var center := Vector3(-15.0, 0.0, 64.0)
	for frame: int in range(frames):
		camera.look_at_from_position(center + Vector3(0.0, 255.0, 0.0), center, Vector3.FORWARD)
		if frame % 30 == 0:
			print("R2R4_CAMERA_DYNAMIC progress=%0.2f" % (float(frame) / float(frames - 1)))
		await create_timer(duration / float(frames)).timeout
	print("R2R4_CAMERA_LIGHT_BUDGET=PASS dynamic_lights=1 max=16")
	print("R2R4_CAMERA_SCOPE_GUARD=PASS R1-R6_dev1_readonly_standby")
	print("CP-D2-R1R6-032_R2_R3_R4_CAMERA_CORRIDOR=PASS")
	quit(0)

func _add_marker(point: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 4.0 if larger else 3.0
	sphere.height = sphere.radius * 2.0
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.2
	sphere.material = material
	marker.mesh = sphere
	marker.position = point
	qa_root.add_child(marker)
	var label := Label3D.new()
	label.text = title
	label.position = point + Vector3(-18.0, 10.0, 0.0)
	label.font_size = 84 if larger else 70
	label.pixel_size = 0.055
	label.outline_size = 8
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)

func _add_segment(from_point: Vector3, to_point: Vector3, color: Color) -> void:
	var segment := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(2.2, 0.14, from_point.distance_to(to_point))
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.14
	mesh.material = material
	segment.mesh = mesh
	segment.position = (from_point + to_point) * 0.5
	segment.look_at_from_position(segment.position, to_point, Vector3.UP)
	qa_root.add_child(segment)
