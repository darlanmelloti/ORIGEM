## ForestCanopyCadence.gd
## DEV4-R4-CANOPY-CADENCE-004
## Variação estática de copas já existentes: sem geometria nova, luz, física, partículas,
## vento, câmara, pós-processamento, shader ou alteração do trilho.

class_name R4ForestCanopyCadence
extends Node3D

const NODE_NAME: String = "R4CadenciaEstaticaDasCopas"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, canopy_roots: Array[Node]) -> R4ForestCanopyCadence:
	if parent == null:
		return null
	var existing: R4ForestCanopyCadence = parent.get_node_or_null(NODE_NAME) as R4ForestCanopyCadence
	if existing != null:
		return existing
	var cadence: R4ForestCanopyCadence = R4ForestCanopyCadence.new()
	cadence.name = NODE_NAME
	parent.add_child(cadence)
	cadence._apply(path_x_at, canopy_roots)
	return cadence

func _apply(path_x_at: Callable, canopy_roots: Array[Node]) -> void:
	var adjusted: int = 0
	var protected_clearing: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for canopy_root: Node in canopy_roots:
		if canopy_root == null:
			continue
		for tree: Node in canopy_root.get_children():
			if not (tree is Node3D) or not String(tree.name).begins_with("ArvoreDaFloresta_") and not String(tree.name).begins_with("CopaFocalFlorestal_"):
				continue
			var canopy: Node3D = tree as Node3D
			var z_value: float = canopy.position.z
			if z_value >= CLEARING_START_Z and z_value <= CLEARING_END_Z:
				protected_clearing += 1
				continue
			# A modulação afecta apenas um terço das árvores existentes; as restantes preservam massa e desempenho.
			if ordinal % 3 != 0:
				ordinal += 1
				continue
			var path_x: float = float(path_x_at.call(z_value))
			var side: float = -1.0 if canopy.position.x < path_x else 1.0
			var lateral_shift: float = 0.34 + float(ordinal % 4) * 0.12
			var proposed_x: float = canopy.position.x + side * lateral_shift
			if abs(proposed_x - path_x) < MIN_PATH_CLEARANCE:
				rejected_for_corridor += 1
				ordinal += 1
				continue
			var lateral_scale: float = 0.90 + float((ordinal * 5) % 6) * 0.035
			var vertical_scale: float = 0.94 + float((ordinal * 7) % 7) * 0.045
			canopy.position.x = proposed_x
			canopy.scale = Vector3(canopy.scale.x * lateral_scale, canopy.scale.y * vertical_scale, canopy.scale.z * lateral_scale)
			canopy.rotation.y += -0.32 + float((ordinal * 11) % 9) * 0.08
			canopy.set_meta("r4_canopy_cadence_static", true)
			adjusted += 1
			ordinal += 1
	set_meta("r4_canopy_adjusted", adjusted)
	set_meta("r4_canopy_clearing_protected", protected_clearing)
	set_meta("r4_canopy_corridor_rejected", rejected_for_corridor)
	set_meta("r4_canopy_dynamic_lights", 0)
	print("[ORIGEM_R4_CANOPY] ajustadas=%d clareira_protegida=%d corredor_rejeitado=%d luzes=0" % [adjusted, protected_clearing, rejected_for_corridor])
