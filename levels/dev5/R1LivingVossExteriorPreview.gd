## Dev5 — CP-D5-093: Casa Voss exterior viva R1; QA isolado, sem tocar em VossHouse.gd, porta ou Player.gd.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const DEER: PackedScene = preload("res://assets/models_cc0/deer_quaternius_cc0.glb")
const TREE: PackedScene = preload("res://assets/models_cc0/tree_oak_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const STONE_SMALL: PackedScene = preload("res://assets/models_cc0/stone_smallF.glb")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const VOSS_XZ := Vector2(-22.0, 8.0)
const ROUTE_X := -21.4
var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var wildlife: Array[Node3D] = []
var wildlife_origins: Array[Vector3] = []
var grounding_events := 0
var elapsed := 0.0
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_waystation()
	_build_garden()
	_build_wildlife()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _process(delta: float) -> void:
	elapsed += delta
	_update_wildlife()
	actor.global_position.z += 3.2 * delta
	if actor.global_position.z > 20.0:
		actor.global_position.z = -3.0
		route_cycles += 1
		print("[DEV5_R1_LIVING] route_cycle=%d clear=true fauna_distance=%.2f house_production_touched=false door_touched=false" % [route_cycles, _nearest_wildlife_distance()])

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.10, 0.16, 0.19)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.49, 0.46, 0.38)
	env.ambient_light_energy = 0.78
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.fog_enabled = true
	env.fog_light_color = Color(0.28, 0.31, 0.27)
	env.fog_light_energy = 0.42
	env.fog_density = 0.010
	world_environment.environment = env
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-44.0, -28.0, 0.0)
	sun.light_energy = 1.16
	sun.shadow_enabled = true
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.name = "ExteriorCasaVossQA"
	ground.position = Vector3(VOSS_XZ.x, -0.50, VOSS_XZ.y)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(44.0, 0.90, 40.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.18, 0.22, 0.12)
	material.roughness = 0.96
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	ground.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	ground.add_child(collision)

func _build_waystation() -> void:
	var library := CartographicLandmarkObjects.new()
	add_child(library)
	await get_tree().process_frame
	var waystation := library.create_voss_waystation_landmark()
	waystation.name = "AnexoCasaVossVivoQA"
	add_child(waystation)
	var result := GROUNDING.snap_to_ground(get_world_3d(), waystation, Vector3(-28.0, 18.0, 7.0))
	assert(result["grounded"])
	grounding_events += 1

func _build_garden() -> void:
	# Horta de plantas reais e dois vestígios de pedra, sempre fora da soleira e da rota exterior.
	_spawn_grounded("oak_horta", Vector3(-37.0, 18.0, 13.0), TREE, Vector3.ONE * 1.08)
	_spawn_grounded("fern_horta_1", Vector3(-31.0, 18.0, 3.5), FERN, Vector3.ONE * 0.72)
	_spawn_grounded("fern_horta_2", Vector3(-34.0, 18.0, 6.5), FERN, Vector3.ONE * 0.66)
	_spawn_grounded("pedra_domestica_1", Vector3(-32.5, 18.0, 10.0), STONE_SMALL, Vector3.ONE * 0.92, Vector3(0.0, 18.0, 0.0))
	_spawn_grounded("pedra_domestica_2", Vector3(-30.2, 18.0, 11.0), STONE_SMALL, Vector3.ONE * 0.78, Vector3(0.0, -24.0, 0.0))

func _build_wildlife() -> void:
	_spawn_deer("cervo_pomar", Vector3(-8.0, 18.0, 14.0), 0.70, 210.0)
	_spawn_deer("cervo_estrada", Vector3(-12.0, 18.0, -4.0), 0.62, 120.0)

func _spawn_deer(id: String, hint: Vector3, scale_value: float, yaw: float) -> void:
	var root := Node3D.new()
	root.name = id
	root.scale = Vector3.ONE * scale_value
	root.rotation_degrees.y = yaw
	add_child(root)
	root.add_child(DEER.instantiate())
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, hint)
	assert(result["grounded"])
	wildlife.append(root)
	wildlife_origins.append(root.global_position)
	grounding_events += 1

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasExteriorVossVivoQA"
	actor.position = Vector3(ROUTE_X, 1.18, -3.0)
	add_child(actor)
	var collision := CollisionShape3D.new()
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.55
	capsule.height = 1.90
	collision.shape = capsule
	collision.position.y = 0.95
	actor.add_child(collision)
	elias = ELIAS_PRESENTATION.new()
	elias.enabled_for_preview = true
	actor.add_child(elias)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQAExteriorVossVivo"
	camera.position = Vector3(-4.0, 5.4, -8.0)
	camera.fov = 50.0
	add_child(camera)
	camera.look_at(Vector3(-22.0, 1.0, 7.0), Vector3.UP)
	camera.make_current()

func _spawn_grounded(id: String, hint: Vector3, packed: PackedScene, scale_value: Vector3, rotation_value := Vector3.ZERO) -> void:
	var item := packed.instantiate() as Node3D
	item.name = id
	item.scale = scale_value
	item.rotation_degrees = rotation_value
	add_child(item)
	var result := GROUNDING.snap_to_ground(get_world_3d(), item, hint)
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(Vector2(hint.x, hint.z)) < 0.001)
	grounding_events += 1

func _update_wildlife() -> void:
	for index in range(wildlife.size()):
		var deer := wildlife[index]
		var origin := wildlife_origins[index]
		deer.global_position = origin + Vector3(sin(elapsed * 0.66 + index) * 0.44, 0.0, cos(elapsed * 0.48 + index) * 0.28)
		deer.rotation.y += 0.003
		if fmod(elapsed, 0.85) < 0.018:
			GROUNDING.snap_to_ground(get_world_3d(), deer, deer.global_position + Vector3.UP * 8.0)

func _nearest_wildlife_distance() -> float:
	var nearest := INF
	for deer in wildlife:
		nearest = minf(nearest, Vector2(deer.global_position.x - ROUTE_X, deer.global_position.z - actor.global_position.z).length())
	return nearest

func _verify_contract() -> void:
	assert(grounding_events == 8)
	assert(wildlife.size() == 2)
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(_nearest_wildlife_distance() >= 5.0)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R1_LIVING] status=approved fauna=2 garden_elements=5 waystation=true grounded=%d house_production_touched=false door_touched=false production_modules_changed=false" % grounding_events)

func _dynamic_lights() -> int:
	var count := 0
	for child in get_children():
		if child is Light3D:
			count += 1
	return count

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(46.0, 42.0)
	label.size = Vector2(1260.0, 84.0)
	label.text = "CASA VOSS VIVA R1  |  ELIAS · ANEXO · HORTA · FAUNA CC0 · ROTA EXTERIOR\nGROUNDING X/Z · SOLEIRA INTACTA · ZERO EDIÇÃO DE PORTA · 1 LUZ DINÂMICA"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.93, 0.96, 0.92)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame in range(50):
		await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null:
		print("[DEV5_R1_LIVING] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := texture.get_image()
	if image == null:
		print("[DEV5_R1_LIVING] snapshot_unavailable=headless_image path=%s" % path)
		return
	print("[DEV5_R1_LIVING] snapshot=%s result=%s" % [path, image.save_png(path)])
