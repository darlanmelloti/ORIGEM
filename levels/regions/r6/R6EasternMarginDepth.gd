## R6EasternMarginDepth.gd
## DEV6-R6-EASTERN-MARGIN-DEPTH-008
## Profundidade estática apenas nos vestígios orientais já aprovados.

class_name R6EasternMarginDepth
extends RefCounted

const CLUSTER_NAME: String = "ConjuntoDaMargemOriental"
const PIECE_PREFIX: String = "VestigioLinhaAgua_03_"
const TARGET_COUNT: int = 3

static func apply(waterline_reading: Node3D) -> int:
	if waterline_reading == null:
		return 0
	if bool(waterline_reading.get_meta("r6_eastern_margin_depth_applied", false)):
		return int(waterline_reading.get_meta("r6_eastern_margin_depth_adjusted", 0))
	var cluster: Node3D = waterline_reading.get_node_or_null(CLUSTER_NAME) as Node3D
	if cluster == null:
		return 0
	var adjusted: int = 0
	for child: Node in cluster.get_children():
		if not child is Node3D or not String(child.name).begins_with(PIECE_PREFIX):
			continue
		var relic: Node3D = child as Node3D
		if not bool(relic.get_meta("r6_eastern_margin_reading_static", false)):
			continue
		# Não altera posição: somente escala e orientação local aprofundam a leitura da margem já existente.
		var factor: float = 0.992 + 0.017 * float(adjusted)
		relic.scale = Vector3(relic.scale.x * factor, relic.scale.y * (1.014 - 0.006 * float(adjusted)), relic.scale.z * factor)
		relic.rotation.y += -0.036 + 0.040 * float(adjusted)
		relic.set_meta("r6_eastern_margin_depth_static", true)
		adjusted += 1
	waterline_reading.set_meta("r6_eastern_margin_depth_applied", true)
	waterline_reading.set_meta("r6_eastern_margin_depth_adjusted", adjusted)
	waterline_reading.set_meta("r6_eastern_margin_depth_dynamic_lights", 0)
	print("[ORIGEM_R6_EASTERN_DEPTH] vestigios_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
