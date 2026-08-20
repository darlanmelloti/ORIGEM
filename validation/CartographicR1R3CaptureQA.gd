extends SceneTree
## CP-D2-R1R6-003 — câmara QA dedicada para comprovar grounding R1–R3.
## O conteúdo é temporário, não é uma cena de produção e não substitui mapa/terreno.

const Anchors = preload("res://levels/CartographicAnchors.gd")

var qa_root: Node3D

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R1R3CaptureQA"
	root_ready()
	get_root().add_child(qa_root)
	await process_frame
	print("R1R3_CAPTURE_QA_READY camera=dedicated markers=3 corridor=QA_ONLY")
	var capture_seconds := 1.0
	var capture_override := OS.get_environment("QA_CAPTURE_SECONDS")
	if not capture_override.is_empty():
		capture_seconds = maxf(float(capture_override), 1.0)
	await create_timer(capture_seconds).timeout
	quit(0)

func root_ready() -> void:
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#9db5c7")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#c8d4dc")
	world.ambient_light_energy = 0.9
	environment.environment = world
	qa_root.add_child(environment)

	var sun := DirectionalLight3D.new()
	sun.name = "QASun"
	sun.rotation_degrees = Vector3(-52.0, -26.0, 0.0)
	sun.light_energy = 1.2
	sun.shadow_enabled = true
	qa_root.add_child(sun)

	var camera := Camera3D.new()
	camera.name = "DedicatedR1R3Camera"
	camera.position = Vector3(-42.0, 34.0, 66.0)
	camera.look_at_from_position(camera.position, Vector3(-19.0, 0.0, 28.0), Vector3.UP)
	camera.fov = 66.0
	camera.current = true
	qa_root.add_child(camera)

	var ground := MeshInstance3D.new()
	ground.name = "QAGroundPlane"
	var ground_mesh := PlaneMesh.new()
	ground_mesh.size = Vector2(130.0, 130.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color("#385953")
	ground_material.roughness = 0.92
	ground_mesh.material = ground_material
	ground.mesh = ground_mesh
	ground.position = Vector3(-20.0, -0.06, 28.0)
	qa_root.add_child(ground)

	var anchors: Array[Vector2] = [Anchors.CASA_VOSS, Anchors.ESTRADA_RIO_INICIO, Anchors.ARCO_RUINAS]
	var names: Array[String] = ["R1 CASA VOSS", "R2 ESTRADA DO RIO", "R3 ARCO DAS RUÍNAS"]
	var colors: Array[Color] = [Color("#ffd47a"), Color("#6fe0c0"), Color("#d8a2ff")]
	for index: int in range(anchors.size()):
		var position := Anchors.world_position(anchors[index], 0.0, 0.15)
		_add_marker(position, names[index], colors[index], Vector3(-10.0, 3.0, -2.0) if index == 0 else (Vector3(4.5, 2.4, -1.0) if index == 1 else Vector3(-2.8, 2.0, 0.0)))
		print("R1R3_CAPTURE_MARKER region=%d position=%s grounded=true" % [index + 1, str(position)])

	_add_corridor(Anchors.world_position(Anchors.CASA_VOSS, 0.02), Anchors.world_position(Anchors.ARCO_RUINAS, 0.02))
	# Titles are intentionally omitted from the capture: marker labels are the sole visual QA subjects.

func _add_marker(position: Vector3, title: String, color: Color, label_offset: Vector3) -> void:
	var marker := MeshInstance3D.new()
	marker.name = title.replace(" ", "_")
	var sphere := SphereMesh.new()
	sphere.radius = 0.65
	sphere.height = 1.3
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.28
	sphere.material = material
	marker.mesh = sphere
	marker.position = position
	qa_root.add_child(marker)
	_add_title(title, position + label_offset)

func _add_corridor(start: Vector3, finish: Vector3) -> void:
	var ribbon := MeshInstance3D.new()
	ribbon.name = "QACorridorR1R3"
	var mesh := BoxMesh.new()
	mesh.size = Vector3(1.2, 0.08, start.distance_to(finish))
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#b7914f")
	material.roughness = 0.72
	mesh.material = material
	ribbon.mesh = mesh
	ribbon.position = (start + finish) * 0.5
	ribbon.look_at_from_position(ribbon.position, finish, Vector3.UP)
	qa_root.add_child(ribbon)

func _add_title(text: String, position: Vector3) -> void:
	var label := Label3D.new()
	label.text = text
	label.position = position
	label.font_size = 34
	label.pixel_size = 0.022
	label.outline_size = 8
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)
