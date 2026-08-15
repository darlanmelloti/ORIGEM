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
	_build_forest_wayfinding()
	_build_lake_shore_path()
	_build_lake_wayfinding()
	_build_dense_forest()
	_build_majestic_camp()
	_build_submerged_ruins()
	_build_riparian_margin()
	_build_lakeside_focal_vegetation()

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

func _build_forest_wayfinding() -> void:
	# Balizas baixas, quentes e espaçadas: guiam Elias no sub-bosque sem transformar a floresta num corredor iluminado.
	var markers: Node3D = Node3D.new()
	markers.name = "BalizasDoTrilhoFlorestal"
	add_child(markers)
	var stone: StandardMaterial3D = StandardMaterial3D.new()
	stone.albedo_color = Color(0.095, 0.105, 0.085, 1.0)
	stone.roughness = 0.96
	var ember: StandardMaterial3D = StandardMaterial3D.new()
	ember.albedo_color = Color(0.58, 0.12, 0.025, 1.0)
	ember.emission_enabled = true
	ember.emission = Color(1.0, 0.12, 0.018, 1.0)
	ember.emission_energy_multiplier = 0.70
	for index: int in range(5):
		var z_value: float = 122.0 + float(index) * 6.5
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _path_x(z_value) + side * 2.40
		var ground_y: float = _height_at(x_value, z_value)
		var base_mesh: CylinderMesh = CylinderMesh.new()
		base_mesh.top_radius = 0.20
		base_mesh.bottom_radius = 0.29
		base_mesh.height = 1.25
		base_mesh.radial_segments = 7
		base_mesh.material = stone
		var base: MeshInstance3D = MeshInstance3D.new()
		base.name = "BalizaFlorestal_%02d" % index
		base.mesh = base_mesh
		base.position = Vector3(x_value, ground_y + 0.62, z_value)
		base.rotation.y = 0.33 + float(index) * 0.52
		markers.add_child(base)
		var ember_mesh: SphereMesh = SphereMesh.new()
		ember_mesh.radius = 0.105
		ember_mesh.height = 0.21
		ember_mesh.radial_segments = 12
		ember_mesh.material = ember
		var glow: MeshInstance3D = MeshInstance3D.new()
		glow.name = "BrasaDaBaliza_%02d" % index
		glow.mesh = ember_mesh
		glow.position = Vector3(x_value, ground_y + 1.30, z_value)
		markers.add_child(glow)
		var light: OmniLight3D = OmniLight3D.new()
		light.light_color = Color(1.0, 0.32, 0.10, 1.0)
		light.light_energy = 0.20
		light.omni_range = 3.8
		light.shadow_enabled = false
		light.position = glow.position
		markers.add_child(light)

func _lake_shore_x(world_z: float) -> float:
	var t: float = clampf((world_z - 145.0) / 79.0, 0.0, 1.0)
	return lerpf(_path_x(145.0), 14.0, t) + sin(t * PI) * 1.0

func _build_lake_shore_path() -> void:
	var shore_road: Node3D = Node3D.new()
	shore_road.name = "TrilhoAteAMargemDoLago"
	add_child(shore_road)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 40652
	for index: int in range(30):
		var t: float = float(index) / 29.0
		var z_value: float = lerpf(145.0, 224.0, t)
		var x_value: float = _lake_shore_x(z_value)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeMargem_%02d" % index
		slab.mesh = _make_slab(1.72 + rng.randf_range(-0.18, 0.20), 1.30 + rng.randf_range(-0.14, 0.16), rng)
		slab.material_override = path_material
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.055, z_value)
		slab.rotation.y = atan2((_lake_shore_x(z_value + 1.0) - _lake_shore_x(z_value - 1.0)) * 0.5, 2.7) + rng.randf_range(-0.08, 0.08)
		shore_road.add_child(slab)

func _build_lake_wayfinding() -> void:
	# Quatro marcos de pedra com brilho Chronos baixo: orientam a curva da margem sem transformar o trilho em sinalização moderna.
	var markers: Node3D = Node3D.new()
	markers.name = "MarcosDaMargemDoLago"
	add_child(markers)
	var stone: StandardMaterial3D = StandardMaterial3D.new()
	stone.albedo_color = Color(0.14, 0.17, 0.16, 1.0)
	stone.roughness = 0.91
	var chronos: StandardMaterial3D = StandardMaterial3D.new()
	chronos.albedo_color = Color(0.035, 0.20, 0.30, 1.0)
	chronos.emission_enabled = true
	chronos.emission = Color(0.02, 0.42, 0.80, 1.0)
	chronos.emission_energy_multiplier = 1.45
	for index: int in range(4):
		var t: float = float(index) / 3.0
		var z_value: float = lerpf(154.0, 218.0, t)
		var x_value: float = _lake_shore_x(z_value) - 2.35
		var ground_y: float = _height_at(x_value, z_value)
		var pillar_mesh: CylinderMesh = CylinderMesh.new()
		pillar_mesh.top_radius = 0.24
		pillar_mesh.bottom_radius = 0.34
		pillar_mesh.height = 2.35
		pillar_mesh.radial_segments = 8
		pillar_mesh.material = stone
		var pillar: MeshInstance3D = MeshInstance3D.new()
		pillar.name = "MarcoRibeirinho_%02d" % index
		pillar.mesh = pillar_mesh
		pillar.position = Vector3(x_value, ground_y + 1.18, z_value)
		pillar.rotation.y = 0.26 + float(index) * 0.57
		markers.add_child(pillar)
		var beacon_mesh: SphereMesh = SphereMesh.new()
		beacon_mesh.radius = 0.16
		beacon_mesh.height = 0.32
		beacon_mesh.radial_segments = 12
		beacon_mesh.material = chronos
		var beacon: MeshInstance3D = MeshInstance3D.new()
		beacon.name = "LuzChronosMargem_%02d" % index
		beacon.mesh = beacon_mesh
		beacon.position = Vector3(x_value, ground_y + 2.42, z_value)
		markers.add_child(beacon)
		var light: OmniLight3D = OmniLight3D.new()
		light.light_color = Color(0.18, 0.48, 0.82, 1.0)
		light.light_energy = 0.38
		light.omni_range = 5.5
		light.shadow_enabled = false
		light.position = beacon.position
		markers.add_child(light)

func _build_dense_forest() -> void:
	var forest: Node3D = Node3D.new()
	forest.name = "FlorestaDensaRegional"
	add_child(forest)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 40417
	for index: int in range(104):
		var z_value: float = 72.0 + float(index / 2) * 4.5 + rng.randf_range(-2.0, 2.0)
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var spacing: float = 8.5 + fmod(float(index * 7), 20.0)
		var x_value: float = _path_x(z_value) + side * spacing
		# Mantém o corredor livre e evita árvores dentro da bacia elíptica das Ruínas Submersas.
		var lake_dx: float = (x_value - 60.0) / 48.0
		var lake_dz: float = (z_value - 252.0) / 38.0
		if abs(x_value - _path_x(z_value)) < 6.0 or lake_dx * lake_dx + lake_dz * lake_dz < 1.20:
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
	for index: int in range(112):
		var z_value: float = 70.0 + float(index) * 1.55
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _path_x(z_value) + side * (4.7 + fmod(float(index), 5.0) * 0.78)
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
	var center_x: float = 60.0
	var center_z: float = 252.0
	var water_y: float = _height_at(center_x, center_z) + 0.45
	lake.position = Vector3(center_x, water_y, center_z)
	add_child(lake)
	var water_mesh: ArrayMesh = _make_elliptical_lake_mesh(42.0, 34.0)
	water_mesh.surface_set_material(0, _create_lake_material())
	var water: MeshInstance3D = MeshInstance3D.new()
	water.name = "LagoDasRuinasSubmersas"
	water.mesh = water_mesh
	water.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	lake.add_child(water)
	var shoreline_fill: OmniLight3D = OmniLight3D.new()
	shoreline_fill.name = "PreenchimentoAzulDaMargem"
	shoreline_fill.light_color = Color(0.10, 0.28, 0.42, 1.0)
	shoreline_fill.light_energy = 0.56
	shoreline_fill.omni_range = 42.0

	shoreline_fill.shadow_enabled = false
	shoreline_fill.position = Vector3(-19.0, 5.0, -7.0)
	lake.add_child(shoreline_fill)
	for index: int in range(8):
		var angle: float = float(index) * TAU / 8.0
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarSubmerso_%02d" % index
		pillar.position = Vector3(cos(angle) * 23.0, -0.25 + float(index % 3) * 0.60, sin(angle) * 18.0)
		var pillar_scale: float = 0.90 + float(index % 2) * 0.22
		pillar.scale = Vector3(pillar_scale, pillar_scale, pillar_scale)
		pillar.rotation = Vector3(0.20 + float(index % 3) * 0.15, angle, 0.13 * sin(angle))
		_apply_material(pillar, ruin_material)
		lake.add_child(pillar)
	# Três remanescentes altos asseguram que a civilização submersa é lida desde o trilho sem criar uma parede.
	for landmark_index: int in range(3):
		var landmark: Node3D = PILLAR.instantiate() as Node3D
		if landmark == null:
			continue
		landmark.name = "MarcoRuinaEmergente_%02d" % landmark_index
		landmark.position = Vector3(-17.0 + float(landmark_index) * 16.5, 2.35 + float(landmark_index % 2) * 0.55, -9.0 + float(landmark_index) * 5.0)
		var landmark_scale: float = 1.46 - float(landmark_index) * 0.13
		landmark.scale = Vector3(landmark_scale, landmark_scale, landmark_scale)
		landmark.rotation = Vector3(0.08 * float(landmark_index + 1), 0.38 + float(landmark_index) * 0.41, 0.04)
		_apply_material(landmark, ruin_material)
		lake.add_child(landmark)
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

func _make_elliptical_lake_mesh(radius_x: float, radius_z: float) -> ArrayMesh:
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var segments: int = 48
	for index: int in range(segments):
		var angle_a: float = float(index) * TAU / float(segments)
		var angle_b: float = float(index + 1) * TAU / float(segments)
		var point_a: Vector3 = Vector3(cos(angle_a) * radius_x, 0.0, sin(angle_a) * radius_z)
		var point_b: Vector3 = Vector3(cos(angle_b) * radius_x, 0.0, sin(angle_b) * radius_z)
		surface.set_uv(Vector2(0.5, 0.5))
		surface.add_vertex(Vector3.ZERO)
		surface.set_uv(Vector2(0.5 + cos(angle_b) * 0.5, 0.5 + sin(angle_b) * 0.5))
		surface.add_vertex(point_b)
		surface.set_uv(Vector2(0.5 + cos(angle_a) * 0.5, 0.5 + sin(angle_a) * 0.5))
		surface.add_vertex(point_a)
	surface.generate_normals()
	return surface.commit()

func _build_riparian_margin() -> void:
	var margin: Node3D = Node3D.new()
	margin.name = "MargensRochosasDoLago"
	add_child(margin)
	var center: Vector2 = Vector2(60.0, 252.0)
	for index: int in range(48):
		var angle: float = float(index) * TAU / 48.0
		var radius_x: float = 44.0 + sin(float(index) * 1.71) * 2.8
		var radius_z: float = 36.0 + cos(float(index) * 1.27) * 2.4
		var world_x: float = center.x + cos(angle) * radius_x
		var world_z: float = center.y + sin(angle) * radius_z
		# Mantém a entrada ocidental do caminho aberta antes de entrar no vale do lago.
		if world_z < 238.0 and abs(world_x - _path_x(world_z)) < 9.0:
			continue
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaDeMargem_%02d" % index
			rock.position = Vector3(world_x, _height_at(world_x, world_z) + 0.15, world_z)
			var rock_scale: float = 0.19 + fmod(float(index), 4.0) * 0.050
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

func _build_lakeside_focal_vegetation() -> void:
	# Grupos descontínuos de espécies reais: enquadram a água e mantêm a abertura do trilho ocidental livre.
	var foliage: Node3D = Node3D.new()
	foliage.name = "VegetacaoFocalDaMargem"
	add_child(foliage)
	var placements: Array[Vector3] = [
		Vector3(25.0, 0.0, 236.0), Vector3(33.0, 0.0, 278.0),
		Vector3(61.0, 0.0, 290.0), Vector3(88.0, 0.0, 276.0),
		Vector3(101.0, 0.0, 253.0), Vector3(91.0, 0.0, 226.0)
	]
	for index: int in range(placements.size()):
		var source: PackedScene = OAK_DARK if index % 3 == 0 else (DARK_TREE if index % 3 == 1 else PINE_TALL)
		var tree: Node3D = source.instantiate() as Node3D
		if tree == null:
			continue
		var point: Vector3 = placements[index]
		tree.name = "ArvoreFocalMargem_%02d" % index
		tree.position = Vector3(point.x, _height_at(point.x, point.z), point.z)
		var scale_value: float = 0.38 + float(index % 3) * 0.08
		if index % 3 == 0:
			scale_value = 0.58
		tree.scale = Vector3(scale_value, scale_value, scale_value)
		tree.rotation.y = 0.37 + float(index) * 0.91
		foliage.add_child(tree)
	for index: int in range(32):
		var angle: float = 0.34 + float(index) * TAU / 32.0
		var x_value: float = 60.0 + cos(angle) * (46.0 + fmod(float(index), 3.0) * 1.6)
		var z_value: float = 252.0 + sin(angle) * (38.0 + fmod(float(index), 4.0) * 1.1)
		if z_value < 236.0 and x_value < 28.0:
			continue
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern == null:
			continue
		fern.name = "FetoFocalMargem_%02d" % index
		fern.position = Vector3(x_value, _height_at(x_value, z_value) + 0.03, z_value)
		var fern_scale: float = 0.50 + fmod(float(index), 4.0) * 0.075
		fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
		fern.rotation.y = angle + 0.48
		foliage.add_child(fern)

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
render_mode cull_disabled, depth_draw_opaque, diffuse_burley;
void vertex() {
	VERTEX.y += sin(VERTEX.x * 0.16 + TIME * 0.72) * 0.11 + cos(VERTEX.z * 0.13 + TIME * 0.58) * 0.075;
}
void fragment() {
	float ripple = sin(VERTEX.x * 0.28 + VERTEX.z * 0.19 + TIME * 0.75) * 0.5 + 0.5;
					// Água profunda e fria: o detalhe nasce de ripples e reflexo, nunca de emissão ciano plana.
		float broad_ripple = sin(VERTEX.x * 0.08 - VERTEX.z * 0.06 + TIME * 0.22) * 0.5 + 0.5;
		float surface_variation = clamp(ripple * 0.62 + broad_ripple * 0.38, 0.0, 1.0);
		ALBEDO = mix(vec3(0.008, 0.040, 0.060), vec3(0.030, 0.135, 0.165), surface_variation * 0.56);
		EMISSION = vec3(0.0);
		ROUGHNESS = 0.46;
		SPECULAR = 0.42;

		ALPHA = 1.0;

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
