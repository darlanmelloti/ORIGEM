## OrganicRuinKit.gd
## Kit de ruptura visual: rochas, lajes e colunas erodidas geradas como malhas irregulares.

extends Node3D

var stone_material: ShaderMaterial
var wet_stone_material: ShaderMaterial
var moss_material: ShaderMaterial
var terrain_patch: Node3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	_create_materials()
	_build_vale_de_kheper_assets()
	_build_sanctuary_shell()

func _create_materials() -> void:
	stone_material = _organic_material(Color(0.32, 0.36, 0.34), 0.84, 0.045, Color(0.045, 0.090, 0.040))
	wet_stone_material = _organic_material(Color(0.17, 0.24, 0.26), 0.62, 0.038, Color(0.025, 0.075, 0.070))
	moss_material = _organic_material(Color(0.12, 0.28, 0.13), 0.92, 0.016, Color(0.025, 0.065, 0.020))

func _organic_material(base_color: Color, roughness_value: float, displacement_amount: float, moss_color: Color) -> ShaderMaterial:
	var shader: Shader = Shader.new()
	shader.code = """
shader_type spatial;
render_mode cull_back, diffuse_burley;
uniform vec4 base_color : source_color;
uniform vec4 moss_color : source_color;
uniform float surface_roughness = 0.88;
uniform float displacement = 0.04;
uniform float triplanar_scale = 0.72;
float hash(vec3 p) { return fract(sin(dot(p, vec3(12.9898, 78.233, 37.719))) * 43758.5453); }
float noise3(vec3 p) {
	vec3 i = floor(p); vec3 f = fract(p); f = f * f * (3.0 - 2.0 * f);
	return mix(mix(mix(hash(i), hash(i + vec3(1,0,0)), f.x), mix(hash(i + vec3(0,1,0)), hash(i + vec3(1,1,0)), f.x), f.y), mix(mix(hash(i + vec3(0,0,1)), hash(i + vec3(1,0,1)), f.x), mix(hash(i + vec3(0,1,1)), hash(i + vec3(1,1,1)), f.x), f.y), f.z);
}
void vertex() {
	float n = noise3(VERTEX * 2.35) * 2.0 - 1.0;
	VERTEX += NORMAL * n * displacement;
}
void fragment() {
	vec3 blend = abs(NORMAL);
	blend /= max(blend.x + blend.y + blend.z, 0.0001);
	float noise_x = noise3(vec3(VERTEX.zy * triplanar_scale, 17.0));
	float noise_y = noise3(vec3(VERTEX.xz * triplanar_scale, 31.0));
	float noise_z = noise3(vec3(VERTEX.xy * triplanar_scale, 47.0));
	float surface_noise = noise_x * blend.x + noise_y * blend.y + noise_z * blend.z;
	float crack = noise3(VERTEX * 9.0);
	float moss = smoothstep(0.70, 0.94, noise3(VERTEX * 2.8 + vec3(7.0)));
	vec3 weathered_stone = base_color.rgb * (0.70 + surface_noise * 0.34) * (0.82 + crack * 0.18);
	ALBEDO = mix(weathered_stone, moss_color.rgb, moss * 0.30);
	ROUGHNESS = clamp(surface_roughness + (0.5 - crack) * 0.16, 0.25, 1.0);
	METALLIC = 0.0;
}
"""
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("base_color", base_color)
	material.set_shader_parameter("moss_color", moss_color)
	material.set_shader_parameter("surface_roughness", roughness_value)
	material.set_shader_parameter("displacement", displacement_amount)
	return material

func _build_vale_de_kheper_assets() -> void:
	var vale: Node3D = Node3D.new()
	vale.name = "KitOrganicoDoVale"
	add_child(vale)
	var boulders: Array[Dictionary] = [
		{"p": Vector3(-10.0, 0.55, 5.0), "s": Vector3(2.6, 1.4, 1.8), "seed": 11},
		{"p": Vector3(9.4, 0.45, 2.0), "s": Vector3(1.9, 1.1, 2.4), "seed": 12},
		{"p": Vector3(-7.5, 0.42, -14.0), "s": Vector3(2.2, 1.25, 1.7), "seed": 13},
		{"p": Vector3(7.8, 0.35, -20.0), "s": Vector3(3.2, 1.55, 1.9), "seed": 14},
		{"p": Vector3(-10.5, 0.50, -28.0), "s": Vector3(2.7, 1.45, 2.2), "seed": 15},
		{"p": Vector3(10.4, 0.48, -35.0), "s": Vector3(2.4, 1.4, 2.9), "seed": 16},
	]
	for data: Dictionary in boulders:
		_add_boulder(vale, data["p"], data["s"], int(data["seed"]), stone_material, "RochedoErodido")
	for index: int in range(7):
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var pos: Vector3 = Vector3(side * (12.0 + float(index % 3) * 3.2), 1.6, -40.0 - float(index) * 6.2)
		_add_broken_column(vale, pos, 3.4 + float(index % 3) * 0.9, index + 40)

func _build_sanctuary_shell() -> void:
	var shell: Node3D = Node3D.new()
	shell.name = "RuinasOrganicasDoSantuario"
	add_child(shell)
	# Contrafortes assimétricos: criam silhueta monumental sem uma parede retangular lisa.
	for index: int in range(4):
		var angle: float = float(index) * TAU / 4.0 + 0.35
		var pos: Vector3 = Vector3(cos(angle) * 8.6, 1.2, -49.5 + sin(angle) * 6.8)
		var size_value: Vector3 = Vector3(2.1 + float(index % 2) * 0.6, 3.0 + float(index % 2) * 0.8, 1.8)
		_add_boulder(shell, pos, size_value, 80 + index, wet_stone_material, "ContraforteTectonico")
	for index: int in range(9):
		var pos: Vector3 = Vector3(-6.2 + float(index % 3) * 5.8, 0.36, -44.0 - float(index / 3) * 5.4)
		_add_boulder(shell, pos, Vector3(1.1, 0.65, 1.6), 120 + index, moss_material, "FragmentoComMusgo")
	_add_broken_column(shell, Vector3(-6.4, 0.28, -48.0), 6.1, 170)
	_add_broken_column(shell, Vector3(6.0, 0.28, -52.5), 5.2, 171)

func _add_boulder(parent: Node3D, position_value: Vector3, size_value: Vector3, seed_value: int, material: Material, node_name: String, snap_to_ground: bool = true) -> void:
	var instance: MeshInstance3D = MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = _create_rock_mesh(size_value, seed_value)
	instance.material_override = material
	instance.position = position_value
	if snap_to_ground:
		_snap_to_terrain(instance, position_value.x, position_value.z, size_value.y * 0.50 - 0.08)
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(instance)

func _add_broken_column(parent: Node3D, position_value: Vector3, height_value: float, seed_value: int) -> void:
	var root: Node3D = Node3D.new()
	root.name = "ColunaPartida"
	root.position = position_value
	_snap_to_terrain(root, position_value.x, position_value.z, 0.0)
	root.rotation_degrees.z = -7.0 + float(seed_value % 4) * 3.0
	parent.add_child(root)
	_add_boulder(root, Vector3(0.0, height_value * 0.48, 0.0), Vector3(0.82, height_value, 0.82), seed_value, wet_stone_material, "FusteErodido", false)
	_add_boulder(root, Vector3(0.0, 0.20, 0.0), Vector3(1.3, 0.42, 1.3), seed_value + 3, stone_material, "BaseFraturada", false)
	_add_boulder(root, Vector3(0.22, height_value + 0.10, 0.0), Vector3(1.25, 0.46, 1.05), seed_value + 6, stone_material, "CapitelPartido", false)

func _snap_to_terrain(object_node: Node3D, world_x: float, world_z: float, vertical_offset: float = 0.0) -> void:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		var ground_y: float = float(terrain_patch.call("height_at", world_x, world_z))
		object_node.position = Vector3(world_x, ground_y + vertical_offset, world_z)
		return
	# Salvaguarda: procura uma colisão abaixo do objeto quando o terreno ainda não está disponível.
	if not is_inside_tree():
		return
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(Vector3(world_x, 200.0, world_z), Vector3(world_x, -200.0, world_z))
	var result: Dictionary = get_world_3d().direct_space_state.intersect_ray(query)
	if not result.is_empty():
		var hit_position: Vector3 = result.get("position", Vector3.ZERO) as Vector3
		object_node.position = hit_position + Vector3.UP * vertical_offset

func _create_rock_mesh(size_value: Vector3, seed_value: int) -> ArrayMesh:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = seed_value
	var tool: SurfaceTool = SurfaceTool.new()
	tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	var rings: int = 5
	var segments: int = 10
	var vertices: Array[Vector3] = []
	for ring: int in range(rings):
		var vertical_ratio: float = float(ring) / float(rings - 1)
		var y: float = (vertical_ratio - 0.5) * size_value.y
		var taper: float = sin(vertical_ratio * PI) * 0.42 + 0.54
		for segment: int in range(segments):
			var angle: float = float(segment) * TAU / float(segments)
			var irregularity: float = 0.78 + rng.randf_range(-0.14, 0.18)
			vertices.append(Vector3(cos(angle) * size_value.x * taper * irregularity, y, sin(angle) * size_value.z * taper * irregularity))
	for ring: int in range(rings - 1):
		for segment: int in range(segments):
			var next_segment: int = (segment + 1) % segments
			var a: Vector3 = vertices[ring * segments + segment]
			var b: Vector3 = vertices[ring * segments + next_segment]
			var c: Vector3 = vertices[(ring + 1) * segments + segment]
			var d: Vector3 = vertices[(ring + 1) * segments + next_segment]
			tool.add_vertex(a)
			tool.add_vertex(c)
			tool.add_vertex(b)
			tool.add_vertex(b)
			tool.add_vertex(c)
			tool.add_vertex(d)
	var bottom: Vector3 = Vector3(0.0, -size_value.y * 0.5, 0.0)
	var top: Vector3 = Vector3(0.0, size_value.y * 0.5, 0.0)
	for segment: int in range(segments):
		var next_segment: int = (segment + 1) % segments
		tool.add_vertex(bottom)
		tool.add_vertex(vertices[next_segment])
		tool.add_vertex(vertices[segment])
		var top_offset: int = (rings - 1) * segments
		tool.add_vertex(top)
		tool.add_vertex(vertices[top_offset + segment])
		tool.add_vertex(vertices[top_offset + next_segment])
	tool.generate_normals()
	return tool.commit()
