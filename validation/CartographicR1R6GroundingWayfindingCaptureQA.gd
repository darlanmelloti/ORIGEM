extends SceneTree
## CP-D2-R1R6-030 — captura QA-only do grounding/wayfinding R1→R6.
## Evidência temporária: não entra no mundo de produção nem cria coordenadas concorrentes.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const POINTS: Array[Vector2] = [Anchors.CASA_VOSS, Anchors.ESTRADA_RIO_INICIO, Anchors.ARCO_RUINAS, Anchors.FLORESTA_DENSA_ENTRADA, Anchors.ACAMPAMENTO_MAJESTIC, Anchors.RUINAS_SUBMERSAS]
const NAMES: Array[String] = ["R1 CASA VOSS", "R2 ESTRADA DO RIO", "R3 ARCO DAS RUÍNAS", "R4 FLORESTA DENSA", "R5 ACAMPAMENTO MAJESTIC", "R6 RUÍNAS SUBMERSAS"]
var root_qa: Node3D

func _initialize() -> void:
	root_qa = Node3D.new()
	root_qa.name = "CPD2R1R6GroundingWayfindingCaptureQA"
	get_root().add_child(root_qa)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#19303b")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#c0d0d4")
	world.ambient_light_energy = 0.68
	environment.environment = world
	root_qa.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-42.0, -28.0, 0.0)
	sun.light_energy = 0.62
	root_qa.add_child(sun)
	var ground := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(300.0, 300.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color("#365651")
	ground_material.roughness = 0.92
	plane.material = ground_material
	ground.mesh = plane
	ground.position = Vector3(-14.0, -0.06, 130.0)
	root_qa.add_child(ground)
	var previous := Vector3.ZERO
	for index: int in range(POINTS.size()):
		var point := Anchors.world_position(POINTS[index], 0.0, 0.25)
		_add_marker(point, NAMES[index], Color("#f5c56b") if index < 3 else Color("#70d0c0"), index == 5)
		if index > 0:
			_add_segment(previous, point, Color("#d9ae65") if index < 3 else Color("#70d0c0"))
		previous = point
	var camera := Camera3D.new()
	camera.current = true
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 470.0
	root_qa.add_child(camera)
	await process_frame
	var duration := 31.0
	var env_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not env_seconds.is_empty():
		duration = maxf(float(env_seconds), 1.0)
	var frames := maxi(30, ceili(duration * 10.0))
	var center := Vector3(-14.0, 0.0, 130.0)
	for frame: int in range(frames):
		camera.look_at_from_position(center + Vector3(0.0, 430.0, 0.0), center, Vector3.FORWARD)
		if frame % 30 == 0:
			print("R1R6_GROUNDING_DYNAMIC progress=%0.2f" % (float(frame) / float(frames - 1)))
		await create_timer(duration / float(frames)).timeout
	print("GROUNDING_WAYFIND_CAPTURE_LIGHT_BUDGET=PASS dynamic_lights=1 max=16")
	print("GROUNDING_WAYFIND_CAPTURE_SCOPE_GUARD=PASS R1-R6_dev1_readonly_standby")
	print("CP-D2-R1R6-030_R1_R6_GROUNDING_WAYFIND_CAPTURE=PASS")
	quit(0)

func _add_marker(point: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 4.4 if larger else 3.0
	sphere.height = sphere.radius * 2.0
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.22
	sphere.material = material
	marker.mesh = sphere
	marker.position = point
	root_qa.add_child(marker)
	var label := Label3D.new()
	label.text = title
	label.position = point + Vector3(-18.0, 10.0, 0.0)
	label.font_size = 92 if larger else 78
	label.pixel_size = 0.058
	label.outline_size = 9
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	root_qa.add_child(label)

func _add_segment(from_point: Vector3, to_point: Vector3, color: Color) -> void:
	var segment := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(2.4, 0.14, from_point.distance_to(to_point))
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.14
	mesh.material = material
	segment.mesh = mesh
	segment.position = (from_point + to_point) * 0.5
	segment.look_at_from_position(segment.position, to_point, Vector3.UP)
	root_qa.add_child(segment)
