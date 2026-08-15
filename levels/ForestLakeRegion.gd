## ForestLakeRegion.gd
## Marcos 4–6 do mapa regional: Floresta Densa, Acampamento Majestic e Ruínas Submersas.
## Construção modular e aterrrada sobre TerrainPatch para manter continuidade física sem ecrãs de carregamento.

extends Node3D

const PINE_TALL: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const PINE_MEDIUM: PackedScene = preload("res://assets/models_generated/ez_pine_medium_pbr.glb")
const DARK_TREE: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const OAK_DARK: PackedScene = preload("res://assets/models_cc0/tree_oak_dark.glb")
const ISLAND_TREE: PackedScene = preload("res://assets/models_polyhaven/island_tree_01/island_tree_01_1k.gltf")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const ROCK: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const FLAGSTONE: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")
const GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")

var terrain_patch: Node3D
var path_material: StandardMaterial3D
var ruin_material: StandardMaterial3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	path_material = _create_path_material()
	ruin_material = _create_ruin_material()
	_build_forest_path()
	_build_dense_forest()
	_build_majestic_camp()
	_build_submerged_ruins()
	_build_riparian_margin()

func _height_at(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _build_forest_path() -> void:
	var road: Node3D = Node3D.new()
	road.name = "TrilhoDaFlorestaDensa"
	add_child(road)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 40606
	for index: int in range(45):
		var t: float = float(index) / 44.0
		var z_value: float = lerpf(116.0, 240.0, t)
		var x_value: float = _path_x(z_value)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeFloresta_%02d" % index
		slab.mesh = _make_slab(1.58 + rng.randf_range(-0.22, 0.25), 1.20 + rng.randf_range(-0.16, 0.18), rng)
		slab.material_override = path_material
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.05, z_value)
		slab.rotation.y = atan2((_path_x(z_value + 1.0) - _path_x(z_value - 1.0)) * 0.5, 2.8) + rng.randf_range(-0.12, 0.12)
		road.add_child(slab)

func _build_dense_forest() -> void:
	var forest: Node3D = Node3D.new()
	forest.name = "FlorestaDensaRegional"
	add_child(forest)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 40417
	for index: int in range(74):
		var z_value: float = 72.0 + float(index / 2) * 4.5 + rng.randf_range(-2.0, 2.0)
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var spacing: float = 10.0 + fmod(float(index * 7), 18.0)
		var x_value: float = _path_x(z_value) + side * spacing
		# Mantém o corredor livre e cria profundidade em três estratos, não uma parede de árvores.
		if abs(x_value - _path_x(z_value)) < 6.0:
			continue
		var tree_source: PackedScene
		# A maioria dos pontos focais usa malhas orgânicas reais; as coníferas EZ ficam como profundidade económica.
		if index % 7 == 0:
			tree_source = ISLAND_TREE
		elif index % 5 == 0:
			tree_source = OAK_DARK
		elif index % 3 == 0:
			tree_source = DARK_TREE
		elif index % 2 == 0:
			tree_source = PINE_TALL
		else:
			tree_source = PINE_MEDIUM
		var tree: Node3D = tree_source.instantiate() as Node3D
		if tree == null:
			continue
		tree.name = "ArvoreDaFloresta_%02d" % index
		tree.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
		var tree_scale: float = 0.20 + fmod(float(index), 4.0) * 0.045
		if index % 7 == 0:
			tree_scale = 0.68 + fmod(float(index), 3.0) * 0.10
		elif index % 5 == 0:
			tree_scale *= 1.48
		elif index % 3 == 0:
			tree_scale *= 1.20
		tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
		tree.rotation.y = rng.randf_range(-PI, PI)
		forest.add_child(tree)
	for index: int in range(54):
		var z_value: float = 70.0 + float(index) * 3.1
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _path_x(z_value) + side * (4.2 + fmod(float(index), 4.0) * 0.75)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern == null:
			continue
		fern.name = "FetoFloresta_%02d" % index
		fern.position = Vector3(x_value, _height_at(x_value, z_value) + 0.02, z_value)
		var fern_scale: float = 0.34 + fmod(float(index), 3.0) * 0.07
		fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
		fern.rotation.y = float(index) * 0.68
		forest.add_child(fern)

func _build_majestic_camp() -> void:
	var camp: Node3D = Node3D.new()
	camp.name = "AcampamentoMajestic"
	var camp_x: float = -88.0
	var camp_z: float = 178.0
	camp.position = Vector3(camp_x, _height_at(camp_x, camp_z), camp_z)
	add_child(camp)
	var canvas_material: StandardMaterial3D = StandardMaterial3D.new()
	canvas_material.albedo_color = Color(0.18, 0.15, 0.10, 1.0)
	canvas_material.roughness = 0.92
	for index: int in range(4):
		var tent_mesh: PrismMesh = PrismMesh.new()
		tent_mesh.size = Vector3(4.8, 2.4, 5.6)
		tent_mesh.left_to_right = 0.5
		var tent: MeshInstance3D = MeshInstance3D.new()
		tent.name = "TendaMajestic_%02d" % index
		tent.mesh = tent_mesh
		tent.material_override = canvas_material
		var angle: float = float(index) * TAU / 4.0
		tent.position = Vector3(cos(angle) * 6.0, 1.20, sin(angle) * 6.0)
		tent.rotation.y = -angle
		camp.add_child(tent)
	var fire_mesh: SphereMesh = SphereMesh.new()
	fire_mesh.radius = 0.34
	fire_mesh.height = 0.68
	var fire_material: StandardMaterial3D = StandardMaterial3D.new()
	fire_material.albedo_color = Color(0.62, 0.16, 0.025, 1.0)
	fire_material.emission_enabled = true
	fire_material.emission = Color(1.0, 0.18, 0.015, 1.0)
	fire_material.emission_energy_multiplier = 1.6
	fire_mesh.material = fire_material
	var fire: MeshInstance3D = MeshInstance3D.new()
	fire.name = "FogoDoAcampamento"
	fire.mesh = fire_mesh
	fire.position = Vector3(0.0, 0.45, 0.0)
	camp.add_child(fire)
	var fire_light: OmniLight3D = OmniLight3D.new()
	fire_light.light_color = Color(1.0, 0.32, 0.08, 1.0)
	fire_light.light_energy = 1.2
	fire_light.omni_range = 12.0
	fire_light.shadow_enabled = false
	fire_light.position = Vector3(0.0, 1.4, 0.0)
	camp.add_child(fire_light)

func _build_submerged_ruins() -> void:
	var lake: Node3D = Node3D.new()
	lake.name = "RuinasSubmersasDoLago"
	var center_x: float = 26.0
	var center_z: float = 252.0
	var water_y: float = _height_at(center_x, center_z) + 0.45
	lake.position = Vector3(center_x, water_y, center_z)
	add_child(lake)
	var water_mesh: PlaneMesh = PlaneMesh.new()
	water_mesh.size = Vector2(112.0, 92.0)
	water_mesh.subdivide_width = 24
	water_mesh.subdivide_depth = 20
	water_mesh.material = _create_lake_material()
	var water: MeshInstance3D = MeshInstance3D.new()
	water.name = "LagoDasRuinasSubmersas"
	water.mesh = water_mesh
	water.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	lake.add_child(water)
	for index: int in range(8):
		var angle: float = float(index) * TAU / 8.0
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarSubmerso_%02d" % index
		pillar.position = Vector3(cos(angle) * 23.0, -0.7 + float(index % 3) * 0.46, sin(angle) * 18.0)
		var pillar_scale: float = 0.72 + float(index % 2) * 0.18
		pillar.scale = Vector3(pillar_scale, pillar_scale, pillar_scale)
		pillar.rotation = Vector3(0.20 + float(index % 3) * 0.15, angle, 0.13 * sin(angle))
		_apply_material(pillar, ruin_material)
		lake.add_child(pillar)
	var dome_mesh: SphereMesh = SphereMesh.new()
	dome_mesh.radius = 7.5
	dome_mesh.height = 3.6
	dome_mesh.radial_segments = 24
	var dome: MeshInstance3D = MeshInstance3D.new()
	dome.name = "DomoSubmersoDoHub"
	dome.mesh = dome_mesh
	dome.position = Vector3(0.0, -2.6, 0.0)
	dome.scale = Vector3(1.0, 0.38, 1.0)
	dome.material_override = ruin_material
	lake.add_child(dome)

func _build_riparian_margin() -> void:
	var margin: Node3D = Node3D.new()
	margin.name = "MargensRochosasDoLago"
	add_child(margin)
	var center: Vector2 = Vector2(26.0, 252.0)
	for index: int in range(32):
		var angle: float = float(index) * TAU / 32.0
		var radius_x: float = 55.0 + sin(float(index) * 1.71) * 3.5
		var radius_z: float = 45.0 + cos(float(index) * 1.27) * 2.8
		var world_x: float = center.x + cos(angle) * radius_x
		var world_z: float = center.y + sin(angle) * radius_z
		# Mantém a entrada ocidental do caminho aberta antes de entrar no vale do lago.
		if world_z < 238.0 and abs(world_x - _path_x(world_z)) < 9.0:
			continue
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaDeMargem_%02d" % index
			rock.position = Vector3(world_x, _height_at(world_x, world_z) + 0.15, world_z)
			var rock_scale: float = 0.10 + fmod(float(index), 4.0) * 0.035
			rock.scale = Vector3(rock_scale, rock_scale, rock_scale)
			rock.rotation = Vector3(0.0, angle + 0.4, 0.0)
			margin.add_child(rock)
		if index % 2 == 0:
			var fern: Node3D = FERN.instantiate() as Node3D
			if fern != null:
				fern.name = "FetoRibeirinho_%02d" % index
				fern.position = Vector3(world_x * 0.98 + center.x * 0.02, _height_at(world_x, world_z) + 0.03, world_z * 0.98 + center.y * 0.02)
				var fern_scale: float = 0.32 + fmod(float(index), 3.0) * 0.07
				fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
				fern.rotation.y = angle + 0.6
				margin.add_child(fern)

func _make_slab(width: float, depth: float, rng: RandomNumberGenerator) -> ArrayMesh:
	var points: Array[Vector3] = [
		Vector3(-width * 0.52, rng.randf_range(-0.02, 0.03), -depth * 0.48),
		Vector3(width * 0.47, rng.randf_range(-0.02, 0.03), -depth * 0.52),
		Vector3(width * 0.53, rng.randf_range(-0.02, 0.03), depth * 0.46),
		Vector3(-width * 0.44, rng.randf_range(-0.02, 0.03), depth * 0.54)
	]
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for vertex_index: int in [0, 1, 2, 0, 2, 3]:
		surface.set_uv(Vector2(points[vertex_index].x + 0.5, points[vertex_index].z + 0.5))
		surface.add_vertex(points[vertex_index])
	surface.generate_normals()
	return surface.commit()

func _create_path_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.30
	material.roughness = 0.92
	material.uv1_scale = Vector3(0.34, 0.34, 0.34)
	return material

func _create_ruin_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = MOSSY_RUIN_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_RUIN_NORMAL
	material.normal_scale = 0.32
	material.roughness = 0.95
	material.uv1_scale = Vector3(0.28, 0.28, 0.28)
	return material

func _create_lake_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode blend_mix, cull_disabled, depth_draw_always, diffuse_burley;
void vertex() {
	VERTEX.y += sin(VERTEX.x * 0.16 + TIME * 0.72) * 0.11 + cos(VERTEX.z * 0.13 + TIME * 0.58) * 0.075;
}
void fragment() {
	float ripple = sin(VERTEX.x * 0.28 + VERTEX.z * 0.19 + TIME * 0.75) * 0.5 + 0.5;
			ALBEDO = mix(vec3(0.018, 0.14, 0.16), vec3(0.055, 0.34, 0.35), ripple * 0.42 + 0.28);
		ROUGHNESS = 0.28;
		SPECULAR = 0.52;
		ALPHA = 0.88;

}
"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	return material

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
