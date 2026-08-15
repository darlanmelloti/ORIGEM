## TempleLevel.gd
## Orquestra o Vale de Kheper como ambiente 3D real de alto realismo.
## Removidas todas as caixas grossas do greybox inicial em favor de arquitetura orgânica e arruinada.

extends Node3D

const TERRAIN_PATCH_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const VALLEY_BIOME_SCRIPT: Script = preload("res://levels/ValleyBiome.gd")
const SANCTUARY_SLICE_SCRIPT: Script = preload("res://levels/SanctuarySlice.gd")
const SANCTUARY_INTERIOR_SCRIPT: Script = preload("res://levels/SanctuaryInterior.gd")
const ORGANIC_RUIN_KIT_SCRIPT: Script = preload("res://levels/OrganicRuinKit.gd")
const ASSET_PASS_KIT_SCRIPT: Script = preload("res://levels/AssetPassKit.gd")
const VOSS_HOUSE_SCRIPT: Script = preload("res://levels/VossHouse.gd")
const EXPLORABLE_MOUNTAINS_SCRIPT: Script = preload("res://levels/ExplorableMountains.gd")
const DAYLIGHT_VALLEY_SCRIPT: Script = preload("res://levels/DaylightValley.gd")
const RIVER_ROAD_JOURNEY_SCRIPT: Script = preload("res://levels/RiverRoadJourney.gd")
const DAYLIGHT_VARIANT_ENABLED: bool = true

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var dark_stone_material: StandardMaterial3D
var moss_material: StandardMaterial3D
var mountain_material: StandardMaterial3D
var snow_material: StandardMaterial3D
var glow_material: StandardMaterial3D
var fireflies: Array[MeshInstance3D] = []
var elapsed_time: float = 0.0
var voss_house: Node3D
var orion_mountains: Node3D

func _ready() -> void:
	if has_node("TerrainPatch"):
		return
	_create_materials()
	_create_terrain()
	_build_orion_mountains()
	_build_voss_house()
	# A variante diurna mantém a tempestade guardada como opção temporal, mas inicia o vale legível sob sol oblíquo.
	get_tree().create_timer(0.70).timeout.connect(_enforce_voss_opening_daylight)
	# O vale diurno entra cedo para que o percurso, o rio e os marcos sejam visíveis logo depois da saída da Casa Voss.
	get_tree().create_timer(1.20).timeout.connect(_build_world_after_voss_prologue)

func _enforce_voss_opening_daylight() -> void:
	var level_environment: Node = get_parent().get_node_or_null("LevelEnvironment")
	if level_environment != null and level_environment.has_method("apply_voss_daylight"):
		level_environment.call("apply_voss_daylight")

func _process(delta: float) -> void:
	elapsed_time += delta
	for index: int in range(fireflies.size()):
		var firefly: MeshInstance3D = fireflies[index]
		firefly.position.y = 0.82 + sin(elapsed_time * 1.1 + float(index)) * 0.16
		firefly.position.x += sin(elapsed_time * 0.34 + float(index)) * 0.002

func _create_materials() -> void:
	stone_material = _make_material(Color(0.26, 0.28, 0.25), 0.88)
	dark_stone_material = _make_material(Color(0.12, 0.15, 0.13), 0.94)
	moss_material = _make_material(Color(0.09, 0.28, 0.11), 0.96)
	mountain_material = _make_material(Color.WHITE, 1.0)
	mountain_material.vertex_color_use_as_albedo = true
	snow_material = _make_material(Color(0.82, 0.90, 0.94), 0.75)

	glow_material = StandardMaterial3D.new()
	glow_material.albedo_color = Color(0.24, 0.52, 0.88)
	glow_material.emission_enabled = true
	glow_material.emission = Color(0.04, 0.16, 0.45)
	glow_material.emission_energy_multiplier = 1.2
	glow_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

func _create_terrain() -> void:
	terrain_patch = TERRAIN_PATCH_SCRIPT.new() as Node3D
	terrain_patch.name = "TerrainPatch"
	add_child(terrain_patch)

func _build_world_after_voss_prologue() -> void:
	if has_node("ValeDiurnoExploravel"):
		return
	if DAYLIGHT_VARIANT_ENABLED:
		var daylight_valley: Node3D = DAYLIGHT_VALLEY_SCRIPT.new() as Node3D
		daylight_valley.name = "ValeDiurnoExploravel"
		add_child(daylight_valley)
		var river_road: Node3D = RIVER_ROAD_JOURNEY_SCRIPT.new() as Node3D
		river_road.name = "EstradaDoRioExploravel"
		add_child(river_road)
		# A cadeia secundária ocupa somente o horizonte; ruínas, NPCs e templos centrais da variante antiga não são carregados.
		_build_distant_mountains()
		_build_chronos_beacon()
		return

	var biome: Node3D = VALLEY_BIOME_SCRIPT.new() as Node3D
	biome.name = "BiomeDoVale"
	add_child(biome)
	_build_organic_ruin_kit()
	_build_asset_pass()
	_build_landmarks()
	_build_distant_mountains()
	_build_waterfall()
	_build_fireflies()
	_build_sanctuary_interior()

func _build_orion_mountains() -> void:
	# Manto rochoso real diante da Casa Voss: mantém o destino Orion como geometria explorável, nunca como painel de fundo.
	orion_mountains = EXPLORABLE_MOUNTAINS_SCRIPT.new() as Node3D
	orion_mountains.name = "MaciçoOrionExplorável"
	# Variante diurna: Orion recua para a cadeia remota, deixando o vale respirável e mantendo-o como destino explorável futuro.
	orion_mountains.position = Vector3(-184.0, 0.0, -188.0)
	orion_mountains.scale = Vector3(1.30, 1.30, 1.30)
	add_child(orion_mountains)

func _build_chronos_beacon() -> void:
	# Marco azul pequeno e emissivo na face de Orion: indica o futuro Cubo Áureo sem transformar a montanha em painel ou farol próximo.
	var beacon: Node3D = Node3D.new()
	beacon.name = "MarcoChronosAzulRemoto"
	beacon.position = Vector3(-181.0, 54.0, -185.0)
	add_child(beacon)
	var crystal_mesh: SphereMesh = SphereMesh.new()
	crystal_mesh.radius = 1.25
	crystal_mesh.height = 3.6
	crystal_mesh.radial_segments = 12
	var crystal_material: StandardMaterial3D = StandardMaterial3D.new()
	crystal_material.albedo_color = Color(0.06, 0.30, 0.78, 1.0)
	crystal_material.emission_enabled = true
	crystal_material.emission = Color(0.02, 0.22, 1.0, 1.0)
	crystal_material.emission_energy_multiplier = 2.4
	crystal_material.roughness = 0.22
	crystal_mesh.material = crystal_material
	var crystal: MeshInstance3D = MeshInstance3D.new()
	crystal.name = "CristalDoMarcoChronos"
	crystal.mesh = crystal_mesh
	crystal.scale = Vector3(0.64, 1.0, 0.64)
	beacon.add_child(crystal)
	var beacon_light: OmniLight3D = OmniLight3D.new()
	beacon_light.name = "BrilhoAzulChronos"
	beacon_light.light_color = Color(0.10, 0.40, 1.0, 1.0)
	beacon_light.light_energy = 2.1
	beacon_light.omni_range = 16.0
	beacon_light.shadow_enabled = false
	beacon.add_child(beacon_light)

func _build_voss_house() -> void:
	# A Casa Voss é construída imediatamente após o terreno, para que a sua estrada e a câmara de prólogo tenham solo real.
	voss_house = VOSS_HOUSE_SCRIPT.new() as Node3D
	voss_house.name = "VossHouse"
	add_child(voss_house)

func _build_organic_ruin_kit() -> void:
	var organic_kit: Node3D = ORGANIC_RUIN_KIT_SCRIPT.new() as Node3D
	organic_kit.name = "KitDeRuinasOrganicas"
	add_child(organic_kit)

func _build_asset_pass() -> void:
	var asset_pass: Node3D = ASSET_PASS_KIT_SCRIPT.new() as Node3D
	asset_pass.name = "ModelosGLB_Reais"
	add_child(asset_pass)

func _build_sanctuary_interior() -> void:
	var interior: Node3D = SANCTUARY_INTERIOR_SCRIPT.new() as Node3D
	interior.name = "InteriorDoSantuario"
	add_child(interior)

func _build_landmarks() -> void:
	var landmarks: Node3D = Node3D.new()
	landmarks.name = "MarcosDoVale"
	add_child(landmarks)

	_build_starting_ruins(landmarks)
	_build_stone_path(landmarks)
	_build_tide_arch(landmarks)
	_build_spring_sanctuary(landmarks)
	_build_lakeside_observatory(landmarks)

func _build_starting_ruins(parent: Node3D) -> void:
	var ruins: Node3D = Node3D.new()
	ruins.name = "RuinasDoDespertar"
	parent.add_child(ruins)

	# Substituição de bases quadradas por plataformas de pedra natural e pilares esbeltos erosionados
	for position_value: Vector3 in [Vector3(-7.0, 0.0, 8.0), Vector3(7.0, 0.0, 8.0), Vector3(-7.0, 0.0, 0.0), Vector3(7.0, 0.0, 0.0)]:
		_add_organic_pillar(ruins, position_value, 6.2, stone_material)

	_add_box(ruins, Vector3(-4.5, 0.6, 2.0), Vector3(1.4, 1.2, 1.4), dark_stone_material, "AltarDeOrion")
	_add_light(ruins, Vector3(-4.5, 2.8, 2.0), Color(0.18, 0.52, 0.95), 1.5, 8.0, "LuzDoAltar")

func _build_stone_path(parent: Node3D) -> void:
	var path: Node3D = Node3D.new()
	path.name = "CaminhoDoLago"
	parent.add_child(path)
	for index: int in range(20):
		var progress: float = float(index)
		var z_position: float = -5.0 - progress * 3.5
		var x_position: float = sin(progress * 0.28) * 3.5
		var y_position: float = _ground_height(x_position, z_position) + 0.05
		_add_box(path, Vector3(x_position, y_position, z_position), Vector3(2.4, 0.12, 1.8), stone_material, "Laje_%02d" % index)

func _build_tide_arch(parent: Node3D) -> void:
	var arch: Node3D = Node3D.new()
	arch.name = "ArcoDasMares"
	arch.position = Vector3(0.0, _ground_height(0.0, -32.0), -32.0)
	parent.add_child(arch)
	_add_organic_pillar(arch, Vector3(-3.0, 0.0, 0.0), 8.0, dark_stone_material)
	_add_organic_pillar(arch, Vector3(3.0, 0.0, 0.0), 8.0, dark_stone_material)
	_add_box(arch, Vector3(0.0, 7.5, 0.0), Vector3(6.8, 0.8, 1.4), stone_material, "LintelDoArco")
	_add_light(arch, Vector3(0.0, 5.0, 0.0), Color(0.22, 0.78, 0.42), 1.0, 10.0, "LuzDoArco")

func _build_spring_sanctuary(parent: Node3D) -> void:
	var sanctuary: Node3D = SANCTUARY_SLICE_SCRIPT.new() as Node3D
	sanctuary.name = "SantuarioDaNascente"
	sanctuary.position = Vector3(-25.0, _ground_height(-25.0, -70.0), -70.0)
	parent.add_child(sanctuary)

func _build_lakeside_observatory(parent: Node3D) -> void:
	var observatory: Node3D = Node3D.new()
	observatory.name = "ObservatorioAfogado"
	observatory.position = Vector3(40.0, _ground_height(40.0, -72.0), -72.0)
	parent.add_child(observatory)
	for point: Vector3 in [Vector3(-3.0, 0.0, -2.5), Vector3(3.0, 0.0, -2.5), Vector3(-3.0, 0.0, 2.5), Vector3(3.0, 0.0, 2.5)]:
		_add_organic_pillar(observatory, point, 5.5, stone_material)
	_add_light(observatory, Vector3(0.0, 4.0, 0.0), Color(0.18, 0.52, 0.95), 1.2, 12.0, "LuzDoObservatorio")

func _build_distant_mountains() -> void:
	var mountains: Node3D = Node3D.new()
	mountains.name = "MontanhasReais"
	add_child(mountains)
	var mountain_data: Array[Dictionary] = [
		{"position": Vector3(-90.0, 0.0, -140.0), "radius": 32.0, "height": 48.0},
		{"position": Vector3(-45.0, 0.0, -165.0), "radius": 28.0, "height": 68.0},
		{"position": Vector3(0.0, 0.0, -180.0), "radius": 40.0, "height": 90.0},
		{"position": Vector3(50.0, 0.0, -170.0), "radius": 32.0, "height": 70.0},
		{"position": Vector3(95.0, 0.0, -145.0), "radius": 35.0, "height": 55.0}
	]
	for mountain: Dictionary in mountain_data:
		_add_mountain(mountains, mountain["position"] as Vector3, mountain["radius"] as float, mountain["height"] as float)

func _build_waterfall() -> void:
	var waterfall: Node3D = Node3D.new()
	waterfall.name = "QuedaDaMemoria"
	waterfall.position = Vector3(18.0, 20.0, -120.0)
	add_child(waterfall)

	var water_sheet_mesh: QuadMesh = QuadMesh.new()
	water_sheet_mesh.size = Vector2(6.0, 26.0)
	var water_material: StandardMaterial3D = StandardMaterial3D.new()
	water_material.albedo_color = Color(0.50, 0.85, 0.95, 0.78)
	water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	water_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	water_sheet_mesh.material = water_material
	var water_sheet: MeshInstance3D = MeshInstance3D.new()
	water_sheet.name = "CortinaDeAgua"
	water_sheet.mesh = water_sheet_mesh
	waterfall.add_child(water_sheet)
	_add_light(waterfall, Vector3(0.0, 0.0, 2.0), Color(0.20, 0.60, 0.98), 1.0, 12.0, "ReflexoDaQueda")

func _build_fireflies() -> void:
	var lights: Node3D = Node3D.new()
	lights.name = "LuzesDoVale"
	add_child(lights)
	for index: int in range(12):
		var sphere_mesh: SphereMesh = SphereMesh.new()
		sphere_mesh.radius = 0.06
		sphere_mesh.height = 0.12
		sphere_mesh.material = glow_material
		var firefly: MeshInstance3D = MeshInstance3D.new()
		firefly.name = "Luz_%02d" % index
		firefly.mesh = sphere_mesh
		firefly.position = Vector3(-10.0 + float(index % 5) * 4.0, 0.75 + float(index % 3) * 0.25, -15.0 - float(index / 5) * 10.0)
		lights.add_child(firefly)
		fireflies.append(firefly)

func _add_mountain(parent: Node3D, position_value: Vector3, radius: float, height: float) -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = int(abs(position_value.x) * 29.0 + abs(position_value.z) * 13.0)
	var radial_segments: int = 10
	var ring_count: int = 5
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)

	for ring: int in range(ring_count):
		var next_ring: int = ring + 1
		var t0: float = float(ring) / float(ring_count)
		var t1: float = float(next_ring) / float(ring_count)
		for segment: int in range(radial_segments):
			var next_segment: int = (segment + 1) % radial_segments
			var p00: Vector3 = _mountain_point(position_value, radius, height, t0, segment, radial_segments)
			var p10: Vector3 = _mountain_point(position_value, radius, height, t0, next_segment, radial_segments)
			var p01: Vector3 = _mountain_point(position_value, radius, height, t1, segment, radial_segments)
			var p11: Vector3 = _mountain_point(position_value, radius, height, t1, next_segment, radial_segments)
			var color0: Color = _mountain_color(t0)
			var color1: Color = _mountain_color(t1)
			_add_mountain_triangle(surface, p00, p01, p10, color0, color1, color0)
			_add_mountain_triangle(surface, p10, p01, p11, color0, color1, color1)

	surface.generate_normals()
	var mountain_mesh: ArrayMesh = surface.commit()
	mountain_mesh.surface_set_material(0, mountain_material)
	var mountain: MeshInstance3D = MeshInstance3D.new()
	mountain.name = "CristaDoVale"
	mountain.mesh = mountain_mesh
	mountain.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	parent.add_child(mountain)

func _mountain_point(origin: Vector3, radius: float, height: float, t: float, segment: int, segments: int) -> Vector3:
	var angle: float = TAU * float(segment) / float(segments)
	var ridge_variation: float = 0.85 + sin(angle * 3.0 + float(segment) * 0.5) * 0.1
	var ring_radius: float = radius * (1.0 - t * 0.8) * ridge_variation
	return origin + Vector3(cos(angle) * ring_radius, t * height, sin(angle) * ring_radius * 0.7)

func _mountain_color(height_ratio: float) -> Color:
	# Paleta de cadeia remota: vegetação fria na base, rocha azulada no meio e neve apenas nas cristas.
	if height_ratio > 0.78:
		return Color(0.78, 0.86, 0.90)
	if height_ratio > 0.56:
		return Color(0.31, 0.40, 0.43)
	if height_ratio > 0.30:
		return Color(0.17, 0.32, 0.20)
	return Color(0.10, 0.23, 0.13)

func _add_mountain_triangle(surface: SurfaceTool, first: Vector3, second: Vector3, third: Vector3, first_color: Color, second_color: Color, third_color: Color) -> void:
	surface.set_color(first_color)
	surface.add_vertex(first)
	surface.set_color(second_color)
	surface.add_vertex(second)
	surface.set_color(third_color)
	surface.add_vertex(third)

func _add_organic_pillar(parent: Node3D, position_value: Vector3, height: float, material: StandardMaterial3D) -> void:
	var shaft_mesh: CylinderMesh = CylinderMesh.new()
	shaft_mesh.top_radius = 0.32
	shaft_mesh.bottom_radius = 0.48
	shaft_mesh.height = height
	shaft_mesh.radial_segments = 16
	shaft_mesh.material = material
	var shaft: MeshInstance3D = MeshInstance3D.new()
	shaft.name = "ColunaOrganica"
	shaft.mesh = shaft_mesh
	shaft.position = position_value + Vector3(0.0, height * 0.5, 0.0)
	parent.add_child(shaft)

func _add_light(parent: Node3D, position_value: Vector3, color: Color, energy: float, light_range: float, node_name: String) -> void:
	var light: OmniLight3D = OmniLight3D.new()
	light.name = node_name
	light.position = position_value
	light.light_color = color
	light.light_energy = energy
	light.omni_range = light_range
	light.shadow_enabled = false
	parent.add_child(light)

func _add_box(parent: Node3D, position_value: Vector3, size_value: Vector3, material: StandardMaterial3D, node_name: String) -> void:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.name = node_name
	var box_mesh: BoxMesh = BoxMesh.new()
	box_mesh.size = size_value
	box_mesh.material = material
	mesh_instance.mesh = box_mesh
	mesh_instance.position = position_value
	parent.add_child(mesh_instance)

func _ground_height(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _make_material(color: Color, roughness_value: float) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness_value
	return material
