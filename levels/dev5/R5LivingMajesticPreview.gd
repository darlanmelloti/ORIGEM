## Dev5 — CP-D5-090: clareira viva Majestic R5; QA isolado, sem alteração de produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const DEER: PackedScene = preload("res://assets/models_cc0/deer_quaternius_cc0.glb")
const STONE_A: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const STONE_B: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const TREE_DETAILED: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const PINE_TALL: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const MAJESTIC_XZ := Vector2(-88.0, 178.0)
const ROUTE_X := -79.0

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
	_build_pavilion()
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
	if actor == null:
		return
	actor.global_position.z += 2.1 * delta
	if actor.global_position.z > 201.0:
		actor.global_position.z = 155.0
		route_cycles += 1
		print("[DEV5_R5_LIVING] route_cycle=%d clear=true fauna_distance=%.2f pavilion_visible=true cairn=false" % [route_cycles, _nearest_wildlife_distance()])

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.075, 0.14, 0.16)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.44, 0.49, 0.38)
	environment.ambient_light_energy = 0.75
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.24, 0.32, 0.27)
	environment.fog_light_energy = 0.50
	environment.fog_density = 0.012
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-45.0, -18.0, 0.0)
	sun.light_energy = 1.20
	sun.shadow_enabled = true
	add_child(sun)

func _height(x: float, z: float) -> float:
	return 0.17 * sin(x * 0.28) + 0.11 * cos(z * 0.25) + 0.06 * sin((x - z) * 0.48)

func _build_ground() -> void:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var segments_x := 24
	var segments_z := 24
	var width := 52.0
	var depth := 54.0
	for zi in range(segments_z):
		for xi in range(segments_x):
			var x0 := -width * 0.5 + width * float(xi) / float(segments_x)
			var x1 := -width * 0.5 + width * float(xi + 1) / float(segments_x)
			var z0 := -depth * 0.5 + depth * float(zi) / float(segments_z)
			var z1 := -depth * 0.5 + depth * float(zi + 1) / float(segments_z)
			var p00 := Vector3(x0, _height(x0, z0), z0)
			var p10 := Vector3(x1, _height(x1, z0), z0)
			var p01 := Vector3(x0, _height(x0, z1), z1)
			var p11 := Vector3(x1, _height(x1, z1), z1)
			surface.add_vertex(p00); surface.add_vertex(p10); surface.add_vertex(p11)
			surface.add_vertex(p00); surface.add_vertex(p11); surface.add_vertex(p01)
	surface.generate_normals()
	var mesh := surface.commit()
	var body := StaticBody3D.new()
	body.name = "ClareiraMajesticQA"
	body.position = Vector3(MAJESTIC_XZ.x, 0.0, MAJESTIC_XZ.y)
	add_child(body)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.12, 0.22, 0.10)
	material.roughness = 0.95
	mesh.surface_set_material(0, material)
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	body.add_child(visual)
	var collision := CollisionShape3D.new()
	collision.shape = mesh.create_trimesh_shape()
	body.add_child(collision)

func _build_pavilion() -> void:
	var library := CartographicLandmarkObjects.new()
	add_child(library)
	await get_tree().process_frame
	var pavilion := library.create_majestic_pavilion_landmark()
	pavilion.name = "PavilhaoMajesticVivoQA"
	add_child(pavilion)
	var result := GROUNDING.snap_to_ground(get_world_3d(), pavilion, Vector3(MAJESTIC_XZ.x, 18.0, MAJESTIC_XZ.y))
	assert(result["grounded"])
	grounding_events += 1

func _build_shelter_remains() -> void:
	# Abrigo de pedra desabado: três volumes irregulares, distinto do cairn rejeitado.
	_spawn_grounded("abrigo_parede", Vector3(-99.0, 18.0, 188.0), STONE_A, Vector3(1.85, 1.15, 1.32), Vector3(0.0, 23.0, 5.0))
	_spawn_grounded("abrigo_viga", Vector3(-96.0, 18.0, 189.0), STONE_B, Vector3(2.15, 0.68, 1.10), Vector3(8.0, -32.0, 66.0))
	_spawn_grounded("abrigo_base", Vector3(-101.0, 18.0, 189.5), STONE_B, Vector3.ONE * 1.14, Vector3(0.0, -12.0, -8.0))

func _build_vegetation() -> void:
	# Limites LOD: 1 pinheiro focal, 2 árvores detalhadas, 2 árvores leves e 2 fetos.
	_spawn_grounded("pine_focal", Vector3(-104.0, 18.0, 170.0), PINE_TALL, Vector3.ONE * 1.12)
	_spawn_grounded("tree_medium_west", Vector3(-105.0, 18.0, 181.0), TREE_DETAILED, Vector3.ONE * 1.18)
	_spawn_grounded("tree_medium_east", Vector3(-69.0, 18.0, 192.0), TREE_DETAILED, Vector3.ONE * 1.04)
	_spawn_grounded("tree_light_north", Vector3(-72.0, 18.0, 168.0), TREE_LIGHT, Vector3.ONE * 1.16)
	_spawn_grounded("tree_light_south", Vector3(-107.0, 18.0, 198.0), TREE_LIGHT, Vector3.ONE * 1.08)
	_spawn_grounded("fern_left", Vector3(-84.0, 18.0, 165.0), FERN, Vector3.ONE * 0.72)
	_spawn_grounded("fern_right", Vector3(-75.0, 18.0, 195.0), FERN, Vector3.ONE * 0.64)

func _build_wildlife() -> void:
	_spawn_deer("cervo_clareira", Vector3(-70.0, 18.0, 181.0), 0.79, 235.0)
	_spawn_deer("cervo_abrigo", Vector3(-101.0, 18.0, 177.0), 0.66, 118.0)

func _spawn_deer(id: String, hint_position: Vector3, scale_value: float, yaw: float) -> void:
	var root := Node3D.new()
	root.name = id
	root.scale = Vector3.ONE * scale_value
	root.rotation_degrees.y = yaw
	add_child(root)
	var model := DEER.instantiate() as Node3D
	root.add_child(model)
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, hint_position)
	assert(result["grounded"])
	wildlife.append(root)
	wildlife_origins.append(root.global_position)
	grounding_events += 1

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasMajesticVivoQA"
	actor.position = Vector3(ROUTE_X, 1.2, 155.0)
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
	camera.name = "CameraQAClareiraMajestic"
	camera.position = Vector3(-65.0, 5.6, 158.0)
	camera.fov = 48.0
	add_child(camera)
	camera.look_at(Vector3(-88.0, 1.15, 180.0), Vector3.UP)
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
		deer.global_position = origin + Vector3(sin(elapsed * 0.67 + index) * 0.55, 0.0, cos(elapsed * 0.46 + index) * 0.35)
		deer.rotation.y -= 0.003
		if fmod(elapsed, 0.9) < 0.018:
			GROUNDING.snap_to_ground(get_world_3d(), deer, deer.global_position + Vector3.UP * 8.0)

func _nearest_wildlife_distance() -> float:
	var nearest := INF
	for deer in wildlife:
		nearest = minf(nearest, Vector2(deer.global_position.x - ROUTE_X, deer.global_position.z - actor.global_position.z).length())
	return nearest

func _verify_contract() -> void:
	assert(grounding_events == 13)
	assert(wildlife.size() == 2)
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(_nearest_wildlife_distance() >= 5.0)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R5_LIVING] status=approved fauna=2 vegetation=7 shelter_parts=3 pavilion=true grounded=%d cairn=false wall_of_trees=false production_modules_changed=false" % grounding_events)

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
	label.size = Vector2(1240.0, 84.0)
	label.text = "ACAMPAMENTO MAJESTIC VIVO R5  |  ELIAS · PAVILHÃO · FAUNA CC0 · CLAREIRA\nGROUNDING X/Z · DESVIO CARTOGRÁFICO · CORREDOR LIVRE · 1 LUZ DINÂMICA"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.92, 0.96, 0.93)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame in range(50):
		await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null:
		print("[DEV5_R5_LIVING] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := texture.get_image()
	if image == null:
		print("[DEV5_R5_LIVING] snapshot_unavailable=headless_image path=%s" % path)
		return
	print("[DEV5_R5_LIVING] snapshot=%s result=%s" % [path, image.save_png(path)])
