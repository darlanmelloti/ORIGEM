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

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	stone_material = _make_stone_material()
	roof_material = _make_roof_material()
	path_material = _make_path_material()
	_build_lake_to_village_path()
	_build_elevated_village()
	_build_observatory()
	_build_mountain_trail()

func _height_at(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _build_lake_to_village_path() -> void:
	var route: Array[Vector2] = [Vector2(16.0, 288.0), Vector2(48.0, 302.0), Vector2(83.0, 318.0), Vector2(116.0, 336.0), Vector2(138.0, 354.0)]
	_build_flagstone_route("EstradaParaVilaElevada", route, 3.3)

func _build_elevated_village() -> void:
	var village: Node3D = Node3D.new()
	village.name = "VilaElevada"
	var village_x: float = 140.0
	var village_z: float = 352.0
	village.position = Vector3(village_x, _height_at(village_x, village_z) + 5.0, village_z)
	add_child(village)
	# Terraços orgânicos escalonados: afloramentos CC0 conformam a vila sem caixas de greybox.
	for terrace_index: int in range(3):
		var terrace: Node3D = ROCK_LARGE.instantiate() as Node3D
		if terrace == null:
			continue
		terrace.name = "AfloramentoTerraco_%02d" % terrace_index
		terrace.scale = Vector3(1.15 - float(terrace_index) * 0.10, 0.22, 0.78)
		terrace.rotation = Vector3(0.02, float(terrace_index) * 0.34, -0.03)
		terrace.position = Vector3(-float(terrace_index) * 3.5, 0.62 + float(terrace_index) * 3.4, float(terrace_index) * 8.0)
		_apply_material(terrace, stone_material)
		village.add_child(terrace)
	# Três casas-âncora preservam a leitura de vila e reduzem instâncias GLB para o orçamento GTX 1050.
	for house_index: int in range(3):
		var row: int = house_index / 3
		var col: int = house_index % 3
		var house: Node3D = _make_village_house(house_index)
		house.position = Vector3(-10.0 + float(col) * 10.0 - float(row) * 2.5, 1.26 + float(house_index) * 1.35, 2.0 + float(house_index) * 4.0)
		village.add_child(house)
	for pillar_index: int in range(4):
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.position = Vector3(-16.0 + float(pillar_index) * 10.0, 2.4, -4.5)
		pillar.scale = Vector3(0.46, 0.46, 0.46)
		_apply_material(pillar, stone_material)
		village.add_child(pillar)
	var village_lights: Array[Vector3] = [Vector3(-8.0, 6.0, 3.0), Vector3(2.0, 9.0, 9.0), Vector3(10.0, 7.0, 15.0)]
	for light_index: int in range(village_lights.size()):
		var beacon: OmniLight3D = OmniLight3D.new()
		beacon.name = "FachoRessonanciaVila_%02d" % light_index
		beacon.position = village_lights[light_index]
		beacon.light_color = Color("#d9a95f") if light_index < 2 else Color("#5cc8ff")
		beacon.light_energy = 2.10 if light_index < 2 else 2.65
		beacon.omni_range = 32.0
		beacon.shadow_enabled = true
		village.add_child(beacon)

func _make_village_house(index: int) -> Node3D:
	var house: Node3D = Node3D.new()
	house.name = "CasaDePedra_%02d" % index
	var base: Node3D = ROCK_LARGE.instantiate() as Node3D
	if base != null:
		base.name = "MassaOrganicaDaCasa"
		base.scale = Vector3(0.58, 0.70, 0.52)
		base.position = Vector3(0.0, 2.0, 0.0)
		_apply_material(base, stone_material)
		house.add_child(base)
	var roof: Node3D = ROCK_LARGE.instantiate() as Node3D
	if roof != null:
		roof.name = "CoberturaRochosaDaCasa"
		roof.scale = Vector3(0.66, 0.18, 0.58)
		roof.rotation = Vector3(0.18, 0.35, -0.08)
		roof.position = Vector3(0.0, 5.10, 0.0)
		_apply_material(roof, roof_material)
		house.add_child(roof)
	return house

func _build_observatory() -> void:
	var observatory: Node3D = Node3D.new()
	observatory.name = "ObservatorioDaOrion"
	var ox: float = 194.0
	var oz: float = 404.0
	observatory.position = Vector3(ox, _height_at(ox, oz), oz)
	add_child(observatory)
	var plinth_mesh: CylinderMesh = CylinderMesh.new()
	plinth_mesh.top_radius = 10.5
	plinth_mesh.bottom_radius = 12.0
	plinth_mesh.height = 3.2
	plinth_mesh.radial_segments = 24
	var plinth: MeshInstance3D = MeshInstance3D.new()
	plinth.mesh = plinth_mesh
	plinth.position = Vector3(0.0, 1.6, 0.0)
	plinth.material_override = stone_material
	observatory.add_child(plinth)
	var dome_mesh: SphereMesh = SphereMesh.new()
	dome_mesh.radius = 8.8
	dome_mesh.height = 5.0
	dome_mesh.radial_segments = 32
	var dome: MeshInstance3D = MeshInstance3D.new()
	dome.name = "DomoDoObservatorio"
	dome.mesh = dome_mesh
	dome.scale = Vector3(1.0, 0.44, 1.0)
	dome.position = Vector3(0.0, 5.0, 0.0)
	dome.material_override = stone_material
	observatory.add_child(dome)
	for index: int in range(6):
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		var angle: float = float(index) * TAU / 6.0
		pillar.position = Vector3(cos(angle) * 8.4, 3.1, sin(angle) * 8.4)
		pillar.scale = Vector3(0.55, 0.55, 0.55)
		_apply_material(pillar, stone_material)
		observatory.add_child(pillar)
	var beacon: OmniLight3D = OmniLight3D.new()
	beacon.name = "LuzDoObservatorio"
	beacon.light_color = Color(0.22, 0.56, 1.0, 1.0)
	beacon.light_energy = 2.1
	beacon.omni_range = 28.0
	beacon.position = Vector3(0.0, 8.4, 0.0)
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
