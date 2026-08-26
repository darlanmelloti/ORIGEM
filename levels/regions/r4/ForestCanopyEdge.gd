## ForestCanopyEdge.gd
## DEV4-R4-FOREST-CANOPY-EDGE-020
## Modulação estática de copa focal R4 existente na borda exterior, sem criar nós, física ou efeitos.

class_name R4ForestCanopyEdge
extends Node3D

const NODE_NAME: String = "R4BordaDasCopasFlorestal"
const BAND_START_Z: float = 192.0
const BAND_END_Z: float = 199.0
const MIN_PATH_CLEARANCE: float = 7.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, clusters_root: Node) -> R4ForestCanopyEdge:
	if parent == null or clusters_root == null:
		return null
	var existing: R4ForestCanopyEdge = parent.get_node_or_null(NODE_NAME) as R4ForestCanopyEdge
	if existing != null:
		return existing
	var edge: R4ForestCanopyEdge = R4ForestCanopyEdge.new()
	edge.name = NODE_NAME
	parent.add_child(edge)
	edge._apply(path_x_at, height_at, clusters_root)
	return edge

func _apply(path_x_at: Callable, height_at: Callable, clusters_root: Node) -> void:
	var adjusted: int = 0
	var collision_preserved: int = 0
	for child: Node in clusters_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("CopaFocalFlorestal_"):
			continue
		var canopy: Node3D = child as Node3D
		var z_value: float = canopy.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var canopy_index: int = int(String(canopy.name).trim_prefix("CopaFocalFlorestal_"))
		if canopy_index in [0, 3, 5]:
			collision_preserved += 1
			continue
		var side: float = -1.0 if canopy.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = z_value - 0.36
		var target_x: float = float(path_x_at.call(target_z)) + side * 8.10
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		canopy.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		canopy.rotation.y += 0.16
		canopy.set_meta("r4_canopy_edge_static", true)
		adjusted += 1
	set_meta("r4_canopy_edge_adjusted", adjusted)
	set_meta("r4_canopy_edge_collision_preserved", collision_preserved)
	set_meta("r4_canopy_edge_dynamic_lights", 0)
	print("[ORIGEM_R4_CANOPY_EDGE] ajustadas=%d colisores_preservados=%d luzes=0" % [adjusted, collision_preserved])
