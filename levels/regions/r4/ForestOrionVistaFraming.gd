## ForestOrionVistaFraming.gd
## DEV4-R4-ORION-VISTA-FRAMING-006
## Cadência lateral estática para revelar Orion por aproximação, sem alterar clareira, trilho ou geometria.

class_name R4ForestOrionVistaFraming
extends Node3D

const NODE_NAME: String = "R4EnquadramentoLateralDeOrion"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const MIN_PATH_CLEARANCE: float = 6.0
const FRAME_START_Z: float = 96.0
const FRAME_END_Z: float = 168.0

static func install(parent: Node3D, path_x_at: Callable, canopy_roots: Array[Node]) -> R4ForestOrionVistaFraming:
	if parent == null:
		return null
	var existing: R4ForestOrionVistaFraming = parent.get_node_or_null(NODE_NAME) as R4ForestOrionVistaFraming
	if existing != null:
		return existing
	var framing: R4ForestOrionVistaFraming = R4ForestOrionVistaFraming.new()
	framing.name = NODE_NAME
	parent.add_child(framing)
	framing._apply(path_x_at, canopy_roots)
	return framing

func _apply(path_x_at: Callable, canopy_roots: Array[Node]) -> void:
	var adjusted: int = 0
	var protected_clearing: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for canopy_root: Node in canopy_roots:
		if canopy_root == null:
			continue
		for child: Node in canopy_root.get_children():
			if not child is Node3D:
				continue
			var name_value: String = String(child.name)
			if not name_value.begins_with("ArvoreTransicaoArco_") and not name_value.begins_with("CopaFocalFlorestal_"):
				continue
			var canopy: Node3D = child as Node3D
			var z_value: float = canopy.position.z
			if z_value >= CLEARING_START_Z and z_value <= CLEARING_END_Z:
				protected_clearing += 1
				continue
			if z_value < FRAME_START_Z or z_value > FRAME_END_Z:
				continue
			var path_x: float = float(path_x_at.call(z_value))
			var side: float = -1.0 if canopy.position.x < path_x else 1.0
			var outward_shift: float = 0.28 + float(ordinal % 3) * 0.10
			var proposed_x: float = canopy.position.x + side * outward_shift
			if abs(proposed_x - path_x) < MIN_PATH_CLEARANCE:
				rejected_for_corridor += 1
				ordinal += 1
				continue
			var lateral_scale: float = 0.96 + float((ordinal * 5) % 5) * 0.025
			var vertical_scale: float = 0.98 + float((ordinal * 7) % 5) * 0.030
			canopy.position.x = proposed_x
			canopy.scale = Vector3(canopy.scale.x * lateral_scale, canopy.scale.y * vertical_scale, canopy.scale.z * lateral_scale)
			canopy.rotation.y += -0.18 + float((ordinal * 3) % 6) * 0.075
			canopy.set_meta("r4_orion_vista_static", true)
			adjusted += 1
			ordinal += 1
	set_meta("r4_orion_vista_adjusted", adjusted)
	set_meta("r4_orion_vista_clearing_protected", protected_clearing)
	set_meta("r4_orion_vista_corridor_rejected", rejected_for_corridor)
	set_meta("r4_orion_vista_dynamic_lights", 0)
	print("[ORIGEM_R4_VISTA] ajustadas=%d clareira_protegida=%d corredor_rejeitado=%d luzes=0" % [adjusted, protected_clearing, rejected_for_corridor])
