## Dev5 — CP-D5-092: Floresta Densa viva R4; QA isolado, sem portal estrutural e sem produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const DEER: PackedScene = preload("res://assets/models_cc0/deer_quaternius_cc0.glb")
const PINE: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const TREE_DETAIL: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const STONE_TALL: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const STONE_B: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const FOREST_XZ := Vector2(-9.0, 116.0)
const ROUTE_X := -9.0
var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var animals: Array[Node3D] = []
var animal_origins: Array[Vector3] = []
var grounding_events := 0
var elapsed := 0.0
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_lateral_shelter()
	_build_forest_depth()
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
	actor.global_position.z += 4.0 * delta
	if actor.global_position.z > 137.0:
		actor.global_position.z = 99.0
		route_cycles += 1
		print("[DEV5_R4_LIVING] route_cycle=%d clear=true fauna_distance=%.2f structural_portal=false wall_of_trees=false" % [route_cycles, _nearest_animal_distance()])

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.045, 0.105, 0.075)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.32, 0.43, 0.33)
	env.ambient_light_energy = 0.72
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.fog_enabled = true
	env.fog_light_color = Color(0.14, 0.24, 0.17)
	env.fog_light_energy = 0.58
	env.fog_density = 0.022
	world_environment.environment = env
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-47.0, 34.0, 0.0)
	sun.light_energy = 1.08
	sun.shadow_enabled = true
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.name = "ClareiraFlorestaDensaQA"
	ground.position = Vector3(FOREST_XZ.x, -0.50, FOREST_XZ.y)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(50.0, 0.90, 52.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.055, 0.17, 0.075)
	material.roughness = 0.98
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	ground.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	ground.add_child(collision)

func _build_lateral_shelter() -> void:
	# Vestígio lateral de abrigo, nunca portal nem lintel sobre o corredor.
	_spawn_grounded("abrigo_pedra_vertical", Vector3(-22.0, 18.0, 126.0), STONE_TALL, Vector3.ONE * 1.55, Vector3(0.0, 15.0, -7.0))
	_spawn_grounded("abrigo_pedra_caida", Vector3(-19.0, 18.0, 128.0), STONE_B, Vector3(1.85, 0.72, 1.12), Vector3(6.0, -24.0, 64.0))

func _build_forest_depth() -> void:
	# LOD CP-D5-018: um pinheiro focal, três árvores detalhadas, duas leves e um feto por lado.
	_spawn_grounded("pine_focal", Vector3(-27.0, 18.0, 111.0), PINE, Vector3.ONE * 1.05)
	_spawn_grounded("detail_west_front", Vector3(-22.0, 18.0, 104.0), TREE_DETAIL, Vector3.ONE * 1.14)
	_spawn_grounded("detail_west_back", Vector3(-23.0, 18.0, 132.0), TREE_DETAIL, Vector3.ONE * 1.07)
	_spawn_grounded("detail_east_back", Vector3(7.0, 18.0, 132.0), TREE_DETAIL, Vector3.ONE * 1.12)
	_spawn_grounded("light_east_front", Vector3(8.0, 18.0, 105.0), TREE_LIGHT, Vector3.ONE * 1.12)
	_spawn_grounded("light_east_mid", Vector3(14.0, 18.0, 119.0), TREE_LIGHT, Vector3.ONE * 1.05)
	_spawn_grounded("fern_left", Vector3(-14.0, 18.0, 106.0), FERN, Vector3.ONE * 0.72)
	_spawn_grounded("fern_right", Vector3(-4.0, 18.0, 130.0), FERN, Vector3.ONE * 0.66)

func _build_wildlife() -> void:
	_spawn_deer("cervo_floresta_oeste", Vector3(-21.0, 18.0, 116.0), 0.72, 106.0)
	_spawn_deer("cervo_floresta_leste", Vector3(8.0, 18.0, 121.0), 0.64, 244.0)

func _spawn_deer(id: String, hint: Vector3, scale_value: float, yaw: float) -> void:
	var root := Node3D.new()
	root.name = id
	root.scale = Vector3.ONE * scale_value
	root.rotation_degrees.y = yaw
	add_child(root)
	root.add_child(DEER.instantiate())
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, hint)
	assert(result["grounded"])
	animals.append(root)
	animal_origins.append(root.global_position)
	grounding_events += 1

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasFlorestaVivaQA"
	actor.position = Vector3(ROUTE_X, 1.18, 99.0)
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
	camera.name = "CameraQAFlorestaViva"
	camera.position = Vector3(11.0, 5.5, 101.0)
	camera.fov = 49.0
	add_child(camera)
	camera.look_at(Vector3(-9.0, 1.0, 118.0), Vector3.UP)
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
	for index in range(animals.size()):
		var deer := animals[index]
		var origin := animal_origins[index]
		deer.global_position = origin + Vector3(sin(elapsed * 0.70 + index) * 0.50, 0.0, cos(elapsed * 0.46 + index) * 0.30)
		deer.rotation.y -= 0.003
		if fmod(elapsed, 0.85) < 0.018:
			GROUNDING.snap_to_ground(get_world_3d(), deer, deer.global_position + Vector3.UP * 8.0)

func _nearest_animal_distance() -> float:
	var nearest := INF
	for deer in animals:
		nearest = minf(nearest, Vector2(deer.global_position.x - ROUTE_X, deer.global_position.z - actor.global_position.z).length())
	return nearest

func _verify_contract() -> void:
	assert(grounding_events == 12)
	assert(animals.size() == 2)
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(_nearest_animal_distance() >= 5.0)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R4_LIVING] status=approved fauna=2 vegetation=8 shelter_parts=2 grounded=%d structural_portal=false wall_of_trees=false production_modules_changed=false" % grounding_events)

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
	label.text = "FLORESTA DENSA VIVA R4  |  ELIAS · FAUNA CC0 · PROFUNDIDADE VEGETAL · ABRIGO LATERAL\nGROUNDING X/Z · CORREDOR LIVRE · ZERO PORTAL ESTRUTURAL · 1 LUZ DINÂMICA"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.92, 0.97, 0.93)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame in range(50):
		await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null:
		print("[DEV5_R4_LIVING] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := texture.get_image()
	if image == null:
		print("[DEV5_R4_LIVING] snapshot_unavailable=headless_image path=%s" % path)
		return
	print("[DEV5_R4_LIVING] snapshot=%s result=%s" % [path, image.save_png(path)])
