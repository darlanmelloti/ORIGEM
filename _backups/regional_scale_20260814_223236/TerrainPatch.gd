## TerrainPatch.gd
## Terreno tridimensional real para o Vale de Kheper.
## O relevo combina encostas laterais, bacia lacustre e ruído de baixa frequência.

extends Node3D

const CELLS_X: int = 96
const CELLS_Z: int = 110
const SIZE_X: float = 220.0
const SIZE_Z: float = 260.0
const FOREST_GROUND_DIFF: Texture2D = preload("res://assets/textures/pbr/forest_ground_diff.jpg")
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
	var side_ratio: float = clampf((abs(world_x) - 26.0) / 72.0, 0.0, 1.0)
	var rear_ratio: float = clampf(((-world_z) - 112.0) / 128.0, 0.0, 1.0)
	var side_hills: float = side_ratio * side_ratio * 19.0
	var rear_hills: float = rear_ratio * rear_ratio * 15.0
	var macro_noise: float = land_noise.get_noise_2d(world_x, world_z) * (1.7 + side_ratio * 3.4)
	var micro_noise: float = detail_noise.get_noise_2d(world_x, world_z) * 0.45
	var height: float = side_hills + rear_hills + macro_noise + micro_noise

	# A zona inicial permanece navegável, mas recebe micro-relevo físico de solo encharcado em vez de um plano artificial.
	if abs(world_x) < 24.0 and world_z > -112.0:
		var corridor_noise: float = land_noise.get_noise_2d(world_x * 0.65, world_z * 0.65) * 0.30
		var corridor_detail: float = detail_noise.get_noise_2d(world_x, world_z) * 0.22
		height = corridor_noise + corridor_detail

	# Bacia do Lago das Memórias. As margens aproximam-se com transição suave em vez de parede abrupta.
	var lake_center: Vector2 = Vector2(25.0, -62.0)
	var lake_distance: float = Vector2(world_x, world_z).distance_to(lake_center)
	if lake_distance < 43.0:
		var basin: float = 1.0 - lake_distance / 43.0
		height -= basin * basin * 2.15
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
			var z0: float = 55.0 - SIZE_Z * float(z_index) / float(CELLS_Z)
			var z1: float = 55.0 - SIZE_Z * float(z_index + 1) / float(CELLS_Z)

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
					forest_floor = mix(forest_floor, pbr_ground * vec3(0.48, 0.60, 0.32), 0.48);
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
	material.set_shader_parameter("ground_albedo", FOREST_GROUND_DIFF)
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
