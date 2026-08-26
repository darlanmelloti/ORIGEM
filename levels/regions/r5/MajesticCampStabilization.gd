## MajesticCampStabilization.gd
## DEV5-R5-CAMP-STABILIZATION-014
## Estabilização estática somente nas caixas visuais existentes já aprovadas.

class_name R5MajesticCampStabilization
extends RefCounted

const TARGET_COUNT: int = 2

static func apply(camp: Node3D) -> int:
	if camp == null:
		return 0
	if bool(camp.get_meta("r5_stabilization_applied", false)):
		return int(camp.get_meta("r5_stabilization_adjusted", 0))
	var adjusted: int = 0
	for child: Node in camp.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is MeshInstance3D or not bool(child.get_meta("r5_consolidation_static", false)):
			continue
		var supply: MeshInstance3D = child as MeshInstance3D
		supply.scale = Vector3(supply.scale.x * (1.0003 - 0.0003 * float(adjusted)), supply.scale.y, supply.scale.z * (0.9997 + 0.0006 * float(adjusted)))
		supply.rotation.y += -0.0015 + 0.003 * float(adjusted)
		supply.set_meta("r5_stabilization_static", true)
		adjusted += 1
	camp.set_meta("r5_stabilization_applied", true)
	camp.set_meta("r5_stabilization_adjusted", adjusted)
	camp.set_meta("r5_stabilization_dynamic_lights", 0)
	print("[ORIGEM_R5_STABILIZATION] caixas_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
