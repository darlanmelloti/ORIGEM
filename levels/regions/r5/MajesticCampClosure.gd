## MajesticCampClosure.gd
## DEV5-R5-CAMP-CLOSURE-009
## Fecho estático somente nas caixas visuais existentes já aprovadas.

class_name R5MajesticCampClosure
extends RefCounted

const TARGET_COUNT: int = 2

static func apply(camp: Node3D) -> int:
	if camp == null:
		return 0
	if bool(camp.get_meta("r5_closure_applied", false)):
		return int(camp.get_meta("r5_closure_adjusted", 0))
	var adjusted: int = 0
	for child: Node in camp.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is MeshInstance3D or not bool(child.get_meta("r5_rhythm_final_static", false)):
			continue
		var supply: MeshInstance3D = child as MeshInstance3D
		supply.scale = Vector3(supply.scale.x * (0.999 + 0.002 * float(adjusted)), supply.scale.y * (1.002 - 0.002 * float(adjusted)), supply.scale.z)
		supply.rotation.y += -0.009 + 0.018 * float(adjusted)
		supply.set_meta("r5_closure_static", true)
		adjusted += 1
	camp.set_meta("r5_closure_applied", true)
	camp.set_meta("r5_closure_adjusted", adjusted)
	camp.set_meta("r5_closure_dynamic_lights", 0)
	print("[ORIGEM_R5_CLOSURE] caixas_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
