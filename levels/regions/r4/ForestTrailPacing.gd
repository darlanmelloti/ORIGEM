## ForestTrailPacing.gd
## DEV4-R4-FOREST-TRAIL-PACING-012
## Ajuste estático de pedras húmidas R4 existentes nas bordas do trilho, sem tocar em lajes, colisores ou sistemas partilhados.

class_name R4ForestTrailPacing
extends Node3D

const NODE_NAME: String = "R4RitmoVisualDoTrilho"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 170.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, details_root: Node) -> R4ForestTrailPacing:
	if parent == null or details_root == null:
		return null
	var existing: R4ForestTrailPacing = parent.get_node_or_null(NODE_NAME) as R4ForestTrailPacing
	if existing != null:
		return existing
	var pacing: R4ForestTrailPacing = R4ForestTrailPacing.new()
	pacing.name = NODE_NAME
	parent.add_child(pacing)
	pacing._apply(path_x_at, height_at, details_root)
	return pacing

func _apply(path_x_at: Callable, height_at: Callable, details_root: Node) -> void:
	var adjusted: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for child: Node in details_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("PedraHumidaFlorestal_"):
			continue
		var stone: Node3D = child as Node3D
		var z_value: float = stone.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var side: float = -1.0 if stone.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = z_value + (-0.48 if ordinal % 2 == 0 else 0.44)
		var target_x: float = float(path_x_at.call(target_z)) + side * (6.28 + float(ordinal % 2) * 0.76)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			rejected_for_corridor += 1
			ordinal += 1
			continue
		stone.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + 0.035, target_z)
		stone.rotation.y += -0.28 + float((ordinal * 5) % 5) * 0.12
		stone.set_meta("r4_trail_pacing_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_trail_pacing_adjusted", adjusted)
	set_meta("r4_trail_pacing_corridor_rejected", rejected_for_corridor)
	set_meta("r4_trail_pacing_dynamic_lights", 0)
	print("[ORIGEM_R4_PACING] ajustadas=%d corredor_rejeitado=%d luzes=0" % [adjusted, rejected_for_corridor])
