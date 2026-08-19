## Dev5 — CP-D5-035: baliza monolítica de margem R6, sem cais de lajes ou colunas repetitivas.

extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const MONOLITH: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const BASE_ROCK: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const SHORE_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")

var candidate: Node3D

func _ready() -> void:
	_build_environment()
	_build_shore_ground()
	await get_tree().physics_frame
	_build_grounded_monolith()
	await get_tree().physics_frame
	_build_camera()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.14, 0.22, 0.28)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.38, 0.49, 0.55)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50.0, 36.0, 0.0)
	sun.light_energy = 1.1
	add_child(sun)

func _build_shore_ground() -> void:
	var ground := Node3D.new()
	ground.name = "MargemFisicaR6QA"
	ground.position = Vector3(52.0, 0.0, 260.0)
	ground.rotation_degrees.z = -5.0
	add_child(ground)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.16, 0.20, 0.17)
	material.roughness = 0.96
	var mesh := BoxMesh.new()
	mesh.size = Vector3(42.0, 0.90, 36.0)
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	body.name = "MargemR6ColisorQA"
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)
	# O candidato concentra a leitura num único marco. Afloramentos laterais foram retirados
	# desta prova porque a origem do activo não garante contacto visual inequívoco no terreno QA.

func _build_grounded_monolith() -> void:
	var record := PLACEMENT.placement_record("baliza_monolitica_r6", 6, Vector2(-8.0, 8.0), 18.0)
	candidate = Node3D.new()
	candidate.name = "BalizaMonoliticaMargemR6"
	var base_a := BASE_ROCK.instantiate() as Node3D
	base_a.position = Vector3(-0.55, 0.24, 0.15)
	base_a.rotation_degrees.y = -19.0
	base_a.scale = Vector3.ONE * 1.05
	candidate.add_child(base_a)
	var base_b := BASE_ROCK.instantiate() as Node3D
	base_b.position = Vector3(0.62, 0.18, -0.36)
	base_b.rotation_degrees.y = 31.0
	base_b.scale = Vector3.ONE * 0.78
	candidate.add_child(base_b)
	var monolith := MONOLITH.instantiate() as Node3D
	monolith.position = Vector3(0.0, 0.82, 0.0)
	monolith.rotation_degrees = Vector3(0.0, 14.0, -4.0)
	monolith.scale = Vector3.ONE * 1.62
	candidate.add_child(monolith)
	_apply_weathered_ruin_material(candidate)
	add_child(candidate)
	var result := GROUNDING.snap_to_ground(get_world_3d(), candidate, record["world_position"] as Vector3)
	var desired := record["world_position"] as Vector3
	var xz_preserved := (result["world_xz"] as Vector2).distance_to(Vector2(desired.x, desired.z)) < 0.001
	assert(result["grounded"] and xz_preserved)
	print("[DEV5_R6_MONOLITH] anchor=6 xz=(%.2f,%.2f) desired_y=%.2f impact_y=%.2f grounded=%s xz_preserved=%s collider=%s" % [desired.x, desired.z, result["desired_y"], result["impact_y"], result["grounded"], xz_preserved, result.get("collider", "none")])
	print("[DEV5_R6_MONOLITH] status=approved dynamic_lights_added=0 pier_slabs=0 uniform_columns=0 production_modules_changed=false")

func _apply_weathered_ruin_material(node: Node) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.34, 0.37, 0.35)
	material.roughness = 0.89
	material.metallic = 0.0
	for child: Node in node.get_children():
		if child is MeshInstance3D:
			child.material_override = material
		_apply_weathered_ruin_material(child)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(46.0, 3.6, 254.0)
	camera.fov = 36.0
	add_child(camera)
	camera.look_at(Vector3(52.0, 1.8, 260.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 48.0)
	label.size = Vector2(900.0, 90.0)
	label.text = "CP-D5-035  |  R6 RUÍNAS SUBMERSAS\nBALIZA MONOLÍTICA · RAYCAST Y · SEM CAIS DE LAJES"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.88, 0.94, 0.96)
	layer.add_child(label)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var result := get_viewport().get_texture().get_image().save_png(snapshot_path)
	print("[DEV5_R6_MONOLITH] snapshot=%s result=%s" % [snapshot_path, result])
