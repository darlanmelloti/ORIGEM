## ValleyBiome.gd
## Bioma 3D do Vale de Kheper: relva em tufos, arbustos, árvores ramificadas e pedras.
## Todas as instâncias usam a altura real do TerrainPatch; nada é colocado por um plano fixo.

extends Node3D

const GRASS_NEAR_COUNT: int = 1500
const GRASS_MID_COUNT: int = 1180
const GRASS_FAR_COUNT: int = 920

var terrain_patch: Node3D
var foliage_wind: Array[Node3D] = []
var elapsed_time: float = 0.0

var grass_material: StandardMaterial3D
var flower_material: StandardMaterial3D
var bark_material: StandardMaterial3D
var bark_light_material: StandardMaterial3D
var leaf_material: StandardMaterial3D
var leaf_light_material: StandardMaterial3D
var rock_material: StandardMaterial3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	_create_materials()
	_build_grass_biome()
	_build_rock_biome()
	_build_shrubs()
	# As árvores heroicas procedurais foram desativadas neste passe; o enquadramento usa apenas o kit GLB.
	_build_flower_clusters()

func _process(delta: float) -> void:
	elapsed_time += delta
	for index: int in range(foliage_wind.size()):
		var foliage_root: Node3D = foliage_wind[index]
		foliage_root.rotation.z = sin(elapsed_time * 0.90 + float(index) * 0.41) * 0.055
		foliage_root.rotation.x = cos(elapsed_time * 0.73 + float(index) * 0.29) * 0.028

func _create_materials() -> void:
	grass_material = StandardMaterial3D.new()
	grass_material.albedo_color = Color.WHITE
	grass_material.vertex_color_use_as_albedo = true
	grass_material.roughness = 0.94
	grass_material.cull_mode = BaseMaterial3D.CULL_DISABLED

	flower_material = StandardMaterial3D.new()
	flower_material.albedo_color = Color(0.44, 0.54, 0.22)
	flower_material.emission_enabled = true
	flower_material.emission = Color(0.05, 0.08, 0.02)
	flower_material.emission_energy_multiplier = 0.12
	flower_material.cull_mode = BaseMaterial3D.CULL_DISABLED

	bark_material = _make_material(Color(0.105, 0.070, 0.050), 1.0)
	bark_light_material = _make_material(Color(0.18, 0.12, 0.08), 1.0)
	leaf_material = StandardMaterial3D.new()
	leaf_material.albedo_color = Color.WHITE
	leaf_material.vertex_color_use_as_albedo = true
	leaf_material.roughness = 0.88
	leaf_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	leaf_light_material = _make_material(Color(0.16, 0.30, 0.14), 0.92)
	rock_material = _make_material(Color(0.22, 0.24, 0.22), 1.0)

func _build_grass_biome() -> void:
	var grass_mesh: ArrayMesh = _create_grass_clump_mesh()
	_build_grass_sector(Rect2(-64.0, -34.0, 62.0, 88.0), GRASS_NEAR_COUNT, grass_mesh, "RelvaProxima", 9)
	_build_grass_sector(Rect2(0.0, -40.0, 67.0, 94.0), GRASS_MID_COUNT, grass_mesh, "RelvaDoLago", 37)
	_build_grass_sector(Rect2(-82.0, -142.0, 164.0, 90.0), GRASS_FAR_COUNT, grass_mesh, "RelvaDistante", 71)

func _build_grass_sector(region: Rect2, count: int, mesh: ArrayMesh, node_name: String, seed_value: int) -> void:
	var multimesh: MultiMesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.use_colors = true
	multimesh.mesh = mesh
	multimesh.instance_count = count
	multimesh.visible_instance_count = -1
	multimesh.custom_aabb = AABB(Vector3(region.position.x, -1.0, region.position.y), Vector3(region.size.x, 4.0, region.size.y))

	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = seed_value
	var placed: int = 0
	var attempts: int = 0
	while placed < count and attempts < count * 8:
		attempts += 1
		var x: float = rng.randf_range(region.position.x, region.end.x)
		var z: float = rng.randf_range(region.position.y, region.end.y)
		if not _is_valid_ground(x, z):
			continue
		var y: float = _ground_height(x, z)
		var scale_value: float = rng.randf_range(0.55, 1.18)
		var rotation_y: float = rng.randf_range(0.0, TAU)
		var transform: Transform3D = Transform3D(Basis(Vector3.UP, rotation_y).scaled(Vector3(scale_value, scale_value, scale_value)), Vector3(x, y, z))
		multimesh.set_instance_transform(placed, transform)
		multimesh.set_instance_color(placed, _grass_tint(rng.randf()))
		placed += 1

	# Instâncias que não couberem devido a exclusões ficam enterradas no limite do vale, sem blocos flutuantes.
	while placed < count:
		multimesh.set_instance_transform(placed, Transform3D(Basis.IDENTITY, Vector3(0.0, -20.0, 0.0)))
		placed += 1

	var instance: MultiMeshInstance3D = MultiMeshInstance3D.new()
	instance.name = node_name
	instance.multimesh = multimesh
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	instance.visibility_range_end = 115.0
	instance.visibility_range_end_margin = 12.0
	add_child(instance)

func _create_grass_clump_mesh() -> ArrayMesh:
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for blade_index: int in range(7):
		var angle: float = float(blade_index) * 0.897
		var base: Vector3 = Vector3(cos(angle) * 0.08, 0.0, sin(angle) * 0.08)
		var width: float = 0.045 + float(blade_index % 3) * 0.012
		var height: float = 0.52 + float(blade_index % 4) * 0.105
		var bend: Vector3 = Vector3(cos(angle) * 0.18, height, sin(angle) * 0.18)
		var side: Vector3 = Vector3(cos(angle + PI * 0.5) * width, 0.0, sin(angle + PI * 0.5) * width)
		var color: Color = Color(0.08 + float(blade_index % 2) * 0.035, 0.19 + float(blade_index % 3) * 0.045, 0.075, 1.0)
		_add_colored_triangle(surface, base - side, bend, base + side, color)
		_add_colored_triangle(surface, base + side, bend, base - side, color)
	surface.generate_normals()
	var grass_mesh: ArrayMesh = surface.commit()
	grass_mesh.surface_set_material(0, grass_material)
	return grass_mesh

func _build_rock_biome() -> void:
	var rock_mesh: SphereMesh = SphereMesh.new()
	rock_mesh.radius = 0.72
	rock_mesh.height = 0.95
	rock_mesh.radial_segments = 7
	rock_mesh.rings = 3
	rock_mesh.material = rock_material

	var multimesh: MultiMesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = rock_mesh
	multimesh.instance_count = 86
	multimesh.custom_aabb = AABB(Vector3(-92.0, -2.0, -155.0), Vector3(184.0, 12.0, 178.0))
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 401
	for index: int in range(multimesh.instance_count):
		var x: float = rng.randf_range(-82.0, 82.0)
		var z: float = rng.randf_range(-146.0, -10.0)
		if not _is_valid_ground(x, z):
			x = -65.0 + float(index % 12) * 10.0
			z = -115.0 - float(index / 12) * 4.0
		var y: float = _ground_height(x, z)
		var scale_value: float = rng.randf_range(0.28, 1.05)
		var basis: Basis = Basis(Vector3.UP, rng.randf_range(0.0, TAU)).scaled(Vector3(scale_value * 1.25, scale_value, scale_value))
		multimesh.set_instance_transform(index, Transform3D(basis, Vector3(x, y + scale_value * 0.28, z)))

	var instance: MultiMeshInstance3D = MultiMeshInstance3D.new()
	instance.name = "RochasNaturais"
	instance.multimesh = multimesh
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	instance.visibility_range_end = 130.0
	add_child(instance)

func _build_shrubs() -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 811
	for index: int in range(42):
		var x: float = rng.randf_range(-66.0, 66.0)
		var z: float = rng.randf_range(-132.0, -12.0)
		if not _is_valid_ground(x, z) or abs(x) < 8.0 and z > -92.0:
			continue
		_add_shrub(Vector3(x, _ground_height(x, z), z), rng, index)

func _build_hero_trees() -> void:
	var positions: Array[Vector3] = [
		Vector3(-18.0, 0.0, 0.0), Vector3(-29.0, 0.0, -17.0), Vector3(-43.0, 0.0, -49.0),
		Vector3(17.0, 0.0, -20.0), Vector3(60.0, 0.0, -22.0), Vector3(67.0, 0.0, -73.0),
		Vector3(-58.0, 0.0, -85.0), Vector3(17.0, 0.0, -105.0), Vector3(-8.0, 0.0, -117.0),
		Vector3(56.0, 0.0, -112.0), Vector3(-67.0, 0.0, -113.0), Vector3(-35.0, 0.0, -130.0)
	]
	for index: int in range(positions.size()):
		var position_value: Vector3 = positions[index]
		position_value.y = _ground_height(position_value.x, position_value.z)
		_add_tree(position_value, index)

func _build_flower_clusters() -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 1257
	for index: int in range(32):
		var x: float = rng.randf_range(-34.0, 52.0)
		var z: float = rng.randf_range(-105.0, -11.0)
		if not _is_valid_ground(x, z):
			continue
		var root: Node3D = Node3D.new()
		root.name = "FloresDoVale"
		root.position = Vector3(x, _ground_height(x, z), z)
		_snap_to_terrain(root, x, z)
		add_child(root)
		foliage_wind.append(root)
		for flower_index: int in range(4):
			var flower_mesh: SphereMesh = SphereMesh.new()
			flower_mesh.radius = 0.11
			flower_mesh.height = 0.16
			flower_mesh.material = flower_material
			var flower: MeshInstance3D = MeshInstance3D.new()
			flower.mesh = flower_mesh
			flower.position = Vector3(rng.randf_range(-0.32, 0.32), rng.randf_range(0.22, 0.46), rng.randf_range(-0.32, 0.32))
			root.add_child(flower)

func _add_tree(position_value: Vector3, seed_value: int) -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 9000 + seed_value
	var tree: Node3D = Node3D.new()
	tree.name = "ArvoreDoVale"
	tree.position = position_value
	_snap_to_terrain(tree, position_value.x, position_value.z)
	tree.rotation.y = rng.randf_range(0.0, TAU)
	add_child(tree)

	var trunk_height: float = rng.randf_range(5.2, 7.8)
	_add_branch_cylinder(tree, Vector3.ZERO, Vector3(0.0, trunk_height, 0.0), 0.42, 0.22, bark_material)

	# Ramos inclinados quebram a silhueta cilíndrica e criam suporte real para a copa.
	for branch_index: int in range(7):
		var angle: float = float(branch_index) * 0.91 + rng.randf_range(-0.25, 0.25)
		var start: Vector3 = Vector3(0.0, trunk_height * rng.randf_range(0.42, 0.88), 0.0)
		var end: Vector3 = start + Vector3(cos(angle) * rng.randf_range(1.8, 3.1), rng.randf_range(0.4, 1.5), sin(angle) * rng.randf_range(1.8, 3.1))
		_add_branch_cylinder(tree, start, end, 0.16, 0.07, bark_light_material)

	var foliage_root: Node3D = Node3D.new()
	foliage_root.name = "FolhasAnimadas"
	foliage_root.position = Vector3(0.0, trunk_height * 0.78, 0.0)
	tree.add_child(foliage_root)
	foliage_wind.append(foliage_root)

	var canopy: MeshInstance3D = MeshInstance3D.new()
	canopy.name = "CopaComFolhas"
	canopy.mesh = _create_leaf_canopy_mesh(rng)
	foliage_root.add_child(canopy)
	canopy.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON

func _add_shrub(position_value: Vector3, rng: RandomNumberGenerator, index: int) -> void:
	var shrub: Node3D = Node3D.new()
	shrub.name = "Arbusto_%02d" % index
	shrub.position = position_value
	_snap_to_terrain(shrub, position_value.x, position_value.z)
	shrub.rotation.y = rng.randf_range(0.0, TAU)
	add_child(shrub)
	foliage_wind.append(shrub)

	for stem_index: int in range(4):
		var start: Vector3 = Vector3(0.0, 0.05, 0.0)
		var angle: float = float(stem_index) * 1.57 + rng.randf_range(-0.30, 0.30)
		var end: Vector3 = Vector3(cos(angle) * rng.randf_range(0.45, 0.85), rng.randf_range(0.55, 1.05), sin(angle) * rng.randf_range(0.45, 0.85))
		_add_branch_cylinder(shrub, start, end, 0.07, 0.025, bark_light_material)

	var leaves: MeshInstance3D = MeshInstance3D.new()
	leaves.name = "FolhasDoArbusto"
	leaves.mesh = _create_leaf_canopy_mesh(rng, 18, 1.1, 0.7)
	leaves.position.y = 0.55
	shrub.add_child(leaves)

func _create_leaf_canopy_mesh(rng: RandomNumberGenerator, card_count: int = 46, radius: float = 2.6, height: float = 2.2) -> ArrayMesh:
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for card_index: int in range(card_count):
		var angle: float = rng.randf_range(0.0, TAU)
		var horizontal_radius: float = sqrt(rng.randf()) * radius
		var center: Vector3 = Vector3(cos(angle) * horizontal_radius, rng.randf_range(-height * 0.30, height * 0.70), sin(angle) * horizontal_radius)
		var width: float = rng.randf_range(0.38, 0.88)
		var card_height: float = rng.randf_range(0.38, 0.92)
		var card_angle: float = rng.randf_range(0.0, TAU)
		var side: Vector3 = Vector3(cos(card_angle) * width, 0.0, sin(card_angle) * width)
		var up: Vector3 = Vector3(sin(card_angle) * 0.16, card_height, cos(card_angle) * 0.16)
		var leaf_color: Color = Color(rng.randf_range(0.045, 0.11), rng.randf_range(0.19, 0.33), rng.randf_range(0.065, 0.14), 1.0)
		_add_colored_triangle(surface, center - side, center + up, center + side, leaf_color)
		_add_colored_triangle(surface, center + side, center + up, center - side, leaf_color)
	surface.generate_normals()
	var canopy_mesh: ArrayMesh = surface.commit()
	canopy_mesh.surface_set_material(0, leaf_material)
	return canopy_mesh

func _add_branch_cylinder(parent: Node3D, start: Vector3, end: Vector3, bottom_radius: float, top_radius: float, material: StandardMaterial3D) -> void:
	var direction: Vector3 = end - start
	var length: float = direction.length()
	if length <= 0.001:
		return
	var branch_mesh: CylinderMesh = CylinderMesh.new()
	branch_mesh.bottom_radius = bottom_radius
	branch_mesh.top_radius = top_radius
	branch_mesh.height = length
	branch_mesh.radial_segments = 7
	branch_mesh.material = material
	var branch: MeshInstance3D = MeshInstance3D.new()
	branch.mesh = branch_mesh
	branch.position = (start + end) * 0.5
	branch.basis = Basis(Quaternion(Vector3.UP, direction.normalized()))
	parent.add_child(branch)

func _add_colored_triangle(surface: SurfaceTool, first: Vector3, second: Vector3, third: Vector3, color: Color) -> void:
	surface.set_color(color)
	surface.add_vertex(first)
	surface.set_color(color)
	surface.add_vertex(second)
	surface.set_color(color)
	surface.add_vertex(third)

func _is_valid_ground(x: float, z: float) -> bool:
	if Vector2(x, z).distance_to(Vector2(25.0, -62.0)) < 37.0:
		return false
	if abs(x - sin(-z * 0.075) * 4.8) < 3.2 and z < -5.0 and z > -88.0:
		return false
	return true

func _snap_to_terrain(object_node: Node3D, world_x: float, world_z: float) -> void:
	object_node.position = Vector3(world_x, _ground_height(world_x, world_z), world_z)

func _ground_height(x: float, z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", x, z))
	return 0.0

func _grass_tint(value: float) -> Color:
	if value < 0.33:
		return Color(0.08, 0.31, 0.08, 1.0)
	if value < 0.70:
		return Color(0.16, 0.46, 0.10, 1.0)
	return Color(0.28, 0.54, 0.13, 1.0)

func _make_material(color: Color, roughness_value: float) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness_value
	return material
