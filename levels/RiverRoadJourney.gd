## RiverRoadJourney.gd
## Corredor inicial real do mapa: Casa Voss -> Estrada do Rio -> Arco das Ruínas.
## O jogador sai para z positivo; esta zona não reutiliza o antigo corredor de composição em z negativo.

extends Node3D

const RUIN_PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const RUIN_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const SLOPE_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_blockSlope_rock.glb")
const STONE_BRIDGE: PackedScene = preload("res://assets/models_cc0/bridge_stone.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const PINE_MEDIUM: PackedScene = preload("res://assets/models_generated/ez_pine_medium_pbr.glb")
const DARK_TREE: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const OAK_DARK: PackedScene = preload("res://assets/models_cc0/tree_oak_dark.glb")
const FLAGSTONE: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")
const GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")
const GROUND_ROUGHNESS: Texture2D = preload("res://assets/textures/pbr/forest_ground_roughness.jpg")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")
const R3_ARCH_AWAKENING_SCRIPT: Script = preload("res://levels/regions/r3/ArchAwakening.gd")

# Escala física do primeiro corredor: a âncora lógica do mapa mantém-se para UI e narrativa,
# mas o marco arqueológico é recuado para criar uma viagem visível e percorrível.
const ROAD_MACRO_ORIGIN_Z := 8.0
const ROAD_MACRO_FACTOR := 2.1
const ARCH_WORLD_Z := 92.0

var terrain_patch: Node3D
var path_material: StandardMaterial3D
var ruin_material: StandardMaterial3D

func _ready() -> void:
	_build_arch_wet_overlay()
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	path_material = _make_path_material()
	ruin_material = _make_ruin_material()
	_build_compacted_roadbed()
	_build_road_entry_orientation()
	_build_world_life_landmarks()
	_build_traveller_rest_point()
	_build_return_route_cairn()
	_build_river_road()
	_build_river()
	_build_first_orion_reflection()
	_build_orion_reflection_observation_station()
	_build_orion_reflection_lookout()
	_build_return_confirmation_landing()
	_build_river_margins()
	_build_pre_arch_river_edge()
	_build_pre_arch_river_approach()
	_build_final_river_edge_reading()
	_build_recessed_river_approach()
	_build_return_voss_sightline()
	_build_return_environment_markers()
	_build_arch_forest_riparian_screen()
	_build_positive_valley_bridge()
	_build_positive_bridge_approach()
	_build_macro_river_cutbanks()
	_build_ruin_arch()
	_build_cartographic_southwest_readability()
	_build_arch_crown_stones()
	_build_river_fill_light()
	_build_arch_base_ferns()
	_build_riparian_color_variation()
	_build_arch_approach_ecology()
	_build_roadside_vegetation()
	_build_macro_ridge_layers()
	_build_arch_backdrop_foothills()
	_build_valley_rim_outcrops()
	_build_slope_outcrop_chain()

func _build_macro_ridge_layers() -> void:
	# Camadas laterais de relevo: criam profundidade real entre a Casa Voss e o Arco, sem aproximar o destino nem ocupar a faixa de 4,15 m da Estrada.
	var ridge_root: Node3D = Node3D.new()
	ridge_root.name = "CamadasRochosasDoValeMacro"
	add_child(ridge_root)
	var layers: Array[Dictionary] = [
		{"z": 35.0, "side": -1.0, "offset": 9.5, "scale": 0.72, "yaw": 0.22},
		{"z": 47.0, "side": 1.0, "offset": 10.5, "scale": 0.88, "yaw": -0.46},
		{"z": 60.0, "side": -1.0, "offset": 11.2, "scale": 1.00, "yaw": 0.71},
		{"z": 73.0, "side": 1.0, "offset": 12.4, "scale": 1.12, "yaw": -0.18},
		{"z": 84.0, "side": -1.0, "offset": 10.8, "scale": 0.94, "yaw": 0.38}
	]
	for index: int in range(layers.size()):
		var layer: Dictionary = layers[index]
		var z_value: float = layer["z"] as float
		var side: float = layer["side"] as float
		var x_value: float = _road_x(z_value) + side * (layer["offset"] as float)
		var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "AfloramentoMacro_%02d" % (index + 1)
		rock.position = Vector3(x_value, _height_at(x_value, z_value) - 0.10, z_value)
		var rock_scale: float = layer["scale"] as float
		rock.scale = Vector3(rock_scale, rock_scale * 0.78, rock_scale)
		rock.rotation.y = layer["yaw"] as float
		_apply_material(rock, ruin_material)
		ridge_root.add_child(rock)
		# Fragmentos verticais tornam a mesma camada reconhecível como ruína antiga, não como uma parede contínua.
		if index % 2 == 0:
			var fragment: Node3D = RUIN_PILLAR.instantiate() as Node3D
			if fragment != null:
				fragment.name = "VestigioMacro_%02d" % (index + 1)
				fragment.position = Vector3(x_value - side * 1.25, _height_at(x_value - side * 1.25, z_value + 0.8) - 0.04, z_value + 0.8)
				fragment.scale = Vector3(0.32, 0.78, 0.32)
				fragment.rotation.y = (layer["yaw"] as float) + 0.24
				_apply_material(fragment, ruin_material)
				ridge_root.add_child(fragment)

func _build_arch_backdrop_foothills() -> void:
	# Contrafortes reais de plano intermédio: criam relevo após o Arco sem fingir a Montanha Orion, reservada às Regiões 7–12.
	# Todos ficam fora da faixa de rota e não possuem colisores, para a viagem Casa → Estrada → Arco se manter desimpedida.
	var foothills: Node3D = Node3D.new()
	foothills.name = "ContrafortesAposArco"
	add_child(foothills)
	var specs: Array[Dictionary] = [
		{"z": 105.0, "side": -1.0, "offset": 15.0, "scale": 1.85, "yaw": 0.36},
		{"z": 109.0, "side": 1.0, "offset": 16.5, "scale": 2.15, "yaw": -0.58},
		{"z": 113.0, "side": -1.0, "offset": 20.0, "scale": 2.35, "yaw": 0.74},
		{"z": 115.0, "side": 1.0, "offset": 22.0, "scale": 2.60, "yaw": -0.24}
	]
	for index: int in range(specs.size()):
		var spec: Dictionary = specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var x_value: float = _road_x(z_value) + side * (spec["offset"] as float)
		var cliff: Node3D = RUIN_ROCK.instantiate() as Node3D
		if cliff == null:
			continue
		cliff.name = "ContraforteDoArco_%02d" % (index + 1)
		cliff.position = Vector3(x_value, _height_at(x_value, z_value) - 0.18, z_value)
		var scale_value: float = spec["scale"] as float
		cliff.scale = Vector3(scale_value * 1.08, scale_value * 1.42, scale_value)
		cliff.rotation.y = spec["yaw"] as float
		_apply_material(cliff, ruin_material)
		foothills.add_child(cliff)
		# Uma copa isolada em cada segundo contraforte dá escala, mas mantém as clareiras de entrada na Floresta Densa.
		if index % 2 == 0:
			var tree: Node3D = DARK_TREE.instantiate() as Node3D
			if tree != null:
				tree.name = "ArvoreDoContraforte_%02d" % (index + 1)
				tree.position = Vector3(x_value - side * 2.6, _height_at(x_value - side * 2.6, z_value + 1.8), z_value + 1.8)
				tree.scale = Vector3(0.42, 0.42, 0.42)
				tree.rotation.y = 0.48 + float(index) * 0.73
				foothills.add_child(tree)

func _build_valley_rim_outcrops() -> void:
	# Afloramentos em planos alternados tornam os taludes recém-esculpidos legíveis como geografia real, não como uma parede de terreno.
	# As posições ficam a mais de 15 m do eixo da estrada e não recebem colisores.
	var rims: Node3D = Node3D.new()
	rims.name = "AfloramentosDoValeMacro"
	add_child(rims)
	var specs: Array[Dictionary] = [
		{"z": 50.0, "side": -1.0, "offset": 16.0, "scale": 0.78, "yaw": 0.32},
		{"z": 66.0, "side": 1.0, "offset": 17.5, "scale": 1.02, "yaw": -0.61},
		{"z": 80.0, "side": -1.0, "offset": 19.0, "scale": 1.24, "yaw": 0.74},
		{"z": 98.0, "side": 1.0, "offset": 20.5, "scale": 1.46, "yaw": -0.28},
		{"z": 112.0, "side": -1.0, "offset": 23.0, "scale": 1.70, "yaw": 0.49}
	]
	for index: int in range(specs.size()):
		var spec: Dictionary = specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var x_value: float = _road_x(z_value) + side * (spec["offset"] as float)
		var outcrop: Node3D = RUIN_ROCK.instantiate() as Node3D
		if outcrop == null:
			continue
		outcrop.name = "AfloramentoMacro_%02d" % (index + 1)
		outcrop.position = Vector3(x_value, _height_at(x_value, z_value) - 0.15, z_value)
		var scale_value: float = spec["scale"] as float
		outcrop.scale = Vector3(scale_value * 1.34, scale_value * 1.12, scale_value)
		outcrop.rotation.y = spec["yaw"] as float
		_apply_material(outcrop, ruin_material)
		rims.add_child(outcrop)
		if index == 1 or index == 3:
			var vestige: Node3D = RUIN_PILLAR.instantiate() as Node3D
			if vestige != null:
				vestige.name = "VestigioDoTalude_%02d" % (index + 1)
				vestige.position = Vector3(x_value - side * 1.5, _height_at(x_value - side * 1.5, z_value + 0.8), z_value + 0.8)
				vestige.scale = Vector3(0.30, 0.48, 0.30)
				vestige.rotation = Vector3(0.08 * side, (spec["yaw"] as float) + 0.35, 0.05)
				_apply_material(vestige, ruin_material)
				rims.add_child(vestige)

func _build_slope_outcrop_chain() -> void:
	# Volumes CC0 inclinados em planos alternados: quebram os taludes lisos sem criar uma parede nem avançar sobre a rota Casa→Arco.
	var outcrops: Node3D = Node3D.new()
	outcrops.name = "AfloramentosInclinadosDoVale"
	add_child(outcrops)
	var specs: Array[Dictionary] = [
		{"z": 38.0, "side": 1.0, "offset": 18.0, "scale": 0.66, "yaw": -0.48},
		{"z": 57.0, "side": -1.0, "offset": 19.5, "scale": 0.88, "yaw": 0.82},
		{"z": 77.0, "side": 1.0, "offset": 21.0, "scale": 1.06, "yaw": -0.26},
		{"z": 96.0, "side": -1.0, "offset": 22.5, "scale": 1.18, "yaw": 0.56}
	]
	for index: int in range(specs.size()):
		var spec: Dictionary = specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var x_value: float = _road_x(z_value) + side * (spec["offset"] as float)
		var outcrop: Node3D = SLOPE_ROCK.instantiate() as Node3D
		if outcrop == null:
			continue
		outcrop.name = "AfloramentoInclinado_%02d" % (index + 1)
		outcrop.position = Vector3(x_value, _height_at(x_value, z_value) - 0.12, z_value)
		var scale_value: float = spec["scale"] as float
		outcrop.scale = Vector3(scale_value * 1.25, scale_value, scale_value * 1.12)
		outcrop.rotation.y = spec["yaw"] as float
		_apply_material(outcrop, ruin_material)
		outcrops.add_child(outcrop)

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
	# Solo húmido legível: mantém o trilho integrado ao vale, mas evita que o leito físico se perca em preto no crepúsculo.
	# Cor mais clara no corredor macro: a Estrada permanece húmida, mas torna-se uma linha de profundidade legível desde a Casa.
	roadbed_material.albedo_color = Color(0.42, 0.34, 0.22, 1.0)
	roadbed_material.roughness = 0.90
	roadbed_material.emission_enabled = true
	roadbed_material.emission = Color(0.030, 0.022, 0.010, 1.0)
	roadbed_material.emission_energy_multiplier = 0.20
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

func _build_road_entry_orientation() -> void:
	# Marcos laterais de entrada: a primeira decisão espacial após a Casa Voss é legível no mundo,
	# sem criar um portão artificial nem estreitar as lajes da Estrada do Rio.
	var markers: Node3D = Node3D.new()
	markers.name = "MarcosDeOrientacaoCasaVoss"
	add_child(markers)
	var marker_data: Array[Dictionary] = [
		{"z": 17.0, "side": -1.0, "scale": 0.34, "yaw": 0.18},
		{"z": 33.0, "side": -1.0, "scale": 0.34, "yaw": -0.28},
		{"z": 56.0, "side": 1.0, "scale": 0.38, "yaw": 0.12},
		{"z": 74.0, "side": -1.0, "scale": 0.36, "yaw": -0.18},
		{"z": 84.0, "side": 1.0, "scale": 0.30, "yaw": 0.26},
	]
	for index: int in range(marker_data.size()):
		var marker: Dictionary = marker_data[index]
		var z_value: float = marker["z"] as float
		var side: float = marker["side"] as float
		# O deslocamento de 3,25 m mantém todos os volumes fora do leito central de 4,15 m.
		var x_value: float = _road_x(z_value) + side * 3.25
		var pillar: Node3D = RUIN_PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "MarcoDeEstrada_%02d" % (index + 1)
		pillar.position = Vector3(x_value, _height_at(x_value, z_value) - 0.06, z_value)
		var uniform_scale: float = marker["scale"] as float
		pillar.scale = Vector3(uniform_scale, uniform_scale * 1.14, uniform_scale)
		pillar.rotation.y = marker["yaw"] as float
		_apply_material(pillar, ruin_material)
		markers.add_child(pillar)
		# Uma rocha baixa anexa cada marco ao relevo e evita a aparência de objecto plantado.
		var footing: Node3D = RUIN_ROCK.instantiate() as Node3D
		if footing == null:
			continue
		footing.name = "BaseNaturalMarco_%02d" % (index + 1)
		footing.position = Vector3(x_value - side * 0.18, _height_at(x_value - side * 0.18, z_value + 0.28) - 0.03, z_value + 0.28)
		footing.scale = Vector3(0.26, 0.16, 0.26)
		footing.rotation.y = (marker["yaw"] as float) + 0.5
		_apply_material(footing, ruin_material)
		markers.add_child(footing)

func _build_world_life_landmarks() -> void:
	# DEV2-R2-WORLD-LIFE-001 — três leituras espaciais distintas transformam a estrada num percurso,
	# sem alterar a rota, acrescentar luzes ou fechar a vista física do Arco.
	var landmarks: Node3D = Node3D.new()
	landmarks.name = "MarcosVidaDeViagemR2"
	add_child(landmarks)

	# 1) A pedra junto à saída recorda a instrução de Tomás: seguir as pedras, não a luz azul.
	var tomas_z: float = 24.0
	var tomas_x: float = _road_x(tomas_z) - 3.72
	var tomas_root: Node3D = Node3D.new()
	tomas_root.name = "MarcoPedrasDeTomas"
	landmarks.add_child(tomas_root)
	for index: int in range(3):
		var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if stone == null:
			continue
		stone.name = "PedraDeTomás_%02d" % (index + 1)
		var local_z: float = float(index - 1) * 0.68
		stone.position = Vector3(tomas_x + float(index % 2) * 0.42, _height_at(tomas_x, tomas_z + local_z) + 0.04, tomas_z + local_z)
		var stone_scale: float = 0.20 + float(index) * 0.045
		stone.scale = Vector3(stone_scale, stone_scale * 0.56, stone_scale)
		stone.rotation.y = 0.48 + float(index) * 0.73
		_apply_material(stone, ruin_material)
		tomas_root.add_child(stone)
	var tomas_marker: Node3D = RUIN_PILLAR.instantiate() as Node3D
	if tomas_marker != null:
		tomas_marker.name = "LajeInscritaDeTomas"
		tomas_marker.position = Vector3(tomas_x - 0.34, _height_at(tomas_x - 0.34, tomas_z) - 0.03, tomas_z + 0.16)
		tomas_marker.scale = Vector3(0.24, 0.46, 0.24)
		tomas_marker.rotation = Vector3(0.06, -0.36, 0.02)
		_apply_material(tomas_marker, ruin_material)
		tomas_root.add_child(tomas_marker)
	_add_world_life_collision(tomas_root, "ColisorMarcoPedrasDeTomas", Vector3(tomas_x, _height_at(tomas_x, tomas_z) + 0.26, tomas_z), Vector3(0.96, 0.52, 1.54))

	# 2) Vegetação baixa na margem da estrada deixa o rio enquadrado, mas nunca forma uma parede de árvores.
	var margin_z: float = 49.0
	var margin_x: float = _road_x(margin_z) + 3.58
	var margin_root: Node3D = Node3D.new()
	margin_root.name = "PassagemMargemBaixa"
	landmarks.add_child(margin_root)
	var margin_rock: Node3D = SLOPE_ROCK.instantiate() as Node3D
	if margin_rock != null:
		margin_rock.name = "RochedoDaPassagemDeMargem"
		margin_rock.position = Vector3(margin_x + 0.42, _height_at(margin_x + 0.42, margin_z) + 0.02, margin_z - 0.34)
		margin_rock.scale = Vector3(0.30, 0.22, 0.30)
		margin_rock.rotation.y = -0.58
		_apply_material(margin_rock, ruin_material)
		margin_root.add_child(margin_rock)
	for index: int in range(4):
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern == null:
			continue
		fern.name = "FetoDaPassagemDeMargem_%02d" % (index + 1)
		var fern_x: float = margin_x + 0.52 + float(index % 2) * 0.72
		var fern_z: float = margin_z - 1.05 + float(index) * 0.66
		fern.position = Vector3(fern_x, _height_at(fern_x, fern_z) + 0.02, fern_z)
		var fern_scale: float = 0.40 + float(index % 2) * 0.07
		fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
		fern.rotation.y = float(index) * 1.13
		margin_root.add_child(fern)
	_add_world_life_collision(margin_root, "ColisorPassagemMargemBaixa", Vector3(margin_x + 0.42, _height_at(margin_x + 0.42, margin_z) + 0.18, margin_z - 0.34), Vector3(0.82, 0.36, 0.92))

	# 3) O vestígio baixo antecede o Arco sem competir com a sua silhueta em Z≈92.
	var ruin_z: float = 80.0
	var ruin_x: float = _road_x(ruin_z) - 3.62
	var ruin_root: Node3D = Node3D.new()
	ruin_root.name = "VestigioAntesDoArco"
	landmarks.add_child(ruin_root)
	var remnant: Node3D = RUIN_PILLAR.instantiate() as Node3D
	if remnant != null:
		remnant.name = "FragmentoDeMarcoPreArco"
		remnant.position = Vector3(ruin_x, _height_at(ruin_x, ruin_z) - 0.04, ruin_z)
		remnant.scale = Vector3(0.30, 0.72, 0.30)
		remnant.rotation = Vector3(0.12, 0.38, -0.06)
		_apply_material(remnant, ruin_material)
		ruin_root.add_child(remnant)
	for index: int in range(2):
		var debris: Node3D = RUIN_ROCK.instantiate() as Node3D
		if debris == null:
			continue
		debris.name = "PedraDoVestigioPreArco_%02d" % (index + 1)
		var debris_x: float = ruin_x + 0.52 + float(index) * 0.58
		var debris_z: float = ruin_z - 0.48 + float(index) * 0.82
		debris.position = Vector3(debris_x, _height_at(debris_x, debris_z) + 0.04, debris_z)
		var debris_scale: float = 0.21 + float(index) * 0.05
		debris.scale = Vector3(debris_scale, debris_scale * 0.62, debris_scale)
		debris.rotation.y = -0.56 + float(index) * 1.18
		_apply_material(debris, ruin_material)
		ruin_root.add_child(debris)
	_add_world_life_collision(ruin_root, "ColisorVestigioAntesDoArco", Vector3(ruin_x, _height_at(ruin_x, ruin_z) + 0.38, ruin_z), Vector3(0.88, 0.76, 0.96))

func _build_traveller_rest_point() -> void:
	# DEV2-R2-TRAVELLER-REST-003: ponto de observação silencioso, distinto da Casa Voss e do Acampamento Majestic.
	# Fica a leste da estrada, fora do leito de 4,15 m, sem save, cura, fogo ativo, partículas ou luz dinâmica.
	var rest_z: float = 64.0
	var rest_x: float = _road_x(rest_z) + 5.35
	var rest_root: Node3D = Node3D.new()
	rest_root.name = "PontoDescansoDoViajante"
	add_child(rest_root)
	var ground_y: float = _height_at(rest_x, rest_z)
	var rest_stone_mat: StandardMaterial3D = StandardMaterial3D.new()
	rest_stone_mat.albedo_color = Color(0.19, 0.17, 0.12, 1.0)
	rest_stone_mat.roughness = 0.94
	var cloth_mat: StandardMaterial3D = StandardMaterial3D.new()
	cloth_mat.albedo_color = Color(0.07, 0.09, 0.075, 1.0)
	cloth_mat.roughness = 0.96
	var wood_mat: StandardMaterial3D = StandardMaterial3D.new()
	wood_mat.albedo_color = Color(0.20, 0.12, 0.065, 1.0)
	wood_mat.roughness = 0.90

	# Abrigo baixo de pedra caída: enquadra o rio sem formar parede ou segundo arco.
	var shelter: Node3D = Node3D.new()
	shelter.name = "AbrigoBaixoDePedraCaida"
	rest_root.add_child(shelter)
	for index: int in range(3):
		var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rock == null:
			continue
		var side: float = -1.0 if index == 0 else 1.0
		rock.name = "PedraAbrigoViajante_%02d" % (index + 1)
		rock.position = Vector3(rest_x + side * (0.68 + (0.32 if index == 2 else 0.0)), _height_at(rest_x + side * 0.68, rest_z + float(index) * 0.38) + 0.28, rest_z + float(index - 1) * 0.42)
		rock.scale = Vector3(0.46 + float(index) * 0.05, 0.34 + float(index) * 0.05, 0.38)
		rock.rotation = Vector3(0.08 * side, 0.36 * float(index), -0.06 * side)
		_apply_material(rock, rest_stone_mat)
		shelter.add_child(rock)

	# Banco/laje orientado para a água e para a Montanha Orion, com colisor coincidente.
	var bench_mesh: BoxMesh = BoxMesh.new()
	bench_mesh.size = Vector3(1.72, 0.22, 0.62)
	var bench: MeshInstance3D = MeshInstance3D.new()
	bench.name = "LajeBancoDeObservacao"
	bench.mesh = bench_mesh
	bench.material_override = rest_stone_mat
	bench.position = Vector3(rest_x, ground_y + 0.48, rest_z - 0.08)
	bench.rotation.y = 0.10
	rest_root.add_child(bench)
	var bench_body: StaticBody3D = StaticBody3D.new()
	bench_body.name = "ColisorLajeBancoDeObservacao"
	bench_body.position = bench.position
	bench_body.rotation.y = bench.rotation.y
	var bench_collision: CollisionShape3D = CollisionShape3D.new()
	var bench_shape: BoxShape3D = BoxShape3D.new()
	bench_shape.size = Vector3(1.72, 0.22, 0.62)
	bench_collision.shape = bench_shape
	bench_body.add_child(bench_collision)
	rest_root.add_child(bench_body)

	# Mochila de Miguel e ferramentas desaparecidas: leitura narrativa, sem interação ou sistema de descanso.
	var pack_mesh: BoxMesh = BoxMesh.new()
	pack_mesh.size = Vector3(0.58, 0.72, 0.34)
	var pack: MeshInstance3D = MeshInstance3D.new()
	pack.name = "MochilaDeMiguel"
	pack.mesh = pack_mesh
	pack.material_override = cloth_mat
	pack.position = Vector3(rest_x + 0.96, ground_y + 0.38, rest_z + 0.32)
	pack.rotation = Vector3(0.10, -0.26, 0.12)
	rest_root.add_child(pack)
	for index: int in range(2):
		var tool_mesh: CylinderMesh = CylinderMesh.new()
		tool_mesh.top_radius = 0.035
		tool_mesh.bottom_radius = 0.045
		tool_mesh.height = 0.86
		var tool: MeshInstance3D = MeshInstance3D.new()
		tool.name = "FerramentaDesaparecida_%02d" % (index + 1)
		tool.mesh = tool_mesh
		tool.material_override = wood_mat
		tool.position = Vector3(rest_x + 1.06 + float(index) * 0.18, ground_y + 0.10, rest_z + 0.72 + float(index) * 0.12)
		tool.rotation = Vector3(0.12, 0.24 * float(index), 1.18 - float(index) * 0.16)
		rest_root.add_child(tool)

	# Fogueira extinta: apenas anel de pedras frias, sem OmniLight3D, emissão ou partículas.
	var hearth: Node3D = Node3D.new()
	hearth.name = "FogueiraExtintaSemLuz"
	rest_root.add_child(hearth)
	for index: int in range(5):
		var ember_rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if ember_rock == null:
			continue
		ember_rock.name = "PedraFogueiraFria_%02d" % (index + 1)
		var angle: float = TAU * float(index) / 5.0
		var fire_x: float = rest_x - 0.78 + cos(angle) * 0.48
		var fire_z: float = rest_z - 0.76 + sin(angle) * 0.48
		ember_rock.position = Vector3(fire_x, _height_at(fire_x, fire_z) + 0.08, fire_z)
		ember_rock.scale = Vector3(0.14, 0.09, 0.14)
		ember_rock.rotation.y = angle
		_apply_material(ember_rock, rest_stone_mat)
		hearth.add_child(ember_rock)

func _build_return_route_cairn() -> void:
	# DEV2-R2-RIVER-CAIRN-004: marco baixo de retorno, ambiental e sem segundo Arco ou barreira de passagem.
	var cairn_z: float = 31.0
	var cairn_x: float = _road_x(cairn_z) + 4.85
	var cairn_root: Node3D = Node3D.new()
	cairn_root.name = "MarcoCairnRegresso"
	add_child(cairn_root)
	var cairn_material: StandardMaterial3D = StandardMaterial3D.new()
	cairn_material.albedo_color = Color(0.22, 0.20, 0.15, 1.0)
	cairn_material.roughness = 0.95
	for index: int in range(3):
		var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if stone == null:
			continue
		var stone_x: float = cairn_x + float(index - 1) * 0.34
		var stone_z: float = cairn_z + float(index % 2) * 0.26
		stone.name = "PedraCairnRegresso_%02d" % (index + 1)
		stone.position = Vector3(stone_x, _height_at(stone_x, stone_z) + 0.12 + float(index) * 0.16, stone_z)
		stone.scale = Vector3(0.24 + float(index) * 0.04, 0.18 + float(index) * 0.06, 0.22 + float(index) * 0.03)
		stone.rotation = Vector3(0.04 * float(index), 0.52 * float(index), -0.06 * float(index))
		_apply_material(stone, cairn_material)
		cairn_root.add_child(stone)
	var fallen_slab_mesh: BoxMesh = BoxMesh.new()
	fallen_slab_mesh.size = Vector3(0.88, 0.14, 0.42)
	var fallen_slab: MeshInstance3D = MeshInstance3D.new()
	fallen_slab.name = "LajeTombadaDoCairn"
	fallen_slab.mesh = fallen_slab_mesh
	fallen_slab.material_override = cairn_material
	fallen_slab.position = Vector3(cairn_x + 0.02, _height_at(cairn_x, cairn_z - 0.46) + 0.08, cairn_z - 0.46)
	fallen_slab.rotation = Vector3(0.08, -0.18, 0.24)
	cairn_root.add_child(fallen_slab)
	var slab_body: StaticBody3D = StaticBody3D.new()
	slab_body.name = "ColisorLajeTombadaDoCairn"
	slab_body.position = fallen_slab.position
	slab_body.rotation = fallen_slab.rotation
	var slab_collision: CollisionShape3D = CollisionShape3D.new()
	var slab_shape: BoxShape3D = BoxShape3D.new()
	slab_shape.size = fallen_slab_mesh.size
	slab_collision.shape = slab_shape
	slab_body.add_child(slab_collision)
	cairn_root.add_child(slab_body)

func _add_world_life_collision(parent: Node3D, collision_name: String, center: Vector3, size: Vector3) -> void:
	var body: StaticBody3D = StaticBody3D.new()
	body.name = collision_name
	body.position = center
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = size
	var collision: CollisionShape3D = CollisionShape3D.new()
	collision.shape = shape
	body.add_child(collision)
	parent.add_child(body)

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
		# A aproximação ao Arco deixa de ler como degraus isolados: a malha prolonga-se, mas o volume físico e o eixo permanecem os mesmos.
		var approach_coverage: float = smoothstep(76.0, 120.0, z_value)
		var slab_depth: float = lerpf(1.34 + rng.randf_range(-0.12, 0.18), 2.42 + rng.randf_range(-0.10, 0.14), approach_coverage)
		slab.mesh = _make_slab(1.76 + rng.randf_range(-0.18, 0.20), slab_depth, rng)
		slab.material_override = path_material
		# Lajes funcionam como guia cartográfico; sem sombra própria evitam faixas negras repetitivas no GL Compatibility.
		slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.042, z_value)
		slab.rotation.y = atan2((_road_x(z_value + 1.0) - _road_x(z_value - 1.0)) * 0.5, 2.0) + rng.randf_range(-0.08, 0.08)
		road.add_child(slab)
		# Cada laje recebe um volume baixo: o caminho é físico sem criar degraus artificiais acima do terreno.
		var slab_body: StaticBody3D = StaticBody3D.new()
		slab_body.name = "ColisorLajeEstradaRio_%02d" % index
		slab_body.position = slab.position + Vector3(0.0, -0.045, 0.0)
		slab_body.rotation.y = slab.rotation.y
		var slab_collision: CollisionShape3D = CollisionShape3D.new()
		var slab_shape: BoxShape3D = BoxShape3D.new()
		slab_shape.size = Vector3(1.58, 0.16, 1.18)
		slab_collision.shape = slab_shape
		slab_body.add_child(slab_collision)
		road.add_child(slab_body)
	# CP-CARTO-11 — o primeiro corredor é a leitura imediata da saída da Casa Voss. Lajes intermédias compactas fecham os intervalos iniciais
	# sem mudar a escala dos 108 m até ao Arco, a largura do solo contínuo ou a posição lateral do rio.
	var infill_rng: RandomNumberGenerator = RandomNumberGenerator.new()
	infill_rng.seed = 10112
	for infill_index: int in range(7):
		var infill_z: float = 12.0 + (float(infill_index) + 0.5) * 108.0 / 37.0
		var infill_x: float = _road_x(infill_z)
		var infill: MeshInstance3D = MeshInstance3D.new()
		infill.name = "LajeContinuidadeEstradaRio_%02d" % infill_index
		infill.mesh = _make_slab(1.56 + infill_rng.randf_range(-0.10, 0.12), 1.70 + infill_rng.randf_range(-0.08, 0.10), infill_rng)
		infill.material_override = path_material
		infill.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		infill.position = Vector3(infill_x, _height_at(infill_x, infill_z) + 0.039, infill_z)
		infill.rotation.y = atan2((_road_x(infill_z + 1.0) - _road_x(infill_z - 1.0)) * 0.5, 2.0) + infill_rng.randf_range(-0.055, 0.055)
		road.add_child(infill)
		var infill_body: StaticBody3D = StaticBody3D.new()
		infill_body.name = "ColisorLajeContinuidadeEstradaRio_%02d" % infill_index
		infill_body.position = infill.position + Vector3(0.0, -0.045, 0.0)
		infill_body.rotation.y = infill.rotation.y
		var infill_collision: CollisionShape3D = CollisionShape3D.new()
		var infill_shape: BoxShape3D = BoxShape3D.new()
		infill_shape.size = Vector3(1.40, 0.16, 1.66)
		infill_collision.shape = infill_shape
		infill_body.add_child(infill_collision)
		road.add_child(infill_body)

func _build_river() -> void:
	var river_root: Node3D = Node3D.new()
	river_root.name = "RioDaEstrada_Norte"
	add_child(river_root)
	# Largura macro: o rio é uma camada de vale visível desde a Estrada, sem invadir a rota que se mantém a oeste.
	# A montante do limiar da Floresta a água afunila entre margens reais, em vez de surgir como uma faixa plana dominante.
	var width_start: float = 14.0
	var width_forest: float = 3.8
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(32):
		var z0: float = 8.0 + float(index) * 5.0
		var z1: float = z0 + 5.0
		var x0: float = _river_x(z0)
		var x1: float = _river_x(z1)
		var forest_t0: float = smoothstep(82.0, 112.0, z0)
		var forest_t1: float = smoothstep(82.0, 112.0, z1)
		var width0: float = lerpf(width_start, width_forest, forest_t0)
		var width1: float = lerpf(width_start, width_forest, forest_t1)
		# Lâmina ligeiramente acima do terreno local: mantém o curso contínuo no modo de compatibilidade sem invadir a estrada distante.
		var y0: float = (_height_at(x0 - width0 * 0.35, z0) + _height_at(x0 + width0 * 0.35, z0)) * 0.5 + 0.20
		var y1: float = (_height_at(x1 - width1 * 0.35, z1) + _height_at(x1 + width1 * 0.35, z1)) * 0.5 + 0.20
		# Cada segmento usa os quatro vértices da sua própria faixa. A versão anterior reutilizava x0 no bordo esquerdo seguinte,
		# esticando um triângulo na curva do rio e criando uma lâmina ciano plana no limiar Arco–Floresta.
		var left0: Vector3 = Vector3(x0 - width0 * 0.5, y0, z0)
		var right0: Vector3 = Vector3(x0 + width0 * 0.5, y0, z0)
		var left1: Vector3 = Vector3(x1 - width1 * 0.5, y1, z1)
		var right1: Vector3 = Vector3(x1 + width1 * 0.5, y1, z1)
		_add_water_triangle(surface, left0, left1, right0, Vector2(0.0, float(index) * 0.18), Vector2(0.0, float(index + 1) * 0.18), Vector2(1.0, float(index) * 0.18))
		_add_water_triangle(surface, right0, left1, right1, Vector2(1.0, float(index) * 0.18), Vector2(0.0, float(index + 1) * 0.18), Vector2(1.0, float(index + 1) * 0.18))
	var mesh: ArrayMesh = surface.commit()
	mesh.surface_set_material(0, _make_water_material())
	var water: MeshInstance3D = MeshInstance3D.new()
	water.name = "SuperficieRioEstrada"
	water.mesh = mesh
	water.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	river_root.add_child(water)
	# Rochas submersas no leito do rio: emergem ligeiramente acima da lâmina para criar leitura de profundidade e naturalizar o curso.
	# Sem colisores: o jogador não atravessa o rio; as rochas são apenas visuais.
	var bed_rock_mat: StandardMaterial3D = StandardMaterial3D.new()
	bed_rock_mat.albedo_color = Color(0.068, 0.095, 0.088, 1.0)
	bed_rock_mat.roughness = 0.82
	bed_rock_mat.emission_enabled = true
	bed_rock_mat.emission = Color(0.006, 0.016, 0.018, 1.0)
	bed_rock_mat.emission_energy_multiplier = 0.18
	var bed_rock_data: Array[Dictionary] = [
		{"z": 28.0, "dx": -1.4, "scale": 0.32, "yaw": 0.42},
		{"z": 52.0, "dx": 1.8, "scale": 0.28, "yaw": -1.12},
		{"z": 76.0, "dx": -0.6, "scale": 0.36, "yaw": 2.34},
		{"z": 102.0, "dx": 1.2, "scale": 0.30, "yaw": -0.78},
		# Pedras emergentes (CP 192): sobressaem acima da lâmina para criar leitura de profundidade adicional.
		{"z": 38.0, "dx": 0.6, "scale": 0.44, "yaw": 1.22},
		{"z": 64.0, "dx": -1.0, "scale": 0.38, "yaw": -0.55},
		{"z": 88.0, "dx": 1.5, "scale": 0.42, "yaw": 2.80},
	]
	for bed_data: Dictionary in bed_rock_data:
		var bz: float = bed_data["z"] as float
		var bx: float = _river_x(bz) + (bed_data["dx"] as float)
		var rock_width: float = lerpf(width_start, width_forest, smoothstep(82.0, 112.0, bz))
		var by: float = (_height_at(bx - rock_width * 0.35, bz) + _height_at(bx + rock_width * 0.35, bz)) * 0.5 + 0.08
		var bed_rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if bed_rock == null:
			continue
		bed_rock.name = "RochaDeLeitoDoRio_%s" % str(int(bz))
		bed_rock.position = Vector3(bx, by, bz)
		var bscale: float = bed_data["scale"] as float
		bed_rock.scale = Vector3(bscale, bscale * 0.62, bscale)
		bed_rock.rotation.y = bed_data["yaw"] as float
		_apply_material(bed_rock, bed_rock_mat)
		river_root.add_child(bed_rock)

func _build_first_orion_reflection() -> void:
	# R2: a primeira anomalia azul aparece como reflexo breve no curso, orientando o olhar para Orion.
	# É uma camada localizada e transparente; não torna a água emissiva de forma constante.
	var reflection_root: Node3D = Node3D.new()
	reflection_root.name = "PrimeiroReflexoAzulOrion"
	add_child(reflection_root)
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var z0: float = 43.0
	var z1: float = 56.0
	var width: float = 3.6
	var x0: float = _river_x(z0)
	var x1: float = _river_x(z1)
	var y0: float = (_height_at(x0 - width * 0.35, z0) + _height_at(x0 + width * 0.35, z0)) * 0.5 + 0.235
	var y1: float = (_height_at(x1 - width * 0.35, z1) + _height_at(x1 + width * 0.35, z1)) * 0.5 + 0.235
	var left0: Vector3 = Vector3(x0 - width * 0.5, y0, z0)
	var right0: Vector3 = Vector3(x0 + width * 0.5, y0, z0)
	var left1: Vector3 = Vector3(x1 - width * 0.5, y1, z1)
	var right1: Vector3 = Vector3(x1 + width * 0.5, y1, z1)
	_add_water_triangle(surface, left0, left1, right0, Vector2(0.0, 0.0), Vector2(0.0, 1.0), Vector2(1.0, 0.0))
	_add_water_triangle(surface, right0, left1, right1, Vector2(1.0, 0.0), Vector2(0.0, 1.0), Vector2(1.0, 1.0))
	var reflection: MeshInstance3D = MeshInstance3D.new()
	reflection.name = "ReflexoAzulOrientadoParaOrion"
	reflection.mesh = surface.commit()
	reflection.material_override = _make_orion_reflection_material()
	reflection.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	reflection_root.add_child(reflection)

func _build_orion_reflection_observation_station() -> void:
	# DEV2-R2-ORION-REFLECTION-002 — a anomalia é observada a partir de uma margem arqueológica;
	# a água continua apenas um pulso localizado e nunca se torna uma seta luminosa para o jogador seguir.
	var station_z: float = 51.0
	var river_center_x: float = _river_x(station_z)
	var river_width: float = 14.0
	var station_x: float = river_center_x - river_width * 0.5 - 1.55
	var ground_y: float = _height_at(station_x, station_z)
	var station: Node3D = Node3D.new()
	station.name = "EstacaoDeObservacaoDoReflexoOrion"
	add_child(station)

	# O pequeno patamar de cinco lajes é irregular e apontado para a água; fica longe do leito da Estrada.
	var slab_specs: Array[Dictionary] = [
		{"x": -0.68, "z": -1.06, "w": 0.88, "d": 0.98, "yaw": -0.16},
		{"x": 0.32, "z": -1.16, "w": 0.96, "d": 0.86, "yaw": 0.09},
		{"x": -0.82, "z": 0.00, "w": 0.92, "d": 1.06, "yaw": 0.12},
		{"x": 0.34, "z": -0.02, "w": 0.84, "d": 0.96, "yaw": -0.10},
		{"x": -0.20, "z": 1.03, "w": 1.10, "d": 0.90, "yaw": 0.03}
	]
	for index: int in range(slab_specs.size()):
		var spec: Dictionary = slab_specs[index]
		var slab_x: float = station_x + (spec["x"] as float)
		var slab_z: float = station_z + (spec["z"] as float)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeDaEstacaoOrion_%02d" % (index + 1)
		var slab_mesh: BoxMesh = BoxMesh.new()
		slab_mesh.size = Vector3(spec["w"] as float, 0.12, spec["d"] as float)
		slab.mesh = slab_mesh
		slab.material_override = path_material
		slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		slab.position = Vector3(slab_x, _height_at(slab_x, slab_z) + 0.075, slab_z)
		slab.rotation.y = spec["yaw"] as float
		station.add_child(slab)
		_add_world_life_collision(station, "ColisorLajeDaEstacaoOrion_%02d" % (index + 1), Vector3(slab_x, _height_at(slab_x, slab_z) + 0.015, slab_z), Vector3(spec["w"] as float, 0.12, spec["d"] as float))

	# Dois vestígios baixos moldam uma linha de visada em vez de um portão ou de uma barreira para a rota.
	for side: float in [-1.0, 1.0]:
		var marker: Node3D = RUIN_PILLAR.instantiate() as Node3D
		if marker == null:
			continue
		marker.name = "VestigioDaEstacaoOrion_%s" % ("Oeste" if side < 0.0 else "Este")
		var marker_x: float = station_x + side * 1.12
		var marker_z: float = station_z + 0.90
		marker.position = Vector3(marker_x, _height_at(marker_x, marker_z) - 0.05, marker_z)
		marker.scale = Vector3(0.24, 0.52 if side < 0.0 else 0.40, 0.24)
		marker.rotation = Vector3(0.08 * side, -0.34 + side * 0.22, 0.03 * side)
		_apply_material(marker, ruin_material)
		station.add_child(marker)
		_add_world_life_collision(station, "ColisorVestigioDaEstacaoOrion_%s" % ("Oeste" if side < 0.0 else "Este"), Vector3(marker_x, _height_at(marker_x, marker_z) + 0.24, marker_z), Vector3(0.48, 0.54, 0.48))

	# Pequenas pedras dirigem o olhar para o reflexo, sem luz adicional nem decoração em linha repetida.
	for index: int in range(3):
		var guide_stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if guide_stone == null:
			continue
		guide_stone.name = "PedraDeVisadaOrion_%02d" % (index + 1)
		var guide_x: float = station_x + 1.40 + float(index) * 0.62
		var guide_z: float = station_z - 0.82 + float(index) * 0.74
		guide_stone.position = Vector3(guide_x, _height_at(guide_x, guide_z) + 0.035, guide_z)
		var guide_scale: float = 0.13 + float(index) * 0.032
		guide_stone.scale = Vector3(guide_scale, guide_scale * 0.60, guide_scale)
		guide_stone.rotation.y = -0.46 + float(index) * 0.39
		_apply_material(guide_stone, ruin_material)
		station.add_child(guide_stone)

func _make_orion_reflection_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode cull_disabled, unshaded, blend_mix, depth_draw_never;
void fragment() {
	float phase = fract(TIME / 9.0);
	float rise = smoothstep(0.04, 0.14, phase);
	float fall = 1.0 - smoothstep(0.34, 0.58, phase);
	float ripple = 0.5 + 0.5 * sin(UV.y * 34.0 - TIME * 2.2);
	float mask = rise * fall * (0.55 + ripple * 0.45);
	ALBEDO = vec3(0.055, 0.24, 0.34);
	// Godot 4 não expõe EMISSION_ENERGY em shaders spatial; a intensidade é aplicada na própria cor.
	EMISSION = vec3(0.033, 0.187, 0.286) * mask;
	ALPHA = 0.22 * mask;
}
"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	return material

func _build_positive_valley_bridge() -> void:
	# CP280 — ponte de leitura no eixo positivo: integra Casa, rio, Estrada e Arco na sequência do mapa.
	# É uma silhueta lateral sem colisor; a rota principal permanece na estrada ocidental e a ponte legada negativa não é tocada.
	var bridge_z: float = 58.0
	var bridge_x: float = _river_x(bridge_z)
	# Elevação de leitura CP286: separa a silhueta da ponte do talude e do curso de água sem aproximar o marco cartográfico.
	var bridge_y: float = (_height_at(bridge_x - 4.8, bridge_z) + _height_at(bridge_x + 4.8, bridge_z)) * 0.5 + 0.92
	var bridge_root: Node3D = Node3D.new()
	bridge_root.name = "PonteDeLeituraDoValePositivo"
	bridge_root.position = Vector3(bridge_x, bridge_y, bridge_z)
	bridge_root.rotation.y = PI * 0.5
	add_child(bridge_root)
	var bridge: Node3D = STONE_BRIDGE.instantiate() as Node3D
	if bridge != null:
		bridge.name = "PonteDePedraDoEixoPositivo"
		bridge.scale = Vector3(1.34, 1.05, 1.34)
		_apply_material(bridge, ruin_material)
		bridge_root.add_child(bridge)
	for side: float in [-1.0, 1.0]:
		var footing_x: float = bridge_x + side * 7.05
		var footing: Node3D = RUIN_ROCK.instantiate() as Node3D
		if footing == null:
			continue
		footing.name = "EncontroDaPonte_%s" % ("Oeste" if side < 0.0 else "Este")
		footing.position = Vector3(footing_x, _height_at(footing_x, bridge_z) + 0.02, bridge_z + side * 0.58)
		footing.scale = Vector3(0.78, 0.54, 0.84)
		footing.rotation = Vector3(0.05 * side, side * 0.46, -0.04 * side)
		_apply_material(footing, ruin_material)
		bridge_root.add_child(footing)

func _build_positive_bridge_approach() -> void:
	# DEV2-R2-RIVER-FOOTBRIDGE-005: aproximação arqueológica lateral à ponte positiva, sem tocar o eixo Casa Voss → Arco.
	var bridge_z: float = 58.0
	var bridge_x: float = _river_x(bridge_z)
	var approach_root: Node3D = Node3D.new()
	approach_root.name = "AproximacaoPonteLateralR2"
	add_child(approach_root)
	for side: float in [-1.0, 1.0]:
		var side_name: String = "Oeste" if side < 0.0 else "Este"
		var bank_x: float = bridge_x + side * 5.65
		var bank_z: float = bridge_z + side * 1.18
		var bank: Node3D = RUIN_ROCK.instantiate() as Node3D
		if bank != null:
			bank.name = "EncontroBaixoAproximacaoPonte_%s" % side_name
			bank.position = Vector3(bank_x, _height_at(bank_x, bank_z) + 0.10, bank_z)
			bank.scale = Vector3(0.58, 0.34, 0.46)
			bank.rotation = Vector3(0.06 * side, 0.42 * side, -0.04)
			_apply_material(bank, ruin_material)
			approach_root.add_child(bank)
			_add_world_life_collision(approach_root, "ColisorEncontroBaixoPonte_%s" % side_name, Vector3(bank_x, _height_at(bank_x, bank_z) + 0.28, bank_z), Vector3(0.92, 0.56, 0.86))
		for index: int in range(2):
			var slab_x: float = bank_x - side * (0.92 + float(index) * 0.72)
			var slab_z: float = bank_z + side * (0.62 + float(index) * 0.78)
			var access_slab: MeshInstance3D = MeshInstance3D.new()
			access_slab.name = "LajePartidaAcessoPonte_%s_%02d" % [side_name, index + 1]
			var slab_mesh: BoxMesh = BoxMesh.new()
			slab_mesh.size = Vector3(0.78 - float(index) * 0.08, 0.11, 0.62 + float(index) * 0.06)
			access_slab.mesh = slab_mesh
			access_slab.material_override = path_material
			access_slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
			access_slab.position = Vector3(slab_x, _height_at(slab_x, slab_z) + 0.075, slab_z)
			access_slab.rotation.y = -0.18 * side + 0.08 * float(index)
			approach_root.add_child(access_slab)
			_add_world_life_collision(approach_root, "ColisorLajeAcessoPonte_%s_%02d" % [side_name, index + 1], Vector3(slab_x, _height_at(slab_x, slab_z) + 0.02, slab_z), slab_mesh.size)
			var fern: Node3D = FERN.instantiate() as Node3D
			if fern != null:
				fern.name = "FetoAcessoPonte_%s_%02d" % [side_name, index + 1]
				fern.position = Vector3(slab_x + side * 0.58, _height_at(slab_x + side * 0.58, slab_z) + 0.02, slab_z + side * 0.26)
				fern.scale = Vector3(0.30 + float(index) * 0.05, 0.30 + float(index) * 0.05, 0.30 + float(index) * 0.05)
				fern.rotation.y = side * 0.65 + float(index) * 0.42
				approach_root.add_child(fern)

func _build_orion_reflection_lookout() -> void:
	# DEV2-R2-RIVER-LOOKOUT-030: micro-miradouro físico para ler o reflexo Orion e reter a orientação de retorno.
	# Uma única laje lateral cria um ponto jogável, sem corredor novo para o rio, painel, luz ou emissão.
	var lookout_root: Node3D = Node3D.new()
	lookout_root.name = "MiradouroReflexoOrionR2"
	add_child(lookout_root)
	var lookout_z: float = 56.0
	var lookout_x: float = _road_x(lookout_z) + 5.90
	var ground_y: float = _height_at(lookout_x, lookout_z)
	var lookout_material: StandardMaterial3D = StandardMaterial3D.new()
	lookout_material.albedo_color = Color(0.16, 0.18, 0.16, 1.0)
	lookout_material.roughness = 0.91
	var slab_mesh: BoxMesh = BoxMesh.new()
	slab_mesh.size = Vector3(1.48, 0.16, 1.02)
	var slab: MeshInstance3D = MeshInstance3D.new()
	slab.name = "LajeMiradouroReflexoOrion"
	slab.mesh = slab_mesh
	slab.material_override = lookout_material
	slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	slab.position = Vector3(lookout_x, ground_y + 0.10, lookout_z)
	slab.rotation = Vector3(0.02, -0.12, 0.04)
	lookout_root.add_child(slab)
	var body: StaticBody3D = StaticBody3D.new()
	body.name = "ColisorLajeMiradouroReflexoOrion"
	body.position = slab.position
	body.rotation = slab.rotation
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = slab_mesh.size
	collision.shape = shape
	body.add_child(collision)
	lookout_root.add_child(body)
	for index: int in range(2):
		var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if stone == null:
			continue
		stone.name = "PedraVisadaReflexoOrion_%02d" % (index + 1)
		var side: float = -1.0 if index == 0 else 1.0
		stone.position = Vector3(lookout_x + side * 0.78, _height_at(lookout_x + side * 0.78, lookout_z + 0.18) + 0.08, lookout_z + 0.18)
		stone.scale = Vector3(0.18 + float(index) * 0.03, 0.13 + float(index) * 0.025, 0.20)
		stone.rotation.y = side * 0.44
		_apply_material(stone, lookout_material)
		lookout_root.add_child(stone)
	var fern: Node3D = FERN.instantiate() as Node3D
	if fern != null:
		fern.name = "FetoMiradouroReflexoOrion"
		fern.position = Vector3(lookout_x + 0.72, _height_at(lookout_x + 0.72, lookout_z - 0.42) + 0.02, lookout_z - 0.42)
		fern.scale = Vector3(0.24, 0.24, 0.24)
		fern.rotation.y = 0.52
		lookout_root.add_child(fern)

func _build_return_confirmation_landing() -> void:
	# DEV2-R2-RIVER-RETURN-031: laje lateral de confirmação Casa Voss, sem seta, painel ou interação obrigatória.
	# O ponto fica no lado oposto ao miradouro Orion e orienta a leitura para trás sem abrir atalho ao leito.
	var landing_root: Node3D = Node3D.new()
	landing_root.name = "LajeConfirmacaoRetornoVossR2"
	add_child(landing_root)
	var landing_z: float = 58.0
	var landing_x: float = _road_x(landing_z) - 4.85
	var ground_y: float = _height_at(landing_x, landing_z)
	var landing_material: StandardMaterial3D = StandardMaterial3D.new()
	landing_material.albedo_color = Color(0.14, 0.17, 0.15, 1.0)
	landing_material.roughness = 0.94
	var slab_mesh: BoxMesh = BoxMesh.new()
	slab_mesh.size = Vector3(1.32, 0.14, 0.88)
	var slab: MeshInstance3D = MeshInstance3D.new()
	slab.name = "LajeConfirmacaoRetornoVoss"
	slab.mesh = slab_mesh
	slab.material_override = landing_material
	slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	slab.position = Vector3(landing_x, ground_y + 0.08, landing_z)
	slab.rotation = Vector3(-0.02, 0.18, -0.04)
	landing_root.add_child(slab)
	var body: StaticBody3D = StaticBody3D.new()
	body.name = "ColisorLajeConfirmacaoRetornoVoss"
	body.position = slab.position
	body.rotation = slab.rotation
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = slab_mesh.size
	collision.shape = shape
	body.add_child(collision)
	landing_root.add_child(body)
	for index: int in range(2):
		var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if stone == null:
			continue
		stone.name = "PedraConfirmacaoRetornoVoss_%02d" % (index + 1)
		var side: float = -1.0 if index == 0 else 1.0
		stone.position = Vector3(landing_x + side * 0.72, _height_at(landing_x + side * 0.72, landing_z + 0.22) + 0.06, landing_z + 0.22)
		stone.scale = Vector3(0.17 + float(index) * 0.025, 0.12 + float(index) * 0.02, 0.19)
		stone.rotation.y = -side * 0.38
		_apply_material(stone, landing_material)
		landing_root.add_child(stone)
	var fern: Node3D = FERN.instantiate() as Node3D
	if fern != null:
		fern.name = "FetoConfirmacaoRetornoVoss"
		fern.position = Vector3(landing_x - 0.66, _height_at(landing_x - 0.66, landing_z - 0.38) + 0.02, landing_z - 0.38)
		fern.scale = Vector3(0.22, 0.22, 0.22)
		fern.rotation.y = -0.48
		landing_root.add_child(fern)

func _build_river_margins() -> void:
	# Rochas, fetos e uma pequena seleção de colisores tornam o rio uma margem explorável, não uma faixa de água isolada.
	var margins: Node3D = Node3D.new()
	margins.name = "MargensRochosasDaEstradaDoRio"
	add_child(margins)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 10139
	var wet_material: StandardMaterial3D = StandardMaterial3D.new()
	wet_material.albedo_color = Color(0.075, 0.115, 0.105, 1.0)
	wet_material.roughness = 0.78
	wet_material.emission_enabled = true
	wet_material.emission = Color(0.008, 0.020, 0.022, 1.0)
	wet_material.emission_energy_multiplier = 0.20
	for index: int in range(28):
		var z_value: float = 14.0 + float(index) * 4.90
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var river_center: float = _river_x(z_value)
		var x_value: float = river_center + side * (5.80 + float(index % 3) * 0.42)
		var ground_y: float = _height_at(x_value, z_value)
		var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaMargemRio_%02d" % index
			rock.position = Vector3(x_value, ground_y + 0.06, z_value + rng.randf_range(-1.0, 1.0))
			var rock_scale: float = 0.14 + float(index % 4) * 0.035
			rock.scale = Vector3(rock_scale, rock_scale * 0.76, rock_scale)
			rock.rotation.y = rng.randf_range(-PI, PI)
			_apply_material(rock, wet_material)
			margins.add_child(rock)
			if index % 4 == 0:
				var rock_body: StaticBody3D = StaticBody3D.new()
				rock_body.name = "ColisorRochaMargemRio_%02d" % index
				rock_body.position = rock.position + Vector3(0.0, 0.35, 0.0)
				var rock_collision: CollisionShape3D = CollisionShape3D.new()
				var rock_shape: BoxShape3D = BoxShape3D.new()
				rock_shape.size = Vector3(0.92, 0.70, 0.90)
				rock_collision.shape = rock_shape
				rock_body.add_child(rock_collision)
				margins.add_child(rock_body)
		if index % 2 == 0:
			var fern: Node3D = FERN.instantiate() as Node3D
			if fern != null:
				fern.name = "FetoMargemRio_%02d" % index
				fern.position = Vector3(x_value + side * 0.86, ground_y + 0.025, z_value + rng.randf_range(-0.82, 0.82))
				var fern_scale: float = 0.38 + float(index % 3) * 0.065
				fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
				fern.rotation.y = rng.randf_range(-PI, PI)
				margins.add_child(fern)

func _build_pre_arch_river_edge() -> void:
	# DEV2-R2-RIVER-EDGE-006: margem geológica curta antes do Arco; visual lateral, sem rota alternativa ou luz nova.
	var edge_root: Node3D = Node3D.new()
	edge_root.name = "MargemGeologicaAntesDoArcoR2"
	add_child(edge_root)
	var wet_edge_material: StandardMaterial3D = StandardMaterial3D.new()
	wet_edge_material.albedo_color = Color(0.10, 0.14, 0.13, 1.0)
	wet_edge_material.roughness = 0.84
	wet_edge_material.emission_enabled = false
	var edge_specs: Array[Dictionary] = [
		{"z": 73.0, "side": 1.0, "offset": 6.90, "scale": 0.62, "yaw": -0.34},
		{"z": 82.0, "side": -1.0, "offset": 6.55, "scale": 0.54, "yaw": 0.48}
	]
	for index: int in range(edge_specs.size()):
		var spec: Dictionary = edge_specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var x_value: float = _river_x(z_value) + side * (spec["offset"] as float)
		var outcrop: Node3D = SLOPE_ROCK.instantiate() as Node3D
		if outcrop != null:
			outcrop.name = "AfloramentoBaixoMargemArco_%02d" % (index + 1)
			outcrop.position = Vector3(x_value, _height_at(x_value, z_value) + 0.05, z_value)
			var scale_value: float = spec["scale"] as float
			outcrop.scale = Vector3(scale_value * 1.18, scale_value * 0.72, scale_value)
			outcrop.rotation.y = spec["yaw"] as float
			_apply_material(outcrop, wet_edge_material)
			edge_root.add_child(outcrop)
		for rock_index: int in range(3):
			var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
			if rock == null:
				continue
			rock.name = "PedraHumidaMargemArco_%02d_%02d" % [index + 1, rock_index + 1]
			var rock_x: float = x_value - side * (0.72 + float(rock_index) * 0.48)
			var rock_z: float = z_value - 0.62 + float(rock_index) * 0.58
			var rock_scale: float = 0.13 + float(rock_index) * 0.035
			rock.position = Vector3(rock_x, _height_at(rock_x, rock_z) + 0.035, rock_z)
			rock.scale = Vector3(rock_scale, rock_scale * 0.64, rock_scale)
			rock.rotation.y = 0.24 * float(rock_index) + side * 0.36
			_apply_material(rock, wet_edge_material)
			edge_root.add_child(rock)
		for fern_index: int in range(2):
			var fern: Node3D = FERN.instantiate() as Node3D
			if fern == null:
				continue
			fern.name = "FetoDispersoMargemArco_%02d_%02d" % [index + 1, fern_index + 1]
			var fern_x: float = x_value + side * (0.82 + float(fern_index) * 0.64)
			var fern_z: float = z_value + 0.18 + float(fern_index) * 0.72
			fern.position = Vector3(fern_x, _height_at(fern_x, fern_z) + 0.02, fern_z)
			fern.scale = Vector3(0.28 + float(fern_index) * 0.06, 0.28 + float(fern_index) * 0.06, 0.28 + float(fern_index) * 0.06)
			fern.rotation.y = side * 0.58 + float(fern_index) * 0.44
			edge_root.add_child(fern)

func _build_pre_arch_river_approach() -> void:
	# DEV2-R2-RIVER-APPROACH-007: leitura baixa do último trecho até ao Arco, sem criar rota nova para o rio.
	var approach_root: Node3D = Node3D.new()
	approach_root.name = "AproximacaoUltimoTrechoArcoR2"
	add_child(approach_root)
	var stone_material: StandardMaterial3D = StandardMaterial3D.new()
	stone_material.albedo_color = Color(0.16, 0.18, 0.16, 1.0)
	stone_material.roughness = 0.90
	var road_z: float = 87.0
	var road_x: float = _road_x(road_z)
	for index: int in range(2):
		var side: float = -1.0 if index == 0 else 1.0
		var slab_z: float = road_z + float(index) * 2.10
		var slab_x: float = road_x + side * 3.30
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeInterrompidaUltimoTrecho_%02d" % (index + 1)
		var slab_mesh: BoxMesh = BoxMesh.new()
		slab_mesh.size = Vector3(1.05, 0.12, 0.74)
		slab.mesh = slab_mesh
		slab.material_override = path_material
		slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		slab.position = Vector3(slab_x, _height_at(slab_x, slab_z) + 0.07, slab_z)
		slab.rotation = Vector3(0.02 * side, side * 0.22, -0.08 * side)
		approach_root.add_child(slab)
		_add_world_life_collision(approach_root, "ColisorLajeInterrompidaUltimoTrecho_%02d" % (index + 1), Vector3(slab_x, _height_at(slab_x, slab_z) + 0.02, slab_z), slab_mesh.size)
		var border: Node3D = RUIN_ROCK.instantiate() as Node3D
		if border != null:
			border.name = "PedraBordaUltimoTrecho_%02d" % (index + 1)
			border.position = Vector3(slab_x + side * 0.86, _height_at(slab_x + side * 0.86, slab_z) + 0.05, slab_z + side * 0.24)
			border.scale = Vector3(0.24, 0.18, 0.28)
			border.rotation.y = side * 0.58
			_apply_material(border, stone_material)
			approach_root.add_child(border)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoUltimoTrecho_%02d" % (index + 1)
			fern.position = Vector3(slab_x - side * 0.74, _height_at(slab_x - side * 0.74, slab_z) + 0.02, slab_z - side * 0.32)
			fern.scale = Vector3(0.27, 0.27, 0.27)
			fern.rotation.y = side * 0.44
			approach_root.add_child(fern)

func _build_final_river_edge_reading() -> void:
	# DEV2-R2-RIVER-EDGE-008: linha curta de pedras na margem final; visual lateral, leito não atravessável.
	var reading_root: Node3D = Node3D.new()
	reading_root.name = "LinhaPedrasMargemFinalR2"
	add_child(reading_root)
	var edge_material: StandardMaterial3D = StandardMaterial3D.new()
	edge_material.albedo_color = Color(0.12, 0.16, 0.15, 1.0)
	edge_material.roughness = 0.92
	for index: int in range(3):
		var z_value: float = 89.0 + float(index) * 1.25
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _river_x(z_value) + side * (6.40 + float(index) * 0.28)
		var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if stone != null:
			stone.name = "PedraLeituraMargemFinal_%02d" % (index + 1)
			stone.position = Vector3(x_value, _height_at(x_value, z_value) + 0.05, z_value)
			var stone_scale: float = 0.19 + float(index % 2) * 0.035
			stone.scale = Vector3(stone_scale, stone_scale * 0.58, stone_scale * 0.92)
			stone.rotation.y = -0.30 + float(index) * 0.42
			_apply_material(stone, edge_material)
			reading_root.add_child(stone)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoAbertoMargemFinal_%02d" % (index + 1)
			fern.position = Vector3(x_value - side * 0.82, _height_at(x_value - side * 0.82, z_value) + 0.02, z_value + 0.36)
			fern.scale = Vector3(0.24, 0.24, 0.24)
			fern.rotation.y = side * 0.52
			reading_root.add_child(fern)

func _build_recessed_river_approach() -> void:
	# DEV2-R2-RIVER-APPROACH-009: recuo lateral baixo antes do Arco, sem ampliar o leito nem criar atalho.
	var recess_root: Node3D = Node3D.new()
	recess_root.name = "RecuoMargemFinalArcoR2"
	add_child(recess_root)
	var wet_material: StandardMaterial3D = StandardMaterial3D.new()
	wet_material.albedo_color = Color(0.11, 0.15, 0.14, 1.0)
	wet_material.roughness = 0.94
	var base_z: float = 84.5
	var base_x: float = _river_x(base_z) + 6.85
	for index: int in range(2):
		var side: float = -1.0 if index == 0 else 1.0
		var z_value: float = base_z + float(index) * 1.55
		var x_value: float = base_x + side * 0.58
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeBaixaRecuoArco_%02d" % (index + 1)
		var slab_mesh: BoxMesh = BoxMesh.new()
		slab_mesh.size = Vector3(0.92, 0.10, 0.62)
		slab.mesh = slab_mesh
		slab.material_override = path_material
		slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.06, z_value)
		slab.rotation.y = side * 0.26
		recess_root.add_child(slab)
		_add_world_life_collision(recess_root, "ColisorLajeBaixaRecuoArco_%02d" % (index + 1), Vector3(x_value, _height_at(x_value, z_value) + 0.02, z_value), slab_mesh.size)
		var wet_stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if wet_stone != null:
			wet_stone.name = "PedraMolhadaRecuoArco_%02d" % (index + 1)
			wet_stone.position = Vector3(x_value + side * 0.96, _height_at(x_value + side * 0.96, z_value) + 0.04, z_value - 0.30)
			wet_stone.scale = Vector3(0.18, 0.11, 0.22)
			wet_stone.rotation.y = side * 0.48
			_apply_material(wet_stone, wet_material)
			recess_root.add_child(wet_stone)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoRecuoMargemArco_%02d" % (index + 1)
			fern.position = Vector3(x_value - side * 0.76, _height_at(x_value - side * 0.76, z_value) + 0.02, z_value + 0.30)
			fern.scale = Vector3(0.23, 0.23, 0.23)
			fern.rotation.y = -side * 0.38
			recess_root.add_child(fern)

func _build_return_voss_sightline() -> void:
	# DEV2-R2-RIVER-RETURN-010: visada ambiental baixa para Casa Voss, lateral e sem seta ou interação.
	var sightline_root: Node3D = Node3D.new()
	sightline_root.name = "VisadaRetornoCasaVossR2"
	add_child(sightline_root)
	var reference_material: StandardMaterial3D = StandardMaterial3D.new()
	reference_material.albedo_color = Color(0.13, 0.16, 0.15, 1.0)
	reference_material.roughness = 0.93
	var base_z: float = 67.5
	var base_x: float = _road_x(base_z) + 4.85
	for index: int in range(2):
		var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if stone == null:
			continue
		var side: float = -1.0 if index == 0 else 1.0
		var stone_x: float = base_x + side * 0.88
		var stone_z: float = base_z + float(index) * 1.18
		stone.name = "PedraReferenciaRetornoVoss_%02d" % (index + 1)
		stone.position = Vector3(stone_x, _height_at(stone_x, stone_z) + 0.05, stone_z)
		stone.scale = Vector3(0.20, 0.14, 0.24)
		stone.rotation.y = side * 0.36
		_apply_material(stone, reference_material)
		sightline_root.add_child(stone)
	var slab: MeshInstance3D = MeshInstance3D.new()
	slab.name = "LajeCurtaVisadaRetornoVoss"
	var slab_mesh: BoxMesh = BoxMesh.new()
	slab_mesh.size = Vector3(0.86, 0.10, 0.52)
	slab.mesh = slab_mesh
	slab.material_override = path_material
	slab.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	slab.position = Vector3(base_x, _height_at(base_x, base_z + 0.58) + 0.06, base_z + 0.58)
	slab.rotation = Vector3(0.02, 0.16, -0.06)
	sightline_root.add_child(slab)
	_add_world_life_collision(sightline_root, "ColisorLajeCurtaVisadaRetornoVoss", Vector3(slab.position.x, slab.position.y - 0.04, slab.position.z), slab_mesh.size)

func _build_return_environment_markers() -> void:
	# DEV2-R2-RIVER-MARKER-011: dois marcadores ambientais baixos, sem sinalização explícita ou interação.
	var marker_root: Node3D = Node3D.new()
	marker_root.name = "MarcadoresAmbientaisRetornoR2"
	add_child(marker_root)
	var marker_material: StandardMaterial3D = StandardMaterial3D.new()
	marker_material.albedo_color = Color(0.14, 0.17, 0.15, 1.0)
	marker_material.roughness = 0.94
	for index: int in range(2):
		var side: float = -1.0 if index == 0 else 1.0
		var z_value: float = 63.5 + float(index) * 1.35
		var x_value: float = _road_x(z_value) + side * 5.25
		var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
		if stone != null:
			stone.name = "PedraMarcadorRetorno_%02d" % (index + 1)
			stone.position = Vector3(x_value, _height_at(x_value, z_value) + 0.04, z_value)
			stone.scale = Vector3(0.16, 0.20, 0.15)
			stone.rotation.y = side * 0.40
			_apply_material(stone, marker_material)
			marker_root.add_child(stone)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoMarcadorRetorno_%02d" % (index + 1)
			fern.position = Vector3(x_value - side * 0.55, _height_at(x_value - side * 0.55, z_value) + 0.02, z_value + 0.22)
			fern.scale = Vector3(0.19, 0.19, 0.19)
			fern.rotation.y = -side * 0.35
			marker_root.add_child(fern)

func _build_arch_forest_riparian_screen() -> void:
	# Três núcleos orgânicos escalonados na margem oeste: enquadram o afunilamento do rio a partir do Arco,
	# interrompem a leitura de faixa plana e preservam uma abertura ampla para o trilho cartográfico.
	var screen_root: Node3D = Node3D.new()
	screen_root.name = "NucleosRibeirinhosArcoFloresta"
	add_child(screen_root)
	var specs: Array[Dictionary] = [
		{"z": 94.0, "offset": -4.8, "scale": 0.30, "yaw": -0.28},
		{"z": 103.0, "offset": -5.7, "scale": 0.38, "yaw": 0.42},
		{"z": 112.0, "offset": -4.6, "scale": 0.28, "yaw": -0.56}
	]
	for index: int in range(specs.size()):
		var spec: Dictionary = specs[index]
		var z_value: float = spec["z"] as float
		var x_value: float = _river_x(z_value) + (spec["offset"] as float)
		var ground_y: float = _height_at(x_value, z_value)
		var tree: Node3D = DARK_TREE.instantiate() as Node3D
		if tree != null:
			tree.name = "ArvoreRibeirinhaDoLimiar_%02d" % (index + 1)
			tree.position = Vector3(x_value, ground_y, z_value)
			var tree_scale: float = spec["scale"] as float
			tree.scale = Vector3(tree_scale, tree_scale * (1.05 + float(index % 2) * 0.12), tree_scale)
			tree.rotation.y = spec["yaw"] as float
			screen_root.add_child(tree)
		var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rock != null:
			rock.name = "RochaRibeirinhaDoLimiar_%02d" % (index + 1)
			rock.position = Vector3(x_value - 1.05, _height_at(x_value - 1.05, z_value + 0.75) + 0.03, z_value + 0.75)
			rock.scale = Vector3(0.22 + float(index) * 0.035, 0.16 + float(index) * 0.024, 0.22 + float(index) * 0.035)
			rock.rotation.y = (spec["yaw"] as float) + 0.38
			_apply_material(rock, ruin_material)
			screen_root.add_child(rock)

func _build_macro_river_cutbanks() -> void:
	# Afloramentos de margem em escala intermédia: quebram a leitura de faixa plana de água e deixam a hidrologia orientar a vista.
	var cutbanks: Node3D = Node3D.new()
	cutbanks.name = "TaludesMacroDoRio"
	add_child(cutbanks)
	var wet_rock: StandardMaterial3D = StandardMaterial3D.new()
	wet_rock.albedo_color = Color(0.082, 0.115, 0.105, 1.0)
	wet_rock.roughness = 0.80
	var bank_data: Array[Dictionary] = [
		{"z": 31.0, "scale": 0.58, "yaw": 0.35},
		{"z": 49.0, "scale": 0.78, "yaw": -0.42},
		{"z": 68.0, "scale": 0.68, "yaw": 0.74},
		{"z": 87.0, "scale": 0.86, "yaw": -0.18},
		{"z": 106.0, "scale": 0.64, "yaw": 0.52}
	]
	for index: int in range(bank_data.size()):
		var data: Dictionary = bank_data[index]
		var z_value: float = data["z"] as float
		var x_value: float = _river_x(z_value) - 8.1
		var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "AfloramentoTaludeRio_%02d" % (index + 1)
		rock.position = Vector3(x_value, _height_at(x_value, z_value) - 0.05, z_value)
		var scale_value: float = data["scale"] as float
		rock.scale = Vector3(scale_value, scale_value * 0.72, scale_value)
		rock.rotation.y = data["yaw"] as float
		_apply_material(rock, wet_rock)
		cutbanks.add_child(rock)

func _build_ruin_arch() -> void:
	var arch: Node3D = Node3D.new()
	arch.name = "ArcoDasRuinas_EstradaDoRio"
	var arch_z: float = ARCH_WORLD_Z
	var arch_x: float = _road_x(arch_z)
	arch.position = Vector3(arch_x, _height_at(arch_x, arch_z), arch_z)
	add_child(arch)
	for offset_x: float in [-3.25, 3.25]:
		var pillar: Node3D = RUIN_PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarArcoEstrada_%.1f" % offset_x
		pillar.position = Vector3(offset_x, 0.0, 0.0)
		# Escala monumental: a ruína permanece em z=92, mas a silhueta supera o relevo intermédio e confirma o destino distante.
		pillar.scale = Vector3(1.70, 3.55, 1.70)
		pillar.rotation.y = signf(offset_x) * 0.08
		_apply_material(pillar, ruin_material)
		arch.add_child(pillar)
	# Núcleos de alvenaria regulares mantêm a silhueta do arco legível a partir da Estrada do Rio.
	for offset_x: float in [-3.25, 3.25]:
		var masonry_mesh: BoxMesh = BoxMesh.new()
		masonry_mesh.size = Vector3(1.48, 12.40, 1.72)
		var masonry: MeshInstance3D = MeshInstance3D.new()
		masonry.name = "NucleoDeAlvenaria_%.1f" % offset_x
		masonry.mesh = masonry_mesh
		masonry.position = Vector3(offset_x, 6.20, 0.0)
		masonry.material_override = ruin_material
		arch.add_child(masonry)
		# Volume físico coincidente com a alvenaria; mantém o vão central da estrada inteiramente livre.
		var pillar_body: StaticBody3D = StaticBody3D.new()
		pillar_body.name = "ColisorPilarArco_%.1f" % offset_x
		pillar_body.position = masonry.position
		var pillar_collision: CollisionShape3D = CollisionShape3D.new()
		var pillar_shape: BoxShape3D = BoxShape3D.new()
		pillar_shape.size = Vector3(1.48, 12.40, 1.72)
		pillar_collision.shape = pillar_shape
		pillar_body.add_child(pillar_collision)
		arch.add_child(pillar_body)
	var lintel_mesh: BoxMesh = BoxMesh.new()
	lintel_mesh.size = Vector3(10.60, 1.08, 1.68)
	var lintel: MeshInstance3D = MeshInstance3D.new()
	lintel.name = "LintelDoArcoEstrada"
	lintel.mesh = lintel_mesh
	lintel.position = Vector3(0.0, 12.72, 0.0)
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
	# Pedras de base (CP 193): naturalizam a transição entre os pilares e o solo, reforçando a leitura arqueológica.
	for base_side: float in [-3.25, 3.25]:
		var base_rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if base_rock != null:
			base_rock.name = "PedraDaBaseDoArco_%.1f" % base_side
			base_rock.position = Vector3(base_side, -0.12, 0.55)
			var base_scale: float = 0.34 if base_side < 0.0 else 0.30
			base_rock.scale = Vector3(base_scale, base_scale * 0.58, base_scale)
			base_rock.rotation.y = base_side * 0.22
			_apply_material(base_rock, ruin_material)
			arch.add_child(base_rock)
	_build_arch_grounding_clusters(arch)
	# Duas brasas litúrgicas tornam o arco reconhecível à distância, mantendo a luz concentrada no marco e não em toda a estrada.
	var ember_material: StandardMaterial3D = StandardMaterial3D.new()
	ember_material.albedo_color = Color(0.30, 0.075, 0.018, 1.0)
	ember_material.emission_enabled = true
	ember_material.emission = Color(0.42, 0.070, 0.012, 1.0)
	ember_material.emission_energy_multiplier = 0.40
	for ember_side: float in [-2.82, 2.82]:
		var ember_mesh: SphereMesh = SphereMesh.new()
		ember_mesh.radius = 0.10
		ember_mesh.height = 0.20
		ember_mesh.radial_segments = 12
		var ember: MeshInstance3D = MeshInstance3D.new()
		ember.name = "BrasaLiturgicaArco_%.1f" % ember_side
		ember.mesh = ember_mesh
		ember.material_override = ember_material
		ember.position = Vector3(ember_side, 3.15, -0.78)
		arch.add_child(ember)
		var light: OmniLight3D = OmniLight3D.new()
		light.name = "LuzLiturgicaArco_%.1f" % ember_side
		light.light_color = Color(0.82, 0.20, 0.045, 1.0)
		light.light_energy = 0.12
		light.omni_range = 2.8
		light.shadow_enabled = false
		light.position = ember.position
		arch.add_child(light)
	# Restos de coroamento quebram a perfeição do lintel; ficam acima ou fora do vão para não interferir com a rota física.
	for crown_index: int in range(5):
		var crown: Node3D = RUIN_ROCK.instantiate() as Node3D
		if crown == null:
			continue
		var crown_side: float = -1.0 if crown_index % 2 == 0 else 1.0
		crown.name = "FragmentoDaCoroaDoArco_%02d" % crown_index
		crown.position = Vector3(crown_side * (3.35 + float(crown_index % 3) * 1.22), 13.05 + float(crown_index % 2) * 0.46, -0.12 + float(crown_index % 2) * 0.48)
		var crown_scale: float = 0.14 + float(crown_index % 3) * 0.035
		crown.scale = Vector3(crown_scale, crown_scale * 0.78, crown_scale)
		crown.rotation = Vector3(0.16 * float(crown_index % 2), float(crown_index) * 0.68, 0.12 * crown_side)
		_apply_material(crown, ruin_material)
		arch.add_child(crown)
	# O marco conserva apenas as duas brasas litúrgicas: o preenchimento Omni anterior foi removido
	# para respeitar o contrato R3 (máximo de duas luzes dinâmicas locais).
	# Camada Dev3: inscrições e despertar persistente, sem criar luzes novas ou bloquear o vão do Arco.
	var r3_awakening = R3_ARCH_AWAKENING_SCRIPT.call("install", arch)
	if r3_awakening == null:
		push_error("[ORIGEM_R3] Não foi possível instalar o despertar do Arco.")

func _build_arch_grounding_clusters(arch: Node3D) -> void:
	# Grupos baixos e assimétricos de pedra quebram a transição recta pilar-solo. Estão fora do vão
	# central, não recebem colisores e não acrescentam luzes dinâmicas ao orçamento do corredor.
	var cluster_specs: Array[Dictionary] = [
		{"x": -4.50, "z": -1.28, "s": 0.28, "yaw": 0.36},
		{"x": -4.92, "z": 0.32, "s": 0.22, "yaw": -0.72},
		{"x": -4.30, "z": 1.56, "s": 0.17, "yaw": 1.08},
		{"x": 4.50, "z": 1.22, "s": 0.27, "yaw": -0.44},
		{"x": 4.94, "z": -0.34, "s": 0.20, "yaw": 0.88},
		{"x": 4.26, "z": -1.46, "s": 0.16, "yaw": -1.18},
	]
	for index: int in range(cluster_specs.size()):
		var spec: Dictionary = cluster_specs[index]
		var rubble: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rubble == null:
			continue
		rubble.name = "GrupoDeBaseArco_%02d" % index
		var scale_value: float = spec["s"] as float
		rubble.position = Vector3(spec["x"] as float, -0.11, spec["z"] as float)
		rubble.scale = Vector3(scale_value, scale_value * 0.60, scale_value * 0.92)
		rubble.rotation.y = spec["yaw"] as float
		_apply_material(rubble, ruin_material)
		arch.add_child(rubble)

func _build_cartographic_southwest_readability() -> void:
	# CP 218 — Leitura cartográfica do sudoeste: Casa Voss → Estrada do Rio → Arco.
	# Os marcos ficam fora das lajes para orientar o olhar pelo vale sem introduzir colisores no percurso principal.
	var cues: Node3D = Node3D.new()
	cues.name = "MarcosCartograficosSudoeste"
	add_child(cues)
	var cue_specs: Array[Dictionary] = [
		# A ordem mantém o mapa como autoridade; as posições físicas distribuem a viagem em profundidade macro.
		{"z": CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO.y + 4.0, "side": -1.0, "scale": 0.22, "name": "MarcoDaSaidaVoss"},
		{"z": 52.0, "side": 1.0, "scale": 0.26, "name": "MarcoDaCurvaDoRio"},
		{"z": ARCH_WORLD_Z - 14.0, "side": -1.0, "scale": 0.30, "name": "MarcoDaVistaDoArco"},
	]
	for cue_index: int in range(cue_specs.size()):
		var spec: Dictionary = cue_specs[cue_index]
		var z_value: float = float(spec["z"])
		var side: float = float(spec["side"])
		var base_x: float = _road_x(z_value) + side * 5.15
		var base_y: float = _height_at(base_x, z_value)
		var cairn: Node3D = Node3D.new()
		cairn.name = str(spec["name"])
		cairn.position = Vector3(base_x, base_y, z_value)
		cues.add_child(cairn)
		for stone_index: int in range(2):
			var stone: Node3D = RUIN_ROCK.instantiate() as Node3D
			if stone == null:
				continue
			stone.name = "PedraDeOrientacao_%02d" % stone_index
			var scale_value: float = float(spec["scale"]) * (1.0 - float(stone_index) * 0.18)
			stone.scale = Vector3(scale_value, scale_value * (0.68 + float(stone_index) * 0.18), scale_value)
			stone.position = Vector3(side * (0.22 + float(stone_index) * 0.34), 0.06 + float(stone_index) * 0.34, 0.10 - float(stone_index) * 0.16)
			stone.rotation = Vector3(0.05 * float(stone_index), side * (0.22 + float(stone_index) * 0.10), 0.08 * side)
			_apply_material(stone, ruin_material)
			cairn.add_child(stone)

func _build_arch_crown_stones() -> void:
	# CP 205: Pedras de topo no Arco das Ruínas para silhueta arqueológica mais rica.
	# Fragmentos irregulares no topo dos pilares e na verga para leitura de colapso.
	var arch_root: Node3D = get_node_or_null("RuinArch")
	if arch_root == null:
		arch_root = Node3D.new()
		arch_root.name = "RuinArchCrownStones"
		add_child(arch_root)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 50312
	var crown_mat: StandardMaterial3D = StandardMaterial3D.new()
	crown_mat.albedo_color = Color(0.16, 0.135, 0.09, 1.0)
	crown_mat.roughness = 0.93
	# Fragmentos no topo e lados do arco macro, agora recuado na Estrada para sustentar a profundidade do vale.
	var crown_positions: Array = [
		Vector3(_road_x(ARCH_WORLD_Z) - 4.8, _height_at(_road_x(ARCH_WORLD_Z) - 4.8, ARCH_WORLD_Z) + 11.3, ARCH_WORLD_Z),
		Vector3(_road_x(ARCH_WORLD_Z) + 4.8, _height_at(_road_x(ARCH_WORLD_Z) + 4.8, ARCH_WORLD_Z) + 11.0, ARCH_WORLD_Z),
		Vector3(_road_x(ARCH_WORLD_Z) - 4.5, _height_at(_road_x(ARCH_WORLD_Z) - 4.5, ARCH_WORLD_Z - 0.5) + 8.4, ARCH_WORLD_Z - 0.5),
		Vector3(_road_x(ARCH_WORLD_Z) + 4.6, _height_at(_road_x(ARCH_WORLD_Z) + 4.6, ARCH_WORLD_Z + 0.5) + 8.0, ARCH_WORLD_Z + 0.5),
		Vector3(_road_x(ARCH_WORLD_Z), _height_at(_road_x(ARCH_WORLD_Z), ARCH_WORLD_Z) + 12.2, ARCH_WORLD_Z),
	]
	for i: int in range(crown_positions.size()):
		var pos: Vector3 = crown_positions[i]
		var frag: Node3D = RUIN_ROCK.instantiate() as Node3D
		if frag == null:
			continue
		frag.name = "FragmentoCroa_%02d" % i
		# Fragmentos reais preservam o desgaste irregular da ruína, em vez de blocos rectangulares de greybox.
		var scale_value: float = rng.randf_range(0.095, 0.165)
		frag.scale = Vector3(
			scale_value * rng.randf_range(0.86, 1.18),
			scale_value * rng.randf_range(0.56, 0.88),
			scale_value * rng.randf_range(0.82, 1.12)
		)
		frag.position = pos
		frag.rotation = Vector3(
			rng.randf_range(-0.18, 0.18),
			rng.randf_range(-0.35, 0.35),
			rng.randf_range(-0.12, 0.12)
		)
		_apply_material(frag, crown_mat)
		arch_root.add_child(frag)


func _build_arch_approach_ecology() -> void:
	# Grupos laterais e descontínuos fazem a aproximação parecer uma margem antiga invadida pela vegetação, sem fechar o eixo de lajes.
	var ecology: Node3D = Node3D.new()
	ecology.name = "EcologiaDaAproximacaoDoArco"
	add_child(ecology)
	var placements: Array[Vector3] = [
		Vector3(-1.0, 0.0, ARCH_WORLD_Z - 32.0), Vector3(1.0, 0.0, ARCH_WORLD_Z - 25.0),
		Vector3(-1.0, 0.0, ARCH_WORLD_Z - 17.0), Vector3(1.0, 0.0, ARCH_WORLD_Z - 8.0),
		Vector3(-1.0, 0.0, ARCH_WORLD_Z + 7.0), Vector3(1.0, 0.0, ARCH_WORLD_Z + 14.0)
	]
	for index: int in range(placements.size()):
		var point: Vector3 = placements[index]
		var side: float = point.x
		var x_value: float = _road_x(point.z) + side * (4.85 + float(index % 2) * 0.72)
		var ground_y: float = _height_at(x_value, point.z)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoDaAproximacaoDoArco_%02d" % index
			fern.position = Vector3(x_value, ground_y + 0.025, point.z)
			var fern_scale: float = 0.38 + float(index % 3) * 0.055
			fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			fern.rotation.y = 0.46 + float(index) * 0.83
			ecology.add_child(fern)
		if index % 2 == 0:
			var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
			if rock == null:
				continue
			rock.name = "RochaDaAproximacaoDoArco_%02d" % index
			rock.position = Vector3(x_value + side * 0.72, ground_y + 0.06, point.z + 0.48)
			var rock_scale: float = 0.18 + float(index % 3) * 0.035
			rock.scale = Vector3(rock_scale, rock_scale * 0.72, rock_scale)
			rock.rotation.y = 0.34 + float(index) * 0.76
			_apply_material(rock, ruin_material)
			ecology.add_child(rock)

func _build_roadside_vegetation() -> void:
	var vegetation: Node3D = Node3D.new()
	vegetation.name = "VegetacaoEstradaDoRio"
	add_child(vegetation)
	# Núcleos espaçados: a sequência quebra a leitura de parede vegetal, conserva a floresta explorável e abre janelas para o Arco distante.
	var tree_specs: Array[Dictionary] = [
		{"z": 30.0, "side": -1.0, "offset": 8.4, "scale": 0.22, "oak": true, "yaw": 0.18},
		{"z": 42.0, "side": 1.0, "offset": 10.8, "scale": 0.25, "oak": false, "pine_pbr": true, "yaw": -0.46},
		{"z": 57.0, "side": -1.0, "offset": 12.6, "scale": 0.23, "oak": false, "yaw": 0.84},
		{"z": 74.0, "side": 1.0, "offset": 14.2, "scale": 0.29, "oak": true, "yaw": -0.30},
		# Sem árvores no eixo entre z=80 e z=94: a silhueta do Arco permanece legível na viagem real.
		{"z": 101.0, "side": -1.0, "offset": 13.8, "scale": 0.24, "oak": false, "yaw": 0.62},
		{"z": 112.0, "side": 1.0, "offset": 15.6, "scale": 0.30, "oak": true, "yaw": -0.74}
	]
	for index: int in range(tree_specs.size()):
		var spec: Dictionary = tree_specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var x_value: float = _road_x(z_value) + side * (spec["offset"] as float)
		# Um único pinheiro PBR focal introduz leitura vegetal real sem exceder o limite de LOD nem fechar a janela para o Arco.
		var tree_source: PackedScene = PINE_MEDIUM if bool(spec.get("pine_pbr", false)) else (OAK_DARK if bool(spec["oak"]) else DARK_TREE)
		var tree: Node3D = tree_source.instantiate() as Node3D
		if tree != null:
			tree.name = "NucleoDeArvoreEstrada_%02d" % index
			tree.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
			var tree_scale: float = spec["scale"] as float
			tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
			tree.rotation.y = spec["yaw"] as float
			vegetation.add_child(tree)

	for index: int in range(16):
		var z_value: float = 18.0 + float(index) * 6.0
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _road_x(z_value) + side * (3.5 + float(index % 3) * 0.8)
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.name = "FetoEstrada_%02d" % index
			fern.position = Vector3(x_value, _height_at(x_value, z_value) + 0.02, z_value)
			var fern_scale: float = 0.32 + float(index % 3) * 0.055
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
	# Matiz de pedra húmida: integra a Estrada do Rio à paleta florestal sem reduzir a leitura da rota física.
	# Tom mineral ligeiramente mais quente: mantém pedra húmida, mas separa a rota do solo florestal em média distância.
	material.albedo_color = Color(0.56, 0.54, 0.44, 1.0)
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.24
	material.roughness_texture = GROUND_ROUGHNESS
	material.roughness = 0.90
	material.uv1_scale = Vector3(0.34, 0.34, 0.34)
	return material

func _make_ruin_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = MOSSY_RUIN_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_RUIN_NORMAL
	material.normal_scale = 0.32
	material.roughness = 0.94
	# Resposta residual de material: retém a leitura do musgo e dos blocos no modo GL Compatibility sem transformar a ruína em luz própria.
	material.emission_enabled = true
	material.emission = Color(0.026, 0.040, 0.030, 1.0)
	material.emission_energy_multiplier = 0.30
	material.uv1_scale = Vector3(0.28, 0.28, 0.28)
	return material

func _make_water_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode cull_disabled, depth_draw_opaque, diffuse_burley;
void vertex() {
	VERTEX.y += sin(VERTEX.x * 0.52 + TIME * 0.9) * 0.042 + cos(VERTEX.z * 0.35 + TIME * 0.7) * 0.028;
}
void fragment() {
	// Fluxo longitudinal discreto: a água desloca a leitura ao longo do rio sem virar uma faixa emissiva.
	float flow = 0.5 + 0.5 * sin(UV.y * 26.0 - TIME * 1.15 + sin(UV.x * 8.0));
	float ripple = sin(UV.y * 18.0 + TIME * 0.85 + flow * 0.7) * 0.5 + 0.5;
			// Água de vale profunda: uma variação azul-petróleo discreta separa o leito das margens sem reflexo plano nem emissão.
		ALBEDO = mix(vec3(0.018, 0.084, 0.092), vec3(0.042, 0.198, 0.208), ripple * 0.28 + flow * 0.10 + 0.25);
		ROUGHNESS = 0.44;
		SPECULAR = 0.20;

	ALPHA = 1.0;
}
"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	return material

func _build_south_bend_ecology() -> void:
	# CP 195: ecologia da curva sul do rio (z=112-138).
	var south: Node3D = Node3D.new()
	south.name = "SouthBendEcology"
	add_child(south)
	var positions: Array = [
		[Vector3(_road_x(115.0) - 4.5, _height_at(_road_x(115.0) - 4.5, 115.0) + 0.05, 115.0), 0.22],
		[Vector3(_road_x(124.0) + 5.2, _height_at(_road_x(124.0) + 5.2, 124.0) + 0.05, 124.0), 0.19],
		[Vector3(_road_x(132.0) - 3.8, _height_at(_road_x(132.0) - 3.8, 132.0) + 0.05, 132.0), 0.25],
	]
	for pd in positions:
		var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rock != null:
			rock.position = pd[0]
			var s: float = pd[1]
			rock.scale = Vector3(s, s * 0.78, s)
			south.add_child(rock)
	var fern_positions: Array = [
		[Vector3(_road_x(119.0) + 4.8, _height_at(_road_x(119.0) + 4.8, 119.0) + 0.02, 119.0), 0.38],
		[Vector3(_road_x(128.0) - 4.2, _height_at(_road_x(128.0) - 4.2, 128.0) + 0.02, 128.0), 0.42],
	]
	for fp in fern_positions:
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern != null:
			fern.position = fp[0]
			var s: float = fp[1]
			fern.scale = Vector3(s, s, s)
			south.add_child(fern)

func _build_arch_wet_overlay() -> void:
	# CP 198: sobreposicao de pedra humida na zona do Arco (z=38-60).
	var arch_zone_mat: StandardMaterial3D = StandardMaterial3D.new()
	arch_zone_mat.albedo_color = Color(0.095, 0.082, 0.055, 1.0)
	arch_zone_mat.roughness = 0.92
	var arch_surface: SurfaceTool = SurfaceTool.new()
	arch_surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(9):
		var z0: float = 38.0 + float(index) * 2.5
		var z1: float = z0 + 2.5
		var x0: float = _road_x(z0)
		var x1: float = _road_x(z1)
		var aw: float = 5.20
		var ap00: Vector3 = Vector3(x0 - aw * 0.5, _height_at(x0 - aw * 0.5, z0) + 0.025, z0)
		var ap10: Vector3 = Vector3(x0 + aw * 0.5, _height_at(x0 + aw * 0.5, z0) + 0.025, z0)
		var ap01: Vector3 = Vector3(x1 - aw * 0.5, _height_at(x1 - aw * 0.5, z1) + 0.025, z1)
		var ap11: Vector3 = Vector3(x1 + aw * 0.5, _height_at(x1 + aw * 0.5, z1) + 0.025, z1)
		arch_surface.add_vertex(ap00); arch_surface.add_vertex(ap01); arch_surface.add_vertex(ap10)
		arch_surface.add_vertex(ap10); arch_surface.add_vertex(ap01); arch_surface.add_vertex(ap11)
	arch_surface.generate_normals()
	var arch_overlay: MeshInstance3D = MeshInstance3D.new()
	arch_overlay.name = "SoloHumidoZonaArco"
	arch_overlay.mesh = arch_surface.commit()
	arch_overlay.material_override = arch_zone_mat
	add_child(arch_overlay)

func _build_river_fill_light() -> void:
	# CP 206: Luz de preenchimento fria sobre o leito do rio para revelar as pedras emergentes.
	# Duas OmniLight3D de baixa energia posicionadas sobre a lâmina de água.
	var river_root: Node3D = Node3D.new()
	river_root.name = "RiverFillLights"
	add_child(river_root)
	# Luz 1: zona central do rio (z≈35, junto às pedras emergentes do CP 192)
	var fill1: OmniLight3D = OmniLight3D.new()
	fill1.name = "LuzRio_Centro"
	fill1.position = Vector3(0.0, 3.5, 35.0)
	fill1.light_color = Color(0.72, 0.82, 0.95, 1.0)
	fill1.light_energy = 0.55
	fill1.omni_range = 14.0
	fill1.shadow_enabled = false
	river_root.add_child(fill1)
	# Luz 2: zona norte do rio (z≈18, junto à margem sul do CP 195)
	var fill2: OmniLight3D = OmniLight3D.new()
	fill2.name = "LuzRio_Norte"
	fill2.position = Vector3(0.0, 3.5, 18.0)
	fill2.light_color = Color(0.68, 0.78, 0.92, 1.0)
	fill2.light_energy = 0.48
	fill2.omni_range = 12.0
	fill2.shadow_enabled = false
	river_root.add_child(fill2)


func _build_arch_base_ferns() -> void:
	# CP 207: Fetos na base dos pilares do Arco das Ruínas para ecologia arqueológica.
	# 4 fetos baixos em torno dos pilares (z≈48, x≈±4.5) para naturalizar a transição pedra-solo.
	var fern_root: Node3D = Node3D.new()
	fern_root.name = "ArchBaseFerns"
	add_child(fern_root)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 61204
	var fern_mat: StandardMaterial3D = StandardMaterial3D.new()
	fern_mat.albedo_color = Color(0.09, 0.13, 0.06, 1.0)
	fern_mat.roughness = 0.88
	# 4 fetos: 2 por pilar, alternados em x e z
	var fern_offsets: Array = [
		Vector3(-5.2, 0.0, 47.2),
		Vector3(-3.8, 0.0, 48.8),
		Vector3(5.1, 0.0, 47.5),
		Vector3(3.9, 0.0, 48.6),
	]
	for i: int in range(fern_offsets.size()):
		var fpos: Vector3 = fern_offsets[i]
		var fern: MeshInstance3D = MeshInstance3D.new()
		fern.name = "FernArco_%02d" % i
		var fmesh: CylinderMesh = CylinderMesh.new()
		fmesh.top_radius = 0.0
		fmesh.bottom_radius = rng.randf_range(0.28, 0.42)
		fmesh.height = rng.randf_range(0.55, 0.85)
		fmesh.radial_segments = 5
		fern.mesh = fmesh
		fern.material_override = fern_mat
		fern.position = fpos
		fern.rotation.y = rng.randf_range(0.0, TAU)
		fern_root.add_child(fern)


func _build_riparian_color_variation() -> void:
	# CP 209: Variação de cor nas margens ribeirinhas — alterna verde-musgo e castanho-seco
	# para quebrar a uniformidade visual e criar leitura de ecologia real.
	var var_root: Node3D = Node3D.new()
	var_root.name = "RiparianColorVariation"
	add_child(var_root)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 72815
	# 6 manchas de cor alternadas ao longo das margens (z=5 a z=70)
	var color_patches: Array = [
		{"pos": Vector3(-6.5, 0.05, 12.0), "col": Color(0.08, 0.12, 0.04, 1.0)},  # musgo escuro
		{"pos": Vector3(6.2, 0.05, 22.0), "col": Color(0.18, 0.12, 0.06, 1.0)},   # castanho seco
		{"pos": Vector3(-7.0, 0.05, 35.0), "col": Color(0.07, 0.11, 0.05, 1.0)},  # musgo húmido
		{"pos": Vector3(5.8, 0.05, 48.0), "col": Color(0.16, 0.10, 0.05, 1.0)},   # terra seca
		{"pos": Vector3(-6.0, 0.05, 58.0), "col": Color(0.09, 0.14, 0.04, 1.0)},  # musgo vivo
		{"pos": Vector3(6.5, 0.05, 68.0), "col": Color(0.14, 0.09, 0.04, 1.0)},   # folha morta
	]
	for patch: Dictionary in color_patches:
		var p: MeshInstance3D = MeshInstance3D.new()
		p.name = "AgrupamentoDeFolhagemBaixa"
		# Sem planos no mundo: cada agrupamento é um volume baixo real, moldado pela altura local do terreno.
		var pmesh: SphereMesh = SphereMesh.new()
		pmesh.radius = 0.5
		pmesh.height = 1.0
		pmesh.radial_segments = 12
		pmesh.rings = 6
		p.mesh = pmesh
		var pmat: StandardMaterial3D = StandardMaterial3D.new()
		pmat.albedo_color = patch["col"]
		pmat.roughness = 0.95
		p.material_override = pmat
		var authored_pos: Vector3 = patch["pos"] as Vector3
		p.position = Vector3(authored_pos.x, _height_at(authored_pos.x, authored_pos.z) + 0.030, authored_pos.z)
		p.scale = Vector3(rng.randf_range(1.8, 3.2), rng.randf_range(0.025, 0.055), rng.randf_range(1.4, 2.6))
		p.rotation.y = rng.randf_range(0.0, TAU)
		var_root.add_child(p)


func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
