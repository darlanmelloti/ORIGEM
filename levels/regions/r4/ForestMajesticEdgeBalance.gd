## ForestMajesticEdgeBalance.gd
## DEV4-R4-MAJESTIC-EDGE-BALANCE-008
## Ajuste estático e exclusivamente visual de fetos e copas focais pertencentes à R4 junto ao limite anterior a Majestic.

class_name R4ForestMajesticEdgeBalance
extends Node3D

const NODE_NAME: String = "R4EquilibrioDaBordaMajestic"
const EDGE_START_Z: float = 165.0
const EDGE_END_Z: float = 174.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, roots: Array[Node]) -> R4ForestMajesticEdgeBalance:
	if parent == null:
		return null
	var existing: R4ForestMajesticEdgeBalance = parent.get_node_or_null(NODE_NAME) as R4ForestMajesticEdgeBalance
	if existing != null:
		return existing
	var balance: R4ForestMajesticEdgeBalance = R4ForestMajesticEdgeBalance.new()
	balance.name = NODE_NAME
	parent.add_child(balance)
	balance._apply(path_x_at, height_at, roots)
	return balance

func _apply(path_x_at: Callable, height_at: Callable, roots: Array[Node]) -> void:
	var adjusted: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for source_root: Node in roots:
		if source_root == null:
			continue
		for child: Node in source_root.get_children():
			if not child is Node3D:
				continue
			var name_value: String = String(child.name)
			if not name_value.begins_with("FetoFloresta_") and not name_value.begins_with("CopaFocalFlorestal_"):
				continue
			var element: Node3D = child as Node3D
			var z_value: float = element.position.z
			if z_value < EDGE_START_Z or z_value > EDGE_END_Z:
				continue
			var path_x: float = float(path_x_at.call(z_value))
			var side: float = -1.0 if element.position.x < path_x else 1.0
			var target_z: float = z_value + (-0.18 if ordinal % 2 == 0 else 0.16)
			var target_clearance: float = 6.30 + float((ordinal * 5) % 3) * 0.24
			if name_value.begins_with("Copa"):
				target_clearance += 1.00
			var target_x: float = float(path_x_at.call(target_z)) + side * target_clearance
			if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
				rejected_for_corridor += 1
				ordinal += 1
				continue
			element.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + (0.02 if name_value.begins_with("Feto") else 0.0), target_z)
			var lateral_scale: float = 0.94 + float((ordinal * 7) % 4) * 0.025
			var vertical_scale: float = 0.98 + float((ordinal * 11) % 4) * 0.020
			element.scale = Vector3(element.scale.x * lateral_scale, element.scale.y * vertical_scale, element.scale.z * lateral_scale)
			element.rotation.y += -0.14 + float((ordinal * 3) % 5) * 0.055
			element.set_meta("r4_majestic_edge_static", true)
			adjusted += 1
			ordinal += 1
	set_meta("r4_majestic_edge_adjusted", adjusted)
	set_meta("r4_majestic_edge_corridor_rejected", rejected_for_corridor)
	set_meta("r4_majestic_edge_dynamic_lights", 0)
	print("[ORIGEM_R4_EDGE] ajustados=%d corredor_rejeitado=%d luzes=0" % [adjusted, rejected_for_corridor])
