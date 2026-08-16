extends Node3D
## Casa Voss — abertura jogável de 1908.
## Refúgio de Elias em pedra, madeira e cobre; a entrada olha para a estrada e a montanha.

const HOUSE_ORIGIN := Vector3(-22.0, 0.0, 8.0)
const MOSSY_ROCK_DIFF: Texture2D = preload("res://assets/textures/pbr/mossy_rock_diff.jpg")
const MOSSY_ROCK_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")
const MOSSY_ROCK_ROUGH: Texture2D = preload("res://assets/textures/pbr/mossy_rock_roughness.jpg")
const HERO_TREE: PackedScene = preload("res://assets/models_polyhaven/island_tree_01/island_tree_01_1k.gltf")
const FERN_REAL_ASSET: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const MOSS_ROCK_SET: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const FERN_ASSET: PackedScene = preload("res://assets/models_cc0/stone_smallF.glb")
const GRASS_ASSET: PackedScene = preload("res://assets/models_cc0/stone_smallF.glb")
const DARK_TREE_ASSET: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const FOREST_TREE_ASSET: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const PINE_LOD_ASSET: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const EZ_PINE_CANDIDATE: PackedScene = preload("res://assets/models_generated/ez_pine_medium_pbr.glb")
const EZ_PINE_TALL_CANDIDATE: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const RUIN_PILLAR_ASSET: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const RUIN_WALL_ASSET: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const FOREST_SECTOR_SCRIPT: Script = preload("res://levels/ForestSector3D.gd")
const DAYLIGHT_VARIANT_ENABLED: bool = true
const FOREST_GROUND_DIFF: Texture2D = preload("res://assets/textures/pbr/forest_ground_diff.jpg")
const WET_SLATE_ROOF_DIFF: Texture2D = preload("res://assets/textures/generated/wet_slate_roof_v2.png")
const WEATHERED_DARK_TIMBER_DIFF: Texture2D = preload("res://assets/textures/generated/weathered_dark_timber.jpg")
const DAYLIGHT_WEATHERED_TIMBER_DIFF: Texture2D = preload("res://assets/textures/generated/daylight_weathered_timber.png")
const DAYLIGHT_WEATHERED_FLAGSTONE_DIFF: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")
const DAYLIGHT_WEATHERED_SLATE_ROOF_DIFF: Texture2D = preload("res://assets/textures/generated/daylight_weathered_slate_roof.png")
const WET_FIELDSTONE_WALL_DIFF: Texture2D = preload("res://assets/textures/generated/wet_fieldstone_wall.jpg")
const FOREST_GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")
const FOREST_GROUND_ROUGH: Texture2D = preload("res://assets/textures/pbr/forest_ground_roughness.jpg")

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var timber_material: StandardMaterial3D
var aged_wood_material: StandardMaterial3D
var roof_material: StandardMaterial3D
var interior_wood_material: StandardMaterial3D
var brass_material: StandardMaterial3D
var window_material: StandardMaterial3D
var warm_glow_material: StandardMaterial3D
var chronos_window_material: StandardMaterial3D
var opening_camera: Camera3D
var opening_ui: CanvasLayer
var opening_hidden_nodes: Array[Node3D] = []
var opening_timer: Timer
var opening_skip_timer: Timer
var opening_skip_layer: CanvasLayer
var opening_skip_label: Label
var opening_active: bool = false
var opening_skip_hold_time: float = 0.0
var opening_skip_key_held: bool = false
var opening_was_skipped: bool = false
const OPENING_SKIP_HOLD_SECONDS: float = 1.50
var front_door_open: bool = false

func _ready() -> void:
	add_to_group("voss_house_controller")
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	_create_materials()
	var house: Node3D = Node3D.new()
	house.name = "CasaVoss"
	house.add_to_group("voss_house")
	var base_y: float = _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z)
	house.position = Vector3(HOUSE_ORIGIN.x, base_y, HOUSE_ORIGIN.z)
	# A fachada olha para a serra: o jogador vê casa, estrada e montanha no primeiro quadro.
	house.rotation.y = PI + deg_to_rad(10.0)
	add_child(house)
	_build_foundation(house)
	_build_walls_and_frame(house)
	_build_reference_gable_face(house)
	_build_roof_and_chimney(house)
	_build_side_annex(house)
	_build_interior(house)
	_build_exterior_details(house)
	_build_mountain_road(house)
	_build_opening_landscape(house)
	_build_cinematic_exterior_depth(house)
	_build_real_forest_frame()
	_build_ez_pine_depth_candidate()
	_build_real_fern_frame()
	_build_forest_ground_integration_92(house)
	_build_opening_camera()
	_build_exterior_porch_light()

func _build_visible_opening_road() -> void:
	# Percurso contínuo no espaço mundial: acompanha o relevo e usa o mesmo PBR de solo, sem placas ou planos de fundo.
	var road_material: StandardMaterial3D = StandardMaterial3D.new()
	road_material.albedo_color = Color(0.245, 0.165, 0.082, 1.0)
	road_material.albedo_texture = FOREST_GROUND_DIFF
	road_material.normal_enabled = true
	road_material.normal_texture = FOREST_GROUND_NORMAL
	road_material.normal_scale = 0.50
	road_material.roughness_texture = FOREST_GROUND_ROUGH
	road_material.roughness = 0.90
	road_material.uv1_triplanar = true
	road_material.uv1_world_triplanar = true
	road_material.uv1_scale = Vector3(0.42, 0.42, 0.42)

	var route: Array[Vector2] = [Vector2(-21.0, 7.2), Vector2(-19.7, 9.9), Vector2(-18.1, 12.7), Vector2(-16.3, 15.4), Vector2(-14.2, 18.2), Vector2(-11.9, 20.9), Vector2(-9.5, 23.7), Vector2(-7.2, 27.0)]
	var widths: Array[float] = [1.25, 1.38, 1.56, 1.72, 1.90, 2.04, 2.18, 2.30]
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(route.size() - 1):
		var direction: Vector2 = (route[index + 1] - route[index]).normalized()
		var side: Vector2 = Vector2(-direction.y, direction.x)
		var width_a: float = widths[index] + sin(float(index) * 1.71) * 0.14
		var width_b: float = widths[index + 1] + sin(float(index + 1) * 1.71) * 0.14
		var a_left: Vector2 = route[index] - side * width_a
		var a_right: Vector2 = route[index] + side * (width_a * 0.88)
		var b_left: Vector2 = route[index + 1] - side * width_b
		var b_right: Vector2 = route[index + 1] + side * (width_b * 0.88)
		var vertices: Array[Vector2] = [a_left, b_left, a_right, a_right, b_left, b_right]
		for point: Vector2 in vertices:
			surface.set_uv(Vector2(point.x * 0.17, point.y * 0.17))
			surface.add_vertex(Vector3(point.x, _ground_height(point.x, point.y) + 0.018, point.y))
	surface.generate_normals()
	var road_mesh: ArrayMesh = surface.commit()
	road_mesh.surface_set_material(0, road_material)
	var road: MeshInstance3D = MeshInstance3D.new()
	road.name = "EstradaDeLamaConformada"
	road.mesh = road_mesh
	road.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(road)

func _build_real_forest_frame() -> void:
	# Coníferas recuadas usam uma silhueta húmida mais escura, mantendo folhosas reais apenas nas margens do vale.
	var pine_silhouette_material: StandardMaterial3D = _material(Color(0.045, 0.075, 0.050, 1.0), 0.86, 0.0)
	# As duas folhosas da margem recebem apenas uma tonalidade atmosférica, distinta das coníferas quase pretas.
	var broadleaf_atmosphere_material: StandardMaterial3D = _material(Color(0.068, 0.098, 0.072, 1.0), 0.90, 0.0)
	var forest_positions: Array[Vector2] = [Vector2(-15.0, -8.0), Vector2(-8.0, -15.0), Vector2(-4.0, -13.0), Vector2(1.0, -10.0), Vector2(-3.5, -21.0), Vector2(8.0, -18.0)]
	for index: int in range(forest_positions.size()):
		var tree_asset: PackedScene = EZ_PINE_TALL_CANDIDATE if index == 0 or index == 3 else EZ_PINE_CANDIDATE if index == 1 or index == 2 else HERO_TREE
		var tree: Node3D = tree_asset.instantiate() as Node3D
		if tree == null:
			continue
		tree.name = "ArvoreCC0PlanoMedio_%02d" % index
		var tree_x: float = forest_positions[index].x
		var tree_z: float = forest_positions[index].y
		tree.position = Vector3(tree_x, _ground_height(tree_x, tree_z), tree_z)
		var tree_scale: float = 0.22 if index == 0 else 0.19 if index == 1 else 0.17 if index == 2 else 0.21 if index == 3 else 1.08 + float(index) * 0.14
		tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
		tree.rotation.y = 0.42 + float(index) * 1.26
		if index <= 3:
			_tint_tree_silhouette(tree, pine_silhouette_material)
		else:
			_tint_tree_silhouette(tree, broadleaf_atmosphere_material)
		add_child(tree)

func _build_ez_pine_depth_candidate() -> void:
	# Três coníferas escalonadas: troncos reais e intervalos irregulares, aprovados sem muralha vegetal.
	var pine_silhouette_material: StandardMaterial3D = _material(Color(0.045, 0.075, 0.050, 1.0), 0.86, 0.0)
	var pine_data: Array[Dictionary] = [
		{"pos": Vector2(-11.2, -17.4), "scale": 0.25, "yaw": -0.54},
		{"pos": Vector2(-5.6, -24.6), "scale": 0.22, "yaw": 0.62},
		{"pos": Vector2(-15.6, -27.8), "scale": 0.20, "yaw": -1.14},
		# Duas silhuetas projetadas no intervalo entre a Casa Voss e Orion, à esquerda do pico.
		{"pos": Vector2(-23.0, -7.0), "scale": 0.23, "yaw": 0.31},
		{"pos": Vector2(-25.0, -12.0), "scale": 0.19, "yaw": -0.81},
		# Grupo de fundo irregular: preenche a base de Orion sem alinhar as árvores como uma parede.
		{"pos": Vector2(-18.6, -21.0), "scale": 0.18, "yaw": 1.18},
		{"pos": Vector2(-13.0, -23.0), "scale": 0.16, "yaw": -0.28},
		{"pos": Vector2(-7.5, -20.0), "scale": 0.17, "yaw": 0.91},
	]
	for index: int in range(pine_data.size()):
		var pine_asset: PackedScene = EZ_PINE_TALL_CANDIDATE if index == 0 or index == 3 or index == 5 else EZ_PINE_CANDIDATE
		var pine: Node3D = pine_asset.instantiate() as Node3D
		if pine == null:
			continue
		var data: Dictionary = pine_data[index]
		var position_2d: Vector2 = data["pos"] as Vector2
		var scale_value: float = data["scale"] as float
		pine.name = "ConiferaEZTreePlanoMedio_%02d" % index
		pine.position = Vector3(position_2d.x, _ground_height(position_2d.x, position_2d.y), position_2d.y)
		pine.scale = Vector3(scale_value, scale_value, scale_value)
		pine.rotation.y = data["yaw"] as float
		_tint_tree_silhouette(pine, pine_silhouette_material)
		add_child(pine)

func _build_sectorized_mid_forest() -> void:
	# Dois sectores compactos de árvores reais. O MultiMesh reduz draw calls, enquanto sectores separados preservam culling espacial.
	var source_root: Node3D = HERO_TREE.instantiate() as Node3D
	if source_root == null:
		return
	var source_mesh_node: MeshInstance3D = source_root.get_node_or_null("island_tree_01_LOD0") as MeshInstance3D
	if source_mesh_node == null or source_mesh_node.mesh == null:
		source_root.queue_free()
		return
	var tree_mesh: Mesh = source_mesh_node.mesh
	var sectors: Array[Dictionary] = [
		{
			"name": "BosqueSectorOeste",
			"items": [
				{"position": Vector3(-20.0, _ground_height(-20.0, -27.0), -27.0), "scale": 0.54, "yaw": 0.22},
				{"position": Vector3(-14.0, _ground_height(-14.0, -33.0), -33.0), "scale": 0.48, "yaw": 1.18},
				{"position": Vector3(-9.0, _ground_height(-9.0, -28.0), -28.0), "scale": 0.57, "yaw": 2.05},
				{"position": Vector3(-5.0, _ground_height(-5.0, -37.0), -37.0), "scale": 0.46, "yaw": 2.82}
			],
			"aabb": AABB(Vector3(-25.0, -2.0, -43.0), Vector3(25.0, 18.0, 23.0))
		},
		{
			"name": "BosqueSectorEste",
			"items": [
				{"position": Vector3(3.0, _ground_height(3.0, -27.0), -27.0), "scale": 0.52, "yaw": 0.74},
				{"position": Vector3(9.0, _ground_height(9.0, -33.0), -33.0), "scale": 0.45, "yaw": 1.66},
				{"position": Vector3(15.0, _ground_height(15.0, -28.0), -28.0), "scale": 0.56, "yaw": 2.46},
				{"position": Vector3(20.0, _ground_height(20.0, -36.0), -36.0), "scale": 0.43, "yaw": 3.08}
			],
			"aabb": AABB(Vector3(-2.0, -2.0, -42.0), Vector3(29.0, 18.0, 22.0))
		}
	]
	for sector_data: Dictionary in sectors:
		var forest_sector: ForestSector3D = FOREST_SECTOR_SCRIPT.new() as ForestSector3D
		if forest_sector == null:
			continue
		forest_sector.name = sector_data["name"] as String
		add_child(forest_sector)
		forest_sector.build_sector(
			sector_data["name"] as String,
			tree_mesh,
			sector_data["items"] as Array[Dictionary],
			sector_data["aabb"] as AABB,
			false
		)
	source_root.queue_free()

func _build_real_fern_frame() -> void:
	# Vegetação rasteira CC0 em poucos grupos: acrescenta parallax e detalhe orgânico sem fechar a rota do jogador.
	var fern_positions: Array[Vector2] = [Vector2(-19.0, 9.3), Vector2(-17.2, 12.4), Vector2(-14.6, 15.8), Vector2(-9.3, 17.6), Vector2(-4.8, 14.1)]
	for index: int in range(fern_positions.size()):
		var fern: Node3D = FERN_REAL_ASSET.instantiate() as Node3D
		if fern == null:
			continue
		fern.name = "FetoCC0Margem_%02d" % index
		var fern_x: float = fern_positions[index].x
		var fern_z: float = fern_positions[index].y
		fern.position = Vector3(fern_x, _ground_height(fern_x, fern_z) + 0.015, fern_z)
		var fern_scale: float = 0.38 + float(index % 3) * 0.07
		fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
		fern.rotation.y = 0.31 + float(index) * 1.19
		add_child(fern)

func _build_forest_ground_integration_92(house: Node3D) -> void:
	# Ramificação controlada: duas margens de floresta real, centro livre para Casa Voss, percurso e Orion.
	var source_root: Node3D = HERO_TREE.instantiate() as Node3D
	if source_root != null:
		var source_mesh_node: MeshInstance3D = source_root.get_node_or_null("island_tree_01_LOD0") as MeshInstance3D
		if source_mesh_node != null and source_mesh_node.mesh != null:
			var sectors: Array[Dictionary] = [
				{
					"name": "Integration92_BosqueOeste",
					"items": [
						{"position": Vector3(-26.0, _ground_height(-26.0, -14.0), -14.0), "scale": 0.38, "yaw": 0.22},
						{"position": Vector3(-34.0, _ground_height(-34.0, -24.0), -24.0), "scale": 0.32, "yaw": 1.16},
						{"position": Vector3(-42.0, _ground_height(-42.0, -31.0), -31.0), "scale": 0.28, "yaw": 2.05}
					],
					"aabb": AABB(Vector3(-48.0, -2.0, -38.0), Vector3(28.0, 22.0, 31.0))
				},
				{
					"name": "Integration92_BosqueEste",
					"items": [
						{"position": Vector3(-2.0, _ground_height(-2.0, -14.0), -14.0), "scale": 0.36, "yaw": 0.74},
						{"position": Vector3(5.5, _ground_height(5.5, -23.0), -23.0), "scale": 0.30, "yaw": 1.66},
						{"position": Vector3(12.0, _ground_height(12.0, -31.0), -31.0), "scale": 0.27, "yaw": 2.46}
					],
					"aabb": AABB(Vector3(-7.0, -2.0, -38.0), Vector3(25.0, 22.0, 31.0))
				}
			]
			for sector_data: Dictionary in sectors:
				var forest_sector: ForestSector3D = FOREST_SECTOR_SCRIPT.new() as ForestSector3D
				if forest_sector == null:
					continue
				forest_sector.name = sector_data["name"] as String
				# Setores ficam no espaço mundial do vale; as instâncias não herdam a rotação da Casa Voss.
				add_child(forest_sector)
				forest_sector.build_sector(
					sector_data["name"] as String,
					source_mesh_node.mesh,
					sector_data["items"] as Array[Dictionary],
					sector_data["aabb"] as AABB,
					false
				)
		source_root.queue_free()

	# Quatro árvores PBR focais nas margens, em escalas diferentes, dão troncos e copa à leitura da floresta sem fechar o vale.
	var hero_margin_trees: Array[Dictionary] = [
		{"position": Vector2(-30.0, -10.0), "scale": 0.42, "yaw": -0.32},
		{"position": Vector2(-18.0, -20.0), "scale": 0.31, "yaw": 0.88},
		{"position": Vector2(-1.5, -15.0), "scale": 0.38, "yaw": -1.08},
		{"position": Vector2(9.0, -24.0), "scale": 0.29, "yaw": 1.66}
	]
	for index: int in range(hero_margin_trees.size()):
		var hero_tree: Node3D = HERO_TREE.instantiate() as Node3D
		if hero_tree == null:
			continue
		var hero_data: Dictionary = hero_margin_trees[index]
		var hero_point: Vector2 = hero_data["position"] as Vector2
		hero_tree.name = "Integration92_ArvorePBRMargem_%02d" % index
		hero_tree.position = Vector3(hero_point.x, _ground_height(hero_point.x, hero_point.y), hero_point.y)
		var hero_scale: float = hero_data["scale"] as float
		hero_tree.scale = Vector3(hero_scale, hero_scale, hero_scale)
		hero_tree.rotation.y = hero_data["yaw"] as float
		add_child(hero_tree)

	# Camada de coníferas intermédia: escalas e espaçamentos irregulares densificam o vale, mas deixam corredores de leitura até Orion.
	var pine_silhouette_material: StandardMaterial3D = _material(Color(0.045, 0.075, 0.050, 1.0), 0.86, 0.0)
	var middle_pines: Array[Dictionary] = [
		{"position": Vector2(-21.0, -16.0), "scale": 0.22, "yaw": 0.18},
		{"position": Vector2(-16.5, -23.0), "scale": 0.19, "yaw": 1.11},
		{"position": Vector2(-8.5, -20.0), "scale": 0.24, "yaw": 2.06},
		{"position": Vector2(-2.5, -25.5), "scale": 0.18, "yaw": 0.70},
		{"position": Vector2(3.5, -18.0), "scale": 0.20, "yaw": 1.82},
		{"position": Vector2(8.5, -27.5), "scale": 0.17, "yaw": 2.72}
	]
	for index: int in range(middle_pines.size()):
		var pine_asset: PackedScene = EZ_PINE_TALL_CANDIDATE if index % 2 == 0 else EZ_PINE_CANDIDATE
		var pine: Node3D = pine_asset.instantiate() as Node3D
		if pine == null:
			continue
		var pine_data: Dictionary = middle_pines[index]
		var pine_point: Vector2 = pine_data["position"] as Vector2
		pine.name = "Integration92_ConiferaIntermedia_%02d" % index
		pine.position = Vector3(pine_point.x, _ground_height(pine_point.x, pine_point.y), pine_point.y)
		var pine_scale: float = pine_data["scale"] as float
		pine.scale = Vector3(pine_scale, pine_scale, pine_scale)
		pine.rotation.y = pine_data["yaw"] as float
		_tint_tree_silhouette(pine, pine_silhouette_material)
		add_child(pine)

	# Fetos e pequenos detritos seguem o relevo e permanecem fora do corredor central de saída (|x| < 2.6).
	var border_ferns: Array[Dictionary] = [
		{"position": Vector2(-3.20, -6.3), "scale": 0.30, "yaw": 0.28},
		{"position": Vector2(3.35, -7.5), "scale": 0.34, "yaw": 1.06},
		{"position": Vector2(-3.75, -11.0), "scale": 0.28, "yaw": 2.14},
		{"position": Vector2(3.85, -12.7), "scale": 0.37, "yaw": 0.62},
		{"position": Vector2(-4.20, -16.2), "scale": 0.32, "yaw": 1.70},
		{"position": Vector2(4.25, -18.0), "scale": 0.29, "yaw": 2.74}
	]
	for index: int in range(border_ferns.size()):
		var fern: Node3D = FERN_REAL_ASSET.instantiate() as Node3D
		if fern == null:
			continue
		var fern_data: Dictionary = border_ferns[index]
		var fern_point: Vector2 = fern_data["position"] as Vector2
		fern.name = "Integration92_FetoDeMargem_%02d" % index
		fern.position = Vector3(fern_point.x, _house_ground_y(house, fern_point.x, fern_point.y) + 0.018, fern_point.y)
		var fern_scale: float = fern_data["scale"] as float
		fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
		fern.rotation.y = fern_data["yaw"] as float
		house.add_child(fern)

	var edge_debris: Array[Dictionary] = [
		{"position": Vector2(-3.65, -5.6), "scale": 0.24, "yaw": 0.31},
		{"position": Vector2(3.85, -9.4), "scale": 0.19, "yaw": 1.18},
		{"position": Vector2(-4.30, -13.6), "scale": 0.28, "yaw": 2.22},
		{"position": Vector2(4.50, -16.4), "scale": 0.22, "yaw": 0.88},
		{"position": Vector2(-5.10, -20.4), "scale": 0.30, "yaw": 2.92}
	]
	for index: int in range(edge_debris.size()):
		var debris: Node3D = MOSS_ROCK_SET.instantiate() as Node3D
		if debris == null:
			continue
		var debris_data: Dictionary = edge_debris[index]
		var debris_point: Vector2 = debris_data["position"] as Vector2
		debris.name = "Integration92_DetritoDeSolo_%02d" % index
		debris.position = Vector3(debris_point.x, _house_ground_y(house, debris_point.x, debris_point.y) + 0.035, debris_point.y)
		var debris_scale: float = debris_data["scale"] as float
		debris.scale = Vector3(debris_scale, debris_scale, debris_scale)
		debris.rotation.y = debris_data["yaw"] as float
		house.add_child(debris)

func _house_ground_y(house: Node3D, local_x: float, local_z: float) -> float:
	var sample_position: Vector3 = house.to_global(Vector3(local_x, 0.0, local_z))
	return _ground_height(sample_position.x, sample_position.z) - house.global_position.y

func _input(event: InputEvent) -> void:
	# O salto é associado diretamente à tecla física E e mantém a ação interact como alternativa para comandos remapeados.
	if not opening_active:
		return
	var is_skip_key: bool = event.is_action("interact")
	if event is InputEventKey:
		var key_event: InputEventKey = event as InputEventKey
		is_skip_key = is_skip_key or key_event.keycode == KEY_E or key_event.physical_keycode == KEY_E
	if not is_skip_key:
		return
	var is_holding: bool = event.is_pressed()
	if is_holding and not opening_skip_key_held:
		opening_skip_key_held = true
		if opening_skip_timer != null:
			opening_skip_timer.start()
	elif not is_holding and opening_skip_key_held:
		opening_skip_key_held = false
		if opening_skip_timer != null:
			opening_skip_timer.stop()
	_update_opening_skip_prompt()

func _process(_delta: float) -> void:
	if opening_active:
		# Salvaguarda contínua: o estado físico de E é lido a cada frame para que o salto não dependa de um evento perdido durante o carregamento regional.
		var physical_skip_held: bool = Input.is_key_pressed(KEY_E) or Input.is_action_pressed("interact")
		if physical_skip_held and not opening_skip_key_held:
			opening_skip_key_held = true
			if opening_skip_timer != null:
				opening_skip_timer.start()
		elif not physical_skip_held and opening_skip_key_held:
			opening_skip_key_held = false
			if opening_skip_timer != null:
				opening_skip_timer.stop()
		_update_opening_skip_prompt()
		return
	# Salvaguarda de gameplay: perto da entrada, E abre a porta mesmo se o raycast estiver a tocar numa moldura em vez do gatilho.
	if not front_door_open and Input.is_action_just_pressed("interact"):
		_try_open_front_door_by_proximity()

func _complete_opening_skip() -> void:
	if opening_active and opening_skip_key_held:
		opening_was_skipped = true
		_finish_opening_camera()

func _complete_opening_for_qa() -> void:
	if not opening_active:
		return
	opening_was_skipped = true
	_finish_opening_camera()

func _create_opening_skip_prompt() -> void:
	if not opening_active:
		return
	opening_skip_layer = CanvasLayer.new()
	opening_skip_layer.name = "UI_SaltarPrologo"
	opening_skip_layer.layer = 8
	var panel: ColorRect = ColorRect.new()
	panel.color = Color(0.015, 0.022, 0.035, 0.72)
	panel.position = Vector2(392.0, 646.0)
	panel.size = Vector2(496.0, 56.0)
	opening_skip_layer.add_child(panel)
	opening_skip_label = Label.new()
	opening_skip_label.name = "TextoSaltarPrologo"
	opening_skip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	opening_skip_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	opening_skip_label.position = Vector2(404.0, 651.0)
	opening_skip_label.size = Vector2(472.0, 46.0)
	opening_skip_label.add_theme_font_size_override("font_size", 18)
	opening_skip_label.add_theme_color_override("font_color", Color(0.86, 0.91, 0.96, 1.0))
	opening_skip_layer.add_child(opening_skip_label)
	get_tree().current_scene.add_child(opening_skip_layer)
	_update_opening_skip_prompt()

func _update_opening_skip_prompt() -> void:
	if opening_skip_label == null:
		return
	var progress: int = 0
	if opening_skip_key_held and opening_skip_timer != null:
		opening_skip_hold_time = OPENING_SKIP_HOLD_SECONDS - opening_skip_timer.time_left
		progress = clampi(roundi((opening_skip_hold_time / OPENING_SKIP_HOLD_SECONDS) * 100.0), 0, 100)
	else:
		opening_skip_hold_time = 0.0
	if opening_skip_key_held:
		opening_skip_label.text = "A saltar prólogo... %d%%" % progress
	else:
		opening_skip_label.text = "Mantenha [E] para saltar o prólogo"

func _try_open_front_door_by_proximity() -> void:
	var house: Node3D = get_node_or_null("CasaVoss") as Node3D
	var elias: Node3D = get_tree().get_first_node_in_group("player") as Node3D
	if house == null or elias == null:
		return
	var threshold: Vector3 = house.to_global(Vector3(0.0, 1.20, -3.38))
	if elias.global_position.distance_to(threshold) <= 3.75:
		if open_front_door():
			EventBus.player_message_requested.emit("Porta da Casa Voss aberta. O caminho para o exterior está livre.", 2.6)

func open_front_door() -> bool:
	if front_door_open:
		return false
	var house: Node3D = get_node_or_null("CasaVoss") as Node3D
	if house == null:
		return false
	front_door_open = true

	var left_panel: Node3D = house.get_node_or_null("PortaVossEsquerda") as Node3D
	var right_panel: Node3D = house.get_node_or_null("PortaVossDireita") as Node3D
	# Os três corpos abaixo eram as únicas colisões do vão: desativam-se no mesmo frame e são removidos da cena.
	for collision_name: String in ["PortaVossEsquerda_Colisao", "PortaVossDireita_Colisao", "VossFrontDoor"]:
		var collision_body: StaticBody3D = house.get_node_or_null(collision_name) as StaticBody3D
		if collision_body == null:
			continue
		collision_body.collision_layer = 0
		collision_body.collision_mask = 0
		for child: Node in collision_body.get_children():
			if child is CollisionShape3D:
				(child as CollisionShape3D).set_deferred("disabled", true)
		collision_body.queue_free()

	var door_tween: Tween = create_tween().set_parallel(true)
	if left_panel != null:
		door_tween.tween_property(left_panel, "position:x", -2.45, 0.62).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		door_tween.tween_property(left_panel, "rotation:y", deg_to_rad(-24.0), 0.62).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	if right_panel != null:
		door_tween.tween_property(right_panel, "position:x", 2.45, 0.62).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		door_tween.tween_property(right_panel, "rotation:y", deg_to_rad(24.0), 0.62).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	return true

func _build_opening_landscape(house: Node3D) -> void:
	# Moldura física: copas reais cortam o céu e rochas criam a transição para a estrada da serra.
	var tree_left: Node3D = HERO_TREE.instantiate() as Node3D
	if tree_left != null:
		tree_left.name = "SobreiroDeTomas"
		var left_world_x: float = HOUSE_ORIGIN.x - (-23.0)
		var left_world_z: float = HOUSE_ORIGIN.z - 1.0
		tree_left.position = Vector3(-23.0, _ground_height(left_world_x, left_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z), 1.0)
		tree_left.scale = Vector3(1.20, 1.20, 1.20)
		tree_left.rotation.y = -0.42
		house.add_child(tree_left)
	var tree_right: Node3D = null
	if not DAYLIGHT_VARIANT_ENABLED:
		tree_right = HERO_TREE.instantiate() as Node3D
	if tree_right != null:
		tree_right.name = "ArvoreDaEstrada"
		# Recuada para enquadrar a borda do cenário, sem atravessar o centro da composição.
		var right_world_x: float = HOUSE_ORIGIN.x - 27.0
		var right_world_z: float = HOUSE_ORIGIN.z - 15.0
		tree_right.position = Vector3(27.0, _ground_height(right_world_x, right_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z), 15.0)
		tree_right.scale = Vector3(1.18, 1.18, 1.18)
		tree_right.rotation.y = 0.72
		house.add_child(tree_right)
	for index: int in range(3):
		var rock: Node3D = MOSS_ROCK_SET.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "RochaDaEstrada_%02d" % index
		rock.position = Vector3(-6.0 + float(index) * 5.6, 0.12, -8.0 - float(index) * 2.0)
		rock.scale = Vector3(0.34 + 0.05 * float(index), 0.34 + 0.05 * float(index), 0.34 + 0.05 * float(index))
		rock.rotation.y = float(index) * 1.14
		house.add_child(rock)

func _build_cinematic_exterior_depth(house: Node3D) -> void:
	# Estrada de terra húmida: oferece um percurso legível desde a casa até às ruínas e à serra.
	var wet_ground: StandardMaterial3D = _material(Color(0.12, 0.105, 0.075, 1.0), 0.24, 0.05)
	wet_ground.albedo_texture = FOREST_GROUND_DIFF
	wet_ground.normal_enabled = true
	wet_ground.normal_texture = FOREST_GROUND_NORMAL
	wet_ground.normal_scale = 0.42
	wet_ground.roughness_texture = FOREST_GROUND_ROUGH
	wet_ground.uv1_scale = Vector3(0.34, 0.34, 0.34)
	for index: int in range(0 if DAYLIGHT_VARIANT_ENABLED else 8):
		var road_piece: MeshInstance3D = MeshInstance3D.new()
		road_piece.name = "EstradaHumida_%02d" % index
		var road_mesh: BoxMesh = BoxMesh.new()
		road_mesh.size = Vector3(4.45 - float(index) * 0.17, 0.060, 3.80)
		road_mesh.material = wet_ground
		road_piece.mesh = road_mesh
		var curve_x: float = 2.25 * sin(float(index) * 0.57)
		road_piece.position = Vector3(curve_x, 0.10, -5.60 - float(index) * 3.15)
		road_piece.rotation.y = sin(float(index) * 0.48) * 0.20
		house.add_child(road_piece)

	# Camadas florestais, rochas e ruínas: evitam a leitura de cenário plano e orientam o olhar para a serra.
	var pine_positions: Array[Vector2] = [
		Vector2(-19.0, 12.5), Vector2(-15.0, 7.5), Vector2(-11.0, 15.0),
		Vector2(-5.0, 10.0), Vector2(0.0, 16.0), Vector2(7.0, 8.5),
		Vector2(12.0, 15.0), Vector2(17.0, 11.5), Vector2(22.0, 17.0),
		Vector2(25.0, 9.0), Vector2(30.0, 14.5),
		Vector2(-22.0, 22.0), Vector2(-14.0, 24.0), Vector2(-7.0, 21.0),
		Vector2(3.0, 25.0), Vector2(10.0, 22.0), Vector2(17.0, 26.0),
		# Agrupamentos periféricos: reforçam o vale sem fechar a rota visual para Orion.
		Vector2(-30.0, 9.0), Vector2(-27.0, 14.5), Vector2(-24.0, 19.0),
		Vector2(-20.0, 28.5), Vector2(-15.0, 31.0), Vector2(-10.0, 27.0),
		Vector2(12.0, 29.0), Vector2(18.0, 32.0), Vector2(23.5, 28.0),
		Vector2(29.0, 33.0), Vector2(34.0, 29.5), Vector2(39.0, 25.5),
		# Pequenos núcleos periféricos: aumentam a profundidade do bosque, preservando a abertura para a serra e a estrada.
		Vector2(-34.0, 23.5), Vector2(-30.5, 30.5), Vector2(31.5, 19.5), Vector2(36.5, 17.0), Vector2(41.0, 30.0)
	]
	# Os pinheiros GLB recuperados tinham silhueta excessivamente estilizada; a densidade vem das árvores CC0 focais abaixo.
	for index: int in range(0):
		var tree: Node3D = PINE_LOD_ASSET.instantiate() as Node3D
		if tree == null:
			continue
		tree.name = "ArvoreDeProfundidade_%02d" % index
		var tree_x: float = pine_positions[index].x
		var tree_z: float = pine_positions[index].y
		# O nó CasaVoss roda 180°: convertem-se as coordenadas locais para amostrar o relevo mundial antes de o aterrar.
		var tree_world_x: float = HOUSE_ORIGIN.x - tree_x
		var tree_world_z: float = HOUSE_ORIGIN.z - tree_z
		var tree_y: float = _ground_height(tree_world_x, tree_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z)
		tree.position = Vector3(tree_x, tree_y, tree_z)
		# A malha GLB mede cerca de 1,3 unidades na vertical; esta escala cria grupos de 7–9 m no plano médio.
		var tree_scale: float = 6.35 + fmod(float(index), 3.0) * 0.78
		if index >= 11:
			tree_scale = 4.90 + fmod(float(index), 3.0) * 0.55
		tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
		tree.rotation.y = float(index) * 0.79
		# Coníferas CC0 decimadas: troncos e copas reais em grupos irregulares, sem uma parede vegetal.
		house.add_child(tree)

	var broadleaf_positions: Array[Vector2] = [Vector2(-9.0, 17.0), Vector2(4.0, 23.0), Vector2(20.0, 18.0)]
	# Copas low-poly desativadas no prólogo; a leitura vegetal é resolvida por árvores CC0 de tronco e folhagem reais.
	for index: int in range(0):
		var broadleaf: Node3D = DARK_TREE_ASSET.instantiate() as Node3D
		if broadleaf == null:
			continue
		broadleaf.name = "CopaEscuraDeProfundidade_%02d" % index
		var broadleaf_x: float = broadleaf_positions[index].x
		var broadleaf_z: float = broadleaf_positions[index].y
		var broadleaf_world_x: float = HOUSE_ORIGIN.x - broadleaf_x
		var broadleaf_world_z: float = HOUSE_ORIGIN.z - broadleaf_z
		broadleaf.position = Vector3(broadleaf_x, _ground_height(broadleaf_world_x, broadleaf_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z), broadleaf_z)
		var broadleaf_scale: float = 0.68 + float(index) * 0.14
		broadleaf.scale = Vector3(broadleaf_scale, broadleaf_scale, broadleaf_scale)
		broadleaf.rotation.y = 0.36 + float(index) * 1.18
		house.add_child(broadleaf)

	# Copas PBR amplas quebram a repetição das coníferas nos vazios laterais, sem fechar a vista da estrada.
	var canopy_positions: Array[Vector2] = [Vector2(-18.0, 15.0), Vector2(2.0, 17.0), Vector2(15.0, 24.0), Vector2(-25.0, 23.0), Vector2(27.0, 27.0), Vector2(-7.0, 29.0), Vector2(10.0, 32.0), Vector2(25.0, 35.0)]
	for index: int in range(0 if DAYLIGHT_VARIANT_ENABLED else canopy_positions.size()):
		var canopy_tree: Node3D = HERO_TREE.instantiate() as Node3D
		if canopy_tree == null:
			continue
		canopy_tree.name = "ArvorePBRDeProfundidade_%02d" % index
		var canopy_x: float = canopy_positions[index].x
		var canopy_z: float = canopy_positions[index].y
		var canopy_world_x: float = HOUSE_ORIGIN.x - canopy_x
		var canopy_world_z: float = HOUSE_ORIGIN.z - canopy_z
		canopy_tree.position = Vector3(canopy_x, _ground_height(canopy_world_x, canopy_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z), canopy_z)
		var canopy_scale: float = 0.66 + fmod(float(index), 3.0) * 0.12
		canopy_tree.scale = Vector3(canopy_scale, canopy_scale, canopy_scale)
		canopy_tree.rotation.y = float(index) * 0.94
		house.add_child(canopy_tree)
		
	# Ruínas próximas pertencem somente à variante nocturna; o vale diurno começa por natureza, caminho e água.
	for index: int in range(0 if DAYLIGHT_VARIANT_ENABLED else 4):
		var pillar: Node3D = RUIN_PILLAR_ASSET.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "RuinaDistante_%02d" % index
		var ruin_x: float = -2.0 + float(index) * 4.8
		var ruin_z: float = 23.0 + fmod(float(index), 2.0) * 3.2
		var ruin_world_x: float = HOUSE_ORIGIN.x - ruin_x
		var ruin_world_z: float = HOUSE_ORIGIN.z - ruin_z
		var ruin_y: float = _ground_height(ruin_world_x, ruin_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z)
		pillar.position = Vector3(ruin_x, ruin_y, ruin_z)
		pillar.scale = Vector3(1.72, 1.72 + fmod(float(index), 2.0) * 0.44, 1.72)
		pillar.rotation.y = float(index) * 0.35
		house.add_child(pillar)
	var ruin_wall: Node3D = null
	if not DAYLIGHT_VARIANT_ENABLED:
		ruin_wall = RUIN_WALL_ASSET.instantiate() as Node3D
	if ruin_wall != null:
		ruin_wall.name = "MuroDaRuinaDistante"
		var wall_world_x: float = HOUSE_ORIGIN.x - 11.5
		var wall_world_z: float = HOUSE_ORIGIN.z - 28.5
		ruin_wall.position = Vector3(11.5, _ground_height(wall_world_x, wall_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z), 28.5)
		ruin_wall.scale = Vector3(1.75, 1.75, 1.75)
		ruin_wall.rotation.y = -0.62
		house.add_child(ruin_wall)
	# Marco quebrado próximo fica guardado para a variante nocturna; as ruínas diurnas passam para o horizonte.
	var visible_ruin: Node3D = null
	if not DAYLIGHT_VARIANT_ENABLED:
		visible_ruin = RUIN_PILLAR_ASSET.instantiate() as Node3D
	if visible_ruin != null:
		visible_ruin.name = "RuinaVisivelDoVale"
		var visible_ruin_x: float = -15.0
		var visible_ruin_z: float = 18.5
		var visible_world_x: float = HOUSE_ORIGIN.x - visible_ruin_x
		var visible_world_z: float = HOUSE_ORIGIN.z - visible_ruin_z
		visible_ruin.position = Vector3(visible_ruin_x, _ground_height(visible_world_x, visible_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z), visible_ruin_z)
		visible_ruin.scale = Vector3(1.62, 2.14, 1.62)
		visible_ruin.rotation.y = -0.24
		house.add_child(visible_ruin)
	for index: int in range(5):

		var rock: Node3D = MOSS_ROCK_SET.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "RochaDePrimeiroPlano_%02d" % index
		var rock_x: float = -12.0 + float(index) * 6.0
		var rock_z: float = -17.0 + fmod(float(index), 2.0) * 1.7
		var rock_world_x: float = HOUSE_ORIGIN.x - rock_x
		var rock_world_z: float = HOUSE_ORIGIN.z - rock_z
		rock.position = Vector3(rock_x, _ground_height(rock_world_x, rock_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z) + 0.06, rock_z)
		var rock_scale: float = 0.34 + fmod(float(index), 3.0) * 0.10
		rock.scale = Vector3(rock_scale, rock_scale, rock_scale)
		rock.rotation.y = float(index) * 0.61
		house.add_child(rock)
	# Afloramentos de primeiro plano: molduram a margem direita do vale com geometria PBR real.
	for index: int in range(3):
		var foreground_rock: Node3D = MOSS_ROCK_SET.instantiate() as Node3D
		if foreground_rock == null:
			continue
		foreground_rock.name = "AfloramentoDireito_%02d" % index
		var outcrop_x: float = 16.0 + float(index) * 4.6
		var outcrop_z: float = 18.0 + float(index) * 3.3
		var outcrop_world_x: float = HOUSE_ORIGIN.x - outcrop_x
		var outcrop_world_z: float = HOUSE_ORIGIN.z - outcrop_z
		foreground_rock.position = Vector3(outcrop_x, _ground_height(outcrop_world_x, outcrop_world_z) - _ground_height(HOUSE_ORIGIN.x, HOUSE_ORIGIN.z) + 0.10, outcrop_z)
		var foreground_scale: float = 0.78 + float(index) * 0.18
		foreground_rock.scale = Vector3(foreground_scale, foreground_scale, foreground_scale)
		foreground_rock.rotation.y = 0.45 + float(index) * 0.73
		house.add_child(foreground_rock)
	if not DAYLIGHT_VARIANT_ENABLED:
		_build_rain_and_puddles(house)

func _build_rain_and_puddles(house: Node3D) -> void:
	# Chuva leve de prólogo: elementos discretos e baratos, apenas para a leitura de tempestade.
	var rain_material: StandardMaterial3D = _material(Color(0.36, 0.44, 0.54, 0.11), 0.18, 0.0)
	rain_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	rain_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	for index: int in range(54):
		var streak: MeshInstance3D = MeshInstance3D.new()
		streak.name = "Chuva_%02d" % index
		var streak_mesh: BoxMesh = BoxMesh.new()
		streak_mesh.size = Vector3(0.009, 0.48 + fmod(float(index), 4.0) * 0.10, 0.009)
		streak_mesh.material = rain_material
		streak.mesh = streak_mesh
		streak.position = Vector3(-12.0 + fmod(float(index) * 3.7, 24.0), 2.0 + fmod(float(index) * 2.9, 8.0), -10.0 + fmod(float(index) * 4.3, 28.0))
		streak.rotation.z = deg_to_rad(9.0)
		house.add_child(streak)
	var puddle_material: StandardMaterial3D = _material(Color(0.035, 0.075, 0.10, 1.0), 0.12, 0.46)
	# As poças mais próximas entravam no canto inferior da lente; mantêm-se apenas as do plano médio.
	for index: int in range(2, 6):
		var puddle: MeshInstance3D = MeshInstance3D.new()
		puddle.name = "PocaDaEstrada_%02d" % index
		var puddle_mesh: CylinderMesh = CylinderMesh.new()
		puddle_mesh.top_radius = 0.72 + fmod(float(index), 2.0) * 0.24
		puddle_mesh.bottom_radius = puddle_mesh.top_radius
		puddle_mesh.height = 0.012
		puddle_mesh.radial_segments = 16
		puddle_mesh.material = puddle_material
		puddle.mesh = puddle_mesh
		puddle.position = Vector3(-1.25 + sin(float(index) * 1.5) * 0.62, 0.13, -6.2 - float(index) * 2.65)
		puddle.scale = Vector3(1.65, 1.0, 0.58)
		house.add_child(puddle)

func _tint_tree_silhouette(tree: Node3D, material: StandardMaterial3D) -> void:
	for child: Node in tree.find_children("*", "MeshInstance3D", true, false):
		var mesh_node: MeshInstance3D = child as MeshInstance3D
		if mesh_node != null:
			mesh_node.material_override = material

func _build_opening_camera() -> void:
	# Prólogo breve: apresenta a Casa Voss diante da serra antes de Elias recuperar o controlo no interior.
	opening_camera = Camera3D.new()
	opening_camera.name = "CameraPrologoCasaVoss"
	opening_camera.current = false
	opening_camera.fov = 52.0
	add_child(opening_camera)
	# Os modos de QA ignoram apenas o prólogo para permitir testar takes e travessias físicas; o fluxo normal do jogo permanece inalterado.
	if OS.has_environment("ORIGEM_CAPTURE_TAKE") or OS.has_environment("ORIGEM_QA_ROUTE") or OS.has_environment("ORIGEM_QA_INTERACT"):
		opening_camera.queue_free()
		opening_camera = null
		opening_active = false
		return
	# Variante diurna: câmara mais alta e ligeiramente à direita, deixando Casa Voss à esquerda, lajes ao centro e rio à direita.
	if DAYLIGHT_VARIANT_ENABLED:
		# A abertura mostra o percurso que Elias realmente seguirá: Casa Voss à esquerda, rio à direita e Arco das Ruínas no plano médio.
		opening_camera.fov = 51.0
		opening_camera.position = Vector3(-34.0, 5.2, 4.0)
		opening_camera.look_at(Vector3(-10.0, 1.5, 43.0), Vector3.UP)
	else:
		opening_camera.position = Vector3(-5.0, 1.72, 29.0)
		opening_camera.look_at(Vector3(-11.5, 1.16, -1.0), Vector3.UP)
	# A ativação é adiada até todas as câmaras de gameplay concluírem o seu _ready().
	opening_active = true
	# O prólogo pode decorrer enquanto a simulação do nível está suspensa; esta Casa continua a processar a contagem de E.
	process_mode = Node.PROCESS_MODE_ALWAYS
	# A Casa Voss é construída durante o _ready() do nível; o painel entra no frame seguinte, quando a cena já aceita novos filhos.
	call_deferred("_create_opening_skip_prompt")
	call_deferred("_activate_opening_camera")
	# Timer persistente: a entrega de controlo não depende de uma referência temporária efémera durante a abertura.
	opening_timer = Timer.new()
	opening_timer.name = "TemporizadorPrologoCasaVoss"
	opening_timer.one_shot = true
	opening_timer.wait_time = 35.0
	opening_timer.process_mode = Node.PROCESS_MODE_ALWAYS
	opening_timer.timeout.connect(_finish_opening_camera)
	add_child(opening_timer)
	opening_timer.start()
	opening_skip_timer = Timer.new()
	opening_skip_timer.name = "TemporizadorSaltarPrologo"
	opening_skip_timer.one_shot = true
	opening_skip_timer.wait_time = OPENING_SKIP_HOLD_SECONDS
	opening_skip_timer.process_mode = Node.PROCESS_MODE_ALWAYS
	opening_skip_timer.timeout.connect(_complete_opening_skip)
	add_child(opening_skip_timer)
	# Exclusivo de validação automatizada: acelera apenas a apresentação de QA depois de Novo Jogo.
	# Não é lido numa execução normal nem altera o gesto E destinado ao jogador.
	if OS.get_environment("ORIGEM_QA_SKIP_OPENING") == "1":
		get_tree().create_timer(2.0).timeout.connect(_complete_opening_for_qa)

func _activate_opening_camera() -> void:
	# Elias acorda no interior: depois do prólogo, a exploração começa realmente na Casa Voss.
	var elias: Node3D = get_tree().get_first_node_in_group("player") as Node3D
	if elias != null:
		elias.global_position = HOUSE_ORIGIN + Vector3(0.0, 1.75, 0.0)
	if opening_camera != null:
		opening_camera.current = true
	# Durante o enquadramento inicial, não há HUD nem mensagens de outro mapa a competir com a Casa Voss.
	opening_ui = get_tree().current_scene.get_node_or_null("UI") as CanvasLayer
	if opening_ui != null:
		opening_ui.visible = false
	# Marcadores, inimigos e protótipos do vale só entram depois do prólogo; não devem contaminar a leitura da casa.
	for node_name: String in ["Enemies", "Interactables", "Characters"]:
		var legacy_node: Node3D = get_tree().current_scene.get_node_or_null(node_name) as Node3D
		if legacy_node != null and legacy_node.visible:
			legacy_node.visible = false
			opening_hidden_nodes.append(legacy_node)
	# A tempestade é aplicada imediatamente à câmara de prólogo; o reforço diferido vence qualquer sincronização Chronos tardia.
	_apply_opening_storm()
	get_tree().create_timer(0.35).timeout.connect(_apply_opening_storm)

func _apply_opening_storm() -> void:
	var level_environment: Node = get_tree().current_scene.get_node_or_null("LevelEnvironment")
	if level_environment == null:
		return
	if DAYLIGHT_VARIANT_ENABLED and level_environment.has_method("apply_voss_daylight"):
		level_environment.call("apply_voss_daylight")
	elif level_environment.has_method("apply_voss_opening_storm"):
		level_environment.call("apply_voss_opening_storm")

func _finish_opening_camera() -> void:
	if not opening_active:
		return
	opening_active = false
	opening_skip_hold_time = 0.0
	opening_skip_key_held = false
	process_mode = Node.PROCESS_MODE_INHERIT
	if opening_timer != null and not opening_timer.is_stopped():
		opening_timer.stop()
	if opening_skip_timer != null and not opening_skip_timer.is_stopped():
		opening_skip_timer.stop()
	if opening_skip_layer != null:
		opening_skip_layer.queue_free()
		opening_skip_layer = null
		opening_skip_label = null
	if opening_camera != null:
		# Liberta definitivamente a câmara cinematográfica antes de devolver o controlo.
		# Isto evita uma moldura preta quando duas câmaras disputam o viewport no mesmo frame.
		opening_camera.current = false
		opening_camera.queue_free()
		opening_camera = null
	var elias: Node = get_tree().get_first_node_in_group("player")
	if elias != null:
		# Reposiciona Elias numa área interior livre, afastada de parede, telhado e fundação.
		# A porta fica à frente no eixo local -Z, preservando o começo narrativo dentro da Casa Voss.
		var house_node: Node3D = get_node_or_null("CasaVoss") as Node3D
		if elias is Node3D:
			var elias_3d: Node3D = elias as Node3D
			if opening_was_skipped:
				# O salto deve ser uma entrada segura no vale, nunca uma câmara presa em geometria interior.
				var recovery_x: float = -25.0
				var recovery_z: float = 3.0
				elias_3d.global_position = Vector3(recovery_x, _ground_height(recovery_x, recovery_z) + 1.30, recovery_z)
				elias_3d.global_rotation.y = deg_to_rad(-32.0)
			elif house_node != null:
				elias_3d.global_position = house_node.to_global(Vector3(0.0, 1.28, -1.80))
				elias_3d.global_rotation.y = house_node.global_rotation.y
			else:
				elias_3d.rotation.y = PI + deg_to_rad(10.0)
			if elias is CharacterBody3D:
				(elias as CharacterBody3D).velocity = Vector3.ZERO
		var player_head: Node3D = elias.get_node_or_null("Head") as Node3D
		if player_head != null:
			player_head.rotation.x = 0.0
		var player_camera: Camera3D = elias.get_node_or_null("Head/Camera3D") as Camera3D
		if player_camera != null:
			# make_current garante o viewport da primeira pessoa no próprio frame do salto.
			player_camera.make_current()
			player_camera.current = true
			get_tree().create_timer(0.10).timeout.connect(_verify_player_camera_handoff.bind(player_camera))
	if opening_ui != null:
		opening_ui.visible = true
		opening_ui = null
	for hidden_node: Node3D in opening_hidden_nodes:
		if is_instance_valid(hidden_node):
			hidden_node.visible = true
	opening_hidden_nodes.clear()
	# A exploração volta ao perfil temporal ativo depois do prólogo de tempestade.
	var level_environment: Node = get_tree().current_scene.get_node_or_null("LevelEnvironment")
	if level_environment != null and level_environment.has_method("restore_timeline_environment"):
		level_environment.call("restore_timeline_environment")
	var opening_message: String = "Prólogo saltado. Elias recupera o controlo na Casa Voss." if opening_was_skipped else "1908 — Casa Voss\n\nA tempestade cobre a estrada para as cavernas de Orion."
	EventBus.player_message_requested.emit(opening_message, 3.0 if opening_was_skipped else 5.5)

func _verify_player_camera_handoff(player_camera: Camera3D) -> void:
	if player_camera == null or not is_instance_valid(player_camera):
		push_error("[ORIGEM_OPENING] A câmara de Elias não está disponível após o prólogo.")
		return
	player_camera.make_current()
	var active_camera: Camera3D = get_viewport().get_camera_3d()
	var diagnostic: String = "camera_current=%s active=%s player_pos=%s camera_pos=%s" % [
		str(player_camera.is_current()),
		active_camera.name if active_camera != null else "NULA",
		str(player_camera.get_parent().get_parent().global_position),
		str(player_camera.global_position)
	]
	print("[ORIGEM_OPENING] Controlo devolvido a Elias; %s" % diagnostic)
	var debug_file: FileAccess = FileAccess.open("user://origem_opening_camera_debug.txt", FileAccess.WRITE)
	if debug_file != null:
		debug_file.store_line(diagnostic)
		debug_file.close()

func _create_materials() -> void:
	stone_material = _material(Color(0.24, 0.27, 0.24, 1.0), 0.66, 0.04)
	stone_material.albedo_texture = WET_FIELDSTONE_WALL_DIFF
	stone_material.normal_enabled = true
	stone_material.normal_texture = MOSSY_ROCK_NORMAL
	stone_material.normal_scale = 0.72
	stone_material.roughness_texture = MOSSY_ROCK_ROUGH
	stone_material.uv1_triplanar = true
	stone_material.uv1_world_triplanar = true
	stone_material.uv1_scale = Vector3(0.26, 0.26, 0.26)
	# Emissão residual imperceptível à distância, mas suficiente para conservar a leitura de parede em GL Compatibility.
	stone_material.emission_enabled = true
	stone_material.emission = Color(0.012, 0.020, 0.018, 1.0)
	stone_material.emission_energy_multiplier = 0.46
	timber_material = _material(Color(0.175, 0.155, 0.125, 1.0), 0.48, 0.02)
	timber_material.albedo_texture = WEATHERED_DARK_TIMBER_DIFF
	timber_material.uv1_triplanar = true
	timber_material.uv1_world_triplanar = true
	timber_material.uv1_scale = Vector3(0.28, 0.28, 0.28)
	aged_wood_material = _material(Color(0.105, 0.092, 0.072, 1.0), 0.42, 0.05)
	aged_wood_material.albedo_texture = WEATHERED_DARK_TIMBER_DIFF
	aged_wood_material.uv1_triplanar = true
	aged_wood_material.uv1_world_triplanar = true
	aged_wood_material.uv1_scale = Vector3(0.24, 0.24, 0.24)
	# Ardósia escura e molhada: substitui a textura anterior, que continha uma parede de pedra clara e desviava a leitura da cobertura.
	roof_material = _material(Color(0.072, 0.082, 0.086, 1.0), 0.48, 0.03)
	roof_material.albedo_texture = WET_SLATE_ROOF_DIFF
	roof_material.normal_enabled = true
	roof_material.normal_texture = MOSSY_ROCK_NORMAL
	roof_material.normal_scale = 0.42
	roof_material.roughness_texture = MOSSY_ROCK_ROUGH
	roof_material.uv1_triplanar = true
	roof_material.uv1_world_triplanar = true
	roof_material.uv1_scale = Vector3(0.42, 0.42, 0.42)
	if DAYLIGHT_VARIANT_ENABLED:
		# Ardósia gerada: conserva placas escuras e envelhecidas sem estourar sob a luz diurna.
		roof_material.albedo_texture = DAYLIGHT_WEATHERED_SLATE_ROOF_DIFF
		roof_material.albedo_color = Color(0.26, 0.29, 0.30, 1.0)
		roof_material.uv1_scale = Vector3(0.34, 0.34, 0.34)
		roof_material.roughness = 0.92
		timber_material.albedo_texture = DAYLIGHT_WEATHERED_TIMBER_DIFF
		timber_material.albedo_color = Color(0.34, 0.25, 0.17, 1.0)
		timber_material.uv1_scale = Vector3(0.34, 0.34, 0.34)
		aged_wood_material.albedo_texture = DAYLIGHT_WEATHERED_TIMBER_DIFF
		aged_wood_material.albedo_color = Color(0.22, 0.15, 0.095, 1.0)
		aged_wood_material.uv1_scale = Vector3(0.30, 0.30, 0.30)
	interior_wood_material = _material(Color(0.28, 0.16, 0.08, 1.0), 0.82, 0.0)
	# Resposta residual do mobiliário: revela silhuetas narrativas em GL Compatibility sem converter madeira em material luminoso.
	interior_wood_material.emission_enabled = true
	interior_wood_material.emission = Color(0.032, 0.016, 0.006, 1.0)
	interior_wood_material.emission_energy_multiplier = 0.52
	brass_material = _material(Color(0.34, 0.20, 0.07, 1.0), 0.48, 0.63)
	brass_material.emission_enabled = true
	brass_material.emission = Color(0.055, 0.025, 0.006, 1.0)
	brass_material.emission_energy_multiplier = 0.42
	window_material = _material(Color(0.10, 0.035, 0.008, 1.0), 0.24, 0.05)
	window_material.emission_enabled = true
	window_material.emission = Color(0.46, 0.235, 0.070, 1.0)
	window_material.emission_energy_multiplier = 0.42
	warm_glow_material = _material(Color(1.0, 0.54, 0.16, 1.0), 0.38, 0.0)
	warm_glow_material.emission_enabled = true
	warm_glow_material.emission = Color(1.0, 0.20, 0.025, 1.0)
	warm_glow_material.emission_energy_multiplier = 1.08
	chronos_window_material = _material(Color(0.018, 0.060, 0.14, 1.0), 0.30, 0.06)
	chronos_window_material.emission_enabled = true
	chronos_window_material.emission = Color(0.010, 0.085, 0.42, 1.0)
	chronos_window_material.emission_energy_multiplier = 1.10

func _build_foundation(house: Node3D) -> void:
	_add_box(house, "FundacaoDePedra", Vector3(0.0, 0.22, 0.0), Vector3(9.4, 0.44, 7.9), stone_material, true)
	_add_box(house, "PisoDeMadeira", Vector3(0.0, 0.51, 0.0), Vector3(8.75, 0.16, 7.25), interior_wood_material, true)
	for index: int in range(9):
		var x: float = -3.65 + float(index) * 0.91
		_add_box(house, "TábuaPiso_%02d" % index, Vector3(x, 0.61, 0.0), Vector3(0.055, 0.035, 6.8), timber_material, false)

func _build_walls_and_frame(house: Node3D) -> void:
	# Parede traseira e laterais: pedra baixa, madeira e vãos de luz.
	_add_box(house, "ParedeTraseira", Vector3(0.0, 2.1, 3.38), Vector3(8.3, 3.25, 0.35), stone_material, true)
	_add_box(house, "ParedeEsquerda", Vector3(-4.15, 2.0, 0.0), Vector3(0.35, 3.05, 6.55), stone_material, true)
	_add_box(house, "ParedeDireita", Vector3(4.15, 2.0, 0.0), Vector3(0.35, 3.05, 6.55), stone_material, true)
	# Frente interrompida pelo vão da porta de saída para a montanha.
	_add_box(house, "FrenteEsquerda", Vector3(-3.05, 2.0, -3.38), Vector3(2.2, 3.05, 0.35), stone_material, true)
	_add_box(house, "FrenteDireita", Vector3(3.05, 2.0, -3.38), Vector3(2.2, 3.05, 0.35), stone_material, true)
	_add_box(house, "LintelDaPorta", Vector3(0.0, 3.52, -3.38), Vector3(3.9, 0.40, 0.52), timber_material, true)
	_add_box(house, "PortaVossEsquerda", Vector3(-0.95, 1.88, -3.61), Vector3(1.72, 2.65, 0.18), aged_wood_material, true)
	_add_box(house, "PortaVossDireita", Vector3(0.95, 1.88, -3.61), Vector3(1.72, 2.65, 0.18), aged_wood_material, true)
	var door_left: Node3D = house.get_node_or_null("PortaVossEsquerda") as Node3D
	var door_right: Node3D = house.get_node_or_null("PortaVossDireita") as Node3D
	if door_left != null:
		_add_door_face_details(door_left, "DetalhePortaOeste")
	if door_right != null:
		_add_door_face_details(door_right, "DetalhePortaEste")
	# Sem grade independente no vão: os dois painéis móveis são os únicos elementos da porta.
	# O alvo de interação usa a camada 4, a mesma do InteractRay de Elias, sem bloquear a cápsula do jogador.
	_add_interactable(house, "VossFrontDoor", Vector3(0.0, 1.90, -3.08), Vector3(3.95, 2.80, 0.64), "GatilhoDaPortaVoss")
	_add_front_chronos_window(house, Vector3(-3.10, 2.08, -3.61), "JanelaChronosFrontal")
	_add_front_window(house, Vector3(2.05, 2.08, -3.61), "JanelaFrontalEste")
	# Janela anómala: a referência visual da abertura associa a casa ao brilho azul de Chronos.
	_add_chronos_window(house, Vector3(-3.86, 2.14, -0.92))
	_add_box(house, "FrontaoEscuro", Vector3(0.0, 4.28, -3.52), Vector3(2.75, 1.52, 0.20), aged_wood_material, false)
	# Ripas de frontão: acrescentam a leitura de madeira antiga sem gerar colisões ou bloquear a entrada.
	for x: float in [-0.62, -0.28, 0.28, 0.62]:
		_add_box(house, "RipaFrontao_%0.2f" % x, Vector3(x, 4.28, -3.67), Vector3(0.10, 1.24, 0.08), darken(timber_material, 0.86), false)
	_add_box(house, "VigaFrontaoOeste", Vector3(-1.05, 4.54, -3.70), Vector3(0.20, 2.70, 0.25), timber_material, false, Vector3(0.0, 0.0, -0.72))
	_add_box(house, "VigaFrontaoEste", Vector3(1.05, 4.54, -3.70), Vector3(0.20, 2.70, 0.25), timber_material, false, Vector3(0.0, 0.0, 0.72))
	_add_box(house, "JanelaDoSotao", Vector3(0.0, 4.36, -3.70), Vector3(0.72, 0.74, 0.12), window_material, false)
	_add_light(house, Vector3(0.0, 4.36, -4.04), Color(1.0, 0.38, 0.08, 1.0), 0.42, 3.6, "LuzDoSotao")
	for x: float in [-3.85, -2.0, 2.0, 3.85]:
		_add_box(house, "VigaVertical_%0.1f" % x, Vector3(x, 2.4, -3.62), Vector3(0.24, 3.65, 0.25), timber_material, true)
	for z: float in [-2.65, -1.35, 0.0, 1.35, 2.65]:
		_add_box(house, "VigaTraseira_%0.1f" % z, Vector3(0.0, 3.45, z), Vector3(8.4, 0.24, 0.22), timber_material, false)
	# Escoras frontais irregulares: recuperam a carpintaria envelhecida sem fechar porta, janelas ou circulação.
	_add_box(house, "EscoraFrontalOeste", Vector3(-2.72, 2.10, -3.76), Vector3(0.16, 3.05, 0.12), darken(timber_material, 0.76), false, Vector3(0.0, 0.0, -0.62))
	_add_box(house, "EscoraFrontalEste", Vector3(2.74, 2.08, -3.77), Vector3(0.15, 2.65, 0.12), darken(timber_material, 0.82), false, Vector3(0.0, 0.0, 0.56))
	# Janela para a montanha e para a anomalia temporal.
	_add_box(house, "JanelaDaMontanha", Vector3(4.34, 2.35, -0.60), Vector3(0.10, 1.42, 1.78), window_material, false)
	_add_box(house, "TravessaJanelaVertical", Vector3(4.40, 2.35, -0.60), Vector3(0.13, 1.62, 0.12), timber_material, false)
	_add_box(house, "TravessaJanelaHorizontal", Vector3(4.40, 2.35, -0.60), Vector3(0.13, 0.12, 1.88), timber_material, false)

func _build_reference_gable_face(house: Node3D) -> void:
	# Frontão alto em madeira envelhecida: reforça a silhueta de refúgio antigo sem acrescentar colisão ou alterar a volumetria jogável.
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var left_base: Vector3 = Vector3(-2.20, 3.50, -3.75)
	var right_base: Vector3 = Vector3(2.20, 3.50, -3.75)
	var apex: Vector3 = Vector3(0.0, 6.62, -3.75)
	surface.add_vertex(left_base)
	surface.add_vertex(right_base)
	surface.add_vertex(apex)
	surface.add_vertex(right_base)
	surface.add_vertex(left_base)
	surface.add_vertex(apex)
	surface.generate_normals()
	var gable_mesh: ArrayMesh = surface.commit()
	gable_mesh.surface_set_material(0, aged_wood_material)
	var gable: MeshInstance3D = MeshInstance3D.new()
	gable.name = "FrontaoAltoDeReferencia"
	gable.mesh = gable_mesh
	gable.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	house.add_child(gable)
	# Travessas verticais irregulares dão escala de tábuas e sobrevivem ao plano aberto da câmara.
	for x: float in [-1.55, -0.82, -0.34, 0.38, 0.94, 1.52]:
		var upper_y: float = 5.88 - absf(x) * 0.78
		_add_box(house, "TábuaFrontaoAlto_%0.2f" % x, Vector3(x, 4.64, -3.82), Vector3(0.11, maxf(0.56, upper_y - 3.50), 0.07), darken(timber_material, 0.76), false)
	_add_box(house, "EscoraFrontaoAltoOeste", Vector3(-1.38, 5.10, -3.84), Vector3(0.16, 3.28, 0.10), timber_material, false, Vector3(0.0, 0.0, -0.70))
	_add_box(house, "EscoraFrontaoAltoEste", Vector3(1.38, 5.10, -3.84), Vector3(0.16, 3.28, 0.10), timber_material, false, Vector3(0.0, 0.0, 0.70))

func _add_door_face_details(door: Node3D, name_prefix: String) -> void:
	# Detalhes decorativos filhos do próprio painel: acompanham a animação e não criam qualquer colisão no vão.
	for index: int in range(3):
		var plank_x: float = -0.48 + float(index) * 0.48
		_add_box(door, name_prefix + "_Prancha_%02d" % index, Vector3(plank_x, 0.0, -0.12), Vector3(0.13, 2.34, 0.05), timber_material, false)
	_add_box(door, name_prefix + "_CintaSuperior", Vector3(0.0, 0.72, -0.15), Vector3(1.50, 0.10, 0.05), darken(timber_material, 0.62), false)
	_add_box(door, name_prefix + "_CintaInferior", Vector3(0.0, -0.72, -0.15), Vector3(1.50, 0.10, 0.05), darken(timber_material, 0.62), false)

func _add_chronos_window(house: Node3D, pos: Vector3) -> void:
	var window: MeshInstance3D = MeshInstance3D.new()
	window.name = "JanelaChronosAzul"
	var window_mesh: BoxMesh = BoxMesh.new()
	window_mesh.size = Vector3(0.11, 1.18, 1.34)
	window_mesh.material = chronos_window_material
	window.mesh = window_mesh
	window.position = pos
	house.add_child(window)
	_add_box(house, "JanelaChronosTravessaHorizontal", pos, Vector3(0.14, 0.12, 1.46), timber_material, false)
	_add_box(house, "JanelaChronosTravessaVertical", pos, Vector3(0.14, 1.34, 0.12), timber_material, false)
	_add_light(house, pos + Vector3(-0.48, 0.0, 0.0), Color(0.07, 0.22, 0.80, 1.0), 0.44, 4.4, "LuzDaJanelaChronos")

func _add_front_chronos_window(house: Node3D, pos: Vector3, node_name: String) -> void:
	var window: MeshInstance3D = MeshInstance3D.new()
	window.name = node_name
	var window_mesh: BoxMesh = BoxMesh.new()
	window_mesh.size = Vector3(1.28, 1.34, 0.10)

	window_mesh.material = chronos_window_material
	window.mesh = window_mesh
	window.position = pos
	house.add_child(window)
	_add_box(house, node_name + "_Vertical", pos + Vector3(0.0, 0.0, -0.07), Vector3(0.10, 1.48, 0.12), timber_material, false)
	_add_box(house, node_name + "_Horizontal", pos + Vector3(0.0, 0.0, -0.07), Vector3(1.40, 0.10, 0.12), timber_material, false)
	_add_box(house, node_name + "_VerticalOeste", pos + Vector3(-0.32, 0.0, -0.07), Vector3(0.065, 1.42, 0.11), darken(timber_material, 0.78), false)
	_add_box(house, node_name + "_VerticalEste", pos + Vector3(0.32, 0.0, -0.07), Vector3(0.065, 1.42, 0.11), darken(timber_material, 0.78), false)
	_add_box(house, node_name + "_HorizontalSuperior", pos + Vector3(0.0, 0.33, -0.07), Vector3(1.34, 0.065, 0.11), darken(timber_material, 0.78), false)
	_add_box(house, node_name + "_HorizontalInferior", pos + Vector3(0.0, -0.33, -0.07), Vector3(1.34, 0.065, 0.11), darken(timber_material, 0.78), false)

	_add_light(house, pos + Vector3(0.0, 0.0, -0.38), Color(0.045, 0.15, 0.62, 1.0), 0.40, 3.4, node_name + "_Luz")

func _add_front_window(house: Node3D, pos: Vector3, node_name: String) -> void:
	var frame: MeshInstance3D = MeshInstance3D.new()
	frame.name = node_name
	var frame_mesh: BoxMesh = BoxMesh.new()
	frame_mesh.size = Vector3(1.20, 1.35, 0.10)
	frame_mesh.material = window_material
	frame.mesh = frame_mesh
	frame.position = pos
	house.add_child(frame)
	_add_box(house, node_name + "_Vertical", pos + Vector3(0.0, 0.0, -0.07), Vector3(0.11, 1.52, 0.12), timber_material, false)
	_add_box(house, node_name + "_Horizontal", pos + Vector3(0.0, 0.0, -0.07), Vector3(1.35, 0.11, 0.12), timber_material, false)
	_add_light(house, pos + Vector3(0.0, 0.0, -0.36), Color(1.0, 0.52, 0.18, 1.0), 0.26, 3.4, node_name + "_Luz")

func _build_roof_and_chimney(house: Node3D) -> void:
	# Duas águas profundas e escuras, pensadas para o aspecto húmido do prólogo.
	# As duas águas sobem da parede externa e convergem no frontão central.
	_add_roof_plane(house, "TelhadoOeste", Vector3(-2.05, 5.18, 0.0), 0.78)
	_add_roof_plane(house, "TelhadoEste", Vector3(2.05, 5.18, 0.0), -0.78)
	# Fileiras muito finas de ardósia quebram a superfície lisa sem gerar colisão ou fragmentos físicos.
	var slate_edge_material: StandardMaterial3D = darken(roof_material, 0.58)
	for row: int in range(4):
		var west_x: float = -3.45 + float(row) * 0.82
		var west_y: float = 5.18 + (west_x + 2.05) * sin(0.78) + 0.14
		_add_box(house, "ArdosiaOeste_%02d" % row, Vector3(west_x, west_y, 0.0), Vector3(0.12, 0.07, 8.16), slate_edge_material, false, Vector3(0.0, 0.0, 0.78))
		var east_x: float = 3.45 - float(row) * 0.82
		var east_y: float = 5.18 + (east_x - 2.05) * sin(-0.78) + 0.14
		_add_box(house, "ArdosiaEste_%02d" % row, Vector3(east_x, east_y, 0.0), Vector3(0.12, 0.07, 8.16), slate_edge_material, false, Vector3(0.0, 0.0, -0.78))
	_add_box(house, "CumeeiraDeArdosia", Vector3(0.0, 6.76, 0.0), Vector3(0.28, 0.20, 8.25), darken(roof_material, 0.80), false)
	for z: float in [-2.8, -1.8, -0.8, 0.2, 1.2, 2.2, 3.0]:
		_add_box(house, "RipaTelhado_%0.1f" % z, Vector3(0.0, 5.63, z), Vector3(0.20, 0.16, 0.13), aged_wood_material, false)
	_add_box(house, "ChamineDePedra", Vector3(-3.55, 5.05, 1.75), Vector3(1.0, 4.2, 1.05), stone_material, true)
	_add_box(house, "TopoChamine", Vector3(-3.55, 7.18, 1.75), Vector3(1.30, 0.25, 1.30), darken(stone_material, 0.82), false)

func _build_side_annex(house: Node3D) -> void:
	# Ala baixa em pedra e madeira: dá à casa a assimetria e a idade de um refúgio ocupado.
	_add_box(house, "FundacaoDaAla", Vector3(-6.1, 0.22, 0.68), Vector3(3.5, 0.44, 5.8), stone_material, true)
	_add_box(house, "ParedeExternaDaAla", Vector3(-7.72, 1.62, 0.68), Vector3(0.30, 2.35, 5.30), stone_material, true)
	_add_box(house, "ParedeFrontalDaAla", Vector3(-6.1, 1.62, -1.98), Vector3(3.5, 2.35, 0.30), stone_material, true)
	_add_box(house, "VigaDaAla", Vector3(-6.1, 3.02, 0.68), Vector3(3.75, 0.22, 5.70), timber_material, false)
	_add_roof_plane(house, "TelhadoDaAla", Vector3(-6.10, 3.52, 0.68), 0.28)
	_add_front_window(house, Vector3(-6.25, 1.72, -2.15), "JanelaDaAla")
	_add_box(house, "PilhaDeLenhaDaAla", Vector3(-8.12, 0.88, 2.05), Vector3(0.56, 1.20, 1.45), aged_wood_material, false)
	# Travessas irregulares, apenas decorativas, dão idade à ala sem criar uma nova barreira jogável.
	for index: int in range(4):
		var board_y: float = 0.92 + float(index) * 0.48
		_add_box(house, "TabuaAla_%02d" % index, Vector3(-6.10, board_y, -2.16), Vector3(3.20, 0.12, 0.08), timber_material, false)
	# Duas escoras antigas quebram a regularidade da ala sem acrescentar obstáculos físicos.
	_add_box(house, "EscoraAlaOeste", Vector3(-6.10, 1.82, -2.27), Vector3(3.36, 0.13, 0.10), darken(timber_material, 0.70), false, Vector3(0.0, 0.0, -0.48))
	_add_box(house, "EscoraAlaEste", Vector3(-6.10, 1.82, -2.29), Vector3(3.36, 0.13, 0.10), darken(timber_material, 0.70), false, Vector3(0.0, 0.0, 0.48))

func _build_interior(house: Node3D) -> void:
	# A parede da espada é a primeira âncora narrativa da casa.
	_add_box(house, "ParedeDaEspada", Vector3(-3.84, 2.15, 1.20), Vector3(0.16, 2.75, 3.15), aged_wood_material, true)
	_add_interactable(house, "SwordWall", Vector3(-3.62, 2.02, 1.15), Vector3(0.38, 1.75, 0.76), "ParedeDaEspadaLimiar")
	_add_box(house, "SuporteDaEspada", Vector3(-3.53, 2.42, 1.15), Vector3(0.16, 0.22, 1.10), brass_material, false)
	_add_box(house, "LimiarCoberta", Vector3(-3.38, 2.42, 1.15), Vector3(0.12, 0.12, 1.85), brass_material, false)
	# Mesa de Tomás: fotografia, pedra marcada e metal amarelo.
	_add_box(house, "MesaDeTomas", Vector3(1.35, 1.35, 1.35), Vector3(2.55, 0.20, 1.20), interior_wood_material, true)
	for x: float in [0.36, 2.34]:
		for z: float in [0.90, 1.80]:
			_add_box(house, "PernaMesa_%0.1f_%0.1f" % [x, z], Vector3(x, 0.92, z), Vector3(0.16, 0.85, 0.16), timber_material, true)
	_add_interactable(house, "TomasTable", Vector3(1.35, 1.48, 1.35), Vector3(2.4, 0.48, 1.2), "MesaDaMemoria")
	_add_box(house, "PedraMarcada", Vector3(0.72, 1.62, 1.24), Vector3(0.34, 0.15, 0.42), stone_material, false)
	_add_box(house, "FragmentoAmarelo", Vector3(1.42, 1.62, 1.20), Vector3(0.15, 0.12, 0.42), brass_material, false)
	_add_box(house, "FotografiaDesbotada", Vector3(2.00, 1.61, 1.25), Vector3(0.42, 0.04, 0.34), _material(Color(0.54, 0.47, 0.35, 1.0), 0.85, 0.0), false)
	# Mapa e ferramentas do pai.
	_add_interactable(house, "MountainMap", Vector3(3.88, 2.12, 1.32), Vector3(0.32, 1.0, 1.25), "MapaDaMontanha")
	_add_box(house, "MapaDaMontanha", Vector3(3.96, 2.12, 1.32), Vector3(0.08, 1.12, 1.38), _material(Color(0.50, 0.38, 0.20, 1.0), 0.92, 0.0), false)
	_add_interactable(house, "MiguelTools", Vector3(-1.75, 1.42, 2.80), Vector3(1.55, 1.60, 0.45), "FerramentasDeMiguel")
	_add_box(house, "BancadaDeMiguel", Vector3(-1.75, 1.18, 2.83), Vector3(2.0, 0.28, 0.62), interior_wood_material, true)
	for index: int in range(4):
		_add_box(house, "Ferramenta_%02d" % index, Vector3(-2.42 + float(index) * 0.44, 1.52, 2.57), Vector3(0.09, 0.55, 0.08), brass_material, false)
	# Lareira e calor doméstico.
	_add_box(house, "Lareira", Vector3(-1.38, 1.12, 3.02), Vector3(1.46, 1.30, 0.58), stone_material, true)
	_add_box(house, "BrasaDaLareira", Vector3(-1.38, 1.22, 2.70), Vector3(0.82, 0.14, 0.18), warm_glow_material, false)
	_add_light(house, Vector3(-1.38, 1.85, 2.30), Color(1.0, 0.38, 0.12, 1.0), 2.0, 6.0, "LuzDaLareira")
	_add_light(house, Vector3(0.0, 3.0, -2.2), Color(1.0, 0.62, 0.29, 1.0), 0.75, 5.0, "LuzDaEntrada")
	# Preenchimento doméstico sem sombras: revela mesa, mapa e estrutura da casa em GL Compatibility, mantendo a lareira como fonte de calor dominante.
	_add_light(house, Vector3(0.18, 2.72, 0.18), Color(0.34, 0.42, 0.48, 1.0), 3.60, 12.0, "PreenchimentoInteriorCasaVoss")
	# Luz prática da mesa de Tomás: guia o olhar para a memória e evita que os objetos narrativos desapareçam após o prólogo.
	_add_light(house, Vector3(1.35, 2.38, 1.35), Color(1.0, 0.54, 0.20, 1.0), 1.45, 5.5, "LuzDaMesaDeTomas")
	# Rebate frio mínimo no limiar: preserva a noite exterior, mas separa a moldura, a porta e o piso quando o jogador desperta.
	_add_light(house, Vector3(0.0, 2.20, -3.25), Color(0.38, 0.48, 0.58, 1.0), 3.10, 12.5, "PreenchimentoDoLimiarVoss")

func _create_daylight_path_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.72, 0.72, 0.67, 1.0)
	material.albedo_texture = DAYLIGHT_WEATHERED_FLAGSTONE_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_ROCK_NORMAL
	material.normal_scale = 0.30
	material.roughness_texture = MOSSY_ROCK_ROUGH
	material.roughness = 0.91
	material.uv1_triplanar = true
	material.uv1_world_triplanar = true
	material.uv1_scale = Vector3(0.38, 0.38, 0.38)
	return material

func _build_exterior_details(house: Node3D) -> void:
	# Degraus, adro e carroça degradada; o trilho diurno evita o aspeto de laje metálica sem bloquear Elias.
	var entrance_path_material: StandardMaterial3D = _create_daylight_path_material() if DAYLIGHT_VARIANT_ENABLED else stone_material
	_add_box(house, "AlpendreVigaEsquerda", Vector3(-3.28, 3.05, -4.46), Vector3(0.28, 3.05, 0.28), timber_material, true)
	_add_box(house, "AlpendreVigaDireita", Vector3(3.28, 3.05, -4.46), Vector3(0.28, 3.05, 0.28), timber_material, true)
	_add_box(house, "AlpendreCobertura", Vector3(0.0, 4.15, -4.25), Vector3(7.25, 0.22, 1.45), roof_material, false, Vector3(0.18, 0.0, 0.0))
	# Os degraus são puramente visuais: CharacterBody3D não sobe blocos baixos automaticamente.
	for index: int in range(3):
		_add_box(house, "Degrau_%02d" % index, Vector3(0.0, 0.28 + float(index) * 0.12, -4.08 - float(index) * 0.42), Vector3(3.10 - float(index) * 0.26, 0.20, 0.72), entrance_path_material, false)
	# Base rasa e texturada sob os degraus: mantém a colisão contínua, mas deixa de ler como uma rampa industrial lisa.
	_add_box(house, "PassagemLivreDaPorta", Vector3(0.0, 0.10, -4.65), Vector3(3.00, 0.18, 1.75), entrance_path_material, true)
	_add_box(house, "PilhaDeLenha", Vector3(-4.78, 0.86, 1.96), Vector3(0.86, 1.18, 1.75), aged_wood_material, false)
	_add_cylinder(house, "RodaDeCarroca", Vector3(-5.10, 0.76, -1.25), 0.68, 0.14, aged_wood_material)
	_add_cylinder(house, "RodaDeCarroca2", Vector3(-5.10, 0.76, -2.42), 0.68, 0.14, aged_wood_material)
	var porch_light: OmniLight3D = OmniLight3D.new()
	porch_light.name = "LanternaDaPorta"
	porch_light.position = Vector3(1.62, 3.15, -3.62)
	porch_light.light_color = Color(1.0, 0.58, 0.20, 1.0)
	porch_light.light_energy = 0.70
	porch_light.omni_range = 11.5

	house.add_child(porch_light)
func _build_mountain_road(house: Node3D) -> void:
	# A estrada antiga sai da porta e encontra o trilho do vale; as marcas de cobre serão a pista para a caverna.
	var road: Node3D = Node3D.new()
	road.name = "EstradaAntigaDaMontanha"
	house.add_child(road)
	# Patamar de nascimento discreto e aterrado: a área de colisão continua contínua, mas reduz a leitura de bloco artificial.
	var wet_path_material: StandardMaterial3D = _create_daylight_path_material() if DAYLIGHT_VARIANT_ENABLED else _material(Color(0.052, 0.067, 0.056, 1.0), 0.25, 0.0)
	_add_box(house, "PatamarDaAbertura", Vector3(0.0, 0.10, -5.72), Vector3(3.35, 0.18, 1.85), wet_path_material, true)

	# Substrato de solo húmido: costura as lajes individuais numa estrada contínua, sem bloquear a cápsula do jogador.
	wet_path_material.albedo_texture = FOREST_GROUND_DIFF
	wet_path_material.normal_enabled = true
	wet_path_material.normal_texture = FOREST_GROUND_NORMAL
	wet_path_material.normal_scale = 0.55
	wet_path_material.uv1_triplanar = true
	wet_path_material.uv1_world_triplanar = true
	wet_path_material.uv1_scale = Vector3(0.26, 0.26, 0.26)
	for index: int in range(0 if DAYLIGHT_VARIANT_ENABLED else 8):
		var path_z: float = -7.0 - float(index) * 2.30
		var path_x: float = sin(float(index) * 0.68) * 0.52
		_add_box(house, "LamaDaEstrada_%02d" % index, Vector3(path_x, 0.10, path_z), Vector3(2.85, 0.035, 2.65), wet_path_material, false, Vector3(0.0, sin(float(index) * 0.46) * 0.07, 0.0))
	for index: int in range(0 if DAYLIGHT_VARIANT_ENABLED else 13):
		var t: float = float(index) / 12.0
		var world_x: float = lerpf(-22.0, -20.0, t) + sin(t * PI * 2.0) * 0.42
		var world_z: float = lerpf(3.85, -10.15, t)
		var local_y: float = _ground_height(world_x, world_z) - house.position.y + 0.13
		var slab_size: float = 1.34 + fmod(float(index), 3.0) * 0.15
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "PedraDaEstrada_%02d" % index
		var mesh: CylinderMesh = CylinderMesh.new()
		mesh.top_radius = 1.0
		mesh.bottom_radius = 0.88
		mesh.height = 0.14
		mesh.radial_segments = 7
		mesh.material = stone_material
		slab.mesh = mesh
		slab.position = Vector3(world_x - house.position.x, local_y, world_z - house.position.z)
		slab.scale = Vector3(slab_size * 0.60, 1.0, 0.82)
		slab.rotation = Vector3(0.02 * sin(float(index)), -0.15 + sin(float(index) * 1.7) * 0.10, 0.015 * cos(float(index)))
		slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
		road.add_child(slab)
		if index % 3 == 0:
			var marker: MeshInstance3D = MeshInstance3D.new()
			marker.name = "MarcaCobre_%02d" % index
			var marker_mesh: SphereMesh = SphereMesh.new()
			marker_mesh.radius = 0.08
			marker_mesh.height = 0.16
			marker_mesh.material = brass_material
			marker.mesh = marker_mesh
			marker.position = slab.position + Vector3(0.42, 0.16, 0.0)
			road.add_child(marker)

func _add_roof_plane(parent: Node3D, node_name: String, pos: Vector3, tilt: float) -> void:
	var roof: MeshInstance3D = MeshInstance3D.new()
	roof.name = node_name
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = Vector3(5.25, 0.24, 8.10)
	mesh.material = roof_material
	roof.mesh = mesh
	roof.position = pos
	roof.rotation.z = tilt
	roof.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(roof)

func _add_interactable(parent: Node3D, node_name: String, pos: Vector3, size_value: Vector3, visual_name: String) -> void:
	var body: StaticBody3D = StaticBody3D.new()
	body.name = node_name
	body.collision_layer = 4
	body.add_to_group("interactable")
	body.position = pos
	var shape: CollisionShape3D = CollisionShape3D.new()
	var box: BoxShape3D = BoxShape3D.new()
	box.size = size_value
	shape.shape = box
	body.add_child(shape)
	var visual: MeshInstance3D = MeshInstance3D.new()
	visual.name = visual_name
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = size_value
	mesh.material = _material(Color(0.0, 0.0, 0.0, 0.0), 1.0, 0.0)
	visual.mesh = mesh
	visual.visible = false
	body.add_child(visual)
	parent.add_child(body)

func _add_box(parent: Node3D, node_name: String, pos: Vector3, size_value: Vector3, material: StandardMaterial3D, collision: bool, rotation_value: Vector3 = Vector3.ZERO) -> void:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.name = node_name
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = size_value
	mesh.material = material
	mesh_instance.mesh = mesh
	mesh_instance.position = pos
	mesh_instance.rotation = rotation_value
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(mesh_instance)
	if collision:
		var body: StaticBody3D = StaticBody3D.new()
		body.name = node_name + "_Colisao"
		body.position = pos
		var shape: CollisionShape3D = CollisionShape3D.new()
		var box: BoxShape3D = BoxShape3D.new()
		box.size = size_value
		shape.shape = box
		body.add_child(shape)
		parent.add_child(body)

func _add_cylinder(parent: Node3D, node_name: String, pos: Vector3, radius: float, depth: float, material: StandardMaterial3D) -> void:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.name = node_name
	var mesh: CylinderMesh = CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = depth
	mesh.radial_segments = 18
	mesh.material = material
	mesh_instance.mesh = mesh
	mesh_instance.position = pos
	mesh_instance.rotation.z = PI * 0.5
	parent.add_child(mesh_instance)

func _add_light(parent: Node3D, pos: Vector3, color: Color, energy: float, light_range: float, node_name: String) -> void:
	var light: OmniLight3D = OmniLight3D.new()
	light.name = node_name
	light.position = pos
	light.light_color = color
	light.light_energy = energy
	light.omni_range = light_range
	light.shadow_enabled = false
	parent.add_child(light)

func _ground_height(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _material(color_value: Color, roughness_value: float, metallic_value: float) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color_value
	material.roughness = roughness_value
	material.metallic = metallic_value
	return material

func _build_voss_candle_and_lantern() -> void:
	# CP 194: vela na mesa de Tomas e lanterna de parede junto a espada.
	var candle_light: OmniLight3D = OmniLight3D.new()
	candle_light.name = "VelaMessaDeTomas"
	candle_light.position = Vector3(-1.2, 1.05, 1.8)
	candle_light.light_color = Color(1.0, 0.72, 0.28, 1.0)
	candle_light.light_energy = 0.90
	candle_light.omni_range = 3.2
	candle_light.shadow_enabled = false
	add_child(candle_light)
	var lantern_light: OmniLight3D = OmniLight3D.new()
	lantern_light.name = "LanternaDeParede"
	lantern_light.position = Vector3(1.8, 1.65, -0.5)
	lantern_light.light_color = Color(0.95, 0.68, 0.32, 1.0)
	lantern_light.light_energy = 0.75
	lantern_light.omni_range = 4.5
	lantern_light.shadow_enabled = false
	add_child(lantern_light)

func _build_exterior_porch_light() -> void:
	# CP 208: Luz de pórtico quente na entrada da Casa Voss para guiar o jogador à porta.
	# OmniLight3D âmbar sobre a entrada, energia moderada para não competir com a lareira.
	var porch_light: OmniLight3D = OmniLight3D.new()
	porch_light.name = "LuzPorchVoss"
	porch_light.position = Vector3(-22.0, 3.2, 10.5)
	porch_light.light_color = Color(0.92, 0.72, 0.38, 1.0)
	porch_light.light_energy = 0.85
	porch_light.omni_range = 7.5
	porch_light.shadow_enabled = false
	add_child(porch_light)


func darken(source: StandardMaterial3D, factor: float) -> StandardMaterial3D:
	return _material(source.albedo_color.darkened(1.0 - factor), source.roughness, source.metallic)
