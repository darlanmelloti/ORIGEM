## ForestUnderstoryEdge.gd
## DEV4-R4-UNDERSTORY-EDGE-005
## Reorganização estática de fetos e rochas já existentes no limiar Arco→Floresta.
## Não cria nós, luzes, colisores, partículas, vento, animação, materiais ou pós-processamento.

class_name R4ForestUnderstoryEdge
extends Node3D

const NODE_NAME: String = "R4TransicaoLateralDoSubBosque"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, understory: Node) -> R4ForestUnderstoryEdge:
	if parent == null or understory == null:
		return null
	var existing: R4ForestUnderstoryEdge = parent.get_node_or_null(NODE_NAME) as R4ForestUnderstoryEdge
	if existing != null:
		return existing
	var edge: R4ForestUnderstoryEdge = R4ForestUnderstoryEdge.new()
	edge.name = NODE_NAME
	parent.add_child(edge)
	edge._apply(path_x_at, height_at, understory)
	return edge

func _apply(path_x_at: Callable, height_at: Callable, understory: Node) -> void:
	var adjusted: int = 0
	var protected_clearing: int = 0
	var minimum_clearance: float = INF
	var ordinal: int = 0
	for child: Node in understory.get_children():
		if not (child is Node3D):
			continue
		var name_value: String = String(child.name)
		if not name_value.begins_with("FetoSubBosqueLimiar_") and not name_value.begins_with("RochaSubBosqueLimiar_"):
			continue
		var element: Node3D = child as Node3D
		var z_value: float = element.position.z
		if z_value >= CLEARING_START_Z and z_value <= CLEARING_END_Z:
			protected_clearing += 1
			continue
		var path_x: float = float(path_x_at.call(z_value))
		var side: float = -1.0 if element.position.x < path_x else 1.0
		var target_clearance: float = 6.25 + float((ordinal * 3) % 4) * 0.28
		var lateral_jitter: float = 0.0 if ordinal % 2 == 0 else 0.16
		var z_jitter: float = -0.38 + float((ordinal * 5) % 5) * 0.19
		var target_x: float = path_x + side * (target_clearance + lateral_jitter)
		var target_z: float = z_value + z_jitter
		element.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + (0.02 if name_value.begins_with("Feto") else 0.03), target_z)
		var scale_factor: float = 0.90 + float((ordinal * 7) % 6) * 0.035
		element.scale *= scale_factor
		element.rotation.y += -0.22 + float((ordinal * 11) % 7) * 0.07
		element.set_meta("r4_understory_edge_static", true)
		minimum_clearance = minf(minimum_clearance, abs(target_x - float(path_x_at.call(target_z))))
		adjusted += 1
		ordinal += 1
	set_meta("r4_understory_adjusted", adjusted)
	set_meta("r4_understory_clearing_protected", protected_clearing)
	set_meta("r4_understory_min_clearance", minimum_clearance if minimum_clearance < INF else 0.0)
	set_meta("r4_understory_dynamic_lights", 0)
	print("[ORIGEM_R4_UNDERSTORY] ajustados=%d clareira_protegida=%d minima=%.2f luzes=0" % [adjusted, protected_clearing, get_meta("r4_understory_min_clearance")])
