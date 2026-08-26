## ForestOuterDepth.gd
## DEV4-R4-FOREST-OUTER-DEPTH-023
## Profundidade estática apenas em árvores exteriores já aprovadas, sem deslocar o corredor.

class_name R4ForestOuterDepth
extends RefCounted

const TARGET_COUNT: int = 3

static func apply(forest_root: Node3D) -> int:
	if forest_root == null:
		return 0
	if bool(forest_root.get_meta("r4_outer_depth_applied", false)):
		return int(forest_root.get_meta("r4_outer_depth_adjusted", 0))
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is Node3D or not bool(child.get_meta("r4_outer_rhythm_static", false)):
			continue
		var tree: Node3D = child as Node3D
		# Não desloca a base espacial: só diferencia planos laterais por escala e orientação local.
		var factor: float = 0.985 + 0.020 * float(adjusted)
		tree.scale = Vector3(tree.scale.x * factor, tree.scale.y * (1.018 - 0.007 * float(adjusted)), tree.scale.z * factor)
		tree.rotation.y += -0.042 + 0.045 * float(adjusted)
		tree.set_meta("r4_outer_depth_static", true)
		adjusted += 1
	forest_root.set_meta("r4_outer_depth_applied", true)
	forest_root.set_meta("r4_outer_depth_adjusted", adjusted)
	forest_root.set_meta("r4_outer_depth_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_DEPTH] arvores_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
