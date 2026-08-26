## ForestRimBalance.gd
## DEV4-R4-FOREST-RIM-BALANCE-023
## Equilíbrio estático da borda R4 com árvores existentes sem colisor, mantendo a margem aberta e lateral.

class_name R4ForestRimBalance
extends Node3D

const NODE_NAME: String = "R4EquilibrioDaBordaFlorestal"
const BAND_START_Z: float = 165.0
const BAND_END_Z: float = 170.0
const MIN_PATH_CLEARANCE: float = 10.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestRimBalance:
	if parent == null or forest_root == null:
		return null
	var existing: R4ForestRimBalance = parent.get_node_or_null(NODE_NAME) as R4ForestRimBalance
	if existing != null:
		return existing
	var balance: R4ForestRimBalance = R4ForestRimBalance.new()
	balance.name = NODE_NAME
	parent.add_child(balance)
	balance._apply(path_x_at, height_at, forest_root)
	return balance

func _apply(path_x_at: Callable, height_at: Callable, forest_root: Node) -> void:
	var adjusted: int = 0
	var collision_preserved: int = 0
	var ordinal: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("ArvoreDaFloresta_"):
			continue
		var tree: Node3D = child as Node3D
		var z_value: float = tree.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var tree_index: int = int(String(tree.name).trim_prefix("ArvoreDaFloresta_"))
		if tree_index % 6 == 0:
			collision_preserved += 1
			continue
		var side: float = -1.0 if tree.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = z_value + (-0.22 if ordinal % 2 == 0 else 0.20)
		var target_x: float = float(path_x_at.call(target_z)) + side * (10.80 + float(ordinal % 2) * 1.10)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		tree.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		tree.rotation.y += -0.08 + float((ordinal * 3) % 4) * 0.07
		tree.set_meta("r4_rim_balance_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_rim_balance_adjusted", adjusted)
	set_meta("r4_rim_balance_collision_preserved", collision_preserved)
	set_meta("r4_rim_balance_dynamic_lights", 0)
	print("[ORIGEM_R4_RIM_BALANCE] ajustadas=%d colisores_preservados=%d luzes=0" % [adjusted, collision_preserved])
