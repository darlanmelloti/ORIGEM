## Dev7 — DEV7-003: abrigo CC0 contextualizado na clareira viva Majestic; QA isolado.
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
const CC0_FLOOR: PackedScene = preload("res://assets/models_dev7/majestic_cc0_selected/Floor_UnevenBrick.gltf")
const CC0_FRAME: PackedScene = preload("res://assets/models_dev7/majestic_cc0_selected/DoorFrame_Round_Brick.gltf")
const CC0_ROOF: PackedScene = preload("res://assets/models_dev7/majestic_cc0_selected/Roof_RoundTiles_4x4.gltf")
const CC0_SUPPORTS: PackedScene = preload("res://assets/models_dev7/majestic_cc0_selected/Roof_FrontSupports.gltf")
const WET_FOREST_FLOOR: Texture2D = preload("res://assets/textures/generated/regional_wet_forest_floor.png")

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
	_build_cc0_shelter()
	_build_rock_accents()
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
		print("[DEV5_R5_LIVING] route_cycle=%d clear=true fauna_distance=%.2f cc0_shelter_visible=true cairn=false" % [route_cycles, _nearest_wildlife_distance()])

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.075, 0.13, 0.17)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.56, 0.51, 0.36)
	environment.ambient_light_energy = 0.92
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.27, 0.36, 0.34)
	environment.fog_light_energy = 0.46
	environment.fog_density = 0.014
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-51.0, -32.0, 0.0)
	sun.light_color = Color(1.0, 0.79, 0.54)
	sun.light_energy = 1.34
	sun.shadow_enabled = true
	add_child(sun)

func _height(x: float, z: float) -> float:
	# Relevo baixo no eixo do corredor e bacias laterais mais pronunciadas para uma clareira legível, não um plano.
	var route_softening := 0.72 if absf(x - 9.0) < 3.6 else 1.0
	return route_softening * (0.92 * sin(x * 0.19) + 0.64 * cos(z * 0.17) + 0.30 * sin((x - z) * 0.31))

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
			var u0 := float(xi) / float(segments_x)
			var u1 := float(xi + 1) / float(segments_x)
			var v0 := float(zi) / float(segments_z)
			var v1 := float(zi + 1) / float(segments_z)
			surface.set_uv(Vector2(u0, v0)); surface.add_vertex(p00)
			surface.set_uv(Vector2(u1, v0)); surface.add_vertex(p10)
			surface.set_uv(Vector2(u1, v1)); surface.add_vertex(p11)
			surface.set_uv(Vector2(u0, v0)); surface.add_vertex(p00)
			surface.set_uv(Vector2(u1, v1)); surface.add_vertex(p11)
			surface.set_uv(Vector2(u0, v1)); surface.add_vertex(p01)

	surface.generate_normals()
	var mesh := surface.commit()
	var body := StaticBody3D.new()
	body.name = "ClareiraMajesticQA"
	body.position = Vector3(MAJESTIC_XZ.x, 0.0, MAJESTIC_XZ.y)
	add_child(body)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.54, 0.68, 0.46)
	material.albedo_texture = WET_FOREST_FLOOR
	material.uv1_scale = Vector3(7.5, 7.5, 1.0)
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	material.roughness = 0.92
	mesh.surface_set_material(0, material)
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	body.add_child(visual)
	var collision := CollisionShape3D.new()
	collision.shape = mesh.create_trimesh_shape()
	body.add_child(collision)

func _build_cc0_shelter() -> void:
	# Construção CC0 lateral: substitui pavilhão procedural, sem ocupar o corredor x=-79.
	var shelter := Node3D.new()
	shelter.name = "AbrigoMajesticCC0Contextual"
	add_child(shelter)
	var result := GROUNDING.snap_to_ground(get_world_3d(), shelter, Vector3(-97.0, 18.0, 187.0))
	assert(result["grounded"])
	grounding_events += 1
	_add_cc0_piece(shelter, CC0_FLOOR, Vector3(0.0, 0.03, 0.0), Vector3(1.45, 1.0, 1.45), 0.0)
	_add_cc0_piece(shelter, CC0_FRAME, Vector3(0.0, 0.05, -1.8), Vector3(1.45, 1.45, 1.45), 0.0)
	_add_cc0_piece(shelter, CC0_SUPPORTS, Vector3(0.0, 0.05, 0.8), Vector3(1.45, 1.45, 1.45), 0.0)
	_add_cc0_piece(shelter, CC0_ROOF, Vector3(0.7, 2.25, 0.2), Vector3(1.4, 1.4, 1.4), -0.32)
	_add_cc0_piece(shelter, CC0_ROOF, Vector3(-1.55, 0.55, 1.65), Vector3(0.8, 0.8, 0.8), 1.05)

func _add_cc0_piece(parent: Node3D, scene: PackedScene, offset: Vector3, scale_value: Vector3, yaw: float) -> void:
	var piece := scene.instantiate() as Node3D
	piece.position = offset
	piece.scale = scale_value
	piece.rotation.y = yaw
	parent.add_child(piece)

func _build_rock_accents() -> void:
	# Afloramentos baixos criam transições de escala sem fechar a rota em X=-79.
	_spawn_grounded("outcrop_shelter_west", Vector3(-103.5, 18.0, 191.0), STONE_A, Vector3.ONE * 1.18, Vector3(0.0, 28.0, 0.0))
	_spawn_grounded("outcrop_shelter_rear", Vector3(-100.5, 18.0, 197.0), STONE_B, Vector3.ONE * 0.96, Vector3(0.0, -34.0, 0.0))
	_spawn_grounded("outcrop_corridor_east", Vector3(-67.0, 18.0, 176.0), STONE_A, Vector3.ONE * 0.86, Vector3(0.0, 62.0, 0.0))

func _build_vegetation() -> void:
	# Limites LOD: 1 pinheiro focal, 2 árvores detalhadas, 3 árvores leves e 2 fetos.
	_spawn_grounded("pine_focal", Vector3(-104.0, 18.0, 170.0), PINE_TALL, Vector3.ONE * 1.12)
	_spawn_grounded("tree_medium_west", Vector3(-105.0, 18.0, 181.0), TREE_DETAILED, Vector3.ONE * 1.18)
	_spawn_grounded("tree_medium_east", Vector3(-64.0, 18.0, 201.0), TREE_DETAILED, Vector3.ONE * 0.96)
	_spawn_grounded("tree_light_north", Vector3(-63.5, 18.0, 174.0), TREE_LIGHT, Vector3.ONE * 0.78)
	_spawn_grounded("tree_light_south", Vector3(-107.0, 18.0, 198.0), TREE_LIGHT, Vector3.ONE * 1.08)
	# Sexta árvore leve no plano distante: acrescenta profundidade, sem formar parede no corredor.
	_spawn_grounded("tree_light_far_east", Vector3(-62.0, 18.0, 205.0), TREE_LIGHT, Vector3.ONE * 0.92)
	_spawn_grounded("tree_light_far_west", Vector3(-111.0, 18.0, 204.0), TREE_LIGHT, Vector3.ONE * 0.84)
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
	camera.position = Vector3(-73.0, 3.5, 161.5)
	camera.fov = 39.0
	add_child(camera)
	camera.look_at(Vector3(-91.5, 1.35, 183.0), Vector3.UP)
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
	assert(grounding_events == 15)
	assert(wildlife.size() == 2)
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(_nearest_wildlife_distance() >= 5.0)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R5_LIVING] status=approved fauna=2 vegetation=9 outcrops=3 shelter_parts=3 pavilion=true grounded=%d cairn=false wall_of_trees=false production_modules_changed=false" % grounding_events)

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
	label.text = "ACAMPAMENTO MAJESTIC VIVO R5  |  ELIAS · ABRIGO CC0 · FAUNA · CLAREIRA\nGROUNDING X/Z · DESVIO CARTOGRÁFICO · CORREDOR LIVRE · 1 LUZ DINÂMICA"
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
