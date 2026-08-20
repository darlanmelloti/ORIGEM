extends SceneTree
## CP-D2-R1R6-024 — captura dinâmica QA-only R11→R12.
## Demonstra a aproximação ao Hub Temporal sem modificar a geometria de produção.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const MAX_DYNAMIC_LIGHTS := 16
var qa_root: Node3D
var dynamic_light_count := 0

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R11R12CaptureQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#211c3f")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#a59bc9")
	world.ambient_light_energy = 0.52
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-35.0, -25.0, 0.0)
	sun.light_energy = 0.35
	qa_root.add_child(sun)
	_register_dynamic_light(sun)
	var ground := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(500.0, 250.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color("#2d2a49")
	ground_material.roughness = 0.90
	plane.material = ground_material
	ground.mesh = plane
	ground.position = Vector3(24.0, -0.06, 386.0)
	qa_root.add_child(ground)
	var start := Anchors.world_position(Anchors.CAMARA_ORION_CUBE, 0.0, 0.2)
	var finish := Anchors.world_position(Anchors.HUB_TEMPORAL, 0.0, 0.2)
	_add_marker(start, "R11 CÂMARA DO ORION CUBE", Color("#c9a4ff"), true)
	_add_marker(finish, "R12 HUB TEMPORAL", Color("#f0b6ff"), true)
	var corridor := MeshInstance3D.new()
	var corridor_mesh := BoxMesh.new()
	corridor_mesh.size = Vector3(5.0, 0.10, start.distance_to(finish))
	var corridor_material := StandardMaterial3D.new()
	corridor_material.albedo_color = Color("#a37ad0")
	corridor_mesh.material = corridor_material
	corridor.mesh = corridor_mesh
	corridor.position = (start + finish) * 0.5
	corridor.look_at_from_position(corridor.position, finish, Vector3.UP)
	qa_root.add_child(corridor)
	var temporal_core := MeshInstance3D.new()
	var core_mesh := SphereMesh.new()
	core_mesh.radius = 5.5
	core_mesh.height = 11.0
	var core_material := StandardMaterial3D.new()
	core_material.albedo_color = Color("#b57cff")
	core_material.emission_enabled = true
	core_material.emission = Color("#6c3fbf")
	core_material.emission_energy_multiplier = 2.3
	core_mesh.material = core_material
	temporal_core.mesh = core_mesh
	temporal_core.position = finish + Vector3(0.0, 5.5, 0.0)
	qa_root.add_child(temporal_core)
	for index: int in range(5):
		var resonance := OmniLight3D.new()
		resonance.name = "R12_Temporal_Resonance_%02d" % (index + 1)
		resonance.light_color = Color("#b56eff") if index % 2 == 0 else Color("#5cc8ff")
		resonance.light_energy = 1.65
		resonance.omni_range = 20.0
		resonance.position = finish + Vector3(cos(float(index)) * 8.0, 2.0 + float(index), sin(float(index)) * 8.0)
		qa_root.add_child(resonance)
		_register_dynamic_light(resonance)
	if dynamic_light_count > MAX_DYNAMIC_LIGHTS:
		push_error("LIGHT_BUDGET_FAIL count=%d max=%d" % [dynamic_light_count, MAX_DYNAMIC_LIGHTS])
		quit(1)
		return
	print("LIGHT_INVENTORY dynamic_lights=%d max=%d" % [dynamic_light_count, MAX_DYNAMIC_LIGHTS])
	print("LIGHT_BUDGET_CONTRACT=PASS")
	var camera := Camera3D.new()
	camera.name = "R11R12DynamicCamera"
	camera.current = true
	camera.fov = 86.0
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
		camera.look_at_from_position(target + Vector3(-175.0, 105.0, -228.0), stable_target + Vector3(0.0, 10.0, 0.0), Vector3.UP)
		if frame % 30 == 0:
			print("R11R12_DYNAMIC progress=%0.2f" % progress)
		await create_timer(duration / float(frame_count)).timeout
	print("CP-D2-R1R6-024_R11_R12_DYNAMIC_CAPTURE=PASS")
	quit(0)

func _register_dynamic_light(light: Light3D) -> void:
	dynamic_light_count += 1

func _add_marker(position: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 5.0 if larger else 3.2
	sphere.height = 10.0 if larger else 6.4
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.26
	sphere.material = material
	marker.mesh = sphere
	marker.position = position
	qa_root.add_child(marker)
	var label := Label3D.new()
	label.text = title
	label.position = position + Vector3(-12.0, 14.0, 0.0)
	label.font_size = 148 if larger else 118
	label.pixel_size = 0.086 if larger else 0.070
	label.outline_size = 10
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)
