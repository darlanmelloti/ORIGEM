## ForestApproachReadability.gd
## DEV4-R4-ORION-APPROACH-READABILITY-011
## Ajuste estático de raízes R4 existentes para marcar leitura lateral do trilho sem UI, eventos, luzes ou novas malhas.

class_name R4ForestApproachReadability
extends Node3D

const NODE_NAME: String = "R4LegibilidadeDaAproximacaoOrion"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 170.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, details_root: Node) -> R4ForestApproachReadability:
	if parent == null or details_root == null:
		return null
	var existing: R4ForestApproachReadability = parent.get_node_or_null(NODE_NAME) as R4ForestApproachReadability
	if existing != null:
		return existing
	var readability: R4ForestApproachReadability = R4ForestApproachReadability.new()
	readability.name = NODE_NAME
	parent.add_child(readability)
	readability._apply(path_x_at, height_at, details_root)
	return readability

func _apply(path_x_at: Callable, height_at: Callable, details_root: Node) -> void:
	var adjusted: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for child: Node in details_root.get_children():
		if not child is MeshInstance3D or not String(child.name).begins_with("RaizExpostaFlorestal_"):
			continue
		var root_mesh: MeshInstance3D = child as MeshInstance3D
		var z_value: float = root_mesh.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var path_x: float = float(path_x_at.call(z_value))
		var side: float = -1.0 if root_mesh.position.x < path_x else 1.0
		var target_z: float = z_value + (-0.42 if ordinal % 2 == 0 else 0.36)
		var target_x: float = float(path_x_at.call(target_z)) + side * (6.20 + float(ordinal % 3) * 0.32)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			rejected_for_corridor += 1
			ordinal += 1
			continue
		root_mesh.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + 0.075, target_z)
		root_mesh.rotation.y += -0.16 + float((ordinal * 5) % 5) * 0.08
		root_mesh.set_meta("r4_approach_readability_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_approach_readability_adjusted", adjusted)
	set_meta("r4_approach_readability_corridor_rejected", rejected_for_corridor)
	set_meta("r4_approach_readability_dynamic_lights", 0)
	print("[ORIGEM_R4_READABILITY] ajustadas=%d corredor_rejeitado=%d luzes=0" % [adjusted, rejected_for_corridor])
