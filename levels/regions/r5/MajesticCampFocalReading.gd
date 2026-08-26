## MajesticCampFocalReading.gd
## DEV5-R5-CAMP-FOCAL-READING-007
## Leitura estática somente em caixas visuais existentes, sem tocar nos colisores correspondentes.

class_name R5MajesticCampFocalReading
extends RefCounted

const TARGET_COUNT: int = 2

static func apply(camp: Node3D) -> int:
	if camp == null:
		return 0
	if bool(camp.get_meta("r5_focal_reading_applied", false)):
		return int(camp.get_meta("r5_focal_reading_adjusted", 0))
	var adjusted: int = 0
	for child: Node in camp.get_children():
		if adjusted >= TARGET_COUNT:
			break
		if not child is MeshInstance3D or not String(child.name).begins_with("CaixaDeCampo_"):
			continue
		var supply: MeshInstance3D = child as MeshInstance3D
		supply.scale = Vector3(supply.scale.x * (0.994 + 0.016 * float(adjusted)), supply.scale.y * (1.004 - 0.004 * float(adjusted)), supply.scale.z)
		supply.rotation.y += -0.022 + 0.044 * float(adjusted)
		supply.set_meta("r5_focal_reading_static", true)
		adjusted += 1
	camp.set_meta("r5_focal_reading_applied", true)
	camp.set_meta("r5_focal_reading_adjusted", adjusted)
	camp.set_meta("r5_focal_reading_dynamic_lights", 0)
	print("[ORIGEM_R5_FOCAL] caixas_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
