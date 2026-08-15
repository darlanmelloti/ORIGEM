## ExplorableMountains.gd
## Maciço Orion: serra procedural tridimensional, colidível e texturizada para a abertura da Casa Voss.
## Não utiliza painéis de fundo; cada pico é uma malha PBR explorável com colisão estática.

extends Node3D
class_name ExplorableMountains

const ROCK_DIFFUSE: Texture2D = preload("res://assets/textures/pbr/mossy_rock_diff.jpg")
const ROCK_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")
const ROCK_ROUGHNESS: Texture2D = preload("res://assets/textures/pbr/mossy_rock_roughness.jpg")

var rock_material: StandardMaterial3D
var dark_rock_material: StandardMaterial3D

func _ready() -> void:
	_create_materials()
	# Teste de uma serra única por campo de alturas: encosta real, contínua e colidível, sem painéis de fundo.
	_build_reference_ridge()

func _create_materials() -> void:
	rock_material = StandardMaterial3D.new()
	# Passe comparativo: o Orion monumental reduz a face excessivamente clara, preservando normal PBR e geometria explorável.
	rock_material.albedo_color = Color(0.115, 0.135, 0.120, 1.0)
	rock_material.albedo_texture = ROCK_DIFFUSE
	rock_material.normal_enabled = true
	rock_material.normal_texture = ROCK_NORMAL
	rock_material.normal_scale = 0.62
	rock_material.roughness_texture = ROCK_ROUGHNESS
	rock_material.roughness = 0.92
	rock_material.uv1_triplanar = true
	rock_material.uv1_world_triplanar = true
	rock_material.uv1_scale = Vector3(0.075, 0.075, 0.075)

	dark_rock_material = rock_material.duplicate() as StandardMaterial3D
	dark_rock_material.albedo_color = Color(0.105, 0.123, 0.110, 1.0)
	dark_rock_material.roughness = 0.93

func _build_reference_ridge() -> void:
	var cells_x: int = 46
	var cells_z: int = 26
	var min_x: float = -24.0
	var max_x: float = 116.0
	var front_z: float = -48.0
	var back_z: float = -126.0
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for z_index: int in range(cells_z):
		for x_index: int in range(cells_x):
			var x0: float = lerpf(min_x, max_x, float(x_index) / float(cells_x))
			var x1: float = lerpf(min_x, max_x, float(x_index + 1) / float(cells_x))
			var z0: float = lerpf(front_z, back_z, float(z_index) / float(cells_z))
			var z1: float = lerpf(front_z, back_z, float(z_index + 1) / float(cells_z))
			var p00: Vector3 = Vector3(x0, _reference_ridge_height(x0, z0), z0)
			var p10: Vector3 = Vector3(x1, _reference_ridge_height(x1, z0), z0)
			var p01: Vector3 = Vector3(x0, _reference_ridge_height(x0, z1), z1)
			var p11: Vector3 = Vector3(x1, _reference_ridge_height(x1, z1), z1)
			_add_triangle(surface, p00, p01, p10)
			_add_triangle(surface, p10, p01, p11)
	surface.generate_normals()
	var mesh: ArrayMesh = surface.commit()
	mesh.surface_set_material(0, rock_material)
	var ridge: MeshInstance3D = MeshInstance3D.new()
	ridge.name = "SerraOrionContinua"
	ridge.mesh = mesh
	ridge.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	add_child(ridge)
	var body: StaticBody3D = StaticBody3D.new()
	body.name = "SerraOrionContinua_Colisao"
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: ConcavePolygonShape3D = ConcavePolygonShape3D.new()
	shape.data = mesh.get_faces()
	collision.shape = shape
	body.add_child(collision)
	add_child(body)

func _reference_ridge_height(x: float, z: float) -> float:
	var depth: float = clampf((front_z_placeholder() - z) / (front_z_placeholder() - back_z_placeholder()), 0.0, 1.0)
	var central_mass: float = 54.0 * exp(-pow((x - 48.0) / 31.0, 2.0))
	var west_shoulder: float = 21.0 * exp(-pow((x - 13.0) / 24.0, 2.0))
	var east_shoulder: float = 19.0 * exp(-pow((x - 82.0) / 25.0, 2.0))
	var ridge_noise: float = sin(x * 0.19 + z * 0.11) * 3.5 + sin(x * 0.43 - z * 0.08) * 1.5 + sin(x * 0.71 + z * 0.39) * 1.35 + sin(x * 1.17 - z * 0.62) * 0.65
	var erosion_gullies: float = absf(sin(x * 0.31 + z * 0.17)) * 2.15 + absf(sin(x * 0.58 - z * 0.29)) * 0.75
	return maxf(0.0, (central_mass + west_shoulder + east_shoulder) * pow(depth, 0.74) + (ridge_noise - erosion_gullies) * depth)

func front_z_placeholder() -> float:
	return -48.0

func back_z_placeholder() -> float:
	return -126.0

func _build_peak(node_name: String, center: Vector3, radius: float, height_value: float, phase: float, material: StandardMaterial3D, add_collision: bool) -> void:
	# Mais segmentos preservam a mesma serra ampla, mas suavizam as transições visíveis entre faces no plano de fundo.
	var radial_segments: int = 30
	var rings: int = 10
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)

	for ring: int in range(rings):
		var t0: float = float(ring) / float(rings)
		var t1: float = float(ring + 1) / float(rings)
		for segment: int in range(radial_segments):
			var next_segment: int = (segment + 1) % radial_segments
			var a: Vector3 = _peak_point(center, radius, height_value, t0, segment, radial_segments, phase)
			var b: Vector3 = _peak_point(center, radius, height_value, t0, next_segment, radial_segments, phase)
			var c: Vector3 = _peak_point(center, radius, height_value, t1, segment, radial_segments, phase)
			var d: Vector3 = _peak_point(center, radius, height_value, t1, next_segment, radial_segments, phase)
			_add_triangle(surface, a, c, b)
			_add_triangle(surface, b, c, d)

	surface.generate_normals()
	var mesh: ArrayMesh = surface.commit()
	mesh.surface_set_material(0, material)
	var peak: MeshInstance3D = MeshInstance3D.new()
	peak.name = node_name
	peak.mesh = mesh
	peak.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	add_child(peak)

	if add_collision:
		var body: StaticBody3D = StaticBody3D.new()
		body.name = node_name + "_Colisao"
		var collision: CollisionShape3D = CollisionShape3D.new()
		var shape: ConcavePolygonShape3D = ConcavePolygonShape3D.new()
		shape.data = mesh.get_faces()
		collision.shape = shape
		body.add_child(collision)
		add_child(body)

func _peak_point(center: Vector3, radius: float, height_value: float, ratio: float, segment: int, segments: int, phase: float) -> Vector3:
	var angle: float = TAU * float(segment) / float(segments)
	var ridge_noise: float = 0.82 + sin(angle * 3.0 + phase * 5.0) * 0.16 + sin(angle * 7.0 - phase) * 0.07
	# Crista mais larga e erodida: evita cones/agulhas e dá uma leitura de serra natural no plano de fundo.
	var ring_radius: float = radius * (1.0 - ratio * 0.64) * ridge_noise
	var x: float = cos(angle) * ring_radius
	var z: float = sin(angle) * ring_radius * 0.72
	var vertical_profile: float = pow(ratio, 1.12)
	var spine: float = sin(angle * 2.0 + phase * 4.0) * radius * 0.08 * (1.0 - ratio)
	var y: float = vertical_profile * height_value + sin(ratio * PI * 3.0 + angle * 2.0 + phase) * 2.1 * ratio
	return center + Vector3(x, maxf(0.0, y), z + spine)

func _add_triangle(surface: SurfaceTool, first: Vector3, second: Vector3, third: Vector3) -> void:
	surface.add_vertex(first)
	surface.add_vertex(second)
	surface.add_vertex(third)
