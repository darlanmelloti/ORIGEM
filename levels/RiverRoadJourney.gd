## RiverRoadJourney.gd
## Corredor inicial real do mapa: Casa Voss -> Estrada do Rio -> Arco das Ruínas.
## O jogador sai para z positivo; esta zona não reutiliza o antigo corredor de composição em z negativo.

extends Node3D

const RUIN_PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const RUIN_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const PINE_MEDIUM: PackedScene = preload("res://assets/models_generated/ez_pine_medium_pbr.glb")
const DARK_TREE: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const OAK_DARK: PackedScene = preload("res://assets/models_cc0/tree_oak_dark.glb")
const FLAGSTONE: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")
const GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")
const GROUND_ROUGHNESS: Texture2D = preload("res://assets/textures/pbr/forest_ground_roughness.jpg")

var terrain_patch: Node3D
var path_material: StandardMaterial3D
var ruin_material: StandardMaterial3D

func _ready() -> void:
	_build_arch_wet_overlay()
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	path_material = _make_path_material()
	ruin_material = _make_ruin_material()
	_build_compacted_roadbed()
	_build_river_road()
	_build_river()
	_build_river_margins()
	_build_ruin_arch()
	_build_arch_crown_stones()
	_build_river_fill_light()
	_build_arch_base_ferns()
	_build_riparian_color_variation()
	_build_arch_approach_ecology()
	_build_roadside_vegetation()

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
	roadbed_material.albedo_color = Color(0.175, 0.148, 0.098, 1.0)
	roadbed_material.roughness = 0.96
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
		slab.mesh = _make_slab(1.76 + rng.randf_range(-0.18, 0.20), 1.34 + rng.randf_range(-0.12, 0.18), rng)
		slab.material_override = path_material
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

func _build_river() -> void:
	var river_root: Node3D = Node3D.new()
	river_root.name = "RioDaEstrada_Norte"
	add_child(river_root)
	var width: float = 10.5
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(32):
		var z0: float = 8.0 + float(index) * 5.0
		var z1: float = z0 + 5.0
		var x0: float = _river_x(z0)
		var x1: float = _river_x(z1)
		# Lâmina ligeiramente acima do terreno local: mantém o curso contínuo no modo de compatibilidade sem invadir a estrada distante.
		var y0: float = (_height_at(x0 - width * 0.35, z0) + _height_at(x0 + width * 0.35, z0)) * 0.5 + 0.20
		var y1: float = (_height_at(x1 - width * 0.35, z1) + _height_at(x1 + width * 0.35, z1)) * 0.5 + 0.20
		_add_water_triangle(surface, Vector3(x0 - width * 0.5, y0, z0), Vector3(x0 - width * 0.5, y1, z1), Vector3(x0 + width * 0.5, y0, z0), Vector2(0.0, float(index) * 0.18), Vector2(0.0, float(index + 1) * 0.18), Vector2(1.0, float(index) * 0.18))
		_add_water_triangle(surface, Vector3(x0 + width * 0.5, y0, z0), Vector3(x0 - width * 0.5, y1, z1), Vector3(x1 + width * 0.5, y1, z1), Vector2(1.0, float(index) * 0.18), Vector2(0.0, float(index + 1) * 0.18), Vector2(1.0, float(index + 1) * 0.18))
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
		var by: float = (_height_at(bx - width * 0.35, bz) + _height_at(bx + width * 0.35, bz)) * 0.5 + 0.08
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

func _build_ruin_arch() -> void:
	var arch: Node3D = Node3D.new()
	arch.name = "ArcoDasRuinas_EstradaDoRio"
	var arch_z: float = 48.0
	var arch_x: float = _road_x(arch_z)
	arch.position = Vector3(arch_x, _height_at(arch_x, arch_z), arch_z)
	add_child(arch)
	for offset_x: float in [-3.25, 3.25]:
		var pillar: Node3D = RUIN_PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarArcoEstrada_%.1f" % offset_x
		pillar.position = Vector3(offset_x, 0.0, 0.0)
		pillar.scale = Vector3(1.45, 1.85, 1.45)
		pillar.rotation.y = signf(offset_x) * 0.08
		_apply_material(pillar, ruin_material)
		arch.add_child(pillar)
	# Núcleos de alvenaria regulares mantêm a silhueta do arco legível a partir da Estrada do Rio.
	for offset_x: float in [-3.25, 3.25]:
		var masonry_mesh: BoxMesh = BoxMesh.new()
		masonry_mesh.size = Vector3(1.12, 6.65, 1.45)
		var masonry: MeshInstance3D = MeshInstance3D.new()
		masonry.name = "NucleoDeAlvenaria_%.1f" % offset_x
		masonry.mesh = masonry_mesh
		masonry.position = Vector3(offset_x, 3.32, 0.0)
		masonry.material_override = ruin_material
		arch.add_child(masonry)
		# Volume físico coincidente com a alvenaria; mantém o vão central da estrada inteiramente livre.
		var pillar_body: StaticBody3D = StaticBody3D.new()
		pillar_body.name = "ColisorPilarArco_%.1f" % offset_x
		pillar_body.position = masonry.position
		var pillar_collision: CollisionShape3D = CollisionShape3D.new()
		var pillar_shape: BoxShape3D = BoxShape3D.new()
		pillar_shape.size = Vector3(1.12, 6.65, 1.45)
		pillar_collision.shape = pillar_shape
		pillar_body.add_child(pillar_collision)
		arch.add_child(pillar_body)
	var lintel_mesh: BoxMesh = BoxMesh.new()
	lintel_mesh.size = Vector3(8.45, 0.92, 1.40)
	var lintel: MeshInstance3D = MeshInstance3D.new()
	lintel.name = "LintelDoArcoEstrada"
	lintel.mesh = lintel_mesh
	lintel.position = Vector3(0.0, 6.85, 0.0)
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
		crown.position = Vector3(crown_side * (2.65 + float(crown_index % 3) * 1.08), 6.98 + float(crown_index % 2) * 0.34, -0.12 + float(crown_index % 2) * 0.48)
		var crown_scale: float = 0.14 + float(crown_index % 3) * 0.035
		crown.scale = Vector3(crown_scale, crown_scale * 0.78, crown_scale)
		crown.rotation = Vector3(0.16 * float(crown_index % 2), float(crown_index) * 0.68, 0.12 * crown_side)
		_apply_material(crown, ruin_material)
		arch.add_child(crown)
	# Preenchimento neutro reduz o corte preto do limiar e conserva as brasas como orientação, sem iluminar toda a Estrada do Rio.
	var arch_fill: OmniLight3D = OmniLight3D.new()
	arch_fill.name = "PreenchimentoDoArcoDasRuinas"
	arch_fill.light_color = Color(0.30, 0.42, 0.46, 1.0)
	arch_fill.light_energy = 0.54
	arch_fill.omni_range = 16.0
	arch_fill.omni_attenuation = 1.32
	arch_fill.shadow_enabled = false
	arch_fill.position = Vector3(0.0, 4.4, 2.6)
	arch.add_child(arch_fill)

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
	# 5 fragmentos de pedra no topo e lados dos pilares do arco (z≈48, x≈±4.5)
	var crown_positions: Array = [
		Vector3(-4.5, 5.8, 48.0),
		Vector3(4.5, 5.6, 48.0),
		Vector3(-4.2, 4.2, 47.5),
		Vector3(4.3, 4.0, 48.5),
		Vector3(0.0, 6.4, 48.0),
	]
	for i: int in range(crown_positions.size()):
		var pos: Vector3 = crown_positions[i]
		var frag: MeshInstance3D = MeshInstance3D.new()
		frag.name = "FragmentoCroa_%02d" % i
		var fmesh: BoxMesh = BoxMesh.new()
		fmesh.size = Vector3(
			rng.randf_range(0.35, 0.75),
			rng.randf_range(0.25, 0.55),
			rng.randf_range(0.30, 0.60)
		)
		frag.mesh = fmesh
		frag.material_override = crown_mat
		frag.position = pos
		frag.rotation = Vector3(
			rng.randf_range(-0.18, 0.18),
			rng.randf_range(-0.35, 0.35),
			rng.randf_range(-0.12, 0.12)
		)
		arch_root.add_child(frag)


func _build_arch_approach_ecology() -> void:
	# Grupos laterais e descontínuos fazem a aproximação parecer uma margem antiga invadida pela vegetação, sem fechar o eixo de lajes.
	var ecology: Node3D = Node3D.new()
	ecology.name = "EcologiaDaAproximacaoDoArco"
	add_child(ecology)
	var placements: Array[Vector3] = [
		Vector3(-1.0, 0.0, 35.5), Vector3(1.0, 0.0, 39.0),
		Vector3(-1.0, 0.0, 43.5), Vector3(1.0, 0.0, 53.0),
		Vector3(-1.0, 0.0, 57.0), Vector3(1.0, 0.0, 61.0)
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
	for index: int in range(10):
		var z_value: float = 26.0 + float(index) * 9.0
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = _road_x(z_value) + side * (7.0 + float(index % 3) * 1.1)
		# Alternância de espécies reais: cria profundidade de margem sem concentrar árvores no eixo do percurso.
		var tree_source: PackedScene = PINE_MEDIUM
		if index % 5 == 0:
			tree_source = OAK_DARK
		elif index % 3 == 0:
			tree_source = DARK_TREE
		var tree: Node3D = tree_source.instantiate() as Node3D
		if tree != null:
			tree.name = "ArvoreEstrada_%02d" % index
			tree.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
			var tree_scale: float = 0.24 + float(index % 3) * 0.04
			tree.scale = Vector3(tree_scale, tree_scale, tree_scale)
			tree.rotation.y = float(index) * 0.72
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
	material.albedo_color = Color(0.43, 0.46, 0.38, 1.0)
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.28
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
	float ripple = sin(UV.y * 18.0 + TIME * 0.85) * 0.5 + 0.5;
	ALBEDO = mix(vec3(0.015, 0.10, 0.12), vec3(0.035, 0.30, 0.33), ripple * 0.40 + 0.30);
	ROUGHNESS = 0.25;
	SPECULAR = 0.58;
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
		var rock: Node3D = ROCK.instantiate() as Node3D
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
		p.name = "ColorPatch"
		var pmesh: PlaneMesh = PlaneMesh.new()
		pmesh.size = Vector2(rng.randf_range(1.8, 3.2), rng.randf_range(1.4, 2.6))
		p.mesh = pmesh
		var pmat: StandardMaterial3D = StandardMaterial3D.new()
		pmat.albedo_color = patch["col"]
		pmat.roughness = 0.95
		p.material_override = pmat
		p.position = patch["pos"]
		p.rotation.y = rng.randf_range(0.0, TAU)
		var_root.add_child(p)


func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
