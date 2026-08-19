## ForestLakeRegion.gd
## Marcos 4–6 do mapa regional: Floresta Densa, Acampamento Majestic e Ruínas Submersas.
## Construção modular e aterrrada sobre TerrainPatch para manter continuidade física sem ecrãs de carregamento.

extends Node3D
# CP 200: Orçamento de luzes — ForestLakeRegion
# Luzes dinâmicas criadas: 22 na auditoria CP 200 + luar de acampamento CP 213.
# Estratégia GTX 1050 Ti: alcance reduzido → menos tiles iluminados simultaneamente
# Limite efectivo simultâneo estimado: ≤14 luzes por frame (câmara nunca vê todas)
# MAX_DYNAMIC_LIGHTS_BUDGET = 14  # referência para futuras adições


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
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")
const CARTOGRAPHIC_GROUNDING: Script = preload("res://levels/dev5/CartographicGroundingSystem.gd")

var terrain_patch: Node3D
var path_material: StandardMaterial3D
var ruin_material: StandardMaterial3D
var shore_material: StandardMaterial3D
var camp_light_sources: Array[OmniLight3D] = []
var camp_flame_meshes: Array[MeshInstance3D] = []
var camp_animation_time: float = 0.0

func _ready() -> void:
	_build_south_shore_fill()
	_build_forest_corridor_fill()
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	path_material = _create_path_material()
	ruin_material = _create_ruin_material()
	shore_material = _create_shore_material()
	_build_forest_path()
	_build_cartographic_forest_threshold()
	_build_arch_to_forest_transition()
	_build_arch_forest_understory()
	_build_forest_wayfinding()
	_build_lake_shore_path()
	_build_cartographic_river_inlet()
	_build_shore_access_steps()
	_build_basin_arrival_frame()
	_build_majestic_lake_transition()
	_build_basin_approach_silhouettes()
	_build_cartographic_lake_vistas()
	_build_lake_wayfinding()
	_build_dense_forest()
	_build_forest_canopy_clusters()
	_build_forest_micro_details()
	_build_majestic_camp()
	_build_majestic_connector()
	_build_majestic_lake_link()
	_build_majestic_turn_marker()
	_build_take9_corridor_fill()
	_build_take6_corridor_accent()
	_build_submerged_ruins()
	_build_cartographic_basin_silhouette()
	_build_riparian_margin()
	_build_dev6_r6_organic_shore_integration()
	_build_lakeside_focal_vegetation()
	_build_majestic_ruins_approach_grounding()
	_apply_riparian_fern_alpha_test()

func _apply_riparian_fern_alpha_test() -> void:
	# CP-CARTO-50: os fetos ribeirinhos não fizeram parte do teste anterior; preserva-se textura PBR e aplica-se apenas o corte alfa compatível.
	for fern: Node in find_children("FetoRibeirinho_*", "Node3D", true, false):
		for mesh_node: Node in fern.find_children("*", "MeshInstance3D", true, false):
			var mesh: MeshInstance3D = mesh_node as MeshInstance3D
			if mesh == null:
				continue
			var source_material: StandardMaterial3D = mesh.get_active_material(0) as StandardMaterial3D
			if source_material == null:
				continue
			var foliage_material: StandardMaterial3D = source_material.duplicate() as StandardMaterial3D
			foliage_material.albedo_color = Color(0.30, 0.56, 0.24, 1.0)
			foliage_material.metallic = 0.0
			foliage_material.roughness = 0.90
			foliage_material.emission_enabled = false
			foliage_material.cull_mode = BaseMaterial3D.CULL_DISABLED
			foliage_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
			foliage_material.alpha_scissor_threshold = 0.36
			mesh.material_override = foliage_material

func _process(delta: float) -> void:
	# Oscilação lenta e determinística: dá vida ao acampamento sem partículas pesadas nem custo de sombras dinâmicas.
	camp_animation_time += delta
	for index: int in range(camp_light_sources.size()):
		var source: OmniLight3D = camp_light_sources[index]
		if is_instance_valid(source):
			var pulse: float = 0.88 + sin(camp_animation_time * (2.10 + float(index) * 0.17) + float(index)) * 0.12
			source.light_energy = source.get_meta("base_energy", source.light_energy) * pulse
	for index: int in range(camp_flame_meshes.size()):
		var flame: MeshInstance3D = camp_flame_meshes[index]
		if is_instance_valid(flame):
			# Flicker de escala mais amplo: 0.82–1.18 para leitura clara no gl_compatibility.
			var flicker: float = 1.0 + sin(camp_animation_time * (3.4 + float(index) * 0.31) + float(index) * 1.7) * 0.18
			flame.scale = Vector3(flicker * 0.92, flicker, flicker * 0.92)

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
	# O trilho florestal termina onde a rota de margem começa; assim evitam-se duas cadeias de lajes a ocupar o mesmo corredor físico.
	var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
	var forest_end_z: float = lake_anchor.y - 107.0
	for index: int in range(12):
		var t: float = float(index) / 11.0
		var z_value: float = lerpf(116.0, forest_end_z, t)
		var x_value: float = _path_x(z_value)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeFloresta_%02d" % index
		slab.mesh = _make_slab(1.58 + rng.randf_range(-0.22, 0.25), 1.20 + rng.randf_range(-0.16, 0.18), rng)
		slab.material_override = path_material
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.05, z_value)
		# Variação de rotação ampliada: ±0.18 rad para naturalizar o pavimento e reduzir a aparência de corredor artificial.
		slab.rotation.y = atan2((_path_x(z_value + 1.0) - _path_x(z_value - 1.0)) * 0.5, 2.8) + rng.randf_range(-0.18, 0.18)
		road.add_child(slab)
		# A laje acompanha o relevo com uma colisão baixa, tornando o trilho transitável sem criar obstáculos no sub-bosque.
		var slab_body: StaticBody3D = StaticBody3D.new()
		slab_body.name = "ColisorLajeFloresta_%02d" % index
		slab_body.position = slab.position + Vector3(0.0, -0.045, 0.0)
		slab_body.rotation.y = slab.rotation.y
		var slab_collision: CollisionShape3D = CollisionShape3D.new()
		var slab_shape: BoxShape3D = BoxShape3D.new()
		slab_shape.size = Vector3(1.48, 0.16, 1.06)
		slab_collision.shape = slab_shape
		slab_body.add_child(slab_collision)
		road.add_child(slab_body)

func _build_cartographic_forest_threshold() -> void:
	# CP 219 — O limiar confirma no mundo físico a passagem Arco das Ruínas → Floresta Densa do mapa.
	# As árvores e rochas formam uma massa de bosque com abertura central, nunca uma parede nem um bloqueio do trilho.
	var threshold: Node3D = Node3D.new()
	threshold.name = "LimiarCartograficoDaFloresta"
	add_child(threshold)
	var forest_entry_z: float = CARTOGRAPHIC_ANCHORS.FLORESTA_DENSA_ENTRADA.y
	var tree_specs: Array[Dictionary] = [
		{"z": forest_entry_z - 28.0, "side": -1.0, "offset": 10.4, "scale": 0.54},
		{"z": forest_entry_z - 24.0, "side": 1.0, "offset": 11.2, "scale": 0.48},
		{"z": forest_entry_z - 16.0, "side": -1.0, "offset": 12.8, "scale": 0.60},
		{"z": forest_entry_z - 11.0, "side": 1.0, "offset": 10.6, "scale": 0.52},
	]
	for tree_index: int in range(tree_specs.size()):
		var spec: Dictionary = tree_specs[tree_index]
		var z_value: float = float(spec["z"])
		var side: float = float(spec["side"])
		var x_value: float = _path_x(z_value) + side * float(spec["offset"])
		var source: PackedScene = ISLAND_TREE if tree_index % 2 == 0 else OAK_DARK
		var tree: Node3D = source.instantiate() as Node3D
		if tree == null:
			continue
		tree.name = "ArvoreLimiarFlorestal_%02d" % tree_index
		tree.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
		var scale_value: float = float(spec["scale"])
		tree.scale = Vector3(scale_value, scale_value * (0.92 + float(tree_index % 2) * 0.12), scale_value)
		tree.rotation.y = side * (0.42 + float(tree_index) * 0.28)
		threshold.add_child(tree)
	for rock_index: int in range(5):
		var z_value: float = forest_entry_z - 26.0 + float(rock_index) * 3.6
		var side: float = -1.0 if rock_index % 2 == 0 else 1.0
		var x_value: float = _path_x(z_value) + side * (5.1 + float(rock_index % 3) * 0.75)
		var ground_y: float = _height_at(x_value, z_value)
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaLimiarFloresta_%02d" % rock_index
			var rock_scale: float = 0.16 + float(rock_index % 3) * 0.045
			rock.scale = Vector3(rock_scale, rock_scale * 0.66, rock_scale)
			rock.position = Vector3(x_value, ground_y + 0.04, z_value)
			rock.rotation = Vector3(0.05 * float(rock_index % 2), float(rock_index) * 0.76, 0.08 * side)
			threshold.add_child(rock)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoLimiarFloresta_%02d" % rock_index
			fern.position = Vector3(x_value + side * 0.78, ground_y + 0.025, z_value + 0.42)
			var fern_scale: float = 0.42 + float(rock_index % 2) * 0.07
			fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			fern.rotation.y = float(rock_index) * 0.64
			threshold.add_child(fern)

func _build_arch_to_forest_transition() -> void:
	# Três clareiras sucessivas deixam o Arco ceder lugar à Floresta Densa por profundidade, não por uma parede de árvores.
	var transition: Node3D = Node3D.new()
	transition.name = "TransicaoOrganicaArcoFloresta"
	add_child(transition)
	var groups: Array[Dictionary] = [
		{"z": 101.0, "side": -1.0, "offset": 8.6, "scale": 0.54, "yaw": 0.18},
		{"z": 106.0, "side": 1.0, "offset": 10.8, "scale": 0.46, "yaw": -0.36},
		{"z": 111.0, "side": -1.0, "offset": 12.4, "scale": 0.60, "yaw": 0.54},
		{"z": 115.0, "side": 1.0, "offset": 9.7, "scale": 0.50, "yaw": -0.22}
	]
	for index: int in range(groups.size()):
		var group: Dictionary = groups[index]
		var z_value: float = group["z"] as float
		var side: float = group["side"] as float
		var x_value: float = _path_x(z_value) + side * (group["offset"] as float)
		var tree_source: PackedScene = DARK_TREE if index % 2 == 0 else OAK_DARK
		var tree: Node3D = tree_source.instantiate() as Node3D
		if tree != null:
			tree.name = "ArvoreTransicaoArco_%02d" % (index + 1)
			tree.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
			var tree_scale: float = group["scale"] as float
			tree.scale = Vector3(tree_scale, tree_scale * (0.92 + float(index % 2) * 0.14), tree_scale)
			tree.rotation.y = group["yaw"] as float
			transition.add_child(tree)
		# Uma rocha baixa próxima ao caminho aterra a mudança de bioma; fica além de 3,6 m do centro do trilho.
		var rock_x: float = _path_x(z_value) + side * 4.3
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaTransicaoArco_%02d" % (index + 1)
			rock.position = Vector3(rock_x, _height_at(rock_x, z_value) - 0.03, z_value + 0.5)
			rock.scale = Vector3(0.24 + float(index % 2) * 0.04, 0.16, 0.24 + float(index % 2) * 0.04)
			rock.rotation.y = (group["yaw"] as float) + 0.42
			transition.add_child(rock)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoTransicaoArco_%02d" % (index + 1)
			fern.position = Vector3(rock_x + side * 0.55, _height_at(rock_x + side * 0.55, z_value + 0.75) + 0.02, z_value + 0.75)
			fern.scale = Vector3(0.36, 0.36, 0.36)
			fern.rotation.y = float(index) * 0.83
			transition.add_child(fern)

func _build_arch_forest_understory() -> void:
	# Estrato de entrada do bosque: fetos e rochas baixos acompanham a passagem sem bloquear o eixo ou criar uma parede de árvores.
	var understory: Node3D = Node3D.new()
	understory.name = "SubBosqueDoLimiarArcoFloresta"
	add_child(understory)
	var specs: Array[Dictionary] = [
		{"z": 104.0, "side": -1.0, "offset": 3.40, "fern": 0.52, "rock": 0.18},
		{"z": 107.5, "side": 1.0, "offset": 3.85, "fern": 0.60, "rock": 0.22},
		{"z": 111.0, "side": -1.0, "offset": 4.15, "fern": 0.55, "rock": 0.24},
		{"z": 114.5, "side": 1.0, "offset": 3.55, "fern": 0.62, "rock": 0.19},
		{"z": 118.0, "side": -1.0, "offset": 4.35, "fern": 0.56, "rock": 0.25},
		{"z": 121.5, "side": 1.0, "offset": 3.70, "fern": 0.50, "rock": 0.20}
	]
	for index: int in range(specs.size()):
		var spec: Dictionary = specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var x_value: float = _path_x(z_value) + side * (spec["offset"] as float)
		var ground_y: float = _height_at(x_value, z_value)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoSubBosqueLimiar_%02d" % (index + 1)
			fern.position = Vector3(x_value, ground_y + 0.02, z_value)
			var fern_scale: float = spec["fern"] as float
			fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			fern.rotation.y = 0.42 + float(index) * 0.73
			understory.add_child(fern)
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaSubBosqueLimiar_%02d" % (index + 1)
			rock.position = Vector3(x_value + side * 0.72, _height_at(x_value + side * 0.72, z_value + 0.48) + 0.025, z_value + 0.48)
			var rock_scale: float = spec["rock"] as float
			rock.scale = Vector3(rock_scale, rock_scale * 0.76, rock_scale)
			rock.rotation.y = -0.28 + float(index) * 0.61
			understory.add_child(rock)

func _build_forest_wayfinding() -> void:
	# Balizas baixas, quentes e espaçadas: guiam Elias no sub-bosque sem transformar a floresta num corredor iluminado.
	var markers: Node3D = Node3D.new()
	markers.name = "BalizasDoTrilhoFlorestal"
	add_child(markers)
	var stone: StandardMaterial3D = StandardMaterial3D.new()
	stone.albedo_color = Color(0.095, 0.105, 0.085, 1.0)
	stone.roughness = 0.96
	var ember: StandardMaterial3D = StandardMaterial3D.new()
	ember.albedo_color = Color(0.30, 0.075, 0.018, 1.0)
	ember.emission_enabled = true
	ember.emission = Color(0.42, 0.070, 0.012, 1.0)
	ember.emission_energy_multiplier = 0.34
	for index: int in range(4):
		var z_value: float = 124.0 + float(index) * 8.4
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _path_x(z_value) + side * 2.75
		var ground_y: float = _height_at(x_value, z_value)
		var base_mesh: CylinderMesh = CylinderMesh.new()
		base_mesh.top_radius = 0.18
		base_mesh.bottom_radius = 0.27
		base_mesh.height = 0.88
		base_mesh.radial_segments = 7
		base_mesh.material = stone
		var base: MeshInstance3D = MeshInstance3D.new()
		base.name = "BalizaFlorestal_%02d" % index
		base.mesh = base_mesh
		base.position = Vector3(x_value, ground_y + 0.44, z_value)
		base.rotation.y = 0.33 + float(index) * 0.52
		markers.add_child(base)
		var ember_mesh: SphereMesh = SphereMesh.new()
		ember_mesh.radius = 0.070
		ember_mesh.height = 0.14
		ember_mesh.radial_segments = 12
		ember_mesh.material = ember
		var glow: MeshInstance3D = MeshInstance3D.new()
		glow.name = "BrasaDaBaliza_%02d" % index
		glow.mesh = ember_mesh
		glow.position = Vector3(x_value, ground_y + 0.94, z_value)
		markers.add_child(glow)
		var light: OmniLight3D = OmniLight3D.new()
		light.light_color = Color(0.82, 0.20, 0.045, 1.0)
		light.light_energy = 0.08
		light.omni_range = 2.6
		light.shadow_enabled = false
		light.position = glow.position
		markers.add_child(light)

func _lake_shore_x(world_z: float) -> float:
	var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
	var shore_start_z: float = lake_anchor.y - 107.0
	var shore_end_z: float = lake_anchor.y - 28.0
	var t: float = clampf((world_z - shore_start_z) / (shore_end_z - shore_start_z), 0.0, 1.0)
	# Meandra controlada: o percurso afasta-se da leitura de lajes em linha reta, mas mantém a chegada à margem oeste livre e previsível.
	return lerpf(_path_x(shore_start_z), lake_anchor.x - 46.0, t) + sin(t * PI) * 3.25 + sin(t * TAU) * 0.85

func _build_cartographic_river_inlet() -> void:
	# Afluente raso sem colisão: liga a leitura do Rio da Estrada à Bacia Central indicada pela cartografia.
	# É deliberadamente leve para não aumentar o orçamento de luzes ou de física da GTX 1050 Ti.
	var inlet: Node3D = Node3D.new()
	inlet.name = "AfluenteCartograficoRioParaBacia"
	add_child(inlet)
	var points: Array[Vector2] = [
		Vector2(12.6, 163.0), Vector2(13.4, 178.0), Vector2(17.8, 193.0),
		Vector2(25.6, 208.0), Vector2(36.0, 224.0)
	]
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(points.size() - 1):
		var point_a: Vector2 = points[index]
		var point_b: Vector2 = points[index + 1]
		var direction: Vector2 = (point_b - point_a).normalized()
		var right: Vector2 = Vector2(-direction.y, direction.x)
		var width_a: float = 2.5 + float(index) * 0.45
		var width_b: float = 2.5 + float(index + 1) * 0.45
		var y_a: float = _height_at(point_a.x, point_a.y) + 0.25
		var y_b: float = _height_at(point_b.x, point_b.y) + 0.25
		var left_a: Vector3 = Vector3(point_a.x - right.x * width_a, y_a, point_a.y - right.y * width_a)
		var right_a: Vector3 = Vector3(point_a.x + right.x * width_a, y_a, point_a.y + right.y * width_a)
		var left_b: Vector3 = Vector3(point_b.x - right.x * width_b, y_b, point_b.y - right.y * width_b)
		var right_b: Vector3 = Vector3(point_b.x + right.x * width_b, y_b, point_b.y + right.y * width_b)
		surface.set_uv(Vector2(0.0, float(index) * 0.25))
		surface.add_vertex(left_a)
		surface.set_uv(Vector2(1.0, float(index) * 0.25))
		surface.add_vertex(right_a)
		surface.set_uv(Vector2(0.0, float(index + 1) * 0.25))
		surface.add_vertex(left_b)
		surface.set_uv(Vector2(1.0, float(index) * 0.25))
		surface.add_vertex(right_a)
		surface.set_uv(Vector2(1.0, float(index + 1) * 0.25))
		surface.add_vertex(right_b)
		surface.set_uv(Vector2(0.0, float(index + 1) * 0.25))
		surface.add_vertex(left_b)
	surface.generate_normals()
	var water_mesh: ArrayMesh = surface.commit()
	water_mesh.surface_set_material(0, _create_lake_material())
	var water: MeshInstance3D = MeshInstance3D.new()
	water.name = "LaminaDoAfluenteCartografico"
	water.mesh = water_mesh
	water.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	inlet.add_child(water)
	# Margens em progressão: rochas e fetos quebram a leitura linear do afluente e confirmam que o rio da Estrada alimenta a Bacia.
	for point_index: int in range(points.size()):
		var bank_point: Vector2 = points[point_index]
		var next_point: Vector2 = points[min(point_index + 1, points.size() - 1)]
		var previous_point: Vector2 = points[max(point_index - 1, 0)]
		var bank_direction: Vector2 = (next_point - previous_point).normalized()
		var bank_right: Vector2 = Vector2(-bank_direction.y, bank_direction.x)
		var half_width: float = 3.55 + float(point_index) * 0.42
		for side_index: int in range(2):
			var side: float = -1.0 if side_index == 0 else 1.0
			var bank_x: float = bank_point.x + bank_right.x * (half_width + side * 0.72)
			var bank_z: float = bank_point.y + bank_right.y * (half_width + side * 0.72)
			var ground_y: float = _height_at(bank_x, bank_z)
			var inlet_rock: Node3D = ROCK.instantiate() as Node3D
			if inlet_rock != null:
				inlet_rock.name = "RochaDaMargemDoAfluente_%02d_%02d" % [point_index, side_index]
				inlet_rock.position = Vector3(bank_x, ground_y + 0.055, bank_z)
				var inlet_scale: float = 0.17 + float((point_index + side_index) % 3) * 0.052
				inlet_rock.scale = Vector3(inlet_scale, inlet_scale * 0.78, inlet_scale)
				inlet_rock.rotation.y = atan2(bank_direction.y, bank_direction.x) + side * 0.58
				_apply_material(inlet_rock, shore_material)
				inlet.add_child(inlet_rock)
			if (point_index + side_index) % 2 == 0:
				var inlet_fern: Node3D = FERN.instantiate() as Node3D
				if inlet_fern != null:
					inlet_fern.name = "FetoDaMargemDoAfluente_%02d_%02d" % [point_index, side_index]
					inlet_fern.position = Vector3(bank_x - bank_right.x * side * 0.64, _height_at(bank_x - bank_right.x * side * 0.64, bank_z - bank_right.y * side * 0.64) + 0.02, bank_z - bank_right.y * side * 0.64)
					inlet_fern.scale = Vector3.ONE * (0.34 + float(point_index % 2) * 0.06)
					inlet_fern.rotation.y = 0.34 + float(point_index) * 0.47
					inlet.add_child(inlet_fern)

func _build_lake_shore_path() -> void:
	var shore_road: Node3D = Node3D.new()
	shore_road.name = "TrilhoAteAMargemDoLago"
	add_child(shore_road)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 40652
	for index: int in range(30):
		var t: float = float(index) / 29.0
		var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
		var z_value: float = lerpf(lake_anchor.y - 107.0, lake_anchor.y - 28.0, t)
		var x_value: float = _lake_shore_x(z_value)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeMargem_%02d" % index
		slab.mesh = _make_slab(1.72 + rng.randf_range(-0.18, 0.20), 1.30 + rng.randf_range(-0.14, 0.16), rng)
		slab.material_override = shore_material
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.055, z_value)
		slab.rotation.y = atan2((_lake_shore_x(z_value + 1.0) - _lake_shore_x(z_value - 1.0)) * 0.5, 2.7) + rng.randf_range(-0.10, 0.10)
		shore_road.add_child(slab)
		# Apoio físico sobreposto: mantém uma passada contínua mesmo quando as lajes visuais são irregulares.
		var slab_body: StaticBody3D = StaticBody3D.new()
		slab_body.name = "ColisorLajeMargem_%02d" % index
		slab_body.position = slab.position + Vector3(0.0, -0.045, 0.0)
		slab_body.rotation.y = slab.rotation.y
		var slab_collision: CollisionShape3D = CollisionShape3D.new()
		var slab_shape: BoxShape3D = BoxShape3D.new()
		slab_shape.size = Vector3(1.72, 0.18, 3.05)
		slab_collision.shape = slab_shape
		slab_body.add_child(slab_collision)
		shore_road.add_child(slab_body)

func _build_shore_access_steps() -> void:
	# As lajes terminam num patamar físico na margem oeste; cada passo tem colisor próprio para a chegada ao lago não depender apenas da malha do terreno.
	var access: Node3D = Node3D.new()
	access.name = "PassagemFisicaParaAMargem"
	add_child(access)
	for index: int in range(7):
		var t: float = float(index) / 6.0
		var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
		var z_value: float = lerpf(lake_anchor.y - 30.0, lake_anchor.y - 12.0, t)
		var x_value: float = lerpf(_lake_shore_x(lake_anchor.y - 30.0), lake_anchor.x - 37.0, t) + sin(t * PI) * 0.45
		var ground_y: float = _height_at(x_value, z_value)
		var step_position: Vector3 = Vector3(x_value, ground_y + 0.10, z_value)
		var step_rotation_y: float = atan2(CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.x - 37.0 - _lake_shore_x(CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.y - 30.0), 18.0)
		# A leitura visual passa a usar afloramentos reais; o colisor continua uma plataforma baixa e regular para a travessia.
		var step: Node3D = ROCK.instantiate() as Node3D
		if step != null:
			step.name = "AfloramentoDeChegada_%02d" % index
			step.scale = Vector3(0.21 + float(index % 2) * 0.018, 0.080 + float(index % 3) * 0.010, 0.18)
			step.position = step_position
			step.rotation = Vector3(0.03 * float((index % 3) - 1), step_rotation_y + 0.10 * float((index % 2) - 1), 0.025 * float((index % 2) - 1))
			_apply_material(step, shore_material)
			access.add_child(step)
		var body: StaticBody3D = StaticBody3D.new()
		body.name = "ColisorLajeDeChegada_%02d" % index
		body.position = step_position
		body.rotation.y = step_rotation_y
		var collision: CollisionShape3D = CollisionShape3D.new()
		var shape: BoxShape3D = BoxShape3D.new()
		shape.size = Vector3(2.05, 0.22, 1.58)
		collision.shape = shape
		body.add_child(collision)
		access.add_child(body)
		if index % 2 == 1:
			var guide_light: OmniLight3D = OmniLight3D.new()
			guide_light.name = "GuiaDaMargem_%02d" % index
			guide_light.light_color = Color(0.78, 0.31, 0.10, 1.0)
			guide_light.light_energy = 0.16
			guide_light.omni_range = 3.0
			guide_light.shadow_enabled = false
			guide_light.position = Vector3(x_value - 0.74, ground_y + 0.54, z_value)
			access.add_child(guide_light)

func _build_basin_approach_silhouettes() -> void:
	# Vestígios distantes surgem em dois planos antes do limiar: conduzem o olhar ao domo e à cascata sem fechar o trilho da margem.
	var approach: Node3D = Node3D.new()
	approach.name = "SilhuetasDeAproximacaoDaBacia"
	add_child(approach)
	var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
	var specs: Array[Dictionary] = [
		{"z": lake_anchor.y - 52.0, "side": -1.0, "offset": 10.8, "scale": 0.54, "yaw": 0.22},
		{"z": lake_anchor.y - 38.0, "side": 1.0, "offset": 11.8, "scale": 0.62, "yaw": -0.34},
		{"z": lake_anchor.y - 31.0, "side": -1.0, "offset": 8.7, "scale": 0.47, "yaw": 0.48}
	]
	for index: int in range(specs.size()):
		var spec: Dictionary = specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var x_value: float = _lake_shore_x(z_value) + side * (spec["offset"] as float)
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar != null:
			pillar.name = "VestigioDeAproximacaoBacia_%02d" % (index + 1)
			pillar.position = Vector3(x_value, _height_at(x_value, z_value) + 0.18, z_value)
			var scale_value: float = spec["scale"] as float
			pillar.scale = Vector3(scale_value, scale_value * 1.46, scale_value)
			pillar.rotation = Vector3(0.08 * side, spec["yaw"] as float, -0.05 * side)
			_apply_material(pillar, ruin_material)
			approach.add_child(pillar)
		var footing: Node3D = ROCK.instantiate() as Node3D
		if footing != null:
			footing.name = "BaseDeAproximacaoBacia_%02d" % (index + 1)
			footing.position = Vector3(x_value - side * 0.32, _height_at(x_value - side * 0.32, z_value + 0.42) + 0.03, z_value + 0.42)
			footing.scale = Vector3(0.26, 0.17, 0.26)
			footing.rotation.y = (spec["yaw"] as float) + 0.36
			_apply_material(footing, ruin_material)
			approach.add_child(footing)

func _build_basin_arrival_frame() -> void:
	# CP 259 — Dois vestígios emergentes enquadram a primeira vista do lago sem criar um portão nem estreitar as lajes de chegada.
	var frame: Node3D = Node3D.new()
	frame.name = "LimiarDasRuinasSubmersas"
	add_child(frame)
	var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
	var arrival_z: float = lake_anchor.y - 26.0
	var arrival_x: float = _lake_shore_x(arrival_z)
	for frame_index: int in range(2):
		var side: float = -1.0 if frame_index == 0 else 1.0
		var pillar_x: float = arrival_x + side * 4.35
		var ground_y: float = _height_at(pillar_x, arrival_z)
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "VestigioDaEntradaDaBacia_%02d" % frame_index
		pillar.position = Vector3(pillar_x, ground_y + 0.34, arrival_z + side * 0.72)
		# Silhueta aumentada para que os dois vestígios possam ser lidos antes da margem, mas continuam exteriores à faixa de lajes.
		var scale_value: float = 1.05 if frame_index == 0 else 0.88
		pillar.scale = Vector3(scale_value, scale_value * 1.60, scale_value)
		pillar.rotation = Vector3(0.09 * side, side * (0.30 + float(frame_index) * 0.22), -0.05 * side)
		_apply_material(pillar, ruin_material)
		frame.add_child(pillar)
		for base_index: int in range(2):
			var rock: Node3D = ROCK.instantiate() as Node3D
			if rock == null:
				continue
			rock.name = "BaseDoVestigioDaBacia_%02d_%02d" % [frame_index, base_index]
			rock.position = Vector3(pillar_x - side * (0.42 + float(base_index) * 0.34), ground_y + 0.035, arrival_z + side * (0.38 - float(base_index) * 0.52))
			var rock_scale: float = 0.22 + float(base_index) * 0.064
			rock.scale = Vector3(rock_scale, rock_scale * 0.72, rock_scale)
			rock.rotation.y = 0.44 + float(frame_index) * 0.72 + float(base_index) * 0.38
			_apply_material(rock, ruin_material)
			frame.add_child(rock)
	var fern: Node3D = FERN.instantiate() as Node3D
	if fern != null:
		fern.name = "FetoDaEntradaDaBacia"
		fern.position = Vector3(arrival_x - 5.10, _height_at(arrival_x - 5.10, arrival_z + 1.6) + 0.02, arrival_z + 1.6)
		fern.scale = Vector3.ONE * 0.50
		fern.rotation.y = 0.46
		frame.add_child(fern)

func _build_majestic_lake_transition() -> void:
	# Vestígios de observação da Majestic acompanham a chegada ao lago: tornam a transição narrativa física sem bloquear o trilho.
	var transition: Node3D = Node3D.new()
	transition.name = "TransicaoMajesticParaRuinasSubmersas"
	add_child(transition)
	# Preenchimento atmosférico local: separa o trilho e a margem no crepúsculo sem atingir a montanha ou a futura região elevada.
	var corridor_fill: OmniLight3D = OmniLight3D.new()
	corridor_fill.name = "PreenchimentoDoCorredorMajestic"
	corridor_fill.light_color = Color(0.20, 0.30, 0.36, 1.0)
	corridor_fill.light_energy = 1.05
	corridor_fill.omni_range = 48.0
	corridor_fill.omni_attenuation = 1.45
	corridor_fill.shadow_enabled = false
	corridor_fill.position = Vector3(7.0, 10.0, 204.0)
	transition.add_child(corridor_fill)
	var crate_material: StandardMaterial3D = StandardMaterial3D.new()
	crate_material.albedo_color = Color(0.115, 0.072, 0.035, 1.0)
	crate_material.roughness = 0.88
	var lamp_material: StandardMaterial3D = StandardMaterial3D.new()
	# Brasa âmbar de baixa intensidade: continua legível a curta distância, sem se destacar como marcador vermelho de protótipo.
	lamp_material.albedo_color = Color(0.26, 0.105, 0.030, 1.0)
	lamp_material.emission_enabled = true
	lamp_material.emission = Color(0.48, 0.105, 0.018, 1.0)
	lamp_material.emission_energy_multiplier = 0.38
	for index: int in range(4):
		var t: float = float(index) / 3.0
		var z_value: float = lerpf(186.0, 220.0, t)
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _lake_shore_x(z_value) + side * 4.25
		var ground_y: float = _height_at(x_value, z_value)
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "AfloramentoDeTransicao_%02d" % index
			rock.position = Vector3(x_value + side * 1.18, ground_y + 0.07, z_value + 1.15)
			var rock_scale: float = 0.18 + float(index % 2) * 0.065
			rock.scale = Vector3(rock_scale, rock_scale, rock_scale)
			rock.rotation.y = 0.42 + float(index) * 0.73
			transition.add_child(rock)
		# CP-CARTO-29 restaurado: rolos de campo apoiados na rocha substituem caixotes cúbicos de protótipo.
		# A silhueta horizontal integra-se na margem, não recebe colisão e mantém o eixo das lajes inteiramente livre.
		var roll_mesh: CylinderMesh = CylinderMesh.new()
		roll_mesh.top_radius = 0.31
		roll_mesh.bottom_radius = 0.38
		roll_mesh.height = 1.34
		roll_mesh.radial_segments = 10
		var roll: MeshInstance3D = MeshInstance3D.new()
		roll.name = "RoloDeCampoMajestic_%02d" % index
		roll.mesh = roll_mesh
		roll.material_override = crate_material
		roll.position = Vector3(x_value, ground_y + 0.37, z_value)
		roll.rotation = Vector3(PI * 0.5, 0.25 + float(index) * 0.58, 0.06 * float((index % 2) * 2 - 1))
		transition.add_child(roll)
		# Lanternas baixas em vez de esferas vermelhas isoladas: a luz preserva a orientação e ganha uma base física reconhecível.
		var lamp_mesh: CylinderMesh = CylinderMesh.new()
		lamp_mesh.top_radius = 0.095
		lamp_mesh.bottom_radius = 0.145
		lamp_mesh.height = 0.34
		lamp_mesh.radial_segments = 10
		var lamp: MeshInstance3D = MeshInstance3D.new()
		lamp.name = "LanternaDeCampoMajestic_%02d" % index
		lamp.mesh = lamp_mesh
		lamp.material_override = lamp_material
		lamp.position = Vector3(x_value, ground_y + 0.82, z_value)
		transition.add_child(lamp)
		var fill: OmniLight3D = OmniLight3D.new()
		fill.name = "LuzDeCampoMajestic_%02d" % index
		fill.light_color = Color(0.82, 0.24, 0.075, 1.0)
		fill.light_energy = 0.12
		fill.omni_range = 2.6
		fill.shadow_enabled = false
		fill.position = lamp.position
		transition.add_child(fill)

func _build_cartographic_lake_vistas() -> void:
	# CP 220 — A vegetação abre para o centro hídrico do mapa sem perder a leitura do Acampamento no flanco oeste.
	# Estes vestígios de observação são visuais e não têm colisão ou luzes, preservando a rota e o orçamento GTX 1050 Ti.
	var vistas: Node3D = Node3D.new()
	vistas.name = "MiradourosCartograficosDoLago"
	add_child(vistas)
	var vista_specs: Array[Dictionary] = [
		{"z": 184.0, "side": -1.0, "offset": 6.8, "scale": 0.34},
		{"z": 202.0, "side": 1.0, "offset": 7.4, "scale": 0.40},
		{"z": 216.0, "side": -1.0, "offset": 6.6, "scale": 0.30},
	]
	for vista_index: int in range(vista_specs.size()):
		var spec: Dictionary = vista_specs[vista_index]
		var z_value: float = float(spec["z"])
		var side: float = float(spec["side"])
		var x_value: float = _lake_shore_x(z_value) + side * float(spec["offset"])
		var ground_y: float = _height_at(x_value, z_value)
		var vista: Node3D = Node3D.new()
		vista.name = "VistaDoLago_%02d" % vista_index
		vista.position = Vector3(x_value, ground_y, z_value)
		vistas.add_child(vista)
		var marker: Node3D = PILLAR.instantiate() as Node3D
		if marker != null:
			marker.name = "VestigioDeObservacao_%02d" % vista_index
			var scale_value: float = float(spec["scale"])
			marker.scale = Vector3(scale_value, scale_value * 1.42, scale_value)
			marker.position = Vector3(side * 0.72, 0.88, 0.0)
			marker.rotation = Vector3(0.06 * side, side * (0.32 + float(vista_index) * 0.16), 0.05 * side)
			_apply_material(marker, ruin_material)
			vista.add_child(marker)
		for rock_index: int in range(2):
			var rock: Node3D = ROCK.instantiate() as Node3D
			if rock == null:
				continue
			rock.name = "PedraDaVista_%02d" % rock_index
			var rock_scale: float = 0.14 + float(rock_index) * 0.055
			rock.scale = Vector3(rock_scale, rock_scale * 0.70, rock_scale)
			rock.position = Vector3(-side * (0.45 + float(rock_index) * 0.78), 0.05 + float(rock_index) * 0.06, 0.42 - float(rock_index) * 0.68)
			rock.rotation = Vector3(0.08 * float(rock_index), float(vista_index + rock_index) * 0.73, 0.07 * side)
			vista.add_child(rock)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoDaVista_%02d" % vista_index
			fern.position = Vector3(side * 1.32, 0.02, -0.76)
			var fern_scale: float = 0.44 + float(vista_index % 2) * 0.08
			fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			fern.rotation.y = side * (0.64 + float(vista_index) * 0.38)
			vista.add_child(fern)

func _build_lake_wayfinding() -> void:
	# Quatro marcos de pedra com brilho Chronos baixo: orientam a curva da margem sem transformar o trilho em sinalização moderna.
	var markers: Node3D = Node3D.new()
	markers.name = "MarcosDaMargemDoLago"
	add_child(markers)
	var stone: StandardMaterial3D = StandardMaterial3D.new()
	stone.albedo_color = Color(0.14, 0.17, 0.16, 1.0)
	stone.roughness = 0.91
	var chronos: StandardMaterial3D = StandardMaterial3D.new()
	chronos.albedo_color = Color(0.040, 0.12, 0.16, 1.0)
	chronos.emission_enabled = true
	chronos.emission = Color(0.006, 0.045, 0.060, 1.0)
	chronos.emission_energy_multiplier = 0.12
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
		# Uma pequena tampa rúnica integra a luz no marco de pedra; elimina a leitura de orbe flutuante de QA.
		var beacon_mesh: CylinderMesh = CylinderMesh.new()
		beacon_mesh.top_radius = 0.065
		beacon_mesh.bottom_radius = 0.090
		beacon_mesh.height = 0.10
		beacon_mesh.radial_segments = 8
		beacon_mesh.material = chronos
		var beacon: MeshInstance3D = MeshInstance3D.new()
		beacon.name = "TampaRunicaDaMargem_%02d" % index
		beacon.mesh = beacon_mesh
		beacon.position = Vector3(x_value, ground_y + 2.37, z_value)
		markers.add_child(beacon)
		var light: OmniLight3D = OmniLight3D.new()
		light.light_color = Color(0.08, 0.18, 0.22, 1.0)
		light.light_energy = 0.06
		light.omni_range = 2.2
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
		var lake_dx: float = (x_value - CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.x) / 48.0
		var lake_dz: float = (z_value - CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.y) / 38.0
		var shore_clearance: bool = z_value >= 194.0 and z_value <= 232.0 and abs(x_value - _lake_shore_x(z_value)) < 6.2
		# A ligação Majestic é horizontal em torno de z=178; sem esta pequena clareira, árvores da dispersão regional entram na câmara e escondem as lajes.
		var majestic_connector_clearance: bool = z_value >= 173.0 and z_value <= 183.0 and x_value >= -82.0 and x_value <= 1.0
		# As clareiras revelam o destino e a margem sem rarefazer a floresta inteira.
		# Clareira focal do Arco: abre os últimos 20 m antes do marco 3, preservando bosque lateral e a massa florestal posterior.
		var arch_sightline_clearance: bool = z_value >= 72.0 and z_value <= 92.0
		if abs(x_value - _path_x(z_value)) < 6.0 or shore_clearance or majestic_connector_clearance or lake_dx * lake_dx + lake_dz * lake_dz < 1.20 or arch_sightline_clearance:
			continue
		var tree_source: PackedScene
		var is_conifer: bool = false
		# A maioria dos pontos focais usa malhas orgânicas reais; as coníferas EZ ficam como profundidade económica.
		if index % 7 == 0:
			# Instâncias próximas usam o pinheiro PBR local; evita a silhueta de folhagem plana do Island Tree no percurso jogável.
			tree_source = PINE_TALL
			is_conifer = true
		elif index % 5 == 0:
			tree_source = OAK_DARK
		elif index % 3 == 0:
			tree_source = DARK_TREE
		elif index % 2 == 0:
			tree_source = PINE_TALL
			is_conifer = true
		else:
			tree_source = PINE_MEDIUM
			is_conifer = true
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
		# Variações independentes tornam cada conífera reconhecível sem deslocar a sua base nem fechar o trilho.
		# A altura fica entre 0.85 e 1.35; XZ varia ±15% apenas nos pinheiros económicos.
		var height_var: float = 0.85 + fmod(float(index * 13 + 7), 50.0) / 100.0
		var horizontal_var: float = 1.0
		if is_conifer:
			horizontal_var = 0.85 + fmod(float(index * 17 + 11), 31.0) / 100.0
		tree.scale = Vector3(tree_scale * horizontal_var, tree_scale * height_var, tree_scale * horizontal_var)
		tree.rotation.y = rng.randf_range(-PI, PI)
		forest.add_child(tree)
		# Um subconjunto de troncos ganha colisão: a floresta torna-se física sem saturar o orçamento nem bloquear o corredor central.
		if index % 3 == 0:
			var trunk_body: StaticBody3D = StaticBody3D.new()
			trunk_body.name = "ColisorTroncoFloresta_%02d" % index
			var trunk_height: float = maxf(2.3, 7.2 * tree_scale * height_var)
			trunk_body.position = tree.position + Vector3(0.0, trunk_height * 0.5, 0.0)
			var trunk_collision: CollisionShape3D = CollisionShape3D.new()
			var trunk_shape: CylinderShape3D = CylinderShape3D.new()
			trunk_shape.radius = maxf(0.22, 0.52 * tree_scale)
			trunk_shape.height = trunk_height
			trunk_collision.shape = trunk_shape
			trunk_body.add_child(trunk_collision)
			forest.add_child(trunk_body)
	for index: int in range(112):
		var z_value: float = 70.0 + float(index) * 1.55
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _path_x(z_value) + side * (5.15 + fmod(float(index), 5.0) * 0.82)
		if z_value >= 194.0 and z_value <= 232.0 and abs(x_value - _lake_shore_x(z_value)) < 4.8:
			continue
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern == null:
			continue
		fern.name = "FetoFloresta_%02d" % index
		fern.position = Vector3(x_value, _height_at(x_value, z_value) + 0.02, z_value)
		var fern_scale: float = 0.42 + fmod(float(index), 3.0) * 0.08
		fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
		fern.rotation.y = float(index) * 0.68
		forest.add_child(fern)

func _build_forest_canopy_clusters() -> void:
	# Sete árvores focais PBR quebram a repetição das coníferas económicas; cada grupo preserva uma abertura clara para a próxima laje.
	var clusters: Node3D = Node3D.new()
	clusters.name = "CopasFocaisDaFlorestaDensa"
	add_child(clusters)
	var cluster_data: Array[Dictionary] = [
		{"z": 138.0, "side": -1.0, "offset": 7.4, "scale": 0.60, "yaw": -0.28},
		{"z": 146.0, "side": 1.0, "offset": 8.2, "scale": 0.56, "yaw": 0.86},
		{"z": 155.0, "side": -1.0, "offset": 9.1, "scale": 0.52, "yaw": -1.24},
		{"z": 163.0, "side": 1.0, "offset": 7.8, "scale": 0.64, "yaw": 2.18},
		{"z": 173.0, "side": -1.0, "offset": 8.6, "scale": 0.56, "yaw": 0.34},
		{"z": 184.0, "side": 1.0, "offset": 9.4, "scale": 0.54, "yaw": -2.02},
		{"z": 196.0, "side": -1.0, "offset": 7.6, "scale": 0.58, "yaw": 1.42}
	]
	for index: int in range(cluster_data.size()):
		var data: Dictionary = cluster_data[index]
		var z_value: float = data["z"] as float
		var side: float = data["side"] as float
		var x_value: float = _path_x(z_value) + side * (data["offset"] as float)
		var tree_source: PackedScene = ISLAND_TREE if index % 3 != 1 else OAK_DARK
		var tree: Node3D = tree_source.instantiate() as Node3D
		if tree == null:
			continue
		tree.name = "CopaFocalFlorestal_%02d" % index
		tree.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
		var scale_value: float = data["scale"] as float
		tree.scale = Vector3(scale_value, scale_value, scale_value)
		tree.rotation.y = data["yaw"] as float
		clusters.add_child(tree)
		# Apenas três troncos do primeiro plano são físicos, para manter a exploração tática sem perfurar o orçamento de colisão.
		if index in [0, 3, 5]:
			var trunk: StaticBody3D = StaticBody3D.new()
			trunk.name = "ColisorCopaFocalFlorestal_%02d" % index
			trunk.position = tree.position + Vector3(0.0, 1.90, 0.0)
			var shape: CollisionShape3D = CollisionShape3D.new()
			var capsule: CylinderShape3D = CylinderShape3D.new()
			capsule.radius = 0.42
			capsule.height = 3.80
			shape.shape = capsule
			trunk.add_child(shape)
			clusters.add_child(trunk)

func _build_forest_micro_details() -> void:
	# Microdetalhe no limite do trilho: raízes e pedra estabelecem escala de exploração sem virar uma parede de vegetação.
	var details: Node3D = Node3D.new()
	details.name = "RaizesPedrasESinaisP0"
	add_child(details)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 40691
	var root_material: StandardMaterial3D = StandardMaterial3D.new()
	root_material.albedo_color = Color(0.115, 0.072, 0.032, 1.0)
	root_material.roughness = 0.96
	var moss_material: StandardMaterial3D = StandardMaterial3D.new()
	moss_material.albedo_color = Color(0.085, 0.135, 0.090, 1.0)
	moss_material.roughness = 0.94
	for index: int in range(16):
		var z_value: float = 126.0 + float(index) * 4.1
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _path_x(z_value) + side * (4.95 + float(index % 3) * 0.44)
		var ground_y: float = _height_at(x_value, z_value)
		var root_mesh: BoxMesh = BoxMesh.new()
		root_mesh.size = Vector3(0.30 + float(index % 3) * 0.06, 0.16, 1.55 + float(index % 4) * 0.24)
		root_mesh.material = root_material
		var root: MeshInstance3D = MeshInstance3D.new()
		root.name = "RaizExpostaFlorestal_%02d" % index
		root.mesh = root_mesh
		root.position = Vector3(x_value, ground_y + 0.075, z_value + rng.randf_range(-0.68, 0.68))
		root.rotation = Vector3(rng.randf_range(-0.06, 0.06), rng.randf_range(-0.92, 0.92), rng.randf_range(-0.12, 0.12))
		details.add_child(root)
		if index % 2 == 0:
			var wet_rock: Node3D = ROCK.instantiate() as Node3D
			if wet_rock != null:
				wet_rock.name = "PedraHumidaFlorestal_%02d" % index
				wet_rock.position = Vector3(x_value + side * 0.64, ground_y + 0.035, z_value + rng.randf_range(-0.84, 0.84))
				var rock_scale: float = 0.12 + float(index % 4) * 0.026
				wet_rock.scale = Vector3(rock_scale, rock_scale * 0.78, rock_scale)
				wet_rock.rotation.y = rng.randf_range(-PI, PI)
				_apply_material(wet_rock, moss_material)
				details.add_child(wet_rock)
	# Três sinais P-0 respondem à narrativa temporal, mas a emissão mínima não compete com a orientação quente do trilho.
	var p0_material: StandardMaterial3D = StandardMaterial3D.new()
	p0_material.albedo_color = Color(0.018, 0.11, 0.16, 1.0)
	p0_material.emission_enabled = true
	p0_material.emission = Color(0.012, 0.105, 0.155, 1.0)
	p0_material.emission_energy_multiplier = 0.38
	for marker_index: int in range(3):
		var marker_z: float = 142.0 + float(marker_index) * 16.0
		var marker_side: float = -1.0 if marker_index % 2 == 0 else 1.0
		var marker_x: float = _path_x(marker_z) + marker_side * 3.65
		var marker_y: float = _height_at(marker_x, marker_z)
		var p0_stone: Node3D = PILLAR.instantiate() as Node3D
		if p0_stone != null:
			p0_stone.name = "SinalP0Florestal_%02d" % marker_index
			p0_stone.position = Vector3(marker_x, marker_y + 0.62, marker_z)
			p0_stone.scale = Vector3(0.28, 0.36, 0.28)
			p0_stone.rotation = Vector3(0.03, 0.34 + float(marker_index) * 0.58, 0.02)
			_apply_material(p0_stone, p0_material)
			details.add_child(p0_stone)
			var p0_light: OmniLight3D = OmniLight3D.new()
			p0_light.name = "BrilhoP0Florestal_%02d" % marker_index
			p0_light.light_color = Color(0.08, 0.25, 0.34, 1.0)
			p0_light.light_energy = 0.07
			p0_light.omni_range = 2.4
			p0_light.shadow_enabled = false
			p0_light.position = p0_stone.position + Vector3(0.0, 0.80, 0.0)
			details.add_child(p0_light)

func _build_majestic_camp() -> void:
	var camp: Node3D = Node3D.new()
	camp.name = "AcampamentoMajestic"
	var camp_x: float = CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC.x
	var camp_z: float = CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC.y
	camp.position = Vector3(camp_x, _height_at(camp_x, camp_z), camp_z)
	add_child(camp)
	var canvas_material: StandardMaterial3D = StandardMaterial3D.new()
	canvas_material.albedo_color = Color(0.72, 0.57, 0.38, 1.0)
	var canvas_texture: Texture2D = load("res://assets/textures/generated/majestic_weathered_canvas_albedo.png") as Texture2D
	if canvas_texture != null:
		canvas_material.albedo_texture = canvas_texture
		canvas_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
		canvas_material.uv1_scale = Vector3(1.18, 1.05, 1.0)
	canvas_material.roughness = 0.86
	# Reflexo de baixa intensidade: mantém a trama e os remendos legíveis no modo GL Compatibility sem transformar a lona numa fonte de luz.
	canvas_material.emission_enabled = true
	canvas_material.emission = Color(0.19, 0.115, 0.055, 1.0)
	canvas_material.emission_energy_multiplier = 0.64
	var camp_wood: StandardMaterial3D = StandardMaterial3D.new()
	camp_wood.albedo_color = Color(0.16, 0.082, 0.030, 1.0)
	camp_wood.roughness = 0.91
	var seam_material: StandardMaterial3D = StandardMaterial3D.new()
	seam_material.albedo_color = Color(0.34, 0.17, 0.060, 1.0)
	seam_material.roughness = 0.94
	seam_material.emission_enabled = true
	seam_material.emission = Color(0.035, 0.012, 0.003, 1.0)
	seam_material.emission_energy_multiplier = 0.16
	var groundsheet_material: StandardMaterial3D = StandardMaterial3D.new()
	groundsheet_material.albedo_color = Color(0.105, 0.075, 0.042, 1.0)
	groundsheet_material.roughness = 0.95
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
		# Estrado e mastros expõem a estrutura da tenda, evitando a silhueta de primitiva isolada.
		var groundsheet: MeshInstance3D = MeshInstance3D.new()
		var groundsheet_mesh: BoxMesh = BoxMesh.new()
		groundsheet_mesh.size = Vector3(4.55, 0.07, 5.28)
		groundsheet.mesh = groundsheet_mesh
		groundsheet.material_override = groundsheet_material
		groundsheet.position = Vector3(tent.position.x, 0.035, tent.position.z)
		groundsheet.rotation.y = tent.rotation.y
		camp.add_child(groundsheet)
		var pole_mesh: CylinderMesh = CylinderMesh.new()
		pole_mesh.top_radius = 0.045
		pole_mesh.bottom_radius = 0.065
		pole_mesh.height = 2.65
		pole_mesh.radial_segments = 8
		pole_mesh.material = camp_wood
		for pole_side: float in [-1.0, 1.0]:
			var pole: MeshInstance3D = MeshInstance3D.new()
			pole.name = "MastroTenda_%02d_%s" % [index, "E" if pole_side > 0.0 else "W"]
			pole.mesh = pole_mesh
			var local_pole: Vector3 = Vector3(pole_side * 1.92, 1.325, -1.88)
			pole.position = tent.position + local_pole.rotated(Vector3.UP, tent.rotation.y)
			pole.rotation.y = tent.rotation.y
			camp.add_child(pole)
		# Costuras e cintas sem colisão: quebram a leitura de prisma e preservam a lona como material de expedição remendado.
		var seam_mesh: BoxMesh = BoxMesh.new()
		seam_mesh.size = Vector3(0.052, 1.78, 0.036)
		seam_mesh.material = seam_material
		for seam_side: float in [-1.0, 1.0]:
			var seam: MeshInstance3D = MeshInstance3D.new()
			seam.name = "CosturaDaTenda_%02d_%s" % [index, "E" if seam_side > 0.0 else "W"]
			seam.mesh = seam_mesh
			seam.position = tent.position + Vector3(seam_side * 1.38, 1.18, -1.48).rotated(Vector3.UP, tent.rotation.y)
			seam.rotation.y = tent.rotation.y
			camp.add_child(seam)
		camp.add_child(tent)
		# Volume físico aproximado da lona: impede atravessar a tenda, mas mantém o anel central e o trilho exterior navegáveis.
		var tent_body: StaticBody3D = StaticBody3D.new()
		tent_body.name = "ColisorTendaMajestic_%02d" % index
		tent_body.position = tent.position
		tent_body.rotation.y = tent.rotation.y
		var tent_collision: CollisionShape3D = CollisionShape3D.new()
		var tent_shape: BoxShape3D = BoxShape3D.new()
		tent_shape.size = Vector3(4.20, 2.10, 4.85)
		tent_collision.shape = tent_shape
		tent_body.add_child(tent_collision)
		camp.add_child(tent_body)
	# Chama principal: esfera emissiva com brilho laranja-âmbar intenso.
	var fire_mesh: SphereMesh = SphereMesh.new()
	fire_mesh.radius = 0.38
	fire_mesh.height = 0.76
	var fire_material: StandardMaterial3D = StandardMaterial3D.new()
	fire_material.albedo_color = Color(0.72, 0.22, 0.028, 1.0)
	fire_material.emission_enabled = true
	fire_material.emission = Color(1.0, 0.26, 0.018, 1.0)
	fire_material.emission_energy_multiplier = 2.4
	fire_mesh.material = fire_material
	var fire: MeshInstance3D = MeshInstance3D.new()
	fire.name = "FogoDoAcampamento"
	fire.mesh = fire_mesh
	fire.position = Vector3(0.0, 0.48, 0.0)
	camp.add_child(fire)
	camp_flame_meshes.append(fire)
	# Núcleo de brasa baixa: esfera menor no centro do anel de pedras para leitura de profundidade.
	var ember_core_mesh: SphereMesh = SphereMesh.new()
	ember_core_mesh.radius = 0.18
	ember_core_mesh.height = 0.36
	var ember_core_mat: StandardMaterial3D = StandardMaterial3D.new()
	ember_core_mat.albedo_color = Color(0.55, 0.10, 0.010, 1.0)
	ember_core_mat.emission_enabled = true
	ember_core_mat.emission = Color(0.80, 0.12, 0.008, 1.0)
	ember_core_mat.emission_energy_multiplier = 1.8
	ember_core_mesh.material = ember_core_mat
	var ember_core: MeshInstance3D = MeshInstance3D.new()
	ember_core.name = "BrasaCentralDoAcampamento"
	ember_core.mesh = ember_core_mesh
	ember_core.position = Vector3(0.0, 0.14, 0.0)
	camp.add_child(ember_core)
	camp_flame_meshes.append(ember_core)
	# Luz principal da fogueira: energia aumentada para 3.2 e alcance expandido para 18 m.
	var fire_light: OmniLight3D = OmniLight3D.new()
	fire_light.name = "LuzPrincipalDaFogueira"
	fire_light.light_color = Color(1.0, 0.34, 0.08, 1.0)
	fire_light.light_energy = 3.2
	fire_light.omni_range = 18.0
	fire_light.shadow_enabled = false
	fire_light.position = Vector3(0.0, 1.5, 0.0)
	fire_light.set_meta("base_energy", fire_light.light_energy)
	camp.add_child(fire_light)
	camp_light_sources.append(fire_light)
	# Luz de brasa ao nível do solo: tom vermelho-âmbar quente para iluminar o anel de pedras e o solo imediato.
	var ember_light: OmniLight3D = OmniLight3D.new()
	ember_light.name = "LuzDeBrasaDoSolo"
	ember_light.light_color = Color(1.0, 0.18, 0.04, 1.0)
	ember_light.light_energy = 1.6
	ember_light.omni_range = 6.0
	ember_light.shadow_enabled = false
	ember_light.position = Vector3(0.0, 0.22, 0.0)
	ember_light.set_meta("base_energy", ember_light.light_energy)
	camp.add_child(ember_light)
	camp_light_sources.append(ember_light)
	var camp_fill: OmniLight3D = OmniLight3D.new()
	camp_fill.name = "PreenchimentoDoAcampamentoMajestic"
	camp_fill.light_color = Color(0.34, 0.43, 0.49, 1.0)
	# Preenchimento de baixa altura: recupera o detalhe da lona e do solo no crepúsculo de compatibilidade.
	camp_fill.light_energy = 2.05
	camp_fill.omni_range = 31.0
	camp_fill.omni_attenuation = 1.12
	camp_fill.shadow_enabled = false
	camp_fill.position = Vector3(0.0, 5.2, 0.0)
	camp.add_child(camp_fill)
	# CP 213 — luar direccional baixo: separa lonas, mastros e solo da luz quente da fogueira.
	# Não lança sombra e tem alcance contido, preservando o orçamento da GTX 1050 Ti.
	var moonlight: SpotLight3D = SpotLight3D.new()
	moonlight.name = "LuarFrioDoAcampamento"
	moonlight.light_color = Color(0.46, 0.62, 0.94, 1.0)
	moonlight.light_energy = 0.30
	moonlight.spot_range = 16.0
	moonlight.spot_angle = 44.0
	moonlight.spot_attenuation = 1.35
	moonlight.shadow_enabled = false
	moonlight.position = Vector3(-1.8, 8.6, 1.4)
	moonlight.rotation_degrees = Vector3(-67.0, -24.0, 0.0)
	camp.add_child(moonlight)
	# Lajes rasas de acampamento: desenham uma área de uso no solo sem adicionar colisores ou degraus ao percurso de Elias.
	var camp_floor: Node3D = Node3D.new()
	camp_floor.name = "LajesRasasDoAcampamento"
	camp.add_child(camp_floor)
	var floor_rng: RandomNumberGenerator = RandomNumberGenerator.new()
	floor_rng.seed = 50518
	for floor_index: int in range(12):
		var floor_angle: float = float(floor_index) * TAU / 12.0 + floor_rng.randf_range(-0.12, 0.12)
		var floor_radius: float = 2.55 + floor_rng.randf_range(-0.28, 0.40)
		var floor_slab: MeshInstance3D = MeshInstance3D.new()
		floor_slab.name = "LajeRasaAcampamento_%02d" % floor_index
		floor_slab.mesh = _make_slab(1.34 + floor_rng.randf_range(-0.18, 0.14), 0.86 + floor_rng.randf_range(-0.12, 0.10), floor_rng)
		floor_slab.material_override = path_material
		floor_slab.position = Vector3(cos(floor_angle) * floor_radius, 0.032, sin(floor_angle) * floor_radius)
		floor_slab.rotation.y = floor_angle + PI * 0.5 + floor_rng.randf_range(-0.18, 0.18)
		camp_floor.add_child(floor_slab)
	# Anel de pedra e caixas de campo: a fogueira passa a ser uma estação arqueológica identificável e fisicamente navegável.
	for ring_index: int in range(8):
		var ring_angle: float = float(ring_index) * TAU / 8.0
		var fire_rock: Node3D = ROCK.instantiate() as Node3D
		if fire_rock == null:
			continue
		fire_rock.name = "PedraDaFogueira_%02d" % ring_index
		fire_rock.position = Vector3(cos(ring_angle) * 1.25, 0.04, sin(ring_angle) * 1.25)
		fire_rock.scale = Vector3(0.16, 0.12, 0.16)
		fire_rock.rotation.y = ring_angle
		camp.add_child(fire_rock)
		var fire_rock_body: StaticBody3D = StaticBody3D.new()
		fire_rock_body.name = "ColisorPedraDaFogueira_%02d" % ring_index
		fire_rock_body.position = fire_rock.position + Vector3(0.0, 0.12, 0.0)
		var fire_rock_collision: CollisionShape3D = CollisionShape3D.new()
		var fire_rock_shape: SphereShape3D = SphereShape3D.new()
		fire_rock_shape.radius = 0.31
		fire_rock_collision.shape = fire_rock_shape
		fire_rock_body.add_child(fire_rock_collision)
		camp.add_child(fire_rock_body)
	var supply_material: StandardMaterial3D = StandardMaterial3D.new()
	supply_material.albedo_color = Color(0.20, 0.105, 0.045, 1.0)
	supply_material.roughness = 0.83
	for supply_index: int in range(3):
		var supply_mesh: BoxMesh = BoxMesh.new()
		supply_mesh.size = Vector3(1.15, 0.76, 0.82)
		var supply: MeshInstance3D = MeshInstance3D.new()
		supply.name = "CaixaDeCampo_%02d" % supply_index
		supply.mesh = supply_mesh
		supply.material_override = supply_material
		supply.position = Vector3(-2.0 + float(supply_index) * 1.25, 0.38, -2.35)
		supply.rotation.y = -0.18
		camp.add_child(supply)
		var supply_body: StaticBody3D = StaticBody3D.new()
		supply_body.name = "ColisorCaixaDeCampo_%02d" % supply_index
		supply_body.position = supply.position
		supply_body.rotation.y = supply.rotation.y
		var supply_collision: CollisionShape3D = CollisionShape3D.new()
		var supply_shape: BoxShape3D = BoxShape3D.new()
		supply_shape.size = Vector3(1.15, 0.76, 0.82)
		supply_collision.shape = supply_shape
		supply_body.add_child(supply_collision)
		camp.add_child(supply_body)
	# Mesa de cartografia e rolos de campanha: contam a logística Majestic sem introduzir cartazes planos ou barreiras no anel central.
	var chart_material: StandardMaterial3D = StandardMaterial3D.new()
	chart_material.albedo_color = Color(0.48, 0.34, 0.16, 1.0)
	chart_material.roughness = 0.88
	chart_material.emission_enabled = true
	chart_material.emission = Color(0.045, 0.025, 0.008, 1.0)
	chart_material.emission_energy_multiplier = 0.34
	var chart_table: MeshInstance3D = MeshInstance3D.new()
	chart_table.name = "MesaDeCartografiaMajestic"
	var chart_table_mesh: BoxMesh = BoxMesh.new()
	chart_table_mesh.size = Vector3(1.75, 0.13, 1.12)
	chart_table.mesh = chart_table_mesh
	chart_table.material_override = camp_wood
	chart_table.position = Vector3(2.72, 1.28, -2.78)
	chart_table.rotation.y = deg_to_rad(-16.0)
	camp.add_child(chart_table)
	for leg_x: float in [-0.68, 0.68]:
		for leg_z: float in [-0.38, 0.38]:
			var leg: MeshInstance3D = MeshInstance3D.new()
			var leg_mesh: CylinderMesh = CylinderMesh.new()
			leg_mesh.top_radius = 0.055
			leg_mesh.bottom_radius = 0.075
			leg_mesh.height = 1.22
			leg_mesh.radial_segments = 8
			leg_mesh.material = camp_wood
			leg.mesh = leg_mesh
			leg.position = chart_table.position + Vector3(leg_x, -0.61, leg_z).rotated(Vector3.UP, chart_table.rotation.y)
			camp.add_child(leg)
	var map_sheet: MeshInstance3D = MeshInstance3D.new()
	map_sheet.name = "MapaDaExpedicaoMajestic"
	var map_mesh: BoxMesh = BoxMesh.new()
	map_mesh.size = Vector3(1.38, 0.026, 0.84)
	map_sheet.mesh = map_mesh
	map_sheet.material_override = chart_material
	map_sheet.position = chart_table.position + Vector3(0.0, 0.083, 0.0)
	map_sheet.rotation.y = chart_table.rotation.y
	camp.add_child(map_sheet)
	for roll_index: int in range(3):
		var roll: MeshInstance3D = MeshInstance3D.new()
		roll.name = "RoloDeCampoMajestic_%02d" % roll_index
		var roll_mesh: CylinderMesh = CylinderMesh.new()
		roll_mesh.top_radius = 0.13
		roll_mesh.bottom_radius = 0.13
		roll_mesh.height = 0.86
		roll_mesh.radial_segments = 12
		roll_mesh.material = chart_material
		roll.mesh = roll_mesh
		roll.position = Vector3(-3.20 + float(roll_index) * 0.52, 0.18, 2.82)
		roll.rotation.z = PI * 0.5
		roll.rotation.y = 0.26 + float(roll_index) * 0.16
		camp.add_child(roll)
	var rack_pole_mesh: CylinderMesh = CylinderMesh.new()
	rack_pole_mesh.top_radius = 0.045
	rack_pole_mesh.bottom_radius = 0.065
	rack_pole_mesh.height = 2.35
	rack_pole_mesh.radial_segments = 8
	rack_pole_mesh.material = camp_wood
	for rack_x: float in [-2.15, -0.85]:
		var rack_pole: MeshInstance3D = MeshInstance3D.new()
		rack_pole.name = "SuporteExpedicaoMajestic"
		rack_pole.mesh = rack_pole_mesh
		rack_pole.position = Vector3(rack_x, 1.18, 3.18)
		camp.add_child(rack_pole)
	var rack_beam: MeshInstance3D = MeshInstance3D.new()
	var rack_beam_mesh: CylinderMesh = CylinderMesh.new()
	rack_beam_mesh.top_radius = 0.055
	rack_beam_mesh.bottom_radius = 0.055
	rack_beam_mesh.height = 1.48
	rack_beam_mesh.radial_segments = 8
	rack_beam_mesh.material = camp_wood
	rack_beam.mesh = rack_beam_mesh
	rack_beam.position = Vector3(-1.50, 2.18, 3.18)
	rack_beam.rotation.z = PI * 0.5
	camp.add_child(rack_beam)
	for torch_index: int in range(3):
		var torch_angle: float = deg_to_rad(35.0 + float(torch_index) * 120.0)
		var torch: MeshInstance3D = MeshInstance3D.new()
		var torch_mesh: CylinderMesh = CylinderMesh.new()
		torch_mesh.top_radius = 0.055
		torch_mesh.bottom_radius = 0.075
		torch_mesh.height = 2.10
		torch.mesh = torch_mesh
		torch.material_override = supply_material
		torch.position = Vector3(cos(torch_angle) * 9.0, 1.05, sin(torch_angle) * 9.0)
		camp.add_child(torch)
		var torch_light: OmniLight3D = OmniLight3D.new()
		torch_light.name = "TochaMajestic_%02d" % torch_index
		torch_light.light_color = Color(1.0, 0.30, 0.075, 1.0)
		torch_light.light_energy = 0.84
		torch_light.omni_range = 9.0
		torch_light.shadow_enabled = false
		torch_light.position = torch.position + Vector3(0.0, 1.05, 0.0)
		torch_light.set_meta("base_energy", torch_light.light_energy)
		camp.add_child(torch_light)
		camp_light_sources.append(torch_light)

	# Silhuetas de chegada: dois mastros e lonas inclinadas anunciam o acampamento no fim da ligação, sem criar qualquer luz adicional.
	var arrival_markers: Node3D = Node3D.new()
	arrival_markers.name = "SilhuetasDeChegadaMajestic"
	camp.add_child(arrival_markers)
	for marker_index: int in range(2):
		var marker_side: float = -1.0 if marker_index == 0 else 1.0
		var mast_mesh: CylinderMesh = CylinderMesh.new()
		mast_mesh.top_radius = 0.07
		mast_mesh.bottom_radius = 0.10
		mast_mesh.height = 6.4
		mast_mesh.radial_segments = 8
		mast_mesh.material = camp_wood
		var mast: MeshInstance3D = MeshInstance3D.new()
		mast.name = "MastroDeChegadaMajestic_%02d" % (marker_index + 1)
		mast.mesh = mast_mesh
		mast.position = Vector3(10.2, 3.2, marker_side * 5.6)
		mast.rotation.z = marker_side * 0.035
		arrival_markers.add_child(mast)
		var banner_mesh: PlaneMesh = PlaneMesh.new()
		banner_mesh.size = Vector2(1.75, 1.12)
		banner_mesh.material = canvas_material
		var banner: MeshInstance3D = MeshInstance3D.new()
		banner.name = "LonaDeChegadaMajestic_%02d" % (marker_index + 1)
		banner.mesh = banner_mesh
		banner.position = mast.position + Vector3(marker_side * 0.92, 1.18, 0.0)
		banner.rotation = Vector3(PI * 0.5, 0.18 * marker_side, 0.0)
		arrival_markers.add_child(banner)
		var mast_rock: Node3D = ROCK.instantiate() as Node3D
		if mast_rock != null:
			mast_rock.name = "BaseMastroMajestic_%02d" % (marker_index + 1)
			mast_rock.position = Vector3(10.2, 0.05, marker_side * 5.6)
			mast_rock.scale = Vector3(0.24, 0.16, 0.24)
			mast_rock.rotation.y = marker_side * 0.42
			arrival_markers.add_child(mast_rock)

	# Estela de memória: um ponto narrativo fora do anel de tendas, acessível por [E] sem bloquear a saída para o lago.

	var camp_stela: StaticBody3D = StaticBody3D.new()
	camp_stela.name = "RuneP0_01"
	camp_stela.collision_layer = 4
	camp_stela.add_to_group("interactable")
	camp_stela.position = Vector3(8.4, 0.0, -5.5)
	var stela_model: Node3D = PILLAR.instantiate() as Node3D
	if stela_model != null:
		stela_model.name = "EstelaDaMemoriaMajestic"
		stela_model.scale = Vector3(0.44, 0.56, 0.44)
		stela_model.rotation.y = -0.34
		camp_stela.add_child(stela_model)
	var stela_collision: CollisionShape3D = CollisionShape3D.new()
	var stela_shape: CylinderShape3D = CylinderShape3D.new()
	stela_shape.radius = 0.44
	stela_shape.height = 2.65
	stela_collision.shape = stela_shape
	stela_collision.position = Vector3(0.0, 1.32, 0.0)
	camp_stela.add_child(stela_collision)
	var stela_light: OmniLight3D = OmniLight3D.new()
	stela_light.name = "RessonanciaDaEstelaMajestic"
	stela_light.light_color = Color(0.13, 0.42, 0.80, 1.0)
	stela_light.light_energy = 0.34
	stela_light.omni_range = 5.4
	stela_light.shadow_enabled = false
	stela_light.position = Vector3(0.0, 1.92, 0.0)
	camp_stela.add_child(stela_light)
	camp.add_child(camp_stela)

func _build_majestic_connector() -> void:

	# Ligação de expedição: une fisicamente o acampamento ao trilho florestal em vez de o deixar como cenário isolado.
	var connector: Node3D = Node3D.new()
	connector.name = "LigacaoMajesticAoTrilhoFlorestal"
	add_child(connector)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 50506
	var camp_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC
	var start_x: float = camp_anchor.x + 10.0
	var end_x: float = _path_x(camp_anchor.y)
	# Densidade de 41 lajes: a distância longitudinal fica abaixo do comprimento dos respectivos colisores,
	# garantindo uma ligação física contínua entre a estação Majestic e o trilho regional.
	for index: int in range(41):
		var t: float = float(index) / 40.0
		var x_value: float = lerpf(start_x, end_x, t)
		var z_value: float = camp_anchor.y + sin(t * PI) * 3.4
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeLigacaoMajestic_%02d" % index
		slab.mesh = _make_slab(2.05 + rng.randf_range(-0.16, 0.20), 1.52 + rng.randf_range(-0.13, 0.16), rng)
		slab.material_override = path_material
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.07, z_value)
		slab.rotation.y = rng.randf_range(-0.05, 0.05)
		connector.add_child(slab)
		var slab_body: StaticBody3D = StaticBody3D.new()
		slab_body.name = "ColisorLigacaoMajestic_%02d" % index
		slab_body.position = slab.position
		var slab_collision: CollisionShape3D = CollisionShape3D.new()
		var slab_shape: BoxShape3D = BoxShape3D.new()
		slab_shape.size = Vector3(2.18, 0.20, 1.70)
		slab_collision.shape = slab_shape
		slab_body.add_child(slab_collision)
		connector.add_child(slab_body)
		if index in [6, 20, 34]:
			var marker: OmniLight3D = OmniLight3D.new()
			marker.name = "SinalDaExpedicao_%02d" % index
			marker.light_color = Color(0.73, 0.28, 0.08, 1.0)
			marker.light_energy = 0.14
			marker.omni_range = 3.0
			marker.shadow_enabled = false
			marker.position = slab.position + Vector3(0.0, 0.68, 0.68)
			connector.add_child(marker)
	# Aglomerados descontínuos recuperam a leitura de margem natural, sem criar uma parede de floresta sobre o corredor físico.
	var connector_margin: Node3D = Node3D.new()
	connector_margin.name = "AglomeradosDaLigacaoMajestic"
	connector.add_child(connector_margin)
	for cluster_index: int in range(10):
		var cluster_t: float = float(cluster_index + 1) / 11.0
		var path_x: float = lerpf(start_x, end_x, cluster_t)
		var path_z: float = camp_anchor.y + sin(cluster_t * PI) * 3.4
		var side: float = -1.0 if cluster_index % 2 == 0 else 1.0
		var offset: float = 3.35 + float(cluster_index % 3) * 0.55
		var world_x: float = path_x + side * offset
		var world_z: float = path_z + rng.randf_range(-1.15, 1.15)
		var ground_y: float = _height_at(world_x, world_z)
		var margin_rock: Node3D = ROCK.instantiate() as Node3D
		if margin_rock != null:
			margin_rock.name = "RochaLigacaoMajestic_%02d" % cluster_index
			margin_rock.position = Vector3(world_x, ground_y + 0.05, world_z)
			var rock_scale: float = 0.14 + float(cluster_index % 4) * 0.032
			margin_rock.scale = Vector3(rock_scale, rock_scale * 0.82, rock_scale)
			margin_rock.rotation.y = rng.randf_range(-PI, PI)
			# CP-CARTO-60: a rocha lateral usa a mesma leitura húmida da margem, evitando o material claro do activo de origem.
			_apply_material(margin_rock, ruin_material)
			connector_margin.add_child(margin_rock)
		var margin_fern: Node3D = FERN.instantiate() as Node3D
		if margin_fern != null:
			margin_fern.name = "FetoLigacaoMajestic_%02d" % cluster_index
			margin_fern.position = Vector3(world_x - side * 0.56, ground_y + 0.03, world_z + rng.randf_range(-0.44, 0.44))
			var fern_scale: float = 0.38 + float(cluster_index % 3) * 0.07
			margin_fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			margin_fern.rotation.y = rng.randf_range(-PI, PI)
			connector_margin.add_child(margin_fern)
		# Quatro focos verticais quebram a silhueta de corredor sem formar uma parede vegetal nem interferir com colisões do trilho.
		if cluster_index in [1, 3, 6, 8]:
			var margin_tree: Node3D = (DARK_TREE if cluster_index % 2 == 0 else OAK_DARK).instantiate() as Node3D
			if margin_tree != null:
				margin_tree.name = "ArvoreLigacaoMajestic_%02d" % cluster_index
				var tree_x: float = path_x + side * (9.20 + float(cluster_index % 2) * 1.20)
				var tree_z: float = path_z + rng.randf_range(-2.0, 2.0)
				margin_tree.position = Vector3(tree_x, _height_at(tree_x, tree_z), tree_z)
				var tree_scale: float = 0.34 + float(cluster_index % 3) * 0.075
				margin_tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
				margin_tree.rotation.y = rng.randf_range(-PI, PI)
				connector_margin.add_child(margin_tree)

func _build_majestic_lake_link() -> void:
	# CP-CARTO-84: a rota R5→R6 tinha uma lacuna curta entre o fim da ligação Majestic e a primeira laje da margem.
	# Esta ponte de lajes fecha apenas esse intervalo, sem reduzir a distância macro Casa→Arco→Floresta→Majestic→Ruínas.
	var link: Node3D = Node3D.new()
	link.name = "LigacaoFisicaMajesticParaMargem"
	add_child(link)
	var camp_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC
	var link_z: float = camp_anchor.y
	var start_x: float = _path_x(link_z)
	var end_x: float = _lake_shore_x(link_z)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 84006
	for index: int in range(6):
		var t: float = float(index + 1) / 7.0
		var x_value: float = lerpf(start_x, end_x, t)
		var z_value: float = link_z + sin(t * PI) * 0.62
		var ground_y: float = _height_at(x_value, z_value)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeLigacaoMajesticMargem_%02d" % index
		slab.mesh = _make_slab(1.76 + rng.randf_range(-0.08, 0.10), 1.42 + rng.randf_range(-0.06, 0.07), rng)
		slab.material_override = shore_material
		slab.position = Vector3(x_value, ground_y + 0.06, z_value)
		slab.rotation.y = rng.randf_range(-0.035, 0.035)
		link.add_child(slab)
		var slab_body: StaticBody3D = StaticBody3D.new()
		slab_body.name = "ColisorLigacaoMajesticMargem_%02d" % index
		slab_body.position = slab.position + Vector3(0.0, -0.045, 0.0)
		var collision: CollisionShape3D = CollisionShape3D.new()
		var shape: BoxShape3D = BoxShape3D.new()
		shape.size = Vector3(1.90, 0.20, 1.64)
		collision.shape = shape
		slab_body.add_child(collision)
		link.add_child(slab_body)

func _build_majestic_turn_marker() -> void:
	# CP 258 — Bifurcação física para Majestic: uma estela baixa orienta a saída oeste do trilho florestal.
	# Não emite luz, não tem colisão e não reduz a passagem central; o acampamento continua a ser alcançado pelas lajes reais do conector.
	var marker_root: Node3D = Node3D.new()
	marker_root.name = "BifurcacaoFisicaParaMajestic"
	add_child(marker_root)
	var turn_z: float = CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC.y
	var turn_x: float = _path_x(turn_z)
	var marker_x: float = turn_x - 3.85
	var marker_y: float = _height_at(marker_x, turn_z)
	var stela: Node3D = PILLAR.instantiate() as Node3D
	if stela != null:
		stela.name = "EstelaDeDireccaoMajestic"
		stela.position = Vector3(marker_x, marker_y + 0.42, turn_z - 0.64)
		stela.scale = Vector3(0.31, 0.48, 0.31)
		stela.rotation = Vector3(0.04, -PI * 0.5, -0.06)
		_apply_material(stela, ruin_material)
		marker_root.add_child(stela)
	for rock_index: int in range(3):
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock == null:
			continue
		var side: float = -1.0 if rock_index != 1 else 1.0
		rock.name = "PedraDaBifurcacaoMajestic_%02d" % rock_index
		rock.position = Vector3(marker_x + side * (0.52 + float(rock_index) * 0.18), marker_y + 0.035, turn_z + 0.48 - float(rock_index) * 0.56)
		var scale_value: float = 0.13 + float(rock_index) * 0.032
		rock.scale = Vector3(scale_value, scale_value * 0.62, scale_value)
		rock.rotation.y = 0.48 + float(rock_index) * 0.86
		_apply_material(rock, ruin_material)
		marker_root.add_child(rock)
	var fern: Node3D = FERN.instantiate() as Node3D
	if fern != null:
		fern.name = "FetoDaBifurcacaoMajestic"
		fern.position = Vector3(marker_x - 0.88, marker_y + 0.02, turn_z + 0.92)
		fern.scale = Vector3.ONE * 0.48
		fern.rotation.y = -0.72
		marker_root.add_child(fern)

func _build_take9_corridor_fill() -> void:
	# Luz de preenchimento do Take 9: ilumina o solo frontal do conector Majestic–lago.
	# A câmara do Take 9 está em (-104, 16, 163) e aponta para (-36, 1.6, 180);
	# o solo frontal (z≈70–180, x≈-90 a -40) estava demasiado escuro na auditoria do CP 187.
	var fill_light: OmniLight3D = OmniLight3D.new()
	fill_light.name = "PreenchimentoSoloTake9"
	fill_light.light_color = Color(0.28, 0.34, 0.40, 1.0)
	fill_light.light_energy = 0.85
	fill_light.omni_range = 52.0
	fill_light.omni_attenuation = 1.20
	fill_light.shadow_enabled = false
	fill_light.position = Vector3(-68.0, 8.5, 172.0)
	add_child(fill_light)

func _build_take6_corridor_accent() -> void:
	# Acentos visuais no eixo central do corredor Majestic–Floresta para criar interesse no Take 6.
	# Posicionados lateralmente ao trilho (offset 4–6 m) para não obstruir a passagem de Elias.
	var accent: Node3D = Node3D.new()
	accent.name = "AcentosVisuaisCorredorTake6"
	add_child(accent)
	var accent_data: Array[Dictionary] = [
		{"x": -38.0, "z": 490.0, "rock_scale": 0.28, "fern_scale": 0.52, "yaw": 0.68},
		{"x": -55.0, "z": 505.0, "rock_scale": 0.22, "fern_scale": 0.44, "yaw": -1.32},
		{"x": -44.0, "z": 520.0, "rock_scale": 0.26, "fern_scale": 0.48, "yaw": 2.14},
	]
	for ad: Dictionary in accent_data:
		var ax: float = ad["x"] as float
		var az: float = ad["z"] as float
		var ay: float = _height_at(ax, az)
		var ar: Node3D = ROCK.instantiate() as Node3D
		if ar != null:
			ar.name = "RochaAcentoTake6_%s" % str(int(ax))
			ar.position = Vector3(ax, ay + 0.04, az)
			var rs: float = ad["rock_scale"] as float
			ar.scale = Vector3(rs, rs * 0.80, rs)
			ar.rotation.y = ad["yaw"] as float
			_apply_material(ar, ruin_material)
			accent.add_child(ar)
		var af: Node3D = FERN.instantiate() as Node3D
		if af != null:
			af.name = "FetoAcentoTake6_%s" % str(int(ax))
			af.position = Vector3(ax + 0.8, ay + 0.02, az + 0.6)
			var fs: float = ad["fern_scale"] as float
			af.scale = Vector3(fs, fs, fs)
			af.rotation.y = -(ad["yaw"] as float)
			accent.add_child(af)

func _build_cartographic_basin_silhouette() -> void:
	# Promontório oriental e queda de água: traduzem a borda elevada da Bacia Central indicada no mapa sem bloquear o acesso oeste.
	var silhouette: Node3D = Node3D.new()
	silhouette.name = "SilhuetaCartograficaDaBacia"
	add_child(silhouette)
	var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
	var promontory_points: Array[Vector3] = [
		Vector3(lake_anchor.x + 42.5, 0.0, lake_anchor.y - 11.0),
		Vector3(lake_anchor.x + 45.0, 0.0, lake_anchor.y - 2.0),
		Vector3(lake_anchor.x + 41.8, 0.0, lake_anchor.y + 9.0)
	]
	for index: int in range(promontory_points.size()):
		var point: Vector3 = promontory_points[index]
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "PromontorioOrientalDaBacia_%02d" % index
		rock.position = Vector3(point.x, _height_at(point.x, point.z) + 0.08, point.z)
		var scale_value: float = 0.56 + float(index) * 0.10
		rock.scale = Vector3(scale_value, scale_value * 1.65, scale_value)
		rock.rotation = Vector3(0.08 * float(index), 0.72 + float(index) * 0.46, -0.12 + float(index) * 0.07)
		_apply_material(rock, ruin_material)
		silhouette.add_child(rock)
	var fall_x: float = lake_anchor.x + 43.0
	var fall_z: float = lake_anchor.y - 1.5
	var fall_y: float = _height_at(fall_x, fall_z)
	# CP-CARTO-30: filetes volumétricos eliminam a cascata de painel plano e acompanham o promontório em profundidade.
	var water_material: StandardMaterial3D = StandardMaterial3D.new()
	water_material.albedo_color = Color(0.10, 0.38, 0.50, 0.70)
	water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_material.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	water_material.roughness = 0.24
	water_material.emission_enabled = true
	water_material.emission = Color(0.008, 0.050, 0.070, 1.0)
	water_material.emission_energy_multiplier = 0.16
	for stream_index: int in range(5):
		var stream_mesh: CylinderMesh = CylinderMesh.new()
		stream_mesh.top_radius = 0.09 + float(stream_index % 2) * 0.025
		stream_mesh.bottom_radius = 0.15 + float((stream_index + 1) % 2) * 0.025
		stream_mesh.height = 7.4 + float(stream_index % 3) * 0.55
		stream_mesh.radial_segments = 8
		stream_mesh.material = water_material
		var stream: MeshInstance3D = MeshInstance3D.new()
		stream.name = "FileteDaCascataOriental_%02d" % stream_index
		stream.mesh = stream_mesh
		var stream_offset: float = -1.35 + float(stream_index) * 0.68
		stream.position = Vector3(fall_x + stream_offset, fall_y + 3.7 + float(stream_index % 2) * 0.22, fall_z + sin(float(stream_index) * 1.7) * 0.28)
		stream.rotation = Vector3(0.04 * float((stream_index % 3) - 1), 0.12 * float(stream_index), 0.05 * float((stream_index % 2) * 2 - 1))
		stream.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		silhouette.add_child(stream)

func _build_submerged_ruins() -> void:
	var lake: Node3D = Node3D.new()
	lake.name = "RuinasSubmersasDoLago"
	var lake_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS
	var center_x: float = lake_anchor.x
	var center_z: float = lake_anchor.y
	# Cota elevada de forma contida: cobre a margem interna fragmentada e revela uma bacia lacustre contínua, preservando as lajes de chegada acima da água.
	var water_y: float = _height_at(center_x, center_z) + 0.82
	lake.position = Vector3(center_x, water_y, center_z)
	add_child(lake)
	# Luz em coordenadas mundiais: garante leitura de margem e ruínas no renderizador de compatibilidade sem depender do espaço local da água.
	var world_lake_fill: OmniLight3D = OmniLight3D.new()
	world_lake_fill.name = "PreenchimentoMundialDoLago"
	world_lake_fill.light_color = Color(0.14, 0.38, 0.62, 1.0)
	world_lake_fill.light_energy = 1.90
	world_lake_fill.omni_range = 58.0
	world_lake_fill.shadow_enabled = false
	world_lake_fill.position = Vector3(center_x - 12.0, water_y + 7.5, center_z - 4.0)
	add_child(world_lake_fill)
	var opposite_lake_fill: OmniLight3D = OmniLight3D.new()
	opposite_lake_fill.name = "PreenchimentoOpostoDoLago"
	opposite_lake_fill.light_color = Color(0.10, 0.28, 0.46, 1.0)
	opposite_lake_fill.light_energy = 1.15
	opposite_lake_fill.omni_range = 46.0
	opposite_lake_fill.shadow_enabled = false
	opposite_lake_fill.position = Vector3(center_x + 18.0, water_y + 5.0, center_z + 6.0)
	add_child(opposite_lake_fill)
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
	shoreline_fill.light_energy = 0.74
	shoreline_fill.omni_range = 46.0
	shoreline_fill.shadow_enabled = false
	shoreline_fill.position = Vector3(-19.0, 5.0, -7.0)
	lake.add_child(shoreline_fill)
	# Luz submersa central: posicionada abaixo da lâmina de água para criar um brilho frio que sobe pelos pilares.
	# Simula a refração subaquatica no gl_compatibility sem SSR nem SDFGI.
	var sub_center: OmniLight3D = OmniLight3D.new()
	sub_center.name = "LuzSubaquaticaCentral"
	sub_center.light_color = Color(0.06, 0.28, 0.52, 1.0)
	sub_center.light_energy = 1.40
	sub_center.omni_range = 38.0
	sub_center.omni_attenuation = 0.80
	sub_center.shadow_enabled = false
	sub_center.position = Vector3(0.0, -1.80, 0.0)
	lake.add_child(sub_center)
	# Luz submersa lateral: deslocada para o quadrante dos pilares mais altos para destacar a silhueta de colapso.
	var sub_lateral: OmniLight3D = OmniLight3D.new()
	sub_lateral.name = "LuzSubaquaticaLateral"
	sub_lateral.light_color = Color(0.04, 0.22, 0.44, 1.0)
	sub_lateral.light_energy = 0.90
	sub_lateral.omni_range = 26.0
	sub_lateral.omni_attenuation = 0.90
	sub_lateral.shadow_enabled = false
	sub_lateral.position = Vector3(14.0, -2.40, 8.0)
	lake.add_child(sub_lateral)
	for index: int in range(8):
		var angle: float = float(index) * TAU / 8.0
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarSubmerso_%02d" % index
		# Cotas, inclinações e escalas irregulares sugerem colapso gradual sob a água em vez de uma coroa regular de pilares.
		pillar.position = Vector3(cos(angle) * (22.2 + float(index % 3) * 0.74), -0.82 + float(index % 4) * 0.47, sin(angle) * (17.1 + float((index + 1) % 3) * 0.62))
		var pillar_scale: float = 0.68 + float(index % 4) * 0.17
		pillar.scale = Vector3(pillar_scale, pillar_scale, pillar_scale)
		pillar.rotation = Vector3(0.10 + float(index % 4) * 0.14, angle + 0.12 * sin(float(index)), -0.16 + float(index % 3) * 0.13)
		_apply_material(pillar, ruin_material)
		lake.add_child(pillar)
		# Apenas metade dos vestígios recebe corpo físico: a ruína ganha presença sem formar uma muralha dentro da água.
		if index % 2 == 0:
			var pillar_body: StaticBody3D = StaticBody3D.new()
			pillar_body.name = "ColisorPilarSubmerso_%02d" % index
			pillar_body.position = pillar.position + Vector3(0.0, 2.05 * pillar_scale, 0.0)
			pillar_body.rotation = pillar.rotation
			var pillar_collision: CollisionShape3D = CollisionShape3D.new()
			var pillar_shape: CylinderShape3D = CylinderShape3D.new()
			pillar_shape.radius = 0.52 * pillar_scale
			pillar_shape.height = 4.10 * pillar_scale
			pillar_collision.shape = pillar_shape
			pillar_body.add_child(pillar_collision)
			lake.add_child(pillar_body)
	# Três remanescentes altos asseguram que a civilização submersa é lida desde o trilho sem criar uma parede.
	for landmark_index: int in range(3):
		var landmark: Node3D = PILLAR.instantiate() as Node3D
		if landmark == null:
			continue
		landmark.name = "MarcoRuinaEmergente_%02d" % landmark_index
		# Marcos emergem acima da lâmina para lerem como ruínas antigas e não como pequenas estacas na margem.
		landmark.position = Vector3(-17.0 + float(landmark_index) * 16.5, 2.95 + float(landmark_index % 2) * 0.60, -9.0 + float(landmark_index) * 5.0)
		var landmark_scale: float = 1.82 - float(landmark_index) * 0.15
		landmark.scale = Vector3(landmark_scale, landmark_scale, landmark_scale)
		landmark.rotation = Vector3(0.11 + float(landmark_index) * 0.10, 0.38 + float(landmark_index) * 0.41, -0.07 + float(landmark_index) * 0.06)
		_apply_material(landmark, ruin_material)
		lake.add_child(landmark)
		# Baliza arqueológica discreta: delineia os marcos emergentes na captura sem criar um perímetro artificial de luz.
		var landmark_beacon: OmniLight3D = OmniLight3D.new()
		landmark_beacon.name = "BrilhoMarcoRuina_%02d" % landmark_index
		landmark_beacon.light_color = Color(0.16, 0.44, 0.68, 1.0)
		landmark_beacon.light_energy = 0.56
		landmark_beacon.omni_range = 9.5
		landmark_beacon.shadow_enabled = false
		landmark_beacon.position = landmark.position + Vector3(0.0, 2.65 * landmark_scale, 0.0)
		lake.add_child(landmark_beacon)
		var landmark_body: StaticBody3D = StaticBody3D.new()
		landmark_body.name = "ColisorMarcoRuinaEmergente_%02d" % landmark_index
		landmark_body.position = landmark.position + Vector3(0.0, 2.55 * landmark_scale, 0.0)
		landmark_body.rotation = landmark.rotation
		var landmark_collision: CollisionShape3D = CollisionShape3D.new()
		var landmark_shape: CylinderShape3D = CylinderShape3D.new()
		landmark_shape.radius = 0.68 * landmark_scale
		landmark_shape.height = 5.10 * landmark_scale
		landmark_collision.shape = landmark_shape
		landmark_body.add_child(landmark_collision)
		lake.add_child(landmark_body)
	var dome_mesh: SphereMesh = SphereMesh.new()
	dome_mesh.radius = 7.5
	dome_mesh.height = 3.6
	dome_mesh.radial_segments = 24
	var dome: MeshInstance3D = MeshInstance3D.new()
	dome.name = "DomoSubmersoDoHub"
	dome.mesh = dome_mesh
	# O coroamento do domo emerge discretamente: é a silhueta central da Bacia no mapa, não um objecto oculto sob a lâmina.
	dome.position = Vector3(0.0, -0.10, 0.0)
	dome.scale = Vector3(1.32, 0.46, 1.32)

	dome.material_override = ruin_material
	lake.add_child(dome)
	# Estela de chegada: dá ao jogador um primeiro ponto de leitura/interação ao alcançar a margem ocidental.
	var arrival_stela: StaticBody3D = StaticBody3D.new()
	arrival_stela.name = "RuneP0_02"
	arrival_stela.collision_layer = 4
	arrival_stela.add_to_group("interactable")
	arrival_stela.position = Vector3(-8.0, 1.45, -21.0)
	var stela_model: Node3D = PILLAR.instantiate() as Node3D
	if stela_model != null:
		stela_model.name = "EstelaDaChegada"
		stela_model.scale = Vector3(0.72, 0.86, 0.72)
		stela_model.rotation = Vector3(0.05, 0.28, -0.03)
		_apply_material(stela_model, ruin_material)
		arrival_stela.add_child(stela_model)
	var stela_collision: CollisionShape3D = CollisionShape3D.new()
	var stela_shape: BoxShape3D = BoxShape3D.new()
	stela_shape.size = Vector3(1.25, 2.75, 1.25)
	stela_collision.shape = stela_shape
	arrival_stela.add_child(stela_collision)
	lake.add_child(arrival_stela)
	var stela_glow: OmniLight3D = OmniLight3D.new()
	stela_glow.name = "BrilhoDaEstelaDaChegada"
	stela_glow.light_color = Color(0.22, 0.48, 0.72, 1.0)
	stela_glow.light_energy = 0.42
	stela_glow.omni_range = 6.0
	stela_glow.shadow_enabled = false
	stela_glow.position = arrival_stela.position + Vector3(0.0, 1.15, 0.0)
	lake.add_child(stela_glow)
	# Lajes rasas: prolongam a chegada ocidental por alguns metros dentro da bacia, sem criar uma ponte artificial sobre o lago.
	var shallow_path: Node3D = Node3D.new()
	shallow_path.name = "LajesRasasDasRuinas"
	lake.add_child(shallow_path)
	for shallow_index: int in range(5):
		var shallow_t: float = float(shallow_index + 1) / 5.5
		var shallow_pos: Vector3 = Vector3(lerpf(-7.0, -3.5, shallow_t), 0.18 + sin(float(shallow_index)) * 0.035, lerpf(-17.4, -5.2, shallow_t))
		var shallow_slab: MeshInstance3D = MeshInstance3D.new()
		shallow_slab.name = "LajeRasaDasRuinas_%02d" % shallow_index
		shallow_slab.mesh = _make_slab(1.85, 1.48, RandomNumberGenerator.new())
		# A laje rasa pertence à margem submersa: usa a pedra húmida para não parecer um pavimento seco suspenso na água.
		shallow_slab.material_override = shore_material
		shallow_slab.position = shallow_pos
		shallow_slab.rotation.y = 0.18 + float(shallow_index) * 0.11
		shallow_path.add_child(shallow_slab)
		var shallow_body: StaticBody3D = StaticBody3D.new()
		shallow_body.name = "ColisorLajeRasaDasRuinas_%02d" % shallow_index
		shallow_body.position = shallow_pos
		shallow_body.rotation.y = shallow_slab.rotation.y
		var shallow_collision: CollisionShape3D = CollisionShape3D.new()
		var shallow_shape: BoxShape3D = BoxShape3D.new()
		shallow_shape.size = Vector3(1.72, 0.20, 1.36)
		shallow_collision.shape = shallow_shape
		shallow_body.add_child(shallow_collision)
		shallow_path.add_child(shallow_body)

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
		var ground_y: float = _height_at(world_x, world_z)
		# Mantém a entrada ocidental do caminho aberta antes de entrar no vale do lago.
		if world_z < 238.0 and abs(world_x - _path_x(world_z)) < 9.0:
			continue
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaDeMargem_%02d" % index
			rock.position = Vector3(world_x, ground_y + 0.08, world_z)
			var rock_scale: float = 0.19 + fmod(float(index), 4.0) * 0.050
			rock.scale = Vector3(rock_scale, rock_scale, rock_scale)
			rock.rotation = Vector3(0.0, angle + 0.4, 0.0)
			_apply_material(rock, ruin_material)
			margin.add_child(rock)
			if index % 3 == 0:
				var rock_body: StaticBody3D = StaticBody3D.new()
				rock_body.name = "ColisorRochaDeMargem_%02d" % index
				rock_body.position = Vector3(world_x, ground_y + 0.42, world_z)
				rock_body.rotation.y = angle + 0.4
				var rock_collision: CollisionShape3D = CollisionShape3D.new()
				var rock_shape: BoxShape3D = BoxShape3D.new()
				var collision_width: float = 0.82 + rock_scale * 2.1
				rock_shape.size = Vector3(collision_width, 0.84, collision_width * 0.88)
				rock_collision.shape = rock_shape
				rock_body.add_child(rock_collision)
				margin.add_child(rock_body)
		if index % 2 == 0:
			var fern: Node3D = FERN.instantiate() as Node3D
			if fern != null:
				fern.name = "FetoRibeirinho_%02d" % index
				fern.position = Vector3(world_x * 0.98 + center.x * 0.02, ground_y + 0.03, world_z * 0.98 + center.y * 0.02)
				var fern_scale: float = 0.32 + fmod(float(index), 3.0) * 0.07
				fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
				fern.rotation.y = angle + 0.6
				margin.add_child(fern)
	# Rochas focais maiores quebram a borda elíptica vista da chegada sem criar uma muralha ou colisores adicionais.
	var shore_accents: Array[Vector3] = [
		Vector3(28.0, 0.0, 226.0), Vector3(42.0, 0.0, 218.5),
		Vector3(57.0, 0.0, 215.5), Vector3(76.0, 0.0, 218.0), Vector3(93.0, 0.0, 226.0)
	]
	for accent_index: int in range(shore_accents.size()):
		var accent_point: Vector3 = shore_accents[accent_index]
		var accent_rock: Node3D = ROCK.instantiate() as Node3D
		if accent_rock != null:
			accent_rock.name = "AcentoRochosoMargem_%02d" % accent_index
			accent_rock.position = Vector3(accent_point.x, _height_at(accent_point.x, accent_point.z) + 0.06, accent_point.z)
			var accent_scale: float = 0.29 + float(accent_index % 3) * 0.055
			accent_rock.scale = Vector3(accent_scale, accent_scale * 0.82, accent_scale)
			accent_rock.rotation.y = 0.42 + float(accent_index) * 0.71
			_apply_material(accent_rock, ruin_material)
			margin.add_child(accent_rock)
		var accent_fern: Node3D = FERN.instantiate() as Node3D
		if accent_fern != null:
			accent_fern.name = "FetoDoAcentoMargem_%02d" % accent_index
			accent_fern.position = Vector3(accent_point.x - 0.78, _height_at(accent_point.x - 0.78, accent_point.z + 0.54) + 0.03, accent_point.z + 0.54)
			accent_fern.scale = Vector3(0.46, 0.46, 0.46)
			accent_fern.rotation.y = 0.28 + float(accent_index) * 0.83
			margin.add_child(accent_fern)

func _build_dev6_r6_organic_shore_integration() -> void:
	# DEV6-050 — promoção reversível da margem orgânica Dev5. A rota para as Ruínas conserva
	# uma faixa livre no eixo x=60; não há cais de lajes, portal, colunas uniformes ou luzes novas.
	var r6_root := Node3D.new()
	r6_root.name = "Dev6_MargemOrganicaR6"
	add_child(r6_root)
	var outcrop_material := StandardMaterial3D.new()
	outcrop_material.albedo_color = Color(0.16, 0.20, 0.18, 1.0)
	outcrop_material.roughness = 0.96
	var monolith := PILLAR.instantiate() as Node3D
	if monolith != null:
		monolith.name = "MonolitoMargemR6_Dev6"
		monolith.position = Vector3(52.0, _height_at(52.0, 260.0), 260.0)
		monolith.scale = Vector3(0.62, 1.06, 0.62)
		monolith.rotation_degrees = Vector3(0.0, 14.0, -4.0)
		_apply_material(monolith, ruin_material)
		monolith.add_to_group("dev6_r6_grounding")
		r6_root.add_child(monolith)
	var outcrop_specs: Array[Dictionary] = [
		{"name": "AfloramentoOesteR6", "x": 46.0, "z": 254.0, "scale": 0.54, "yaw": 0.32},
		{"name": "AfloramentoEsteR6", "x": 73.0, "z": 275.0, "scale": 0.48, "yaw": -0.58},
		{"name": "AfloramentoLinhaAguaR6", "x": 55.0, "z": 278.5, "scale": 0.38, "yaw": 0.80}
	]
	for outcrop_spec: Dictionary in outcrop_specs:
		var outcrop := ROCK.instantiate() as Node3D
		if outcrop == null:
			continue
		var x_value := outcrop_spec["x"] as float
		var z_value := outcrop_spec["z"] as float
		outcrop.name = outcrop_spec["name"] as String
		outcrop.position = Vector3(x_value, _height_at(x_value, z_value) - 0.04, z_value)
		var scale_value := outcrop_spec["scale"] as float
		outcrop.scale = Vector3(scale_value, scale_value * 0.78, scale_value)
		outcrop.rotation.y = outcrop_spec["yaw"] as float
		_apply_material(outcrop, outcrop_material)
		outcrop.add_to_group("dev6_r6_grounding")
		r6_root.add_child(outcrop)
	var fern_specs: Array[Dictionary] = [
		{"name": "FetoMargemOesteR6", "x": 54.0, "z": 251.5, "scale": 0.46, "yaw": 0.20},
		{"name": "FetoMargemEsteR6", "x": 68.0, "z": 271.5, "scale": 0.44, "yaw": -0.48}
	]
	for fern_spec: Dictionary in fern_specs:
		var fern := FERN.instantiate() as Node3D
		if fern == null:
			continue
		var x_value := fern_spec["x"] as float
		var z_value := fern_spec["z"] as float
		fern.name = fern_spec["name"] as String
		fern.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
		var scale_value := fern_spec["scale"] as float
		fern.scale = Vector3.ONE * scale_value
		fern.rotation.y = fern_spec["yaw"] as float
		fern.add_to_group("dev6_r6_grounding")
		r6_root.add_child(fern)
	_build_dev6_r6_grounding_fields(r6_root)
	call_deferred("_ground_dev6_r6_assets")
	print("[DEV6_R6] status=integrated monolith=1 outcrops=3 foliage=2 pier_slabs=0 dynamic_lights=0 route_clear=true reversible=true")

func _build_dev6_r6_grounding_fields(parent: Node3D) -> void:
	var field_root := Node3D.new()
	field_root.name = "AdaptadoresDeTerrenoR6"
	parent.add_child(field_root)
	var field_index := 0
	for candidate: Node in get_tree().get_nodes_in_group("dev6_r6_grounding"):
		if not (candidate is Node3D):
			continue
		var node := candidate as Node3D
		var field := StaticBody3D.new()
		field.name = "SuporteDeTerrenoR6_%02d" % field_index
		field.position = Vector3(node.global_position.x, _height_at(node.global_position.x, node.global_position.z) - 0.08, node.global_position.z)
		var collision := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		shape.size = Vector3(3.40, 0.16, 3.40)
		collision.shape = shape
		field.add_child(collision)
		field_root.add_child(field)
		field_index += 1

func _ground_dev6_r6_assets() -> void:
	await get_tree().physics_frame
	var grounded_count := 0
	for candidate: Node in get_tree().get_nodes_in_group("dev6_r6_grounding"):
		if not (candidate is Node3D):
			continue
		var node := candidate as Node3D
		var desired := node.global_position + Vector3.UP * 48.0
		var result: Dictionary = CARTOGRAPHIC_GROUNDING.snap_to_ground(get_world_3d(), node, desired)
		if bool(result.get("grounded", false)):
			grounded_count += 1
	print("[DEV6_R6] grounding=%d expected=6 xz_preserved=true pier_slabs=0" % grounded_count)
	assert(grounded_count == 6)

func _build_majestic_ruins_approach_grounding() -> void:
	# CP284: três grupos irregulares costuram o fim da expedição Majestic à margem das Ruínas sem fechar a aproximação ocidental.
	var grounding: Node3D = Node3D.new()
	grounding.name = "AterramentoDaChegadaMajesticRuinas"
	add_child(grounding)
	var groups: Array[Dictionary] = [
		{"z": 207.0, "side": -1.0, "offset": 5.4, "rock": 0.30, "tree": 0.42},
		{"z": 219.0, "side": 1.0, "offset": 6.1, "rock": 0.36, "tree": 0.48},
		{"z": 231.0, "side": -1.0, "offset": 5.9, "rock": 0.33, "tree": 0.40},
	]
	for group_index: int in range(groups.size()):
		var group: Dictionary = groups[group_index]
		var z_value: float = group["z"] as float
		var side: float = group["side"] as float
		var x_value: float = _path_x(z_value) + side * (group["offset"] as float)
		var ground_y: float = _height_at(x_value, z_value)
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "AfloramentoChegadaRuinas_%02d" % (group_index + 1)
			var rock_scale: float = group["rock"] as float
			rock.position = Vector3(x_value, ground_y + 0.035, z_value)
			rock.scale = Vector3(rock_scale, rock_scale * 0.72, rock_scale)
			rock.rotation.y = -0.34 + float(group_index) * 0.76
			_apply_material(rock, ruin_material)
			grounding.add_child(rock)
		var tree_source: PackedScene = OAK_DARK if group_index == 1 else DARK_TREE
		var tree: Node3D = tree_source.instantiate() as Node3D
		if tree != null:
			tree.name = "ArvoreChegadaRuinas_%02d" % (group_index + 1)
			var tree_scale: float = group["tree"] as float
			tree.position = Vector3(x_value + side * 2.15, _height_at(x_value + side * 2.15, z_value + 1.4), z_value + 1.4)
			tree.scale = Vector3(tree_scale, tree_scale * (0.92 + float(group_index % 2) * 0.14), tree_scale)
			tree.rotation.y = side * (0.48 + float(group_index) * 0.32)
			grounding.add_child(tree)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoChegadaRuinas_%02d" % (group_index + 1)
			fern.position = Vector3(x_value - side * 0.86, _height_at(x_value - side * 0.86, z_value - 0.45) + 0.025, z_value - 0.45)
			fern.scale = Vector3(0.46, 0.46, 0.46)
			fern.rotation.y = 0.22 + float(group_index) * 0.80
			grounding.add_child(fern)

func _build_lakeside_focal_vegetation() -> void:
	# Grupos descontínuos de espécies reais: enquadram a água e mantêm a abertura do trilho ocidental livre.
	var foliage: Node3D = Node3D.new()
	foliage.name = "VegetacaoFocalDaMargem"
	add_child(foliage)
	var placements: Array[Vector3] = [
		Vector3(25.0, 0.0, 236.0), Vector3(33.0, 0.0, 278.0),
		Vector3(8.0, 0.0, 306.0), Vector3(88.0, 0.0, 276.0),
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

func _create_shore_material() -> StandardMaterial3D:
	# Material de pedra molhada para as lajes de margem do lago: mais escuro e com reflexo subtil.
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.32, 0.36, 0.34, 1.0)
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.42
	material.roughness = 0.72
	material.metallic = 0.04
	material.uv1_scale = Vector3(0.30, 0.30, 0.30)
	return material

func _create_path_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	# Matiz pedra húmida: reduz o contraste branco das lajes contra o relvado sem apagar a continuidade de navegação.
	material.albedo_color = Color(0.43, 0.46, 0.38, 1.0)
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.30
	material.roughness = 0.92
	material.uv1_scale = Vector3(0.34, 0.34, 0.34)
	return material

func _create_ruin_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	# Tonalidade mineral húmida: impede que a textura de ruína rebente em branco sob a luz do modo GL Compatibility.
	material.albedo_color = Color(0.48, 0.52, 0.45, 1.0)
	material.albedo_texture = MOSSY_RUIN_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_RUIN_NORMAL
	material.normal_scale = 0.32
	material.roughness = 0.95
	# Ruínas recebem apenas luz do mundo; a emissão anterior sobre-expondo a estela foi removida.
	material.emission_enabled = false
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
					ALBEDO = mix(vec3(0.028, 0.115, 0.150), vec3(0.085, 0.285, 0.355), surface_variation * 0.70);
			// Emissão fria muito contida: revela a forma elíptica no modo GL Compatibility sem transformar o lago numa superfície luminosa.
			EMISSION = mix(vec3(0.008, 0.040, 0.056), vec3(0.032, 0.128, 0.170), surface_variation * 0.62);

		// Superfície lacustre larga e difusa: suaviza reflexos duros do modo GL Compatibility, preservando ondas e ruínas abaixo da linha de água.
		ROUGHNESS = 0.52;
		SPECULAR = 0.28;

		ALPHA = 1.0;

}
"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	return material

func _build_forest_corridor_fill() -> void:
	# CP 197: 3 luzes frias no corredor central da Floresta Densa.
	var fill_root: Node3D = Node3D.new()
	fill_root.name = "PreenchimentoCorredorFloresta"
	add_child(fill_root)
	var positions: Array = [
		[100.0, 0.58, 17.0],
		[148.0, 0.62, 18.5],
		[196.0, 0.55, 16.0],
	]
	for fp in positions:
		var fz: float = fp[0]
		var fx: float = _path_x(fz)
		var fy: float = _height_at(fx, fz) + 4.5
		var fill: OmniLight3D = OmniLight3D.new()
		fill.name = "PreenchimentoFloresta_z%s" % str(int(fz))
		fill.position = Vector3(fx, fy, fz)
		fill.light_color = Color(0.52, 0.62, 0.78, 1.0)
		fill.light_energy = fp[1]
		fill.omni_range = min(fp[2], 12.0)  # CP 200: limite de alcance para GTX 1050
		fill.shadow_enabled = false
		fill_root.add_child(fill)

func _build_south_shore_fill() -> void:
	# CP 199: margem inferior sul das Ruinas Submersas.
	var south_shore: Node3D = Node3D.new()
	south_shore.name = "MargemInferiorSulLago"
	add_child(south_shore)
	var south_rocks: Array = [
		[Vector3(42.0, _height_at(42.0, 270.0) + 0.06, 270.0), 0.30, 0.82],
		[Vector3(60.0, _height_at(60.0, 278.0) + 0.06, 278.0), 0.26, 2.14],
		[Vector3(78.0, _height_at(78.0, 272.0) + 0.06, 272.0), 0.34, -0.55],
	]
	for rd in south_rocks:
		var rock: Node3D = ROCK.instantiate() as Node3D
		if rock != null:
			rock.position = rd[0]
			var s: float = rd[1]
			rock.scale = Vector3(s, s * 0.78, s)
			rock.rotation.y = rd[2]
			south_shore.add_child(rock)
	var south_fill: OmniLight3D = OmniLight3D.new()
	south_fill.name = "PreenchimentoMargeminferior"
	south_fill.position = Vector3(60.0, _height_at(60.0, 272.0) + 1.5, 272.0)
	south_fill.light_color = Color(0.62, 0.52, 0.38, 1.0)
	south_fill.light_energy = 0.50
	south_fill.omni_range = 14.0  # CP 200: reduzido para GTX 1050
	south_fill.shadow_enabled = false
	south_shore.add_child(south_fill)

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
