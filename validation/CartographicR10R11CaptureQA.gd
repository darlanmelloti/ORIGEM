extends SceneTree
## CP-D2-R1R6-022 — captura dinâmica QA-only R10→R11.
## A cena demonstra o handoff interior com iluminação de ressonância controlada.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const MAX_DYNAMIC_LIGHTS := 16
var qa_root: Node3D
var dynamic_light_count := 0

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R10R11CaptureQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#182a38")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#8ea8bd")
	world.ambient_light_energy = 0.42
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-34.0, -20.0, 0.0)
	sun.light_energy = 0.28
	qa_root.add_child(sun)
	_register_dynamic_light(sun)
	var ground := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(70.0, 70.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color("#263a40")
	ground_material.roughness = 0.88
	plane.material = ground_material
	ground.mesh = plane
	ground.position = Vector3(-116.0, -0.06, 555.0)
	qa_root.add_child(ground)
	var start := Anchors.world_position(Anchors.CAVERNA_ORION, 0.0, 0.2)
	var finish := Anchors.world_position(Anchors.CAMARA_ORION_CUBE, 0.0, 0.2)
	_add_marker(start, "R10 CAVERNA DO ORION", Color("#63d6da"), false)
	_add_marker(finish, "R11 CÂMARA DO ORION CUBE", Color("#c9a4ff"), true)
	var corridor := MeshInstance3D.new()
	var corridor_mesh := BoxMesh.new()
	corridor_mesh.size = Vector3(3.6, 0.10, start.distance_to(finish))
	var corridor_material := StandardMaterial3D.new()
	corridor_material.albedo_color = Color("#a47fd4")
	corridor_mesh.material = corridor_material
	corridor.mesh = corridor_mesh
	corridor.position = (start + finish) * 0.5
	corridor.look_at_from_position(corridor.position, finish, Vector3.UP)
	qa_root.add_child(corridor)
	for index: int in range(3):
		var resonance := OmniLight3D.new()
		resonance.name = "R10R11_Resonance_%02d" % (index + 1)
		resonance.light_color = Color("#5cc8ff")
		resonance.light_energy = 2.0
		resonance.omni_range = 14.0
		resonance.position = finish + Vector3(float(index * 4 - 4), 2.0, float(index * 2 - 2))
		qa_root.add_child(resonance)
		_register_dynamic_light(resonance)
	if dynamic_light_count > MAX_DYNAMIC_LIGHTS:
		push_error("LIGHT_BUDGET_FAIL count=%d max=%d" % [dynamic_light_count, MAX_DYNAMIC_LIGHTS])
		quit(1)
		return
	print("LIGHT_INVENTORY dynamic_lights=%d max=%d" % [dynamic_light_count, MAX_DYNAMIC_LIGHTS])
	print("LIGHT_BUDGET_CONTRACT=PASS")
	var camera := Camera3D.new()
	camera.name = "R10R11DynamicCamera"
	camera.current = true
	camera.fov = 70.0
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
		camera.look_at_from_position(target + Vector3(-38.0, 26.0, -48.0), stable_target + Vector3(0.0, 2.6, 0.0), Vector3.UP)
		if frame % 30 == 0:
			print("R10R11_DYNAMIC progress=%0.2f" % progress)
		await create_timer(duration / float(frame_count)).timeout
	print("CP-D2-R1R6-022_R10_R11_DYNAMIC_CAPTURE=PASS")
	quit(0)

func _register_dynamic_light(light: Light3D) -> void:
	dynamic_light_count += 1

func _add_marker(position: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 1.20 if larger else 0.95
	sphere.height = 2.40 if larger else 1.90
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.24
	sphere.material = material
	marker.mesh = sphere
	marker.position = position
	qa_root.add_child(marker)
	var label := Label3D.new()
	label.text = title
	var is_r11 := title.begins_with("R11")
	label.position = position + (Vector3(8.0, 8.0, 0.0) if is_r11 else Vector3(-24.0, 7.0, 0.0))
	label.font_size = 72 if larger else 60
	label.pixel_size = 0.046 if larger else 0.038
	label.outline_size = 9
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)
