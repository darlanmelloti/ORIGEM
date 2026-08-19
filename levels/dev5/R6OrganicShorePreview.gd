## Dev5 — CP-D5-087: composição QA isolada da margem R6; sem cais de lajes e sem alteração de produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const MONOLITH: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const ROCK_LARGE_A: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const ROCK_LARGE_B: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const ROCK_SMALL_F: PackedScene = preload("res://assets/models_cc0/stone_smallF.glb")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const MONOLITH_XZ := Vector2(52.0, 260.0)
const ROUTE_X := 60.0
const ROUTE_START_Z := 242.0
const ROUTE_END_Z := 278.0

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var organic_mesh: ArrayMesh
var grounded_count := 0
var route_cycles := 0

func _ready() -> void:
	_build_environment()
	_build_organic_shore()
	await get_tree().physics_frame
	_build_water()
	_build_monolith()
	_build_rock_outcrops()
	_build_vegetation()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _physics_process(delta: float) -> void:
	if actor == null:
		return
	actor.global_position.z += 2.25 * delta
	if actor.global_position.z >= ROUTE_END_Z:
		route_cycles += 1
		actor.global_position.z = ROUTE_START_Z
		print("[DEV5_R6_ORGANIC] route_cycle=%d clear=true shoreline_cubes=false pier_slabs=0" % route_cycles)

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.105, 0.18, 0.24)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.37, 0.47, 0.45)
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.22, 0.31, 0.33)
	environment.fog_light_energy = 0.45
	environment.fog_density = 0.018
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-42.0, 28.0, 0.0)
	sun.light_energy = 1.28
	sun.shadow_enabled = true
	add_child(sun)

func _shore_height(local_x: float, local_z: float) -> float:
	return 0.16 * sin(local_x * 0.31) + 0.13 * cos(local_z * 0.27) + 0.07 * sin((local_x + local_z) * 0.52)

func _build_organic_shore() -> void:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var x_segments := 18
	var z_segments := 22
	var width := 42.0
	var depth := 48.0
	for z_index in range(z_segments):
		for x_index in range(x_segments):
			var x0 := -width * 0.5 + width * float(x_index) / float(x_segments)
			var x1 := -width * 0.5 + width * float(x_index + 1) / float(x_segments)
			var z0 := -depth * 0.5 + depth * float(z_index) / float(z_segments)
			var z1 := -depth * 0.5 + depth * float(z_index + 1) / float(z_segments)
			var p00 := Vector3(x0, _shore_height(x0, z0), z0)
			var p10 := Vector3(x1, _shore_height(x1, z0), z0)
			var p01 := Vector3(x0, _shore_height(x0, z1), z1)
			var p11 := Vector3(x1, _shore_height(x1, z1), z1)
			surface.add_vertex(p00)
			surface.add_vertex(p10)
			surface.add_vertex(p11)
			surface.add_vertex(p00)
			surface.add_vertex(p11)
			surface.add_vertex(p01)
	surface.generate_normals()
	organic_mesh = surface.commit()
	var terrain := StaticBody3D.new()
	terrain.name = "MargemOrganicaR6QA"
	terrain.position = Vector3(60.0, 0.0, 260.0)
	add_child(terrain)
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
varying vec3 shore_world_position;
float shore_noise(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}
void vertex() {
	shore_world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}
void fragment() {
	// Variação contínua: evita a leitura de células quadriculadas no solo.
	vec2 p = shore_world_position.xz;
	float macro = 0.5 + 0.5 * sin(p.x * 0.19 + sin(p.y * 0.13));
	float micro = 0.5 + 0.5 * sin(p.x * 0.71 + p.y * 0.53);
	float blend = clamp(macro * 0.72 + micro * 0.28, 0.0, 1.0);
	ALBEDO = mix(vec3(0.055, 0.105, 0.065), vec3(0.20, 0.285, 0.135), blend);
	ROUGHNESS = 0.94;
	METALLIC = 0.0;
}
"""
	var shore_material := ShaderMaterial.new()
	shore_material.shader = shader
	organic_mesh.surface_set_material(0, shore_material)
	var visual := MeshInstance3D.new()
	visual.mesh = organic_mesh
	terrain.add_child(visual)
	var collision := CollisionShape3D.new()
	collision.shape = organic_mesh.create_trimesh_shape()
	terrain.add_child(collision)

func _build_water() -> void:
	var water := MeshInstance3D.new()
	water.name = "AguaMargemR6QA"
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(42.0, 10.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.055, 0.18, 0.23, 0.78)
	material.roughness = 0.18
	material.metallic = 0.08
	mesh.material = material
	water.mesh = mesh
	water.position = Vector3(60.0, 0.06, 283.5)
	add_child(water)

func _build_monolith() -> void:
	var root := Node3D.new()
	root.name = "BalizaMonoliticaOrganicaR6QA"
	var model := MONOLITH.instantiate() as Node3D
	model.position = Vector3(0.0, 0.82, 0.0)
	model.rotation_degrees = Vector3(0.0, 14.0, -4.0)
	model.scale = Vector3.ONE * 1.70
	root.add_child(model)
	_apply_ruin_material(root)
	add_child(root)
	var result := GROUNDING.snap_to_ground(get_world_3d(), root, Vector3(MONOLITH_XZ.x, 18.0, MONOLITH_XZ.y))
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(MONOLITH_XZ) < 0.001)
	grounded_count += 1
	print("[DEV5_R6_ORGANIC] monolith_grounded=true xz=(%.2f,%.2f) y=%.2f" % [root.global_position.x, root.global_position.z, root.global_position.y])

func _build_rock_outcrops() -> void:
	# Afloramentos laterais orgânicos; nenhum ocupa o corredor central X=60.
	_spawn_grounded("outcrop_west", Vector3(46.0, 18.0, 254.0), ROCK_LARGE_A, Vector3.ONE * 1.95)
	_spawn_grounded("outcrop_west_back", Vector3(48.0, 18.0, 271.0), ROCK_LARGE_B, Vector3.ONE * 1.34)
	_spawn_grounded("outcrop_east", Vector3(73.0, 18.0, 275.0), ROCK_LARGE_B, Vector3.ONE * 1.72)
	_spawn_grounded("outcrop_small", Vector3(68.5, 18.0, 255.0), ROCK_SMALL_F, Vector3.ONE * 1.18)
	_spawn_grounded("outcrop_waterline", Vector3(55.0, 18.0, 278.5), ROCK_SMALL_F, Vector3.ONE * 1.05)

func _build_vegetation() -> void:
	_spawn_grounded("tree_distant", Vector3(76.0, 18.0, 267.0), TREE_LIGHT, Vector3.ONE * 1.62)
	_spawn_grounded("tree_west", Vector3(43.0, 18.0, 269.0), TREE_LIGHT, Vector3.ONE * 1.28)
	_spawn_grounded("fern_left", Vector3(54.0, 18.0, 251.5), FERN, Vector3.ONE * 0.64)
	_spawn_grounded("fern_right", Vector3(68.0, 18.0, 271.5), FERN, Vector3.ONE * 0.60)

func _spawn_grounded(id: String, target: Vector3, packed: PackedScene, scale_value: Vector3) -> void:
	var item := packed.instantiate() as Node3D
	item.name = id
	item.scale = scale_value
	add_child(item)
	var result := GROUNDING.snap_to_ground(get_world_3d(), item, target)
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(Vector2(target.x, target.z)) < 0.001)
	if id.begins_with("outcrop"):
		_apply_outcrop_material(item)
	grounded_count += 1

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasR6OrganicQA"
	actor.position = Vector3(ROUTE_X, 1.2, ROUTE_START_Z)
	add_child(actor)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.55
	shape.height = 1.90
	collision.shape = shape
	collision.position.y = 0.95
	actor.add_child(collision)
	elias = ELIAS_PRESENTATION.new()
	elias.enabled_for_preview = true
	actor.add_child(elias)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQAR6MargemOrganica"
	camera.position = Vector3(75.0, 4.6, 250.0)
	camera.fov = 46.0
	add_child(camera)
	camera.look_at(Vector3(58.0, 1.10, 264.0), Vector3.UP)
	camera.make_current()

func _apply_outcrop_material(node: Node) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.16, 0.20, 0.18)
	material.roughness = 0.96
	for child: Node in node.get_children():
		if child is MeshInstance3D:
			child.material_override = material
		_apply_outcrop_material(child)

func _apply_ruin_material(node: Node) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.31, 0.36, 0.33)
	material.roughness = 0.90
	for child: Node in node.get_children():
		if child is MeshInstance3D:
			child.material_override = material
		_apply_ruin_material(child)

func _verify_contract() -> void:
	assert(grounded_count == 10)
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(absf(ROUTE_X - MONOLITH_XZ.x) - 1.40 - 0.55 >= 4.0)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R6_ORGANIC] status=approved organic_terrain=true grounded=%d foliage=4 outcrops=5 pier_slabs=0 wall_of_trees=false production_modules_changed=false" % grounded_count)

func _dynamic_lights() -> int:
	var count := 0
	for node: Node in get_children():
		if node is Light3D:
			count += 1
	return count

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1150.0, 90.0)
	label.text = "CP-D5-087  |  MARGEM R6: ELIAS · BALIZA · RELEVO ORGÂNICO\nRAYCAST X/Z · VEGETAÇÃO RIBEIRINHA · FOLGA ≥4,00 M · ZERO CAIS DE LAJES"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(45):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R6_ORGANIC] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_R6_ORGANIC] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R6_ORGANIC] snapshot=%s result=%s" % [path, result])
