## Perfil geométrico reutilizável para rotas físicas em heightfields.
## Não cria meshes, placas ou decals: apenas devolve a influência suave de uma curva no espaço XZ.

class_name RouteCurveProfile
extends RefCounted

var points: PackedVector2Array = PackedVector2Array()
var travel_width: float = 2.10
var blend_width: float = 1.25
var maximum_depth: float = 0.14

func sample_influence(world_x: float, world_z: float) -> float:
	if points.size() < 2:
		return 0.0
	var world_point: Vector2 = Vector2(world_x, world_z)
	var minimum_distance: float = INF
	for index: int in range(points.size() - 1):
		minimum_distance = minf(minimum_distance, _distance_to_segment(world_point, points[index], points[index + 1]))
	var outer_width: float = travel_width + blend_width
	if minimum_distance >= outer_width:
		return 0.0
	if minimum_distance <= travel_width:
		return 1.0
	var blend_t: float = (minimum_distance - travel_width) / blend_width
	return 1.0 - smoothstep(0.0, 1.0, blend_t)

func height_offset(world_x: float, world_z: float) -> float:
	return -maximum_depth * sample_influence(world_x, world_z)

func _distance_to_segment(point: Vector2, segment_start: Vector2, segment_end: Vector2) -> float:
	var direction: Vector2 = segment_end - segment_start
	var length_squared: float = direction.length_squared()
	if length_squared <= 0.000001:
		return point.distance_to(segment_start)
	var t: float = clampf((point - segment_start).dot(direction) / length_squared, 0.0, 1.0)
	return point.distance_to(segment_start + direction * t)
