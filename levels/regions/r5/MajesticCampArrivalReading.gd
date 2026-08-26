## MajesticCampArrivalReading.gd
## DEV5-R5-CAMP-ARRIVAL-READING-004
## Ajuste estático apenas nas bases existentes dos mastros de chegada ao Acampamento Majestic.

class_name R5MajesticCampArrivalReading
extends RefCounted

const ARRIVAL_MARKERS_NAME: String = "SilhuetasDeChegadaMajestic"
const BASE_PREFIX: String = "BaseMastroMajestic_"
const EXPECTED_BASES: int = 2

static func apply(camp: Node3D) -> int:
	if camp == null:
		return 0
	if bool(camp.get_meta("r5_arrival_reading_applied", false)):
		return int(camp.get_meta("r5_arrival_reading_adjusted", 0))
	var arrival_markers: Node3D = camp.get_node_or_null(ARRIVAL_MARKERS_NAME) as Node3D
	if arrival_markers == null:
		return 0
	var adjusted: int = 0
	for child: Node in arrival_markers.get_children():
		if not child is Node3D or not String(child.name).begins_with(BASE_PREFIX):
			continue
		var base_rock: Node3D = child as Node3D
		var suffix: String = String(base_rock.name).trim_prefix(BASE_PREFIX)
		var index: int = int(suffix)
		# Só escala e orientação locais: a base espacial, os mastros, lonas, trilho e conector permanecem intactos.
		base_rock.scale = Vector3(
			base_rock.scale.x * (1.025 + 0.015 * float(index)),
			base_rock.scale.y * (0.985 + 0.012 * float(index)),
			base_rock.scale.z * (1.012 + 0.010 * float(index))
		)
		base_rock.rotation.y += -0.045 + 0.062 * float(index)
		base_rock.set_meta("r5_arrival_reading_static", true)
		adjusted += 1
	camp.set_meta("r5_arrival_reading_applied", true)
	camp.set_meta("r5_arrival_reading_adjusted", adjusted)
	camp.set_meta("r5_arrival_reading_dynamic_lights", 0)
	print("[ORIGEM_R5_ARRIVAL_READING] bases_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
