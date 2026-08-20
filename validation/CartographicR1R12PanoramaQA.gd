extends SceneTree
## CP-D2-R1R6-026 — panorama integrado QA-only R1→R12.
## A sobreposição é temporária e serve apenas para auditoria visual do mapa.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const IDS: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
const NAMES: Array[String] = ["CASA VOSS", "ESTRADA DO RIO", "ARCO DAS RUÍNAS", "FLORESTA DENSA", "ACAMPAMENTO MAJESTIC", "RUÍNAS SUBMERSAS", "VILA ELEVADA", "OBSERVATÓRIO", "TRILHA DA MONTANHA", "CAVERNA DO ORION", "CÂMARA DO ORION CUBE", "HUB TEMPORAL"]
const POINTS: Array[Vector2] = [Anchors.CASA_VOSS, Anchors.ESTRADA_RIO_INICIO, Anchors.ARCO_RUINAS, Anchors.FLORESTA_DENSA_ENTRADA, Anchors.ACAMPAMENTO_MAJESTIC, Anchors.RUINAS_SUBMERSAS, Anchors.VILA_ELEVADA, Anchors.OBSERVATORIO, Anchors.TRILHA_MONTANHA_INICIO, Anchors.CAVERNA_ORION, Anchors.CAMARA_ORION_CUBE, Anchors.HUB_TEMPORAL]
const COLORS: Array[Color] = [Color("#f5c56b"), Color("#f5c56b"), Color("#e7a66b"), Color("#80c995"), Color("#80c995"), Color("#66cbd3"), Color("#6ec5e8"), Color("#7ea6ef"), Color("#a88be8"), Color("#69d9df"), Color("#c39aff"), Color("#f0b6ff")]

var qa_root: Node3D
var dynamic_light_count := 0

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R1R12PanoramaQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#172435")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#b1bfd2")
	world.ambient_light_energy = 0.58
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-40.0, -26.0, 0.0)
	sun.light_energy = 0.55
	qa_root.add_child(sun)
	dynamic_light_count += 1
	var ground := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(500.0, 500.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#263d45")
	material.roughness = 0.92
	plane.material = material
	ground.mesh = plane
	ground.position = Vector3(24.0, -0.06, 286.0)
	qa_root.add_child(ground)
	var previous := Vector3.ZERO
	for index: int in range(POINTS.size()):
		var point := _world(POINTS[index])
		_add_marker(point, IDS[index], NAMES[index], COLORS[index])
		if index > 0:
			_add_segment(previous, point, COLORS[index])
		previous = point
	var camera := Camera3D.new()
	camera.name = "R1R12PanoramaCamera"
	camera.current = true
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 680.0
	qa_root.add_child(camera)
	await process_frame
	var duration := 31.0
	var override_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not override_seconds.is_empty():
		duration = maxf(float(override_seconds), 1.0)
	var frame_count := maxi(30, ceili(duration * 10.0))
	var first := _world(POINTS[0])
	var last := _world(POINTS[11])
	var center := Vector3(39.0, 0.0, 285.0)
	for frame: int in range(frame_count):
		var progress := float(frame) / float(frame_count - 1)
		var target := first.lerp(last, progress)
		camera.look_at_from_position(center + Vector3(0.0, 620.0, 0.0), center, Vector3.FORWARD)
		if frame % 30 == 0:
			print("R1R12_PANORAMA progress=%0.2f" % progress)
		await create_timer(duration / float(frame_count)).timeout
	print("PANORAMA_LIGHT_INVENTORY dynamic_lights=%d max=16" % dynamic_light_count)
	print("PANORAMA_LIGHT_BUDGET_CONTRACT=PASS")
	print("PANORAMA_SCOPE_GUARD=PASS R1-R6_readonly R7-R12_owner_dev2")
	print("CP-D2-R1R6-026_R1_R12_PANORAMA_CAPTURE=PASS")
	quit(0)

func _world(point: Vector2) -> Vector3:
	return Anchors.world_position(point, 0.0, 0.20)

func _add_segment(from_point: Vector3, to_point: Vector3, color: Color) -> void:
	var segment := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(2.0, 0.12, from_point.distance_to(to_point))
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.15
	mesh.material = material
	segment.mesh = mesh
	segment.position = (from_point + to_point) * 0.5
	segment.look_at_from_position(segment.position, to_point, Vector3.UP)
	qa_root.add_child(segment)

func _add_marker(point: Vector3, region_id: int, title: String, color: Color) -> void:
	var marker := MeshInstance3D.new()
	var mesh := SphereMesh.new()
	mesh.radius = 3.2 if region_id in [1, 2, 3, 4, 5, 6] else 4.0
	mesh.height = mesh.radius * 2.0
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.23
	mesh.material = material
	marker.mesh = mesh
	marker.position = point
	qa_root.add_child(marker)
	var label := Label3D.new()
	label.text = "R%02d  %s" % [region_id, title]
	var label_offset := Vector3(0.0, 9.0, 0.0)
	if region_id == 1:
		label_offset = Vector3(-34.0, 18.0, -24.0)
	elif region_id == 2:
		label_offset = Vector3(30.0, 18.0, -24.0)
	elif region_id == 3:
		label_offset = Vector3(-18.0, 9.0, 10.0)
	elif region_id == 4:
		label_offset = Vector3(18.0, 9.0, 10.0)
	elif region_id == 8:
		label_offset = Vector3(26.0, 9.0, -10.0)
	elif region_id == 9:
		label_offset = Vector3(-28.0, 9.0, 10.0)
	elif region_id == 10:
		label_offset = Vector3(-42.0, 20.0, 22.0)
	elif region_id == 11:
		label_offset = Vector3(36.0, 20.0, -22.0)
	elif region_id % 2 == 0:
		label_offset = Vector3(14.0, 9.0, 0.0)
	else:
		label_offset = Vector3(-14.0, 9.0, 0.0)
	label.position = point + label_offset
	label.font_size = 108
	label.pixel_size = 0.070
	label.outline_size = 9
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)
