## MajesticCampVistaReading.gd
## DEV5-R5-CAMP-VISTA-READING-006
## Leitura estática apenas em costuras de tenda R5 já existentes.

class_name R5MajesticCampVistaReading
extends RefCounted

const TARGET_COUNT: int = 2

static func apply(camp: Node3D) -> int:
	if camp == null:
		return 0
	if bool(camp.get_meta("r5_vista_reading_applied", false)):
		return int(camp.get_meta("r5_vista_reading_adjusted", 0))
	var adjusted: int = 0
	for child: Node in camp.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is MeshInstance3D or not String(child.name).begins_with("CosturaDaTenda_"):
			continue
		var seam: MeshInstance3D = child as MeshInstance3D
		seam.scale = Vector3(seam.scale.x * (0.994 + 0.012 * float(adjusted)), seam.scale.y, seam.scale.z * (1.006 - 0.008 * float(adjusted)))
		seam.rotation.y += -0.024 + 0.048 * float(adjusted)
		seam.set_meta("r5_vista_reading_static", true)
		adjusted += 1
	camp.set_meta("r5_vista_reading_applied", true)
	camp.set_meta("r5_vista_reading_adjusted", adjusted)
	camp.set_meta("r5_vista_reading_dynamic_lights", 0)
	print("[ORIGEM_R5_VISTA] costuras_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
