## ForestApproachRhythm.gd
## DEV4-R4-FOREST-APPROACH-RHYTHM-007
## Reorganização estática de instâncias laterais R4 depois da clareira Orion e antes do conector Majestic.

class_name R4ForestApproachRhythm
extends Node3D

const NODE_NAME: String = "R4CadenciaDaAproximacaoMajestic"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const APPROACH_START_Z: float = 152.0
const APPROACH_END_Z: float = 170.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, roots: Array[Node]) -> R4ForestApproachRhythm:
	if parent == null:
		return null
	var existing: R4ForestApproachRhythm = parent.get_node_or_null(NODE_NAME) as R4ForestApproachRhythm
	if existing != null:
		return existing
	var rhythm: R4ForestApproachRhythm = R4ForestApproachRhythm.new()
	rhythm.name = NODE_NAME
	parent.add_child(rhythm)
	rhythm._apply(path_x_at, height_at, roots)
	return rhythm

func _apply(path_x_at: Callable, height_at: Callable, roots: Array[Node]) -> void:
	var adjusted: int = 0
	var protected_clearing: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for source_root: Node in roots:
		if source_root == null:
			continue
		for child: Node in source_root.get_children():
			if not child is Node3D:
				continue
			var name_value: String = String(child.name)
			if not name_value.begins_with("ArvoreDaFloresta_") and not name_value.begins_with("FetoFloresta_") and not name_value.begins_with("CopaFocalFlorestal_"):
				continue
			var element: Node3D = child as Node3D
			var z_value: float = element.position.z
			if z_value >= CLEARING_START_Z and z_value <= CLEARING_END_Z:
				protected_clearing += 1
				continue
			if z_value < APPROACH_START_Z or z_value > APPROACH_END_Z:
				continue
			var path_x: float = float(path_x_at.call(z_value))
			var side: float = -1.0 if element.position.x < path_x else 1.0
			var target_clearance: float = 6.28 + float((ordinal * 5) % 4) * 0.24
			if name_value.begins_with("Arvore") or name_value.begins_with("Copa"):
				target_clearance += 1.10
			var z_shift: float = -0.30 + float((ordinal * 7) % 5) * 0.15
			var target_z: float = z_value + z_shift
			var target_x: float = float(path_x_at.call(target_z)) + side * target_clearance
			if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
				rejected_for_corridor += 1
				ordinal += 1
				continue
			element.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + (0.02 if name_value.begins_with("Feto") else 0.0), target_z)
			var lateral_scale: float = 0.93 + float((ordinal * 3) % 6) * 0.025
			var vertical_scale: float = 0.96 + float((ordinal * 11) % 5) * 0.030
			element.scale = Vector3(element.scale.x * lateral_scale, element.scale.y * vertical_scale, element.scale.z * lateral_scale)
			element.rotation.y += -0.20 + float((ordinal * 13) % 7) * 0.06
			element.set_meta("r4_forest_approach_static", true)
			adjusted += 1
			ordinal += 1
	set_meta("r4_forest_approach_adjusted", adjusted)
	set_meta("r4_forest_approach_clearing_protected", protected_clearing)
	set_meta("r4_forest_approach_corridor_rejected", rejected_for_corridor)
	set_meta("r4_forest_approach_dynamic_lights", 0)
	print("[ORIGEM_R4_APPROACH] ajustados=%d clareira_protegida=%d corredor_rejeitado=%d luzes=0" % [adjusted, protected_clearing, rejected_for_corridor])
