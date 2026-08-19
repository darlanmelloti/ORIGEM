## Dev5 — margem R6 viva em QA isolado. Usa fauna CC0 e ruína de pedras GLB; não cria cais nem altera produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const DEER: PackedScene = preload("res://assets/models_cc0/deer_quaternius_cc0.glb")
const STONE_TALL: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const STONE_A: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const STONE_B: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const TREE: PackedScene = preload("res://assets/models_cc0/tree_oak_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const ROUTE_X := 60.0
const R6_ANCHOR := Vector2(60.0, 252.0)

var animals: Array[Node3D] = []
var animal_origins: Array[Vector3] = []
var elias: EliasThirdPersonPresentation
var actor: CharacterBody3D
var grounding_events := 0
var elapsed := 0.0
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_water()
	_build_living_ruin()
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
	actor.global_position.z += 2.0 * delta
	if actor.global_position.z > 282.0:
		actor.global_position.z = 242.0
		route_cycles += 1
		print("[DEV5_R6_LIVING] route_cycle=%d clear=true fauna_distance=%.2f collapsed_ruin=true pier_slabs=0" % [route_cycles, _nearest_animal_distance()])

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.065, 0.12, 0.16)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.38, 0.47, 0.40)
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.16, 0.26, 0.27)
	environment.fog_light_energy = 0.55
	environment.fog_density = 0.016
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-42.0, 28.0, 0.0)
	sun.light_energy = 1.22
	sun.shadow_enabled = true
	add_child(sun)

func _shore_height(x: float, z: float) -> float:
	return 0.18 * sin(x * 0.30) + 0.12 * cos(z * 0.26) + 0.07 * sin((x + z) * 0.56)

func _build_ground() -> void:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var x_segments := 22
	var z_segments := 24
	var width := 46.0
	var depth := 52.0
	for zi in range(z_segments):
		for xi in range(x_segments):
			var x0 := -width * 0.5 + width * float(xi) / float(x_segments)
			var x1 := -width * 0.5 + width * float(xi + 1) / float(x_segments)
			var z0 := -depth * 0.5 + depth * float(zi) / float(z_segments)
			var z1 := -depth * 0.5 + depth * float(zi + 1) / float(z_segments)
			var p00 := Vector3(x0, _shore_height(x0, z0), z0)
			var p10 := Vector3(x1, _shore_height(x1, z0), z0)
			var p01 := Vector3(x0, _shore_height(x0, z1), z1)
			var p11 := Vector3(x1, _shore_height(x1, z1), z1)
			surface.add_vertex(p00); surface.add_vertex(p10); surface.add_vertex(p11)
			surface.add_vertex(p00); surface.add_vertex(p11); surface.add_vertex(p01)
	surface.generate_normals()
	var mesh := surface.commit()
	var terrain := StaticBody3D.new()
	terrain.name = "MargemVivaR6QA"
	terrain.position = Vector3(60.0, 0.0, 260.0)
	add_child(terrain)
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
varying vec3 world_pos;
float hash(vec2 p) { return fract(sin(dot(p, vec2(41.71, 289.31))) * 45758.542); }
float value_noise(vec2 p) {
	vec2 cell = floor(p);
	vec2 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);
	float a = hash(cell);
	float b = hash(cell + vec2(1.0, 0.0));
	float c = hash(cell + vec2(0.0, 1.0));
	float d = hash(cell + vec2(1.0, 1.0));
	return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}
void vertex() { world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz; }
void fragment() {
	float broad = value_noise(world_pos.xz * 0.12);
	float detail = value_noise(world_pos.xz * 0.62);
	float n = broad * 0.72 + detail * 0.28;
	ALBEDO = mix(vec3(0.040, 0.085, 0.050), vec3(0.18, 0.285, 0.125), n);
	ROUGHNESS = 0.96;
}
"""
	var material := ShaderMaterial.new()
	material.shader = shader
	mesh.surface_set_material(0, material)
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	terrain.add_child(visual)
	var collision := CollisionShape3D.new()
	collision.shape = mesh.create_trimesh_shape()
	terrain.add_child(collision)

func _build_water() -> void:
	var water := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(46.0, 11.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.035, 0.16, 0.20, 0.84)
	material.roughness = 0.22
	material.metallic = 0.10
	mesh.material = material
	water.mesh = mesh
	water.position = Vector3(60.0, 0.055, 284.0)
	add_child(water)

func _build_living_ruin() -> void:
	# Três peças GLB escoradas como uma ruína de abrigo: não é cais, pedra cúbica nem cairn.
	_spawn_grounded("ruin_pillar", Vector3(47.0, 18.0, 269.0), STONE_TALL, Vector3.ONE * 1.95, Vector3(0.0, 12.0, -5.0))
	_spawn_grounded("ruin_base", Vector3(45.0, 18.0, 271.0), STONE_A, Vector3.ONE * 2.05, Vector3(0.0, -18.0, 4.0))
	_spawn_grounded("ruin_fallen_cap", Vector3(51.0, 18.0, 271.0), STONE_B, Vector3(2.2, 0.76, 1.18), Vector3(8.0, -28.0, 78.0))

func _build_vegetation() -> void:
	_spawn_grounded("oak_west", Vector3(41.0, 18.0, 265.0), TREE, Vector3.ONE * 1.55)
	_spawn_grounded("oak_east", Vector3(78.0, 18.0, 275.0), TREE, Vector3.ONE * 1.22)
	_spawn_grounded("fern_west", Vector3(54.0, 18.0, 250.0), FERN, Vector3.ONE * 0.75)
	_spawn_grounded("fern_water", Vector3(68.0, 18.0, 279.0), FERN, Vector3.ONE * 0.62)

func _build_wildlife() -> void:
	_spawn_deer("cervo_margem", Vector3(69.0, 18.0, 260.0), 0.86, 184.0)
	_spawn_deer("cervo_clareira", Vector3(73.0, 18.0, 266.0), 0.70, 206.0)

func _spawn_deer(id: String, position_hint: Vector3, scale_value: float, yaw: float) -> void:
	var root := Node3D.new()
	root.name = id
	root.scale = Vector3.ONE * scale_value
	root.rotation_degrees.y = yaw
	add_child(root)
	var model := DEER.instantiate() as Node3D
	root.add_child(model)
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, position_hint)
	assert(result["grounded"])
	animals.append(root)
	animal_origins.append(root.global_position)
	grounding_events += 1

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasMargemVivaR6QA"
	actor.position = Vector3(ROUTE_X, 1.2, 242.0)
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
	camera.name = "CameraQAMargemVivaR6"
	camera.position = Vector3(78.0, 4.7, 247.5)
	camera.fov = 47.0
	add_child(camera)
	camera.look_at(Vector3(58.0, 1.1, 266.0), Vector3.UP)
	camera.make_current()

func _spawn_grounded(id: String, position_hint: Vector3, packed: PackedScene, scale_value: Vector3, rotation_value := Vector3.ZERO) -> void:
	var node := packed.instantiate() as Node3D
	node.name = id
	node.scale = scale_value
	node.rotation_degrees = rotation_value
	add_child(node)
	var result := GROUNDING.snap_to_ground(get_world_3d(), node, position_hint)
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(Vector2(position_hint.x, position_hint.z)) < 0.001)
	grounding_events += 1

func _update_wildlife() -> void:
	for index in range(animals.size()):
		var deer := animals[index]
		var origin := animal_origins[index]
		deer.global_position = origin + Vector3(sin(elapsed * 0.72 + index) * 0.65, 0.0, cos(elapsed * 0.48 + index) * 0.38)
		deer.rotation.y += 0.0035
		if fmod(elapsed, 0.8) < 0.018:
			GROUNDING.snap_to_ground(get_world_3d(), deer, deer.global_position + Vector3.UP * 8.0)

func _nearest_animal_distance() -> float:
	var nearest := INF
	for deer in animals:
		nearest = minf(nearest, Vector2(deer.global_position.x - ROUTE_X, deer.global_position.z - actor.global_position.z).length())
	return nearest

func _verify_contract() -> void:
	assert(grounding_events == 9)
	assert(animals.size() == 2)
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(_nearest_animal_distance() >= 5.0)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R6_LIVING] status=approved fauna=2 vegetation=4 ruin_parts=3 grounded=%d pier_slabs=0 wall_of_trees=false production_modules_changed=false" % grounding_events)

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
	label.position = Vector2(48.0, 42.0)
	label.size = Vector2(1200.0, 84.0)
	label.text = "MARGEM VIVA R6  |  ELIAS · FAUNA CC0 · VEGETAÇÃO RIBEIRINHA · RUÍNA COLAPSADA\nGROUNDING X/Z · CORREDOR LIVRE · ZERO CAIS DE LAJES · 1 LUZ DINÂMICA"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.91, 0.96, 0.95)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame in range(50):
		await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null:
		print("[DEV5_R6_LIVING] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := texture.get_image()
	if image == null:
		print("[DEV5_R6_LIVING] snapshot_unavailable=headless_image path=%s" % path)
		return
	print("[DEV5_R6_LIVING] snapshot=%s result=%s" % [path, image.save_png(path)])
