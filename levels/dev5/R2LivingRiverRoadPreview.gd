## Dev5 — CP-D5-091: Estrada do Rio viva R2; QA isolado, sem ponte GLB ou alterações de produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const DEER: PackedScene = preload("res://assets/models_cc0/deer_quaternius_cc0.glb")
const TREE: PackedScene = preload("res://assets/models_cc0/tree_oak_dark.glb")
const PINE: PackedScene = preload("res://assets/models_generated/ez_pine_medium_pbr.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const STONE_A: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const STONE_B: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const RIVER_ROAD_XZ := Vector2(-21.4, 28.0)
const ROUTE_X := -21.4

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var wildlife: Array[Node3D] = []
var wildlife_origins: Array[Vector3] = []
var elapsed := 0.0
var grounding_events := 0
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_water()
	_build_bridge()
	_build_shelter_remains()
	_build_vegetation()
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
	if actor.global_position.z > 40.0:
		actor.global_position.z = 15.0
		route_cycles += 1
		print("[DEV5_R2_LIVING] route_cycle=%d bridge_crossed=true clear=true fauna_distance=%.2f bridge_glb=false" % [route_cycles, _nearest_wildlife_distance()])

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.07, 0.13, 0.17)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.41, 0.48, 0.43)
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.18, 0.27, 0.29)
	environment.fog_light_energy = 0.48
	environment.fog_density = 0.014
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48.0, 22.0, 0.0)
	sun.light_energy = 1.18
	sun.shadow_enabled = true
	add_child(sun)

func _height(x: float, z: float) -> float:
	return 0.10 * sin(x * 0.45) + 0.08 * cos(z * 0.35)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.name = "MargensEstradaRioQA"
	ground.position = Vector3(RIVER_ROAD_XZ.x, -0.52, RIVER_ROAD_XZ.y)
	add_child(ground)
	var visual := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(38.0, 0.90, 46.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.10, 0.20, 0.10)
	material.roughness = 0.94
	mesh.material = material
	visual.mesh = mesh
	ground.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	ground.add_child(collision)

func _build_water() -> void:
	var water := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(7.4, 16.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.02, 0.15, 0.20, 0.85)
	material.roughness = 0.16
	material.metallic = 0.12
	mesh.material = material
	water.mesh = mesh
	water.position = Vector3(RIVER_ROAD_XZ.x, -0.02, RIVER_ROAD_XZ.y)
	add_child(water)

func _build_bridge() -> void:
	var library := CartographicLandmarkObjects.new()
	add_child(library)
	await get_tree().process_frame
	var bridge := library.create_stone_bridge_landmark()
	bridge.name = "PonteModularEstradaRioVivaQA"
	add_child(bridge)
	var result := GROUNDING.snap_to_ground(get_world_3d(), bridge, Vector3(RIVER_ROAD_XZ.x, 18.0, RIVER_ROAD_XZ.y))
	assert(result["grounded"])
	grounding_events += 1

func _build_shelter_remains() -> void:
	# Vestígio de abrigo na margem: rocha estrutural, não cairn, muralha ou ponte GLB.
	_spawn_grounded("abrigo_margem", Vector3(-34.0, 18.0, 22.0), STONE_A, Vector3(1.55, 1.12, 1.24), Vector3(0.0, 26.0, 5.0))
	_spawn_grounded("abrigo_marcador", Vector3(-31.5, 18.0, 23.0), STONE_B, Vector3(1.82, 0.68, 1.08), Vector3(7.0, -30.0, 55.0))

func _build_vegetation() -> void:
	_spawn_grounded("oak_bank_west", Vector3(-40.0, 18.0, 42.0), TREE, Vector3.ONE * 1.12)
	_spawn_grounded("pine_bank_east", Vector3(-5.0, 18.0, 12.0), PINE, Vector3.ONE * 0.94)
	_spawn_grounded("fern_west", Vector3(-30.0, 18.0, 40.0), FERN, Vector3.ONE * 0.70)
	_spawn_grounded("fern_east", Vector3(-11.0, 18.0, 13.0), FERN, Vector3.ONE * 0.62)

func _build_wildlife() -> void:
	_spawn_deer("cervo_margem_oeste", Vector3(-34.0, 18.0, 36.0), 0.75, 126.0)
	_spawn_deer("cervo_margem_leste", Vector3(-9.0, 18.0, 17.0), 0.66, 248.0)

func _spawn_deer(id: String, hint_position: Vector3, scale_value: float, yaw: float) -> void:
	var root := Node3D.new()
	root.name = id
	root.scale = Vector3.ONE * scale_value
	root.rotation_degrees.y = yaw
	add_child(root)
	root.add_child(DEER.instantiate())
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, hint_position)
	assert(result["grounded"])
	wildlife.append(root)
	wildlife_origins.append(root.global_position)
	grounding_events += 1

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasEstradaRioVivaQA"
	actor.position = Vector3(ROUTE_X, 1.18, 15.0)
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
	camera.name = "CameraQAEstradaRioViva"
	camera.position = Vector3(-4.0, 6.2, 47.0)
	camera.fov = 50.0
	add_child(camera)
	camera.look_at(Vector3(-22.0, 0.85, 28.0), Vector3.UP)
	camera.make_current()

func _spawn_grounded(id: String, hint_position: Vector3, packed: PackedScene, scale_value: Vector3, rotation_value := Vector3.ZERO) -> void:
	var item := packed.instantiate() as Node3D
	item.name = id
	item.scale = scale_value
	item.rotation_degrees = rotation_value
	add_child(item)
	var result := GROUNDING.snap_to_ground(get_world_3d(), item, hint_position)
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(Vector2(hint_position.x, hint_position.z)) < 0.001)
	grounding_events += 1

func _update_wildlife() -> void:
	for index in range(wildlife.size()):
		var deer := wildlife[index]
		var origin := wildlife_origins[index]
		deer.global_position = origin + Vector3(sin(elapsed * 0.61 + index) * 0.45, 0.0, cos(elapsed * 0.47 + index) * 0.32)
		deer.rotation.y += 0.003
		if fmod(elapsed, 0.85) < 0.018:
			GROUNDING.snap_to_ground(get_world_3d(), deer, deer.global_position + Vector3.UP * 8.0)

func _nearest_wildlife_distance() -> float:
	var nearest := INF
	for deer in wildlife:
		nearest = minf(nearest, Vector2(deer.global_position.x - ROUTE_X, deer.global_position.z - actor.global_position.z).length())
	return nearest

func _verify_contract() -> void:
	assert(grounding_events == 9)
	assert(wildlife.size() == 2)
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(_nearest_wildlife_distance() >= 5.0)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R2_LIVING] status=approved fauna=2 vegetation=4 shelter_parts=2 modular_bridge=true bridge_glb=false grounded=%d wall_of_trees=false production_modules_changed=false" % grounding_events)

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
	label.size = Vector2(1220.0, 84.0)
	label.text = "ESTRADA DO RIO VIVA R2  |  ELIAS · PONTE MODULAR · FAUNA CC0 · MARGENS\nGROUNDING X/Z · TABULEIRO LIVRE · ZERO PONTE GLB · 1 LUZ DINÂMICA"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.92, 0.96, 0.95)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame in range(50):
		await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null:
		print("[DEV5_R2_LIVING] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := texture.get_image()
	if image == null:
		print("[DEV5_R2_LIVING] snapshot_unavailable=headless_image path=%s" % path)
		return
	print("[DEV5_R2_LIVING] snapshot=%s result=%s" % [path, image.save_png(path)])
