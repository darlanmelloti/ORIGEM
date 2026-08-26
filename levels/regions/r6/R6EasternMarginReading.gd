## R6EasternMarginReading.gd
## DEV6-R6-EASTERN-MARGIN-READING-007
## Ajuste estático apenas nos vestígios arqueológicos já existentes da margem oriental.

class_name R6EasternMarginReading
extends RefCounted

const CLUSTER_NAME: String = "ConjuntoDaMargemOriental"
const PIECE_PREFIX: String = "VestigioLinhaAgua_03_"
const EXPECTED_PIECES: int = 3
const R6_MIN_X: float = 0.0
const R6_MAX_X: float = 120.0
const R6_MIN_Z: float = 212.0
const R6_MAX_Z: float = 292.0

static func apply(waterline_reading: Node3D) -> int:
	if waterline_reading == null:
		return 0
	if bool(waterline_reading.get_meta("r6_eastern_margin_reading_applied", false)):
		return int(waterline_reading.get_meta("r6_eastern_margin_reading_adjusted", 0))
	var cluster: Node3D = waterline_reading.get_node_or_null(CLUSTER_NAME) as Node3D
	if cluster == null:
		return 0
	var adjusted: int = 0
	for child: Node in cluster.get_children():
		if not child is Node3D or not String(child.name).begins_with(PIECE_PREFIX):
			continue
		var relic: Node3D = child as Node3D
		var suffix: String = String(relic.name).trim_prefix(PIECE_PREFIX)
		var index: int = int(suffix)
		# Só orientação e escala local: preserva base, leito navegável, cascata, lajes e handoff R6→R7.
		relic.scale = Vector3(
			relic.scale.x * (1.015 + 0.012 * float(index)),
			relic.scale.y * (0.992 + 0.009 * float(index)),
			relic.scale.z * (0.985 + 0.013 * float(index))
		)
		relic.rotation.y += -0.055 + 0.048 * float(index)
		relic.set_meta("r6_eastern_margin_reading_static", true)
		adjusted += 1
	waterline_reading.set_meta("r6_eastern_margin_reading_applied", true)
	waterline_reading.set_meta("r6_eastern_margin_reading_adjusted", adjusted)
	waterline_reading.set_meta("r6_eastern_margin_reading_dynamic_lights", 0)
	print("[ORIGEM_R6_EASTERN_MARGIN] vestigios_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted

static func is_within_r6_bounds(position_3d: Vector3) -> bool:
	return position_3d.x >= R6_MIN_X and position_3d.x <= R6_MAX_X and position_3d.z >= R6_MIN_Z and position_3d.z <= R6_MAX_Z
