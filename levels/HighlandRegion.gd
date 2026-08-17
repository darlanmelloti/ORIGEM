## HighlandRegion.gd
## Marcos 7–9 do mapa regional: Vila Elevada, Observatório e Trilha da Montanha.
## Estruturas modulares leves, apoiadas no TerrainPatch regional e organizadas para futura expansão jogável.

extends Node3D

const PINE_TALL: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const FLAGSTONE: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")
const GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var roof_material: StandardMaterial3D
var path_material: StandardMaterial3D
var timber_material: StandardMaterial3D
var window_material: StandardMaterial3D
var beacon_material: StandardMaterial3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	stone_material = _make_stone_material()
	roof_material = _make_roof_material()
	path_material = _make_path_material()
	timber_material = _make_timber_material()
	window_material = _make_window_material()
	beacon_material = _make_beacon_material()
	_build_region7_handoff_chain()
	_build_lake_to_village_path()
	_build_elevated_village()
	_build_observatory()
	_build_mountain_trail()
	_build_highland_silhouette()

func _height_at(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _build_region7_handoff_chain() -> void:
	# CP-CINE-06: primeiras massas físicas da Região 7. Estendem a escala real R6→R7 sem aproximar a Vila ou Orion.
	# Não usam luzes, painéis ou colisores na faixa da rota; cada agrupamento é uma massa 3D explorável no bordo da subida.
	var handoff: Node3D = Node3D.new()
	handoff.name = "HandoffRemotoRegiao7"
	add_child(handoff)

	# Terraços baixos e descontínuos: lêem-se depois das Ruínas Submersas, mas deixam a estrada de x≈16→48 aberta.
	var passage_specs: Array[Dictionary] = [
		{"p": Vector2(34.0, 290.0), "s": 0.74, "yaw": 0.30},
		{"p": Vector2(48.0, 298.0), "s": 0.88, "yaw": -0.42},
		{"p": Vector2(66.0, 306.0), "s": 0.96, "yaw": 0.18}
	]
	var passage: Node3D = Node3D.new()
	passage.name = "TerracosDePassagemR7"
	handoff.add_child(passage)
	for index: int in range(passage_specs.size()):
		var spec: Dictionary = passage_specs[index]
		var point: Vector2 = spec["p"] as Vector2
		var base: Node3D = ROCK_LARGE.instantiate() as Node3D
		if base != null:
			base.name = "TerracoR7_%02d" % (index + 1)
			base.position = Vector3(point.x, _height_at(point.x, point.y) - 0.12, point.y)
			var scale_value: float = spec["s"] as float
			base.scale = Vector3(scale_value * 1.55, scale_value * 0.78, scale_value * 1.18)
			base.rotation.y = spec["yaw"] as float
			_apply_material(base, stone_material)
			passage.add_child(base)
		var remnant: Node3D = PILLAR.instantiate() as Node3D
		if remnant != null:
			remnant.name = "VestigioTerracoR7_%02d" % (index + 1)
			remnant.position = Vector3(point.x - 1.45, _height_at(point.x - 1.45, point.y + 0.7) - 0.05, point.y + 0.7)
			remnant.scale = Vector3(0.34, 0.70 + float(index) * 0.07, 0.34)
			remnant.rotation = Vector3(0.06, (spec["yaw"] as float) + 0.22, -0.05)
			_apply_material(remnant, stone_material)
			passage.add_child(remnant)

	# A borda inferior da Vila em socalcos antecipa a cidade principal de z≈352, sem criar uma muralha contínua.
	var village_edge: Node3D = Node3D.new()
	village_edge.name = "BordaBaixaDaVilaR7"
	handoff.add_child(village_edge)
	var edge_specs: Array[Dictionary] = [
		{"p": Vector2(88.0, 318.0), "s": 0.58, "yaw": -0.24},
		{"p": Vector2(104.0, 326.0), "s": 0.64, "yaw": 0.38},
		{"p": Vector2(118.0, 334.0), "s": 0.71, "yaw": -0.16}
	]
	for index: int in range(edge_specs.size()):
		var spec: Dictionary = edge_specs[index]
		var point: Vector2 = spec["p"] as Vector2
		var fragment: Node3D = ROCK_LARGE.instantiate() as Node3D
		if fragment != null:
			fragment.name = "MuroQuebradoR7_%02d" % (index + 1)
			fragment.position = Vector3(point.x, _height_at(point.x, point.y) - 0.06, point.y)
			var scale_value: float = spec["s"] as float
			fragment.scale = Vector3(scale_value * 1.75, scale_value * 0.98, scale_value * 0.86)
			fragment.rotation.y = spec["yaw"] as float
			_apply_material(fragment, stone_material)
			village_edge.add_child(fragment)
		var cap: Node3D = PILLAR.instantiate() as Node3D
		if cap != null:
			cap.name = "PilarBordaVilaR7_%02d" % (index + 1)
			cap.position = Vector3(point.x + 1.85, _height_at(point.x + 1.85, point.y - 0.9) - 0.05, point.y - 0.9)
			cap.scale = Vector3(0.30, 0.62 + float(index) * 0.06, 0.30)
			cap.rotation = Vector3(-0.04, (spec["yaw"] as float) - 0.28, 0.08)
			_apply_material(cap, stone_material)
			village_edge.add_child(cap)

	# Contrafortes: última camada antes da vila. Permanecem rochosos para manter aberto o eixo visual da estrada.
	var foothills: Node3D = Node3D.new()
	foothills.name = "ContrafortesDaSubidaR7"
	handoff.add_child(foothills)
	var foothill_specs: Array[Dictionary] = [
		{"p": Vector2(122.0, 338.0), "s": 1.06, "yaw": 0.34},
		{"p": Vector2(137.0, 346.0), "s": 1.22, "yaw": -0.40},
		{"p": Vector2(151.0, 354.0), "s": 1.34, "yaw": 0.20}
	]
	for index: int in range(foothill_specs.size()):
		var spec: Dictionary = foothill_specs[index]
		var point: Vector2 = spec["p"] as Vector2
		var cliff: Node3D = ROCK_LARGE.instantiate() as Node3D
		if cliff != null:
			cliff.name = "ContraforteR7_%02d" % (index + 1)
			cliff.position = Vector3(point.x, _height_at(point.x, point.y) - 0.18, point.y)
			var scale_value: float = spec["s"] as float
			cliff.scale = Vector3(scale_value * 1.15, scale_value * 1.45, scale_value)
			cliff.rotation.y = spec["yaw"] as float
			_apply_material(cliff, stone_material)
			foothills.add_child(cliff)

func _build_lake_to_village_path() -> void:
	var route: Array[Vector2] = [Vector2(16.0, 288.0), Vector2(48.0, 302.0), Vector2(83.0, 318.0), Vector2(116.0, 336.0), Vector2(138.0, 354.0)]
	_build_flagstone_route("EstradaParaVilaElevada", route, 3.3)

func _build_elevated_village() -> void:
	var village: Node3D = Node3D.new()
	village.name = "VilaElevada"
	var village_x: float = 140.0
	var village_z: float = 352.0
	village.position = Vector3(village_x, _height_at(village_x, village_z), village_z)
	add_child(village)
	# Terraços quebrados: uma vila construída sobre a encosta, não uma muralha geométrica uniforme.
	for terrace_index: int in range(3):
		var width: float = 34.0 - float(terrace_index) * 4.8
		_add_box_mesh(village, "TerracoDePedra_%02d" % terrace_index, Vector3(-float(terrace_index) * 3.8, 0.60 + float(terrace_index) * 3.35, float(terrace_index) * 8.4), Vector3(width, 1.20, 13.4), stone_material)
		_add_box_mesh(village, "MuroDoTerraco_%02d" % terrace_index, Vector3(-float(terrace_index) * 3.8, 1.38 + float(terrace_index) * 3.35, float(terrace_index) * 8.4 - 5.9), Vector3(width - 2.6, 1.45, 0.75), stone_material)
	var house_positions: Array[Vector3] = [
		Vector3(-11.6, 1.28, 1.1), Vector3(-1.8, 1.28, 0.3), Vector3(8.3, 1.28, 1.5),
		Vector3(-8.8, 4.64, 9.5), Vector3(1.1, 4.64, 8.7), Vector3(9.5, 4.64, 10.0),
		Vector3(-5.8, 7.99, 17.3), Vector3(4.6, 7.99, 18.1)
	]
	for house_index: int in range(house_positions.size()):
		var house: Node3D = _make_village_house(house_index)
		house.position = house_positions[house_index]
		village.add_child(house)
	for pillar_index: int in range(4):
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.position = Vector3(-16.0 + float(pillar_index) * 10.4, 2.55, -4.8)
		pillar.scale = Vector3(0.52, 0.52, 0.52)
		pillar.rotation.y = 0.12 * float(pillar_index)
		_apply_material(pillar, stone_material)
		village.add_child(pillar)
	for lantern_index: int in range(4):
		var lantern: OmniLight3D = OmniLight3D.new()
		lantern.name = "LanternaDaVila_%02d" % lantern_index
		lantern.position = Vector3(-10.0 + float(lantern_index) * 7.0, 3.0 + float(lantern_index % 2) * 3.4, 4.0 + float(lantern_index % 2) * 8.0)
		lantern.light_color = Color(1.0, 0.43, 0.14, 1.0)
		lantern.light_energy = 0.65
		lantern.omni_range = 8.0
		lantern.shadow_enabled = false
		village.add_child(lantern)

func _make_village_house(index: int) -> Node3D:
	var house: Node3D = Node3D.new()
	house.name = "CasaDePedra_%02d" % index
	var width: float = 6.2 + float(index % 3) * 0.75
	var depth: float = 5.5 + float(index % 2) * 0.70
	var height: float = 3.5 + float(index % 3) * 0.38
	_add_box_mesh(house, "BaseDePedra", Vector3(0.0, height * 0.5, 0.0), Vector3(width, height, depth), stone_material)
	var roof_mesh: PrismMesh = PrismMesh.new()
	roof_mesh.size = Vector3(width + 0.75, 2.35, depth + 0.90)
	roof_mesh.left_to_right = 0.5
	var roof: MeshInstance3D = MeshInstance3D.new()
	roof.name = "TelhadoDeArdosia"
	roof.mesh = roof_mesh
	roof.position = Vector3(0.0, height + 1.0, 0.0)
	roof.material_override = roof_material
	house.add_child(roof)
	_add_box_mesh(house, "PortaDeMadeira", Vector3(0.0, 1.18, -depth * 0.51), Vector3(1.20, 2.35, 0.12), timber_material)
	for window_index: int in range(2):
		var offset_x: float = -width * 0.27 if window_index == 0 else width * 0.27
		_add_box_mesh(house, "JanelaQuente_%02d" % window_index, Vector3(offset_x, 2.10, -depth * 0.52), Vector3(0.92, 0.82, 0.08), window_material)
	_add_box_mesh(house, "VigaFrontal", Vector3(0.0, height - 0.45, -depth * 0.55), Vector3(width + 0.20, 0.20, 0.14), timber_material)
	if index % 2 == 0:
		_add_box_mesh(house, "Chamine", Vector3(width * 0.28, height + 1.85, depth * 0.14), Vector3(0.55, 2.10, 0.60), stone_material)
	return house

func _build_observatory() -> void:
	var observatory: Node3D = Node3D.new()
	observatory.name = "ObservatorioDaOrion"
	var ox: float = 194.0
	var oz: float = 404.0
	observatory.position = Vector3(ox, _height_at(ox, oz), oz)
	add_child(observatory)
	var plinth_mesh: CylinderMesh = CylinderMesh.new()
	plinth_mesh.top_radius = 10.8
	plinth_mesh.bottom_radius = 13.2
	plinth_mesh.height = 3.5
	plinth_mesh.radial_segments = 28
	var plinth: MeshInstance3D = MeshInstance3D.new()
	plinth.name = "BaseAstronomica"
	plinth.mesh = plinth_mesh
	plinth.position = Vector3(0.0, 1.75, 0.0)
	plinth.material_override = stone_material
	observatory.add_child(plinth)
	for ring_index: int in range(3):
		var ring_mesh: CylinderMesh = CylinderMesh.new()
		ring_mesh.top_radius = 9.4 - float(ring_index) * 1.55
		ring_mesh.bottom_radius = ring_mesh.top_radius + 0.30
		ring_mesh.height = 0.52
		ring_mesh.radial_segments = 28
		var ring: MeshInstance3D = MeshInstance3D.new()
		ring.name = "AnelAstronomico_%02d" % ring_index
		ring.mesh = ring_mesh
		ring.position = Vector3(0.0, 3.65 + float(ring_index) * 1.38, 0.0)
		ring.material_override = stone_material
		observatory.add_child(ring)
	var dome_mesh: SphereMesh = SphereMesh.new()
	dome_mesh.radius = 8.5
	dome_mesh.height = 5.4
	dome_mesh.radial_segments = 32
	var dome: MeshInstance3D = MeshInstance3D.new()
	dome.name = "DomoDoObservatorio"
	dome.mesh = dome_mesh
	dome.scale = Vector3(1.0, 0.46, 1.0)
	dome.position = Vector3(0.0, 6.55, 0.0)
	dome.material_override = stone_material
	observatory.add_child(dome)
	for index: int in range(8):
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		var angle: float = float(index) * TAU / 8.0
		pillar.position = Vector3(cos(angle) * 9.5, 4.25, sin(angle) * 9.5)
		pillar.scale = Vector3(0.62, 0.72 + float(index % 2) * 0.08, 0.62)
		pillar.rotation = Vector3(0.05 * sin(angle), angle + 0.26, 0.04 * cos(angle))
		_apply_material(pillar, stone_material)
		observatory.add_child(pillar)
	var lens_mesh: SphereMesh = SphereMesh.new()
	lens_mesh.radius = 1.15
	lens_mesh.height = 2.30
	lens_mesh.radial_segments = 24
	var lens: MeshInstance3D = MeshInstance3D.new()
	lens.name = "LenteDeOrion"
	lens.mesh = lens_mesh
	lens.position = Vector3(0.0, 9.25, 0.0)
	lens.material_override = beacon_material
	observatory.add_child(lens)
	var beacon: OmniLight3D = OmniLight3D.new()
	beacon.name = "LuzDoObservatorio"
	beacon.light_color = Color(0.22, 0.56, 1.0, 1.0)
	beacon.light_energy = 2.8
	beacon.omni_range = 32.0
	beacon.position = Vector3(0.0, 9.2, 0.0)
	beacon.shadow_enabled = false
	observatory.add_child(beacon)

func _build_mountain_trail() -> void:
	var route: Array[Vector2] = [
		Vector2(174.0, 414.0), Vector2(130.0, 426.0), Vector2(76.0, 443.0),
		Vector2(28.0, 462.0), Vector2(-26.0, 482.0), Vector2(-76.0, 508.0), Vector2(-112.0, 532.0)
	]
	_build_flagstone_route("TrilhaDaMontanhaOrion", route, 4.1)
	var rocks: Node3D = Node3D.new()
	rocks.name = "AfloramentosDaTrilha"
	add_child(rocks)
	for index: int in range(20):
		var t: float = float(index) / 19.0
		var z_value: float = lerpf(430.0, 540.0, t)
		var x_value: float = lerpf(128.0, -114.0, t) + sin(t * PI * 5.0) * 8.0
		var rock: Node3D = ROCK_LARGE.instantiate() as Node3D
		if rock == null:
			continue
		rock.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
		var scale_value: float = 0.18 + fmod(float(index), 4.0) * 0.06
		rock.scale = Vector3(scale_value, scale_value, scale_value)
		rock.rotation.y = float(index) * 0.79
		rocks.add_child(rock)

func _build_flagstone_route(route_name: String, route: Array[Vector2], width: float) -> void:
	var path: Node3D = Node3D.new()
	path.name = route_name
	add_child(path)
	var slab_index: int = 0
	for segment_index: int in range(route.size() - 1):
		var start: Vector2 = route[segment_index]
		var finish: Vector2 = route[segment_index + 1]
		var distance: float = start.distance_to(finish)
		var count: int = max(1, int(distance / 3.0))
		for index: int in range(count):
			var t: float = float(index) / float(count)
			var point: Vector2 = start.lerp(finish, t)
			var next: Vector2 = start.lerp(finish, minf(t + 0.08, 1.0))
			var slab_mesh: BoxMesh = BoxMesh.new()
			slab_mesh.size = Vector3(width, 0.16, 2.2)
			var slab: MeshInstance3D = MeshInstance3D.new()
			slab.name = "Laje_%03d" % slab_index
			slab.mesh = slab_mesh
			slab.material_override = path_material
			slab.position = Vector3(point.x, _height_at(point.x, point.y) + 0.07, point.y)
			slab.rotation.y = atan2(next.x - point.x, next.y - point.y)
			path.add_child(slab)
			slab_index += 1

func _make_stone_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = MOSSY_RUIN_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_RUIN_NORMAL
	material.normal_scale = 0.30
	material.roughness = 0.95
	material.uv1_scale = Vector3(0.26, 0.26, 0.26)
	return material

func _build_highland_silhouette() -> void:
	var forest: Node3D = Node3D.new()
	forest.name = "SilhuetasDaVilaElevada"
	add_child(forest)
	var placements: Array[Vector3] = [
		Vector3(108.0, 0.0, 331.0), Vector3(119.0, 0.0, 372.0), Vector3(154.0, 0.0, 325.0),
		Vector3(172.0, 0.0, 362.0), Vector3(209.0, 0.0, 385.0), Vector3(216.0, 0.0, 423.0)
	]
	for index: int in range(placements.size()):
		var tree: Node3D = PINE_TALL.instantiate() as Node3D
		if tree == null:
			continue
		var point: Vector3 = placements[index]
		tree.name = "ConiferaElevada_%02d" % index
		tree.position = Vector3(point.x, _height_at(point.x, point.z), point.z)
		var scale_value: float = 0.38 + float(index % 3) * 0.08
		tree.scale = Vector3(scale_value, scale_value, scale_value)
		tree.rotation.y = 0.42 + float(index) * 0.84
		forest.add_child(tree)
	for index: int in range(12):
		var angle: float = 0.30 + float(index) * TAU / 12.0
		var x_value: float = 194.0 + cos(angle) * (15.0 + fmod(float(index), 3.0) * 2.8)
		var z_value: float = 404.0 + sin(angle) * (15.0 + fmod(float(index), 4.0) * 2.0)
		var rock: Node3D = ROCK_LARGE.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "RochaDoObservatorio_%02d" % index
		rock.position = Vector3(x_value, _height_at(x_value, z_value) + 0.08, z_value)
		var rock_scale: float = 0.18 + fmod(float(index), 4.0) * 0.055
		rock.scale = Vector3(rock_scale, rock_scale, rock_scale)
		rock.rotation.y = angle + 0.36
		forest.add_child(rock)

func _add_box_mesh(parent: Node3D, node_name: String, position_value: Vector3, size_value: Vector3, material: Material) -> MeshInstance3D:
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = size_value
	var instance: MeshInstance3D = MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = mesh
	instance.position = position_value
	instance.material_override = material
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(instance)
	return instance

func _make_timber_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.075, 0.038, 1.0)
	material.roughness = 0.87
	return material

func _make_window_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.80, 0.20, 0.045, 1.0)
	material.emission_enabled = true
	material.emission = Color(1.0, 0.18, 0.035, 1.0)
	material.emission_energy_multiplier = 1.30
	material.roughness = 0.55
	return material

func _make_beacon_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.08, 0.38, 0.86, 1.0)
	material.emission_enabled = true
	material.emission = Color(0.04, 0.38, 1.0, 1.0)
	material.emission_energy_multiplier = 2.2
	material.roughness = 0.26
	return material

func _make_roof_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.075, 0.09, 0.075, 1.0)
	material.roughness = 0.92
	return material

func _make_path_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.26
	material.roughness = 0.93
	material.uv1_scale = Vector3(0.34, 0.34, 0.34)
	return material

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
