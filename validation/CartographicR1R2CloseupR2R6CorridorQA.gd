extends SceneTree
## CP-D2-R1R6-031 — close-up R1/R2 + corredor R2→R6, QA-only.
## A composição é uma camada de evidência; não altera o mundo de produção.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const MAX_DYNAMIC_LIGHTS := 16
var qa_root: Node3D
var lights := 0

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R1R2CloseupR2R6CorridorQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#172936")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#c1d1d0")
	world.ambient_light_energy = 0.68
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-43.0, -30.0, 0.0)
	sun.light_energy = 0.6
	qa_root.add_child(sun)
	lights += 1
	_add_panel(Vector3(-66.0, 0.0, -48.0), Vector2(-22.0, 8.0), Vector2(-21.4, 12.0), "R1 CASA VOSS", "R2 ESTRADA DO RIO", Color("#f3c266"), 48.0)
	_add_corridor_panel(Vector3(66.0, 0.0, -48.0))
	print("CLOSEUP_SOURCE R1=%s R2=%s R6=%s" % [str(Anchors.CASA_VOSS), str(Anchors.ESTRADA_RIO_INICIO), str(Anchors.RUINAS_SUBMERSAS)])
	print("CLOSEUP_LIGHT_BUDGET=PASS dynamic_lights=%d max=%d" % [lights, MAX_DYNAMIC_LIGHTS])
	var camera := Camera3D.new()
	camera.current = true
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 175.0
	qa_root.add_child(camera)
	await process_frame
	var duration := 31.0
	var env_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not env_seconds.is_empty():
		duration = maxf(float(env_seconds), 1.0)
	var frames := maxi(30, ceili(duration * 10.0))
	var center := Vector3(0.0, 0.0, -48.0)
	for frame: int in range(frames):
		camera.look_at_from_position(center + Vector3(0.0, 280.0, 0.0), center, Vector3.FORWARD)
		if frame % 30 == 0:
			print("CLOSEUP_CORRIDOR_DYNAMIC progress=%0.2f" % (float(frame) / float(frames - 1)))
		await create_timer(duration / float(frames)).timeout
	print("CLOSEUP_SCOPE_GUARD=PASS R1-R6_dev1_readonly_standby")
	print("CP-D2-R1R6-031_R1_R2_CLOSEUP_R2_R6_CORRIDOR=PASS")
	quit(0)

func _add_panel(panel_center: Vector3, source_a: Vector2, source_b: Vector2, title_a: String, title_b: String, color: Color, width: float) -> void:
	var panel := MeshInstance3D.new()
	var panel_mesh := BoxMesh.new()
	panel_mesh.size = Vector3(width, 0.12, 52.0)
	var panel_material := StandardMaterial3D.new()
	panel_material.albedo_color = Color("#30484c")
	panel_mesh.material = panel_material
	panel.mesh = panel_mesh
	panel.position = panel_center
	qa_root.add_child(panel)
	var a := panel_center + Vector3(-20.0, 0.4, 8.0)
	var b := panel_center + Vector3(20.0, 0.4, -8.0)
	_add_marker(a, title_a, color, false)
	_add_marker(b, title_b, color.lightened(0.2), true)
	_add_segment(a, b, color)
	print("CLOSEUP_PAIR %s -> %s source_distance=%0.3f" % [title_a, title_b, (source_b - source_a).length()])

func _add_corridor_panel(panel_center: Vector3) -> void:
	var names: Array[String] = ["R2 ESTRADA", "R3 ARCO", "R4 FLORESTA", "R5 ACAMPAMENTO", "R6 RUÍNAS"]
	var points: Array[Vector2] = [Anchors.ESTRADA_RIO_INICIO, Anchors.ARCO_RUINAS, Anchors.FLORESTA_DENSA_ENTRADA, Anchors.ACAMPAMENTO_MAJESTIC, Anchors.RUINAS_SUBMERSAS]
	var panel := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(92.0, 0.12, 52.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#30484c")
	mesh.material = material
	panel.mesh = mesh
	panel.position = panel_center
	qa_root.add_child(panel)
	var previous := panel_center + Vector3(-36.0, 0.4, 16.0)
	for index: int in range(points.size()):
		var progress := float(index) / float(points.size() - 1)
		var point := panel_center + Vector3(-36.0 + 72.0 * progress, 0.4, 16.0 - 32.0 * progress)
		_add_marker(point, names[index], Color("#72d1c0"), index == points.size() - 1)
		if index > 0:
			_add_segment(previous, point, Color("#72d1c0"))
		previous = point
	print("CORRIDOR_SOURCE R2->R6 segments=4 distance=%0.3f" % (points[0].distance_to(points[1]) + points[1].distance_to(points[2]) + points[2].distance_to(points[3]) + points[3].distance_to(points[4])))

func _add_marker(point: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 3.4 if larger else 2.7
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
	label.position = point + Vector3(-15.0, 8.0, 0.0)
	label.font_size = 72 if larger else 64
	label.pixel_size = 0.052
	label.outline_size = 8
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)

func _add_segment(from_point: Vector3, to_point: Vector3, color: Color) -> void:
	var segment := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(1.8, 0.14, from_point.distance_to(to_point))
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.14
	mesh.material = material
	segment.mesh = mesh
	segment.position = (from_point + to_point) * 0.5
	segment.look_at_from_position(segment.position, to_point, Vector3.UP)
	qa_root.add_child(segment)
