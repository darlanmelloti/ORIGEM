## MajesticCampEdgeReading.gd
## DEV5-R5-CAMP-EDGE-READING-005
## Ajuste estático apenas nos rolos de campo existentes da margem lateral do Acampamento Majestic.

class_name R5MajesticCampEdgeReading
extends RefCounted

const TARGET_COUNT: int = 3

static func apply(camp: Node3D) -> int:
	if camp == null:
		return 0
	if bool(camp.get_meta("r5_edge_reading_applied", false)):
		return int(camp.get_meta("r5_edge_reading_adjusted", 0))
	var adjusted: int = 0
	for child: Node in camp.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is MeshInstance3D or not String(child.name).begins_with("RoloDeCampoMajestic_"):
			continue
		var roll: MeshInstance3D = child as MeshInstance3D
		var factor: float = 0.99 + 0.02 * float(adjusted)
		roll.scale = Vector3(roll.scale.x * factor, roll.scale.y * (1.012 - 0.006 * float(adjusted)), roll.scale.z * factor)
		roll.rotation.y += -0.04 + 0.045 * float(adjusted)
		roll.set_meta("r5_edge_reading_static", true)
		adjusted += 1
	camp.set_meta("r5_edge_reading_applied", true)
	camp.set_meta("r5_edge_reading_adjusted", adjusted)
	camp.set_meta("r5_edge_reading_dynamic_lights", 0)
	print("[ORIGEM_R5_EDGE] rolos_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
