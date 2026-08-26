## R6EasternMarginVista.gd
## DEV6-R6-EASTERN-MARGIN-VISTA-010
## Variação estática em vestígios orientais existentes, sem deslocar a base cartográfica.

class_name R6EasternMarginVista
extends RefCounted

static func apply(waterline: Node3D) -> int:
	if waterline == null:
		return 0
	if bool(waterline.get_meta("r6_eastern_margin_vista_applied", false)):
		return int(waterline.get_meta("r6_eastern_margin_vista_adjusted", 0))
	var cluster: Node3D = waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
	if cluster == null:
		return 0
	var adjusted := 0
	for child: Node in cluster.get_children():
		if not child is Node3D or not bool(child.get_meta("r6_eastern_margin_lateral_static", false)):
			continue
		var relic := child as Node3D
		relic.scale = Vector3(relic.scale.x, relic.scale.y * (1.006 - 0.003 * float(adjusted)), relic.scale.z * (0.995 + 0.008 * float(adjusted)))
		relic.rotation.y += -0.018 + 0.018 * float(adjusted)
		relic.set_meta("r6_eastern_margin_vista_static", true)
		adjusted += 1
	waterline.set_meta("r6_eastern_margin_vista_applied", true)
	waterline.set_meta("r6_eastern_margin_vista_adjusted", adjusted)
	waterline.set_meta("r6_eastern_margin_vista_dynamic_lights", 0)
	print("[ORIGEM_R6_EASTERN_VISTA] vestigios_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
