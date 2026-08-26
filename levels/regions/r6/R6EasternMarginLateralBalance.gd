## R6EasternMarginLateralBalance.gd
## DEV6-R6-EASTERN-MARGIN-LATERAL-BALANCE-009
## Equilíbrio estático apenas nos vestígios orientais já aprovados.

class_name R6EasternMarginLateralBalance
extends RefCounted

static func apply(waterline: Node3D) -> int:
	if waterline == null:
		return 0
	if bool(waterline.get_meta("r6_eastern_margin_lateral_applied", false)):
		return int(waterline.get_meta("r6_eastern_margin_lateral_adjusted", 0))
	var cluster: Node3D = waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
	if cluster == null:
		return 0
	var adjusted := 0
	for child: Node in cluster.get_children():
		if not child is Node3D or not bool(child.get_meta("r6_eastern_margin_depth_static", false)):
			continue
		var relic := child as Node3D
		relic.scale = Vector3(relic.scale.x * (1.0 + 0.012 * float(adjusted)), relic.scale.y, relic.scale.z * (0.994 + 0.010 * float(adjusted)))
		relic.rotation.y += -0.025 + 0.030 * float(adjusted)
		relic.set_meta("r6_eastern_margin_lateral_static", true)
		adjusted += 1
	waterline.set_meta("r6_eastern_margin_lateral_applied", true)
	waterline.set_meta("r6_eastern_margin_lateral_adjusted", adjusted)
	waterline.set_meta("r6_eastern_margin_lateral_dynamic_lights", 0)
	print("[ORIGEM_R6_EASTERN_LATERAL] vestigios_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
