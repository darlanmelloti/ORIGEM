## TerrainPatch.gd
## Terreno tridimensional real para o Vale de Kheper.
## O relevo combina encostas laterais, bacia lacustre e ruído de baixa frequência.

extends Node3D

# Escala regional: cobre Casa Voss, vale, vila, trilha e aproximação de Orion num único terreno físico.
const CELLS_X: int = 192
const CELLS_Z: int = 220
const SIZE_X: float = 640.0
const SIZE_Z: float = 880.0
const TERRAIN_Z_MAX: float = 620.0
const FOREST_GROUND_DIFF: Texture2D = preload("res://assets/textures/pbr/forest_ground_diff.jpg")
const REGIONAL_WET_GROUND_DIFF: Texture2D = preload("res://assets/textures/generated/regional_wet_forest_floor.png")
const FOREST_GROUND_ROUGH: Texture2D = preload("res://assets/textures/pbr/forest_ground_roughness.jpg")
const FOREST_GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")

var terrain_material: Material
var land_noise: FastNoiseLite
var detail_noise: FastNoiseLite

func _ready() -> void:
	_setup_noises()
	_build_terrain()
	# O lago permanece fora da abertura: a referência pede solo húmido, não um espelho de água no primeiro plano.

func _setup_noises() -> void:
	land_noise = FastNoiseLite.new()
	land_noise.seed = 34271
	land_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	land_noise.frequency = 0.018
	land_noise.fractal_octaves = 3
	land_noise.fractal_gain = 0.52

	detail_noise = FastNoiseLite.new()
	detail_noise.seed = 8821
	detail_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	detail_noise.frequency = 0.085
	detail_noise.fractal_octaves = 2

func height_at(world_x: float, world_z: float) -> float:
	# A escala cresce gradualmente para além da Estrada do Rio: laterais, vila e trilha nunca aparecem como paredes planas.
	var side_ratio: float = clampf((abs(world_x) - 32.0) / 238.0, 0.0, 1.0)
	var legacy_ratio: float = clampf(((-world_z) - 112.0) / 148.0, 0.0, 1.0)
	var journey_ratio: float = clampf((world_z - 132.0) / 470.0, 0.0, 1.0)
	var side_hills: float = side_ratio * side_ratio * 34.0
	var legacy_hills: float = legacy_ratio * legacy_ratio * 18.0
	var northern_hills: float = journey_ratio * journey_ratio * 46.0
	var macro_noise: float = land_noise.get_noise_2d(world_x, world_z) * (1.8 + side_ratio * 4.8 + journey_ratio * 5.5)
	var micro_noise: float = detail_noise.get_noise_2d(world_x, world_z) * 0.45
	var height: float = side_hills + legacy_hills + northern_hills + macro_noise + micro_noise

	# Casa Voss e Estrada do Rio: um corredor navegável, com micro-relevo apenas nas margens.
	if abs(world_x) < 30.0 and world_z > -112.0 and world_z < 145.0:
		var corridor_noise: float = land_noise.get_noise_2d(world_x * 0.65, world_z * 0.65) * 0.30
		var corridor_detail: float = detail_noise.get_noise_2d(world_x, world_z) * 0.22
		height = corridor_noise + corridor_detail
		# A faixa jogável permanece baixa; os ombros afastados elevam-se gradualmente e devolvem ao corredor a profundidade do vale.
		var road_progress: float = clampf((world_z - 12.0) / 108.0, 0.0, 1.0)
		var road_center: float = lerpf(-21.4, -10.0, road_progress) + sin(road_progress * PI * 2.5) * 1.8
		var lateral_distance: float = abs(world_x - road_center)
		var shoulder_ratio: float = clampf((lateral_distance - 4.35) / 10.0, 0.0, 1.0)
		var shoulder_height: float = shoulder_ratio * shoulder_ratio * (2.30 + road_progress * 2.10)
		height += shoulder_height
	# Corredor ribeirinho de baixa inclinação: liga a Floresta Densa à margem ocidental do lago regional.
	elif world_x > -38.0 and world_x < 25.0 and world_z >= 145.0 and world_z <= 252.0:
		var shore_noise: float = land_noise.get_noise_2d(world_x * 0.55, world_z * 0.55) * 0.22
		var shore_detail: float = detail_noise.get_noise_2d(world_x, world_z) * 0.14
		height = shore_noise + shore_detail

	# Bacias histórica e regional: a segunda recebe as Ruínas Submersas do mapa de doze marcos.
	for lake_center: Vector2 in [Vector2(25.0, -62.0), Vector2(60.0, 252.0)]:
		var lake_distance: float = Vector2(world_x, world_z).distance_to(lake_center)
		var lake_radius: float = 43.0 if lake_center.y < 0.0 else 46.0
		if lake_distance < lake_radius:
			var basin: float = 1.0 - lake_distance / lake_radius
			height -= basin * basin * (2.15 if lake_center.y < 0.0 else 4.20)
	return height

func _build_terrain() -> void:
	terrain_material = _create_wet_forest_ground_material()

	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for z_index: int in range(CELLS_Z):
		for x_index: int in range(CELLS_X):
			var x0: float = -SIZE_X * 0.5 + SIZE_X * float(x_index) / float(CELLS_X)
			var x1: float = -SIZE_X * 0.5 + SIZE_X * float(x_index + 1) / float(CELLS_X)
			# A malha avança até à câmara do prólogo, eliminando qualquer vazio ou espelho artificial no primeiro plano.
			var z0: float = TERRAIN_Z_MAX - SIZE_Z * float(z_index) / float(CELLS_Z)
			var z1: float = TERRAIN_Z_MAX - SIZE_Z * float(z_index + 1) / float(CELLS_Z)

			var p00: Vector3 = Vector3(x0, height_at(x0, z0), z0)
			var p10: Vector3 = Vector3(x1, height_at(x1, z0), z0)
			var p01: Vector3 = Vector3(x0, height_at(x0, z1), z1)
			var p11: Vector3 = Vector3(x1, height_at(x1, z1), z1)
			_add_terrain_triangle(surface, p00, p01, p10)
			_add_terrain_triangle(surface, p10, p01, p11)

	surface.generate_normals()
	surface.generate_tangents()
	var terrain_mesh: ArrayMesh = surface.commit()
	terrain_mesh.surface_set_material(0, terrain_material)

	var terrain_visual: MeshInstance3D = MeshInstance3D.new()
	terrain_visual.name = "TerrenoEsculpido"
	terrain_visual.mesh = terrain_mesh
	terrain_visual.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	add_child(terrain_visual)

	var terrain_body: StaticBody3D = StaticBody3D.new()
	terrain_body.name = "ColisaoDoTerreno"
	var terrain_shape: CollisionShape3D = CollisionShape3D.new()
	terrain_shape.shape = terrain_mesh.create_trimesh_shape()
	terrain_body.add_child(terrain_shape)
	add_child(terrain_body)

func _create_wet_forest_ground_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode cull_back, diffuse_burley;

uniform sampler2D ground_albedo : source_color;
uniform sampler2D ground_roughness;
uniform sampler2D ground_normal : hint_normal;

float hash21(vec2 p) {
	p = fract(p * vec2(123.34, 345.45));
	p += dot(p, p + 34.345);
	return fract(p.x * p.y);
}

float value_noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);
	return mix(mix(hash21(i), hash21(i + vec2(1.0, 0.0)), f.x), mix(hash21(i + vec2(0.0, 1.0)), hash21(i + vec2(1.0)), f.x), f.y);
}

void fragment() {
	vec2 p = UV * 7.5;
	float broad = value_noise(p * 0.22);
	float soil = value_noise(p * 1.7);
	float leaf = smoothstep(0.57, 0.83, value_noise(p * 3.3));
											vec3 wet_mud = mix(vec3(0.075, 0.110, 0.045), vec3(0.175, 0.185, 0.075), broad);
					vec3 forest_floor = mix(wet_mud, vec3(0.105, 0.215, 0.075), leaf * 0.42);

			float pebbles = smoothstep(0.76, 0.91, value_noise(p * 6.5));
			float leaf_litter = smoothstep(0.62, 0.84, value_noise(p * 4.6 + vec2(4.2, 1.7)));
			forest_floor = mix(forest_floor, vec3(0.042, 0.036, 0.026), pebbles * 0.34);
			forest_floor = mix(forest_floor, vec3(0.155, 0.098, 0.042), leaf_litter * 0.16);
			vec3 pbr_ground = texture(ground_albedo, UV * 1.65).rgb;
			float pbr_rough = texture(ground_roughness, UV * 1.65).r;
				// Passe comparativo: solo de folha e lama menos verde, mais próximo de terra encharcada natural.
					forest_floor = mix(forest_floor, pbr_ground * vec3(0.66, 0.78, 0.54), 0.58);
					forest_floor = mix(forest_floor, vec3(0.135, 0.235, 0.085), leaf * 0.22);

				// Passe comparativo: baixa refletância média de terra molhada, mantendo detalhe PBR e leitura de percurso.
				ALBEDO = forest_floor * mix(0.74, 1.00, soil);
			ROUGHNESS = mix(mix(0.74, 0.96, broad + pebbles * 0.18), pbr_rough, 0.38);
			NORMAL_MAP = texture(ground_normal, UV * 1.65).rgb;
			NORMAL_MAP_DEPTH = 0.32;

		METALLIC = 0.0;
		SPECULAR = 0.22;

	}
	"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("ground_albedo", REGIONAL_WET_GROUND_DIFF)
	material.set_shader_parameter("ground_roughness", FOREST_GROUND_ROUGH)
	material.set_shader_parameter("ground_normal", FOREST_GROUND_NORMAL)
	return material

func _add_terrain_triangle(surface: SurfaceTool, first: Vector3, second: Vector3, third: Vector3) -> void:
	_add_terrain_vertex(surface, first)
	_add_terrain_vertex(surface, second)
	_add_terrain_vertex(surface, third)

func _add_terrain_vertex(surface: SurfaceTool, point: Vector3) -> void:
	surface.set_color(_terrain_color(point))
	# UVs em espaço do mundo: solo florestal húmido repete sobre a malha explorável, sem painel plano.
	surface.set_uv(Vector2(point.x * 0.095, point.z * 0.095))
	surface.add_vertex(point)

func _terrain_color(point: Vector3) -> Color:
	var lake_distance: float = Vector2(point.x, point.z).distance_to(Vector2(25.0, -62.0))
	if lake_distance < 45.0:
		return Color(0.075, 0.16, 0.115)
	if point.y > 15.0:
		return Color(0.27, 0.28, 0.25)
	if point.y > 7.0:
		return Color(0.16, 0.25, 0.16)
	return Color(0.18, 0.31, 0.15)

func _build_lake_surface() -> void:
	var water_mesh: PlaneMesh = PlaneMesh.new()
	water_mesh.size = Vector2(74.0, 56.0)
	water_mesh.subdivide_width = 28
	water_mesh.subdivide_depth = 22
	water_mesh.material = _create_water_material()

	var water: MeshInstance3D = MeshInstance3D.new()
	water.name = "LagoDasMemoriasReal"
	water.mesh = water_mesh
	water.position = Vector3(25.0, -0.14, -62.0)
	water.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(water)

func _create_water_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode blend_mix, cull_disabled, depth_draw_always;

void vertex() {
	float wave_a = sin(VERTEX.x * 0.22 + TIME * 1.05) * 0.075;
	float wave_b = cos(VERTEX.z * 0.19 + TIME * 0.78) * 0.055;
	VERTEX.y += wave_a + wave_b;
}

void fragment() {
	float detail = sin(VERTEX.x * 0.28 + VERTEX.z * 0.12 + TIME * 0.82) * 0.5 + 0.5;
	ALBEDO = mix(vec3(0.012, 0.045, 0.075), vec3(0.028, 0.16, 0.20), detail);
	METALLIC = 0.12;
	ROUGHNESS = 0.26;
	ALPHA = 0.86;
	EMISSION = vec3(0.0, 0.006, 0.014);
}
"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	return material
