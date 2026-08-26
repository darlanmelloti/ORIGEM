## ForestOuterVista.gd
## DEV4-R4-FOREST-OUTER-VISTA-025
## Variação estática de árvores exteriores existentes, sem deslocar bases cartográficas.

class_name R4ForestOuterVista
extends RefCounted

const TARGET_COUNT: int = 2

static func apply(forest_root: Node3D) -> int:
	if forest_root == null:
		return 0
	if bool(forest_root.get_meta("r4_outer_vista_applied", false)):
		return int(forest_root.get_meta("r4_outer_vista_adjusted", 0))
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is Node3D or not bool(child.get_meta("r4_outer_rhythm_static", false)):
			continue
		if bool(child.get_meta("r4_outer_depth_static", false)) or bool(child.get_meta("r4_outer_lateral_balance_static", false)):
			continue
		var tree: Node3D = child as Node3D
		tree.scale = Vector3(tree.scale.x * (0.990 + 0.020 * float(adjusted)), tree.scale.y * (1.008 - 0.004 * float(adjusted)), tree.scale.z)
		tree.rotation.y += -0.020 + 0.040 * float(adjusted)
		tree.set_meta("r4_outer_vista_static", true)
		adjusted += 1
	forest_root.set_meta("r4_outer_vista_applied", true)
	forest_root.set_meta("r4_outer_vista_adjusted", adjusted)
	forest_root.set_meta("r4_outer_vista_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_VISTA] arvores_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
