## ForestOuterLateralBalance.gd
## DEV4-R4-FOREST-OUTER-LATERAL-BALANCE-024
## Equilíbrio estático em árvores exteriores existentes, sem deslocar bases espaciais.

class_name R4ForestOuterLateralBalance
extends RefCounted

const TARGET_COUNT: int = 2

static func apply(forest_root: Node3D) -> int:
	if forest_root == null:
		return 0
	if bool(forest_root.get_meta("r4_outer_lateral_balance_applied", false)):
		return int(forest_root.get_meta("r4_outer_lateral_balance_adjusted", 0))
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is Node3D or not bool(child.get_meta("r4_outer_rhythm_static", false)) or bool(child.get_meta("r4_outer_depth_static", false)):
			continue
		var tree: Node3D = child as Node3D
		var factor: float = 0.992 + 0.024 * float(adjusted)
		tree.scale = Vector3(tree.scale.x * factor, tree.scale.y * (1.01 - 0.006 * float(adjusted)), tree.scale.z * factor)
		tree.rotation.y += -0.030 + 0.060 * float(adjusted)
		tree.set_meta("r4_outer_lateral_balance_static", true)
		adjusted += 1
	forest_root.set_meta("r4_outer_lateral_balance_applied", true)
	forest_root.set_meta("r4_outer_lateral_balance_adjusted", adjusted)
	forest_root.set_meta("r4_outer_lateral_balance_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_LATERAL] arvores_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
