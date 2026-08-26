## ForestCanopyEdge.gd
## DEV4-R4-FOREST-CANOPY-EDGE-020
## Ajuste estático de copas focais existentes na borda exterior, sem geometria, luz, colisão ou efeitos.

class_name R4ForestCanopyEdge
extends Node3D

const NODE_NAME: String = "R4CadenciaDaBordaDasCopas"
const BAND_START_Z: float = 190.0
const BAND_END_Z: float = 202.0
const MIN_PATH_CLEARANCE: float = 7.0

static func install(parent: Node3D, path_x_at: Callable, canopy_root: Node) -> R4ForestCanopyEdge:
	if parent == null or canopy_root == null or not path_x_at.is_valid():
		return null
	var existing: R4ForestCanopyEdge = parent.get_node_or_null(NODE_NAME) as R4ForestCanopyEdge
	if existing != null:
		return existing
	var edge: R4ForestCanopyEdge = R4ForestCanopyEdge.new()
	edge.name = NODE_NAME
	parent.add_child(edge)
	edge._apply(path_x_at, canopy_root)
	return edge

func _apply(path_x_at: Callable, canopy_root: Node) -> void:
	var adjusted: int = 0
	var skipped_collision: int = 0
	for child: Node in canopy_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("CopaFocalFlorestal_"):
			continue
		var canopy: Node3D = child as Node3D
		var z_value: float = canopy.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var suffix: String = String(canopy.name).replace("CopaFocalFlorestal_", "")
		if canopy_root.get_node_or_null("ColisorCopaFocalFlorestal_%s" % suffix) != null:
			skipped_collision += 1
			continue
		var path_x: float = float(path_x_at.call(z_value))
		var side: float = -1.0 if canopy.position.x < path_x else 1.0
		var target_x: float = canopy.position.x + side * 0.46
		if abs(target_x - path_x) < MIN_PATH_CLEARANCE:
			continue
		canopy.position.x = target_x
		canopy.scale = Vector3(canopy.scale.x * 1.06, canopy.scale.y * 0.94, canopy.scale.z * 1.06)
		canopy.rotation.y += side * 0.18
		canopy.set_meta("r4_canopy_edge_static", true)
		adjusted += 1
	set_meta("r4_canopy_edge_adjusted", adjusted)
	set_meta("r4_canopy_edge_collision_skipped", skipped_collision)
	set_meta("r4_canopy_edge_dynamic_lights", 0)
	print("[ORIGEM_R4_CANOPY_EDGE] ajustadas=%d colisores_preservados=%d luzes=0" % [adjusted, skipped_collision])
