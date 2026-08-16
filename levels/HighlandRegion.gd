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
	print("ORIGEM_REGION8_OBSERVATORY_READY ", observatory.global_position)
	var observatory_stone: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
	observatory_stone.albedo_color = Color("#64766d")
	observatory_stone.roughness = 0.78
	# Plataforma e cúpula orgânicas: a Região 8 usa massas CC0 em vez de primitivas de greybox.
	for shell_index: int in range(5):
		var shell: Node3D = ROCK_LARGE.instantiate() as Node3D
		if shell == null:
			continue
		var shell_angle: float = float(shell_index) * TAU / 5.0
		shell.name = "CascaOrganicaObservatorio_%02d" % shell_index
		shell.position = Vector3(cos(shell_angle) * 7.2, 1.8 + float(shell_index % 2) * 0.7, sin(shell_angle) * 7.2)
		shell.scale = Vector3(0.72, 0.32, 0.60)
		shell.rotation = Vector3(0.08, shell_angle, -0.04)
		_apply_material(shell, observatory_stone)
		observatory.add_child(shell)
	for crown_index: int in range(3):
		var crown: Node3D = ROCK_LARGE.instantiate() as Node3D
		if crown == null:
			continue
		crown.name = "CoroaOrganicaObservatorio_%02d" % crown_index
		crown.position = Vector3(-3.6 + float(crown_index) * 3.6, 5.0 + float(crown_index % 2) * 0.8, 0.0)
		crown.scale = Vector3(0.52, 0.46, 0.48)
		crown.rotation = Vector3(0.14, float(crown_index) * 0.7, -0.10)
		_apply_material(crown, observatory_stone)
		observatory.add_child(crown)
	for index: int in range(6):
		var pillar: Node3D = PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		var angle: float = float(index) * TAU / 6.0
		pillar.position = Vector3(cos(angle) * 8.4, 3.1, sin(angle) * 8.4)
		pillar.scale = Vector3(0.55, 0.55, 0.55)
		_apply_material(pillar, stone_material)
		observatory.add_child(pillar)
	var eye: Node3D = ROCK_LARGE.instantiate() as Node3D
	if eye != null:
		eye.name = "OlhoOrganicoDoObservatorio"
		eye.position = Vector3(0.0, 8.2, 0.0)
		eye.scale = Vector3(0.82, 0.64, 0.82)
		var eye_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
		eye_material.albedo_color = Color("#163c4c")
		eye_material.emission_enabled = true
		eye_material.emission = Color("#1a9bc2")
		eye_material.emission_energy_multiplier = 2.4
		_apply_material(eye, eye_material)
		observatory.add_child(eye)
	var beacon: OmniLight3D = OmniLight3D.new()
	beacon.name = "LuzDoObservatorio"
	beacon.light_color = Color(0.22, 0.72, 1.0, 1.0)
	beacon.light_energy = 5.2
	beacon.omni_range = 34.0
	beacon.position = Vector3(0.0, 8.4, 0.0)
	beacon.shadow_enabled = false
	observatory.add_child(beacon)
	for fill_index: int in range(2):
		var fill: OmniLight3D = OmniLight3D.new()
		fill.name = "PreenchimentoObservatorio_%02d" % fill_index
		fill.light_color = Color("#7dc7d8")
		fill.light_energy = 1.45
		fill.omni_range = 22.0
		fill.position = Vector3(-6.0 + float(fill_index) * 12.0, 4.0, 2.5)
		fill.shadow_enabled = false
		observatory.add_child(fill)
	var frontal_fill: OmniLight3D = OmniLight3D.new()
	frontal_fill.name = "PreenchimentoFrontalObservatorio"
	frontal_fill.light_color = Color("#b7dce2")
	frontal_fill.light_energy = 1.15
	frontal_fill.omni_range = 20.0
	frontal_fill.position = Vector3(0.0, 8.5, -8.0)
	frontal_fill.shadow_enabled = false
	observatory.add_child(frontal_fill)

func _build_mountain_trail() -> void:
	var route: Array[Vector2] = [
		Vector2(174.0, 414.0), Vector2(130.0, 426.0), Vector2(76.0, 443.0),
		Vector2(28.0, 462.0), Vector2(-26.0, 482.0), Vector2(-76.0, 508.0), Vector2(-112.0, 532.0)
	]
	_build_organic_route("TrilhaDaMontanhaOrion", route, 4.1)
	var trail_marker: Node3D = ROCK_LARGE.instantiate() as Node3D
	if trail_marker != null:
		trail_marker.name = "MarcoOrganicoEntradaTrilhaTake8"
		trail_marker.position = Vector3(169.0, _height_at(169.0, 414.0) + 1.35, 414.0)
		trail_marker.scale = Vector3(0.72, 1.25, 0.66)
		trail_marker.rotation = Vector3(0.08, -0.26, -0.05)
		_apply_material(trail_marker, stone_material)
		add_child(trail_marker)
		var entry_rocks: Array[Vector3] = [Vector3(162.0, 0.0, 416.0), Vector3(158.0, 0.0, 421.0), Vector3(166.0, 0.0, 424.0)]
		for entry_index: int in range(entry_rocks.size()):
			var entry_rock: Node3D = ROCK_LARGE.instantiate() as Node3D
			if entry_rock == null:
				continue
			var entry_point: Vector3 = entry_rocks[entry_index]
			entry_rock.name = "ArcoOrganicoEntradaTake8_%02d" % entry_index
			entry_rock.position = Vector3(entry_point.x, _height_at(entry_point.x, entry_point.z) + 0.9 + float(entry_index) * 0.35, entry_point.z)
			entry_rock.scale = Vector3(0.52, 0.78 + float(entry_index) * 0.16, 0.48)
			entry_rock.rotation.y = -0.32 + float(entry_index) * 0.44
			_apply_material(entry_rock, stone_material)
			add_child(entry_rock)
	var alpine_fill := DirectionalLight3D.new()
	alpine_fill.name = "RecorteAlpinoTrilhaTake8"
	alpine_fill.light_color = Color("#9fc4d4")
	alpine_fill.light_energy = 0.22
	alpine_fill.shadow_enabled = false
	alpine_fill.rotation_degrees = Vector3(-48.0, -32.0, 0.0)
	add_child(alpine_fill)
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

func _build_organic_route(route_name: String, route: Array[Vector2], width: float) -> void:
	var path: Node3D = Node3D.new()
	path.name = route_name
	add_child(path)
	var route_material: StandardMaterial3D = path_material.duplicate() as StandardMaterial3D
	route_material.emission_enabled = true
	route_material.emission = Color("#173b45")
	route_material.emission_energy_multiplier = 0.65
	var stone_index: int = 0
	for segment_index: int in range(route.size() - 1):
		var start: Vector2 = route[segment_index]
		var finish: Vector2 = route[segment_index + 1]
		var distance: float = start.distance_to(finish)
		var count: int = max(1, int(distance / 4.2))
		for index: int in range(count):
			var t: float = float(index) / float(count)
			var point: Vector2 = start.lerp(finish, t)
			var next: Vector2 = start.lerp(finish, minf(t + 0.08, 1.0))
			var stone: Node3D = ROCK_LARGE.instantiate() as Node3D
			if stone == null:
				continue
			stone.name = "DegrauOrganico_%03d" % stone_index
			stone.position = Vector3(point.x, _height_at(point.x, point.y) + 0.82, point.y)
			if OS.get_environment("ORIGEM_DEBUG_ROUTE") == "1" and (stone_index == 0 or stone_index == 5 or stone_index == 10):
				print("[REGIAO8_9_ROUTE] index=%d world=%s" % [stone_index, str(stone.position)])
			stone.scale = Vector3(width * 0.18, 0.10 + fmod(float(stone_index), 3.0) * 0.025, 0.28)
			stone.rotation = Vector3(0.03, atan2(next.x - point.x, next.y - point.y), -0.04)
			_apply_material(stone, route_material)
			var stone_body := StaticBody3D.new()
			stone_body.name = "ColisaoTrilhaMontanha_%03d" % stone_index
			stone_body.collision_layer = 1
			stone_body.collision_mask = 1
			var stone_shape := CollisionShape3D.new()
			var stone_box := BoxShape3D.new()
			stone_box.size = Vector3(width * 0.62, 0.34, 0.72)
			stone_shape.shape = stone_box
			stone_shape.position = Vector3(0.0, 0.10, 0.0)
			stone_body.add_child(stone_shape)
			stone.add_child(stone_body)
			path.add_child(stone)
			if stone_index % 5 == 0:
				var wayfinder: OmniLight3D = OmniLight3D.new()
				wayfinder.name = "LuzWayfinding_%03d" % stone_index
				wayfinder.light_color = Color("#4ea6b6")
				wayfinder.light_energy = 0.85
				wayfinder.omni_range = 8.0
				wayfinder.position = Vector3(0.0, 1.6, 0.0)
				wayfinder.shadow_enabled = false
				stone.add_child(wayfinder)
			stone_index += 1

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
