## RiverRoadJourney.gd
## Corredor inicial real do mapa: Casa Voss -> Estrada do Rio -> Arco das Ruínas.
## O jogador sai para z positivo; esta zona não reutiliza o antigo corredor de composição em z negativo.

extends Node3D

const RUIN_PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const RUIN_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const PINE_MEDIUM: PackedScene = preload("res://assets/models_generated/ez_pine_medium_pbr.glb")
const FLAGSTONE: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")
const GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")
const GROUND_ROUGHNESS: Texture2D = preload("res://assets/textures/pbr/forest_ground_roughness.jpg")

var terrain_patch: Node3D
var path_material: StandardMaterial3D
var ruin_material: StandardMaterial3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	path_material = _make_path_material()
	ruin_material = _make_ruin_material()
	_build_compacted_roadbed()
	_build_river_road()
	_build_river()
	_build_ruin_arch()
	_build_roadside_vegetation()

func _height_at(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _road_x(world_z: float) -> float:
	var distance: float = clampf((world_z - 12.0) / 108.0, 0.0, 1.0)
	return lerpf(-21.4, -10.0, distance) + sin(distance * PI * 2.5) * 1.8

func _river_x(world_z: float) -> float:
	var distance: float = clampf((world_z - 8.0) / 155.0, 0.0, 1.0)
	return 10.5 + sin(distance * PI * 2.2) * 3.6 + sin(distance * PI * 5.0) * 0.8

func _build_compacted_roadbed() -> void:
	# Solo compactado contínuo: torna o percurso legível entre as lajes e evita a leitura de relvado aleatório.
	var roadbed_material: StandardMaterial3D = StandardMaterial3D.new()
	roadbed_material.albedo_color = Color(0.19, 0.14, 0.075, 1.0)
	roadbed_material.roughness = 0.96
	roadbed_material.normal_enabled = true
	roadbed_material.normal_texture = GROUND_NORMAL
	roadbed_material.normal_scale = 0.22
	var width: float = 4.15
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(42):
		var z0: float = 10.0 + float(index) * 2.7
		var z1: float = z0 + 2.7
		var x0: float = _road_x(z0)
		var x1: float = _road_x(z1)
		var p00: Vector3 = Vector3(x0 - width * 0.5, _height_at(x0 - width * 0.5, z0) + 0.018, z0)
		var p10: Vector3 = Vector3(x0 + width * 0.5, _height_at(x0 + width * 0.5, z0) + 0.018, z0)
		var p01: Vector3 = Vector3(x1 - width * 0.5, _height_at(x1 - width * 0.5, z1) + 0.018, z1)
		var p11: Vector3 = Vector3(x1 + width * 0.5, _height_at(x1 + width * 0.5, z1) + 0.018, z1)
		surface.set_uv(Vector2(0.0, float(index) * 0.18))
		surface.add_vertex(p00)
		surface.set_uv(Vector2(0.0, float(index + 1) * 0.18))
		surface.add_vertex(p01)
		surface.set_uv(Vector2(1.0, float(index) * 0.18))
		surface.add_vertex(p10)
		surface.set_uv(Vector2(1.0, float(index) * 0.18))
		surface.add_vertex(p10)
		surface.set_uv(Vector2(0.0, float(index + 1) * 0.18))
		surface.add_vertex(p01)
		surface.set_uv(Vector2(1.0, float(index + 1) * 0.18))
		surface.add_vertex(p11)
	surface.generate_normals()
	var roadbed: MeshInstance3D = MeshInstance3D.new()
	roadbed.name = "SoloCompactadoEstradaDoRio"
	roadbed.mesh = surface.commit()
	roadbed.material_override = roadbed_material
	add_child(roadbed)

func _build_river_road() -> void:
	var road: Node3D = Node3D.new()
	road.name = "EstradaDoRio_Real"
	add_child(road)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 10102
	for index: int in range(38):
		var t: float = float(index) / 37.0
		var z_value: float = lerpf(12.0, 120.0, t)
		var x_value: float = _road_x(z_value)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeEstradaRio_%02d" % index
		slab.mesh = _make_slab(1.76 + rng.randf_range(-0.18, 0.20), 1.34 + rng.randf_range(-0.12, 0.18), rng)
		slab.material_override = path_material
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.042, z_value)
		slab.rotation.y = atan2((_road_x(z_value + 1.0) - _road_x(z_value - 1.0)) * 0.5, 2.0) + rng.randf_range(-0.08, 0.08)
		road.add_child(slab)

func _build_river() -> void:
	var river_root: Node3D = Node3D.new()
	river_root.name = "RioDaEstrada_Norte"
	add_child(river_root)
	var width: float = 10.5
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(32):
		var z0: float = 8.0 + float(index) * 5.0
		var z1: float = z0 + 5.0
		var x0: float = _river_x(z0)
		var x1: float = _river_x(z1)
		var y0: float = (_height_at(x0 - width * 0.35, z0) + _height_at(x0 + width * 0.35, z0)) * 0.5 + 0.08
		var y1: float = (_height_at(x1 - width * 0.35, z1) + _height_at(x1 + width * 0.35, z1)) * 0.5 + 0.08
		_add_water_triangle(surface, Vector3(x0 - width * 0.5, y0, z0), Vector3(x0 - width * 0.5, y1, z1), Vector3(x0 + width * 0.5, y0, z0), Vector2(0.0, float(index) * 0.18), Vector2(0.0, float(index + 1) * 0.18), Vector2(1.0, float(index) * 0.18))
		_add_water_triangle(surface, Vector3(x0 + width * 0.5, y0, z0), Vector3(x0 - width * 0.5, y1, z1), Vector3(x1 + width * 0.5, y1, z1), Vector2(1.0, float(index) * 0.18), Vector2(0.0, float(index + 1) * 0.18), Vector2(1.0, float(index + 1) * 0.18))
	var mesh: ArrayMesh = surface.commit()
	mesh.surface_set_material(0, _make_water_material())
	var water: MeshInstance3D = MeshInstance3D.new()
	water.name = "SuperficieRioEstrada"
	water.mesh = mesh
	water.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	river_root.add_child(water)

func _build_ruin_arch() -> void:
	var arch: Node3D = Node3D.new()
	arch.name = "ArcoDasRuinas_EstradaDoRio"
	var arch_z: float = 48.0
	var arch_x: float = _road_x(arch_z)
	arch.position = Vector3(arch_x, _height_at(arch_x, arch_z), arch_z)
	add_child(arch)
	for offset_x: float in [-3.25, 3.25]:
		var pillar: Node3D = RUIN_PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarArcoEstrada_%.1f" % offset_x
		pillar.position = Vector3(offset_x, 0.0, 0.0)
		pillar.scale = Vector3(1.45, 1.85, 1.45)
		pillar.rotation.y = signf(offset_x) * 0.08
		_apply_material(pillar, ruin_material)
		arch.add_child(pillar)
	# Núcleos de alvenaria regulares mantêm a silhueta do arco legível a partir da Estrada do Rio.
	for offset_x: float in [-3.25, 3.25]:
		var masonry_mesh: BoxMesh = BoxMesh.new()
		masonry_mesh.size = Vector3(1.12, 6.65, 1.45)
		var masonry: MeshInstance3D = MeshInstance3D.new()
		masonry.name = "NucleoDeAlvenaria_%.1f" % offset_x
		masonry.mesh = masonry_mesh
		masonry.position = Vector3(offset_x, 3.32, 0.0)
		masonry.material_override = ruin_material
		arch.add_child(masonry)
	var lintel_mesh: BoxMesh = BoxMesh.new()
	lintel_mesh.size = Vector3(8.45, 0.92, 1.40)
	var lintel: MeshInstance3D = MeshInstance3D.new()
	lintel.name = "LintelDoArcoEstrada"
	lintel.mesh = lintel_mesh
	lintel.position = Vector3(0.0, 6.85, 0.0)
	lintel.material_override = ruin_material
	arch.add_child(lintel)
	for debris_index: int in range(4):
		var debris: Node3D = RUIN_ROCK.instantiate() as Node3D
		if debris == null:
			continue
		var side: float = -1.0 if debris_index < 2 else 1.0
		debris.name = "EntulhoArcoEstrada_%02d" % debris_index
		debris.position = Vector3(side * (4.15 + float(debris_index % 2) * 0.70), 0.0, -1.7 + float(debris_index % 2) * 2.4)
		var debris_scale: float = 0.24 + float(debris_index % 2) * 0.08
		debris.scale = Vector3(debris_scale, debris_scale * 0.76, debris_scale)
		debris.rotation.y = float(debris_index) * 0.91
		arch.add_child(debris)

func _build_roadside_vegetation() -> void:
	var vegetation: Node3D = Node3D.new()
	vegetation.name = "VegetacaoEstradaDoRio"
	add_child(vegetation)
	for index: int in range(10):
		var z_value: float = 26.0 + float(index) * 9.0
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _road_x(z_value) + side * (7.0 + float(index % 3) * 1.1)
		var tree: Node3D = PINE_MEDIUM.instantiate() as Node3D
		if tree != null:
			tree.name = "ConiferaEstrada_%02d" % index
			tree.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
			var tree_scale: float = 0.24 + float(index % 3) * 0.04
			tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
			tree.rotation.y = float(index) * 0.72
			vegetation.add_child(tree)
	for index: int in range(16):
		var z_value: float = 18.0 + float(index) * 6.0
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _road_x(z_value) + side * (3.5 + float(index % 3) * 0.8)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoEstrada_%02d" % index
			fern.position = Vector3(x_value, _height_at(x_value, z_value) + 0.02, z_value)
			var fern_scale: float = 0.22 + float(index % 3) * 0.04
			fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			fern.rotation.y = float(index) * 0.67
			vegetation.add_child(fern)

func _make_slab(width: float, depth: float, rng: RandomNumberGenerator) -> ArrayMesh:
	var corners: Array[Vector3] = [
		Vector3(-width * 0.52, rng.randf_range(-0.02, 0.025), -depth * 0.50),
		Vector3(width * 0.48, rng.randf_range(-0.02, 0.025), -depth * 0.52),
		Vector3(width * 0.54, rng.randf_range(-0.02, 0.025), depth * 0.46),
		Vector3(-width * 0.45, rng.randf_range(-0.02, 0.025), depth * 0.55)
	]
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for vertex_index: int in [0, 1, 2, 0, 2, 3]:
		surface.set_uv(Vector2(corners[vertex_index].x + 0.5, corners[vertex_index].z + 0.5))
		surface.add_vertex(corners[vertex_index])
	surface.generate_normals()
	return surface.commit()

func _add_water_triangle(surface: SurfaceTool, first: Vector3, second: Vector3, third: Vector3, uv_first: Vector2, uv_second: Vector2, uv_third: Vector2) -> void:
	surface.set_uv(uv_first)
	surface.add_vertex(first)
	surface.set_uv(uv_second)
	surface.add_vertex(second)
	surface.set_uv(uv_third)
	surface.add_vertex(third)

func _make_path_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.28
	material.roughness_texture = GROUND_ROUGHNESS
	material.roughness = 0.90
	material.uv1_scale = Vector3(0.34, 0.34, 0.34)
	return material

func _make_ruin_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.21, 0.25, 0.20, 1.0)
	material.roughness = 0.93
	return material

func _make_water_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode blend_mix, cull_disabled, depth_draw_always, diffuse_burley;
void vertex() {
	VERTEX.y += sin(VERTEX.x * 0.52 + TIME * 0.9) * 0.042 + cos(VERTEX.z * 0.35 + TIME * 0.7) * 0.028;
}
void fragment() {
	float ripple = sin(UV.y * 18.0 + TIME * 0.85) * 0.5 + 0.5;
	ALBEDO = mix(vec3(0.015, 0.10, 0.12), vec3(0.035, 0.30, 0.33), ripple * 0.40 + 0.30);
	ROUGHNESS = 0.25;
	SPECULAR = 0.58;
	ALPHA = 0.78;
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
