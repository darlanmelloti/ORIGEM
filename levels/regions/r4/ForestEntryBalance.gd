## ForestEntryBalance.gd
## DEV4-R4-FOREST-ENTRY-BALANCE-017
## Reequilíbrio estático de fetos R4 existentes na chegada à floresta, anterior à clareira Orion.

class_name R4ForestEntryBalance
extends Node3D

const NODE_NAME: String = "R4EquilibrioDaEntradaFlorestal"
const BAND_START_Z: float = 116.0
const BAND_END_Z: float = 125.5
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestEntryBalance:
	if parent == null or forest_root == null:
		return null
	var existing: R4ForestEntryBalance = parent.get_node_or_null(NODE_NAME) as R4ForestEntryBalance
	if existing != null:
		return existing
	var balance: R4ForestEntryBalance = R4ForestEntryBalance.new()
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
		var side: float = -1.0 if fern.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = z_value + (-0.20 if ordinal % 2 == 0 else 0.18)
		var target_x: float = float(path_x_at.call(target_z)) + side * (6.30 + float(ordinal % 2) * 0.40)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			rejected_for_corridor += 1
			ordinal += 1
			continue
		fern.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + 0.02, target_z)
		fern.rotation.y += -0.16 + float((ordinal * 5) % 4) * 0.10
		fern.set_meta("r4_entry_balance_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_entry_balance_adjusted", adjusted)
	set_meta("r4_entry_balance_corridor_rejected", rejected_for_corridor)
	set_meta("r4_entry_balance_dynamic_lights", 0)
	print("[ORIGEM_R4_ENTRY_BALANCE] ajustados=%d corredor_rejeitado=%d luzes=0" % [adjusted, rejected_for_corridor])
