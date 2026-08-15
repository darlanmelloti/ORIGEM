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
var camp_light_sources: Array[OmniLight3D] = []
var camp_flame_meshes: Array[MeshInstance3D] = []
var camp_animation_time: float = 0.0

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	path_material = _create_path_material()
	ruin_material = _create_ruin_material()
	_build_forest_path()
	_build_forest_wayfinding()
	_build_lake_shore_path()
	_build_shore_access_steps()
	_build_majestic_lake_transition()
	_build_lake_wayfinding()
	_build_dense_forest()
	_build_majestic_camp()
	_build_majestic_connector()
	_build_submerged_ruins()
	_build_riparian_margin()
	_build_lakeside_focal_vegetation()

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
			var flicker: float = 0.93 + sin(camp_animation_time * 3.2) * 0.07
			flame.scale = Vector3(1.0, flicker, 1.0)

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

func _build_shore_access_steps() -> void:
	# As lajes terminam num patamar físico na margem oeste; cada passo tem colisor próprio para a chegada ao lago não depender apenas da malha do terreno.
	var access: Node3D = Node3D.new()
	access.name = "PassagemFisicaParaAMargem"
	add_child(access)
	for index: int in range(7):
		var t: float = float(index) / 6.0
		var z_value: float = lerpf(222.0, 240.0, t)
		var x_value: float = lerpf(_lake_shore_x(222.0), 23.0, t) + sin(t * PI) * 0.45
		var ground_y: float = _height_at(x_value, z_value)
		var step_mesh: BoxMesh = BoxMesh.new()
		step_mesh.size = Vector3(2.05, 0.20, 1.58)
		var step: MeshInstance3D = MeshInstance3D.new()
		step.name = "LajeDeChegada_%02d" % index
		step.mesh = step_mesh
		step.material_override = path_material
		step.position = Vector3(x_value, ground_y + 0.10, z_value)
		step.rotation.y = atan2(23.0 - _lake_shore_x(222.0), 18.0)
		access.add_child(step)
		var body: StaticBody3D = StaticBody3D.new()
		body.name = "ColisorLajeDeChegada_%02d" % index
		body.position = step.position
		body.rotation.y = step.rotation.y
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
	lamp_material.albedo_color = Color(0.42, 0.09, 0.018, 1.0)
	lamp_material.emission_enabled = true
	lamp_material.emission = Color(0.95, 0.11, 0.012, 1.0)
	lamp_material.emission_energy_multiplier = 0.72
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
		var crate_mesh: BoxMesh = BoxMesh.new()
		crate_mesh.size = Vector3(0.95, 0.62, 0.82)
		var crate: MeshInstance3D = MeshInstance3D.new()
		crate.name = "CaixaDeCampoMajestic_%02d" % index
		crate.mesh = crate_mesh
		crate.material_override = crate_material
		crate.position = Vector3(x_value, ground_y + 0.31, z_value)
		crate.rotation.y = 0.25 + float(index) * 0.58
		transition.add_child(crate)
		var lamp_mesh: SphereMesh = SphereMesh.new()
		lamp_mesh.radius = 0.11
		lamp_mesh.height = 0.22
		lamp_mesh.radial_segments = 10
		var lamp: MeshInstance3D = MeshInstance3D.new()
		lamp.name = "LanternaMajestic_%02d" % index
		lamp.mesh = lamp_mesh
		lamp.material_override = lamp_material
		lamp.position = Vector3(x_value, ground_y + 0.94, z_value)
		transition.add_child(lamp)
		var fill: OmniLight3D = OmniLight3D.new()
		fill.name = "LuzDeCampoMajestic_%02d" % index
		fill.light_color = Color(1.0, 0.27, 0.07, 1.0)
		fill.light_energy = 0.18
		fill.omni_range = 3.2
		fill.shadow_enabled = false
		fill.position = lamp.position
		transition.add_child(fill)

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
		# Um subconjunto de troncos ganha colisão: a floresta torna-se física sem saturar o orçamento nem bloquear o corredor central.
		if index % 3 == 0:
			var trunk_body: StaticBody3D = StaticBody3D.new()
			trunk_body.name = "ColisorTroncoFloresta_%02d" % index
			var trunk_height: float = maxf(2.3, 7.2 * tree_scale)
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
	camp_flame_meshes.append(fire)
	var fire_light: OmniLight3D = OmniLight3D.new()
	fire_light.light_color = Color(1.0, 0.32, 0.08, 1.0)
	fire_light.light_energy = 2.10
	fire_light.omni_range = 14.0
	fire_light.shadow_enabled = false
	fire_light.position = Vector3(0.0, 1.4, 0.0)
	fire_light.set_meta("base_energy", fire_light.light_energy)
	camp.add_child(fire_light)
	camp_light_sources.append(fire_light)
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
	var start_x: float = -78.0
	var end_x: float = _path_x(178.0)
	for index: int in range(29):
		var t: float = float(index) / 28.0
		var x_value: float = lerpf(start_x, end_x, t)
		var z_value: float = 178.0 + sin(t * PI) * 3.4
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
		if index in [4, 14, 24]:
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
		var path_z: float = 178.0 + sin(cluster_t * PI) * 3.4
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
				var tree_x: float = path_x + side * (6.80 + float(cluster_index % 2) * 1.10)
				var tree_z: float = path_z + rng.randf_range(-2.0, 2.0)
				margin_tree.position = Vector3(tree_x, _height_at(tree_x, tree_z), tree_z)
				var tree_scale: float = 0.34 + float(cluster_index % 3) * 0.075
				margin_tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
				margin_tree.rotation.y = rng.randf_range(-PI, PI)
				connector_margin.add_child(margin_tree)

func _build_submerged_ruins() -> void:
	var lake: Node3D = Node3D.new()
	lake.name = "RuinasSubmersasDoLago"
	var center_x: float = 60.0
	var center_z: float = 252.0
	var water_y: float = _height_at(center_x, center_z) + 0.45
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
		landmark.position = Vector3(-17.0 + float(landmark_index) * 16.5, 2.35 + float(landmark_index % 2) * 0.55, -9.0 + float(landmark_index) * 5.0)
		var landmark_scale: float = 1.46 - float(landmark_index) * 0.13
		landmark.scale = Vector3(landmark_scale, landmark_scale, landmark_scale)
		landmark.rotation = Vector3(0.08 * float(landmark_index + 1), 0.38 + float(landmark_index) * 0.41, 0.04)
		_apply_material(landmark, ruin_material)
		lake.add_child(landmark)
		# Baliza arqueológica discreta: delineia os marcos emergentes na captura sem criar um perímetro artificial de luz.
		var landmark_beacon: OmniLight3D = OmniLight3D.new()
		landmark_beacon.name = "BrilhoMarcoRuina_%02d" % landmark_index
		landmark_beacon.light_color = Color(0.16, 0.44, 0.68, 1.0)
		landmark_beacon.light_energy = 0.42
		landmark_beacon.omni_range = 8.5
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
	dome.position = Vector3(0.0, -2.6, 0.0)
	dome.scale = Vector3(1.0, 0.38, 1.0)
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
		shallow_slab.material_override = path_material
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
	# Resposta material quase neutra: conserva o musgo no crepúsculo de compatibilidade sem tornar as ruínas autoiluminadas.
	material.emission_enabled = true
	material.emission = Color(0.028, 0.052, 0.060, 1.0)
	material.emission_energy_multiplier = 0.34
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
					ALBEDO = mix(vec3(0.018, 0.085, 0.118), vec3(0.075, 0.255, 0.320), surface_variation * 0.70);
			// Emissão fria contida: separa a bacia e os pilares no renderizador de compatibilidade sem simular um lago luminoso.
			EMISSION = mix(vec3(0.006, 0.028, 0.040), vec3(0.028, 0.115, 0.155), surface_variation * 0.70);

		ROUGHNESS = 0.30;
		SPECULAR = 0.64;

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
