## ForestOuterObservation.gd
## DEV4-R4-FOREST-OUTER-OBSERVATION-029
## Observação estática em árvores existentes, sem alterar bases cartográficas.

class_name R4ForestOuterObservation
extends RefCounted

const TARGET_COUNT: int = 2

static func apply(forest_root: Node3D) -> int:
	if forest_root == null:
		return 0
	if bool(forest_root.get_meta("r4_outer_observation_applied", false)):
		return int(forest_root.get_meta("r4_outer_observation_adjusted", 0))
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is Node3D or not bool(child.get_meta("r4_outer_readability_final_static", false)):
			continue
		var tree: Node3D = child as Node3D
		tree.scale = Vector3(tree.scale.x * (1.001 - 0.001 * float(adjusted)), tree.scale.y * (1.001 - 0.001 * float(adjusted)), tree.scale.z * (0.999 + 0.002 * float(adjusted)))
		tree.rotation.y += -0.005 + 0.010 * float(adjusted)
		tree.set_meta("r4_outer_observation_static", true)
		adjusted += 1
	forest_root.set_meta("r4_outer_observation_applied", true)
	forest_root.set_meta("r4_outer_observation_adjusted", adjusted)
	forest_root.set_meta("r4_outer_observation_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_OBSERVATION] arvores_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
