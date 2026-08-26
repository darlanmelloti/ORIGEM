## ForestEdgeRhythm.gd
## DEV4-R4-FOREST-EDGE-RHYTHM-015
## Ajuste estático de pedras húmidas R4 existentes junto ao conector Majestic, sem criar nós, colisores ou efeitos.

class_name R4ForestEdgeRhythm
extends Node3D

const NODE_NAME: String = "R4CadenciaDaBordaFlorestal"
const BAND_START_Z: float = 174.0
const BAND_END_Z: float = 182.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, details_root: Node) -> R4ForestEdgeRhythm:
	if parent == null or details_root == null:
		return null
	var existing: R4ForestEdgeRhythm = parent.get_node_or_null(NODE_NAME) as R4ForestEdgeRhythm
	if existing != null:
		return existing
	var rhythm: R4ForestEdgeRhythm = R4ForestEdgeRhythm.new()
	rhythm.name = NODE_NAME
	parent.add_child(rhythm)
	rhythm._apply(path_x_at, height_at, details_root)
	return rhythm

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
		var target_z: float = z_value + (-0.34 if ordinal % 2 == 0 else 0.28)
		var target_x: float = float(path_x_at.call(target_z)) + side * (6.52 + float(ordinal % 2) * 0.62)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			rejected_for_corridor += 1
			ordinal += 1
			continue
		stone.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + 0.035, target_z)
		stone.rotation.y += -0.18 + float((ordinal * 3) % 4) * 0.12
		stone.set_meta("r4_edge_rhythm_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_edge_rhythm_adjusted", adjusted)
	set_meta("r4_edge_rhythm_corridor_rejected", rejected_for_corridor)
	set_meta("r4_edge_rhythm_dynamic_lights", 0)
	print("[ORIGEM_R4_EDGE_RHYTHM] ajustadas=%d corredor_rejeitado=%d luzes=0" % [adjusted, rejected_for_corridor])
