## ForestDepthBalance.gd
## DEV4-R4-FOREST-DEPTH-BALANCE-010
## Reorganização estática de fetos R4 existentes em dois planos laterais, sem criar nós, luzes, física ou efeitos.

class_name R4ForestDepthBalance
extends Node3D

const NODE_NAME: String = "R4EquilibrioDeProfundidadeLateral"
const BAND_START_Z: float = 153.0
const BAND_END_Z: float = 169.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestDepthBalance:
	if parent == null or forest_root == null:
		return null
	var existing: R4ForestDepthBalance = parent.get_node_or_null(NODE_NAME) as R4ForestDepthBalance
	if existing != null:
		return existing
	var balance: R4ForestDepthBalance = R4ForestDepthBalance.new()
	balance.name = NODE_NAME
	parent.add_child(balance)
	balance._apply(path_x_at, height_at, forest_root)
	return balance

func _apply(path_x_at: Callable, height_at: Callable, forest_root: Node) -> void:
	var adjusted: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("FetoFloresta_"):
			continue
		var fern: Node3D = child as Node3D
		var z_value: float = fern.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var path_x: float = float(path_x_at.call(z_value))
		var side: float = -1.0 if fern.position.x < path_x else 1.0
		var depth_plane: float = 6.35 if ordinal % 2 == 0 else 8.15
		var target_z: float = z_value + (-0.68 if ordinal % 2 == 0 else 0.58)
		var target_x: float = float(path_x_at.call(target_z)) + side * depth_plane
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			rejected_for_corridor += 1
			ordinal += 1
			continue
		fern.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + 0.02, target_z)
		var scale_factor: float = 0.90 + float((ordinal * 7) % 5) * 0.035
		fern.scale *= scale_factor
		fern.rotation.y += -0.30 + float((ordinal * 5) % 6) * 0.10
		fern.set_meta("r4_depth_balance_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_depth_balance_adjusted", adjusted)
	set_meta("r4_depth_balance_corridor_rejected", rejected_for_corridor)
	set_meta("r4_depth_balance_dynamic_lights", 0)
	print("[ORIGEM_R4_DEPTH] ajustados=%d corredor_rejeitado=%d luzes=0" % [adjusted, rejected_for_corridor])
