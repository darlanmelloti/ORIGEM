## R6EasternMarginCheck.gd
## DEV6-R6-EASTERN-MARGIN-CHECK-020
## Verificação estática em vestígios existentes, sem deslocar bases cartográficas.

class_name R6EasternMarginCheck
extends RefCounted

static func apply(waterline: Node3D) -> int:
	if waterline == null:
		return 0
	if bool(waterline.get_meta("r6_eastern_margin_check_applied", false)):
		return int(waterline.get_meta("r6_eastern_margin_check_adjusted", 0))
	var cluster: Node3D = waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
	if cluster == null:
		return 0
	var adjusted := 0
	for child: Node in cluster.get_children():
		if not child is Node3D or not bool(child.get_meta("r6_eastern_margin_consistency_static", false)):
			continue
		var relic := child as Node3D
		relic.scale = Vector3(relic.scale.x * (1.0001 - 0.0001 * float(adjusted)), relic.scale.y, relic.scale.z * (0.9999 + 0.0002 * float(adjusted)))
		relic.rotation.y += -0.0004 + 0.0004 * float(adjusted)
		relic.set_meta("r6_eastern_margin_check_static", true)
		adjusted += 1
	waterline.set_meta("r6_eastern_margin_check_applied", true)
	waterline.set_meta("r6_eastern_margin_check_adjusted", adjusted)
	waterline.set_meta("r6_eastern_margin_check_dynamic_lights", 0)
	print("[ORIGEM_R6_EASTERN_CHECK] vestigios_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
