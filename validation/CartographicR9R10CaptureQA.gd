extends SceneTree
## CP-D2-R1R6-020 — captura dinâmica QA-only R9→R10.
## O cenário é uma evidência de continuidade e não substitui geometria de produção.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const MAX_DYNAMIC_LIGHTS := 16
var qa_root: Node3D
var dynamic_light_count := 0

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R9R10CaptureQA"
	get_root().add_child(qa_root)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#718b96")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#c5d2d2")
	world.ambient_light_energy = 0.92
	environment.environment = world
	qa_root.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-40.0, -32.0, 0.0)
	sun.light_energy = 1.05
	qa_root.add_child(sun)
	_register_dynamic_light(sun)
	var ground := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(400.0, 180.0)
	var ground_material := StandardMaterial3D.new()
	ground_material.albedo_color = Color("#354d47")
	ground_material.roughness = 0.95
	plane.material = ground_material
	ground.mesh = plane
	ground.position = Vector3(25.0, -0.06, 481.0)
	qa_root.add_child(ground)
	var start := Anchors.world_position(Anchors.TRILHA_MONTANHA_INICIO, 0.0, 0.2)
	var finish := Anchors.world_position(Anchors.CAVERNA_ORION, 0.0, 0.2)
	_add_marker(start, "R9 TRILHA DA MONTANHA", Color("#8dd0e8"), true)
	_add_marker(finish, "R10 CAVERNA DO ORION", Color("#63d6da"), true)
	var corridor := MeshInstance3D.new()
	var corridor_mesh := BoxMesh.new()
	corridor_mesh.size = Vector3(4.0, 0.10, start.distance_to(finish))
	var corridor_material := StandardMaterial3D.new()
	corridor_material.albedo_color = Color("#c69b57")
	corridor_mesh.material = corridor_material
	corridor.mesh = corridor_mesh
	corridor.position = (start + finish) * 0.5
	corridor.look_at_from_position(corridor.position, finish, Vector3.UP)
	qa_root.add_child(corridor)
	for index: int in range(3):
		var resonance := OmniLight3D.new()
		resonance.name = "R10_Resonance_%02d" % (index + 1)
		resonance.light_color = Color("#5cc8ff")
		resonance.light_energy = 1.8
		resonance.omni_range = 18.0
		resonance.position = finish + Vector3(float(index * 5 - 5), 2.4, float(index * 3 - 3))
		qa_root.add_child(resonance)
		_register_dynamic_light(resonance)
	if dynamic_light_count > MAX_DYNAMIC_LIGHTS:
		push_error("LIGHT_BUDGET_FAIL count=%d max=%d" % [dynamic_light_count, MAX_DYNAMIC_LIGHTS])
		quit(1)
		return
	print("LIGHT_INVENTORY dynamic_lights=%d max=%d" % [dynamic_light_count, MAX_DYNAMIC_LIGHTS])
	print("LIGHT_BUDGET_CONTRACT=PASS")
	var camera := Camera3D.new()
	camera.name = "R9R10DynamicCamera"
	camera.current = true
	camera.fov = 72.0
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
		camera.look_at_from_position(target + Vector3(-90.0, 52.0, -118.0), stable_target + Vector3(0.0, 4.0, 0.0), Vector3.UP)
		if frame % 30 == 0:
			print("R9R10_DYNAMIC progress=%0.2f" % progress)
		await create_timer(duration / float(frame_count)).timeout
	print("CP-D2-R1R6-020_R9_R10_DYNAMIC_CAPTURE=PASS")
	quit(0)

func _register_dynamic_light(light: Light3D) -> void:
	dynamic_light_count += 1

func _add_marker(position: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 1.25 if larger else 1.0
	sphere.height = 2.5 if larger else 2.0
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color * 0.28
	sphere.material = material
	marker.mesh = sphere
	marker.position = position
	qa_root.add_child(marker)
	var label := Label3D.new()
	label.text = title
	var is_r10 := title.begins_with("R10")
	label.position = position + (Vector3(18.0, 10.0, 0.0) if is_r10 else Vector3(-26.0, 10.0, 0.0))
	label.font_size = 78 if larger else 64
	label.pixel_size = 0.050 if larger else 0.041
	label.outline_size = 9
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	qa_root.add_child(label)
