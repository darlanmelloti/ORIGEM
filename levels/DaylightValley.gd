## DaylightValley.gd
## Variante diurna explorável do Vale de Kheper.
## Constrói geometria real: rio em malha, caminho de lajes, margens vegetadas e ruínas remotas.

extends Node3D

const HERO_TREE: PackedScene = preload("res://assets/models_polyhaven/island_tree_01/island_tree_01_1k.gltf")
const PINE_TALL: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const PINE_MEDIUM: PackedScene = preload("res://assets/models_generated/ez_pine_medium_pbr.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const RUIN_PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const RUIN_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const STONE_BRIDGE: PackedScene = preload("res://assets/models_cc0/bridge_stone.glb")
const FOREST_GROUND_DIFF: Texture2D = preload("res://assets/textures/pbr/forest_ground_diff.jpg")
const FOREST_GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")
const FOREST_GROUND_ROUGH: Texture2D = preload("res://assets/textures/pbr/forest_ground_roughness.jpg")
const DAYLIGHT_WEATHERED_FLAGSTONE_DIFF: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var water_material: ShaderMaterial
var foliage_material: StandardMaterial3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	stone_material = _create_path_material()
	water_material = _create_river_material()
	foliage_material = _create_foliage_material()
	_build_river_of_glass()
	_build_riverbank_rocks()
	_build_flagstone_path()
	_build_ruin_threshold()
	_build_river_crossing()
	_build_bank_vegetation()
	_build_distant_ruins()

func _height_at(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _river_center_x(z_value: float) -> float:
	# O rio corre à direita da estrada, suficientemente próximo para se ler a água a partir do adro da casa.
	return 11.5 + sin((z_value + 18.0) * 0.046) * 3.1 + sin((z_value - 8.0) * 0.018) * 1.8

func _build_river_of_glass() -> void:
	var river: Node3D = Node3D.new()
	river.name = "RioTurquesaExploravel"
	add_child(river)

	var segments: int = 30
	var width: float = 14.0
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for index: int in range(segments - 1):
		var z0: float = 14.0 - float(index) * 5.4
		var z1: float = 14.0 - float(index + 1) * 5.4
		var x0: float = _river_center_x(z0)
		var x1: float = _river_center_x(z1)
		var y0: float = (_height_at(x0 - width * 0.32, z0) + _height_at(x0 + width * 0.32, z0)) * 0.5 + 0.10
		var y1: float = (_height_at(x1 - width * 0.32, z1) + _height_at(x1 + width * 0.32, z1)) * 0.5 + 0.10
		var left0: Vector3 = Vector3(x0 - width * 0.5, y0, z0)
		var right0: Vector3 = Vector3(x0 + width * 0.5, y0, z0)
		var left1: Vector3 = Vector3(x1 - width * 0.5, y1, z1)
		var right1: Vector3 = Vector3(x1 + width * 0.5, y1, z1)
		_add_water_triangle(surface, left0, left1, right0, Vector2(0.0, float(index) * 0.16), Vector2(0.0, float(index + 1) * 0.16), Vector2(1.0, float(index) * 0.16))
		_add_water_triangle(surface, right0, left1, right1, Vector2(1.0, float(index) * 0.16), Vector2(0.0, float(index + 1) * 0.16), Vector2(1.0, float(index + 1) * 0.16))
	surface.generate_normals()
	var mesh: ArrayMesh = surface.commit()
	mesh.surface_set_material(0, water_material)
	var water: MeshInstance3D = MeshInstance3D.new()
	water.name = "SuperficieDoRioTurquesa"
	water.mesh = mesh
	water.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	river.add_child(water)

func _add_water_triangle(surface: SurfaceTool, a: Vector3, b: Vector3, c: Vector3, uva: Vector2, uvb: Vector2, uvc: Vector2) -> void:
	surface.set_uv(uva)
	surface.add_vertex(a)
	surface.set_uv(uvb)
	surface.add_vertex(b)
	surface.set_uv(uvc)
	surface.add_vertex(c)

func _build_riverbank_rocks() -> void:
	# Rochas de margem em tamanhos irregulares dão profundidade física à água sem criar obstáculos na estrada.
	var bank: Node3D = Node3D.new()
	bank.name = "RochasDasMargensDoRio"
	add_child(bank)
	for index: int in range(16):
		var z_value: float = 10.0 - float(index) * 6.4
		var center_x: float = _river_center_x(z_value)
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var x_value: float = center_x + side * (7.05 + fmod(float(index), 3.0) * 0.55)
		var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "RochaDaMargem_%02d" % index
		rock.position = Vector3(x_value, _height_at(x_value, z_value) + 0.035, z_value)
		var rock_scale: float = 0.20 + fmod(float(index), 4.0) * 0.055
		rock.scale = Vector3(rock_scale, rock_scale * (0.72 + fmod(float(index), 2.0) * 0.12), rock_scale)
		rock.rotation.y = float(index) * 0.71
		bank.add_child(rock)

func _build_river_crossing() -> void:
	# Ponte real CC0: marco de exploração junto ao terço médio do vale e ligação futura entre a estrada e a margem oposta.
	var bridge: Node3D = STONE_BRIDGE.instantiate() as Node3D
	if bridge == null:
		return
	bridge.name = "PonteDePedraDoVale"
	var bridge_z: float = -57.0
	var bridge_x: float = _river_center_x(bridge_z)
	bridge.position = Vector3(bridge_x, _height_at(bridge_x, bridge_z) + 0.10, bridge_z)
	bridge.scale = Vector3(2.35, 1.05, 2.35)
	bridge.rotation.y = PI * 0.5
	add_child(bridge)

func _build_flagstone_path() -> void:
	var path: Node3D = Node3D.new()
	path.name = "EstradaDeLajesDiurna"
	add_child(path)
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 93018
	for index: int in range(40):
		var t: float = float(index) / 39.0
		# A Casa roda cerca de 190 graus: a porta frontal abre para z positivo, não para a antiga estrada em z=5.
		# As primeiras lajes agora nascem no adro real e seguem para o vale pela margem esquerda do rio.
		var z_value: float = lerpf(12.2, -112.0, t)
		var x_value: float = lerpf(-21.4, 4.0, t) + sin(t * PI * 4.2) * 2.3
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeDoCaminho_%02d" % index
		slab.mesh = _create_irregular_slab(1.55 + rng.randf_range(-0.18, 0.22), 1.15 + rng.randf_range(-0.13, 0.16), rng)
		slab.material_override = stone_material
		slab.position = Vector3(x_value, _height_at(x_value, z_value) + 0.045, z_value)
		slab.rotation.y = atan2(cos(t * PI * 4.2) * 2.3 * 4.2, -120.0) + rng.randf_range(-0.10, 0.10)
		path.add_child(slab)

func _create_irregular_slab(width: float, depth: float, rng: RandomNumberGenerator) -> ArrayMesh:
	var corners: Array[Vector3] = [
		Vector3(-width * 0.52, rng.randf_range(-0.020, 0.035), -depth * 0.48),
		Vector3(width * 0.46, rng.randf_range(-0.020, 0.035), -depth * 0.52),
		Vector3(width * 0.54, rng.randf_range(-0.020, 0.035), depth * 0.45),
		Vector3(-width * 0.44, rng.randf_range(-0.020, 0.035), depth * 0.54)
	]
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for vertex_index: int in [0, 1, 2, 0, 2, 3]:
		surface.set_uv(Vector2(corners[vertex_index].x + 0.5, corners[vertex_index].z + 0.5))
		surface.add_vertex(corners[vertex_index])
	surface.generate_normals()
	return surface.commit()

func _build_bank_vegetation() -> void:
	var vegetation: Node3D = Node3D.new()
	vegetation.name = "BosqueDeMargemDiurno"
	add_child(vegetation)
	var tree_data: Array[Dictionary] = [
		{"position": Vector2(-37.0, -12.0), "scale": 0.42, "yaw": 0.22, "hero": true},
		{"position": Vector2(-24.0, -15.0), "scale": 0.44, "yaw": 1.10, "hero": true},
		{"position": Vector2(-17.0, -27.0), "scale": 0.30, "yaw": 2.24, "hero": false},
		{"position": Vector2(-9.0, -39.0), "scale": 0.28, "yaw": 0.64, "hero": false},
		{"position": Vector2(-2.0, -54.0), "scale": 0.31, "yaw": 1.72, "hero": false},
		{"position": Vector2(5.0, -70.0), "scale": 0.26, "yaw": 0.42, "hero": false},
		{"position": Vector2(28.0, 1.0), "scale": 0.46, "yaw": 0.48, "hero": true},
		{"position": Vector2(31.0, -17.0), "scale": 0.36, "yaw": 1.52, "hero": true},
		{"position": Vector2(29.0, -37.0), "scale": 0.29, "yaw": 2.60, "hero": false},
		{"position": Vector2(30.0, -59.0), "scale": 0.26, "yaw": 0.90, "hero": false},
		{"position": Vector2(27.0, -78.0), "scale": 0.23, "yaw": 1.88, "hero": false}
	]
	for index: int in range(tree_data.size()):
		var data: Dictionary = tree_data[index]
		var point: Vector2 = data["position"] as Vector2
		var use_hero: bool = data["hero"] as bool
		# Árvores focais usam conífera PBR média para eliminar as copas claras do ativo folhoso no modo de captura.
		var tree_source: PackedScene = PINE_MEDIUM if use_hero else (PINE_TALL if index % 2 == 0 else PINE_MEDIUM)
		var tree: Node3D = tree_source.instantiate() as Node3D
		if tree == null:
			continue
		tree.name = "ArvoreDeMargem_%02d" % index
		tree.position = Vector3(point.x, _height_at(point.x, point.y), point.y)
		var scale_value: float = float(data["scale"])
		tree.scale = Vector3(scale_value, scale_value, scale_value)
		tree.rotation.y = data["yaw"] as float
		_tint_tree(tree)
		vegetation.add_child(tree)

	var fern_data: Array[Vector2] = [Vector2(-16.5, 4.0), Vector2(-12.5, -2.0), Vector2(-7.0, -12.0), Vector2(17.0, 5.0), Vector2(18.0, -7.0), Vector2(17.0, -20.0), Vector2(15.0, -33.0)]
	for index: int in range(fern_data.size()):
		var point: Vector2 = fern_data[index]
		var fern: Node3D = FERN.instantiate() as Node3D
		if fern == null:
			continue
		fern.name = "FetoDaMargem_%02d" % index
		fern.position = Vector3(point.x, _height_at(point.x, point.y) + 0.018, point.y)
		var fern_scale: float = 0.27 + float(index % 3) * 0.06
		fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
		fern.rotation.y = float(index) * 0.84
		vegetation.add_child(fern)

func _tint_tree(tree: Node3D) -> void:
	for child: Node in tree.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = foliage_material
		_tint_tree(child as Node3D)

func _build_ruin_threshold() -> void:
	# Marco 3 do mapa: um arco monumental atravessável entre a Estrada do Rio e a Floresta Densa.
	var threshold: Node3D = Node3D.new()
	threshold.name = "ArcoDasRuinas_Threshold"
	var arch_x: float = -12.8
	var arch_z: float = -39.0
	threshold.position = Vector3(arch_x, _height_at(arch_x, arch_z), arch_z)
	add_child(threshold)

	var arch_stone: StandardMaterial3D = StandardMaterial3D.new()
	arch_stone.albedo_color = Color(0.22, 0.25, 0.20, 1.0)
	arch_stone.roughness = 0.92
	for offset_x: float in [-3.20, 3.20]:
		var pillar: Node3D = RUIN_PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarDoArco_%.1f" % offset_x
		pillar.position = Vector3(offset_x, 0.0, 0.0)
		pillar.scale = Vector3(1.46, 1.70, 1.46)
		pillar.rotation.y = 0.12 * signf(offset_x)
		_apply_material_recursive(pillar, arch_stone)
		threshold.add_child(pillar)

	var lintel_mesh: BoxMesh = BoxMesh.new()
	lintel_mesh.size = Vector3(8.30, 0.86, 1.35)
	var lintel: MeshInstance3D = MeshInstance3D.new()
	lintel.name = "LintelMonumentalDoArco"
	lintel.mesh = lintel_mesh
	lintel.position = Vector3(0.0, 6.15, 0.0)
	lintel.material_override = arch_stone
	threshold.add_child(lintel)

	# Degraus baixos e apenas visuais: dão leitura de ascensão sem bloquear a cápsula de Elias.
	for step_index: int in range(3):
		var step: MeshInstance3D = MeshInstance3D.new()
		step.name = "DegrauDoArco_%02d" % step_index
		step.mesh = _create_irregular_slab(4.80 - float(step_index) * 0.22, 1.28, RandomNumberGenerator.new())
		step.material_override = stone_material
		step.position = Vector3(0.0, 0.04 + float(step_index) * 0.05, 2.10 - float(step_index) * 0.72)
		threshold.add_child(step)

	for rubble_index: int in range(4):
		var rubble: Node3D = RUIN_ROCK.instantiate() as Node3D
		if rubble == null:
			continue
		var side: float = -1.0 if rubble_index < 2 else 1.0
		rubble.name = "EntulhoDoArco_%02d" % rubble_index
		rubble.position = Vector3(side * (4.0 + float(rubble_index % 2) * 0.65), 0.0, -1.4 + float(rubble_index % 2) * 1.75)
		var rubble_scale: float = 0.26 + float(rubble_index % 2) * 0.09
		rubble.scale = Vector3(rubble_scale, rubble_scale * 0.80, rubble_scale)
		rubble.rotation.y = float(rubble_index) * 0.84
		threshold.add_child(rubble)

func _apply_material_recursive(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material_recursive(child, material)

func _build_distant_ruins() -> void:
	var ruins: Node3D = Node3D.new()
	ruins.name = "RuinasDistantesDoVale"
	add_child(ruins)
	var ruin_data: Array[Dictionary] = [
		{"position": Vector2(-15.0, -48.0), "scale": 0.78, "yaw": 0.20},
		{"position": Vector2(-7.0, -57.0), "scale": 0.96, "yaw": -0.26},
		{"position": Vector2(2.0, -70.0), "scale": 0.72, "yaw": 0.34},
		{"position": Vector2(12.0, -76.0), "scale": 0.82, "yaw": -0.52}
	]
	for index: int in range(ruin_data.size()):
		var data: Dictionary = ruin_data[index]
		var point: Vector2 = data["position"] as Vector2
		var pillar: Node3D = RUIN_PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "RuinaRemota_%02d" % index
		pillar.position = Vector3(point.x, _height_at(point.x, point.y), point.y)
		var scale_value: float = data["scale"] as float
		pillar.scale = Vector3(scale_value, scale_value * (0.92 + float(index % 2) * 0.22), scale_value)
		pillar.rotation.y = data["yaw"] as float
		ruins.add_child(pillar)

	var rock: Node3D = RUIN_ROCK.instantiate() as Node3D
	if rock != null:
		rock.name = "AfloramentoJuntoDasRuinas"
		rock.position = Vector3(16.0, _height_at(16.0, -68.0), -68.0)
		rock.scale = Vector3(1.25, 1.25, 1.25)
		rock.rotation.y = 0.72
		ruins.add_child(rock)

func _create_path_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = DAYLIGHT_WEATHERED_FLAGSTONE_DIFF
	material.normal_enabled = true
	material.normal_texture = FOREST_GROUND_NORMAL
	material.normal_scale = 0.30
	material.roughness_texture = FOREST_GROUND_ROUGH
	material.roughness = 0.90
	material.albedo_color = Color(0.72, 0.72, 0.67, 1.0)
	material.uv1_scale = Vector3(0.34, 0.34, 0.34)
	return material

func _create_foliage_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.075, 0.18, 0.085, 1.0)
	material.roughness = 0.92
	return material

func _create_river_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode blend_mix, cull_disabled, depth_draw_always, diffuse_burley;

void vertex() {
	float wave_a = sin(VERTEX.x * 0.65 + TIME * 1.15) * 0.055;
	float wave_b = cos(VERTEX.z * 0.47 + TIME * 0.80) * 0.040;
	VERTEX.y += wave_a + wave_b;
}

void fragment() {
	float ripple = sin(UV.x * 21.0 + TIME * 1.25) * 0.5 + 0.5;
	vec3 deep = vec3(0.008, 0.12, 0.16);
	vec3 shallow = vec3(0.035, 0.34, 0.38);
	ALBEDO = mix(deep, shallow, ripple * 0.44 + 0.36);
	METALLIC = 0.03;
	ROUGHNESS = 0.24;
	SPECULAR = 0.62;
	ALPHA = 0.76;
	EMISSION = vec3(0.0, 0.008, 0.010);
}
"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	return material
