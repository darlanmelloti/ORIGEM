## R6EasternMarginRhythmFinal.gd
## DEV6-R6-EASTERN-MARGIN-RHYTHM-FINAL-011
## Cadência final estática em vestígios existentes, sem deslocar a base cartográfica.

class_name R6EasternMarginRhythmFinal
extends RefCounted

static func apply(waterline: Node3D) -> int:
	if waterline == null:
		return 0
	if bool(waterline.get_meta("r6_eastern_margin_rhythm_final_applied", false)):
		return int(waterline.get_meta("r6_eastern_margin_rhythm_final_adjusted", 0))
	var cluster: Node3D = waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
	if cluster == null:
		return 0
	var adjusted := 0
	for child: Node in cluster.get_children():
		if not child is Node3D or not bool(child.get_meta("r6_eastern_margin_vista_static", false)):
			continue
		var relic := child as Node3D
		relic.scale = Vector3(relic.scale.x * (1.003 - 0.003 * float(adjusted)), relic.scale.y, relic.scale.z * (0.996 + 0.006 * float(adjusted)))
		relic.rotation.y += -0.012 + 0.012 * float(adjusted)
		relic.set_meta("r6_eastern_margin_rhythm_final_static", true)
		adjusted += 1
	waterline.set_meta("r6_eastern_margin_rhythm_final_applied", true)
	waterline.set_meta("r6_eastern_margin_rhythm_final_adjusted", adjusted)
	waterline.set_meta("r6_eastern_margin_rhythm_final_dynamic_lights", 0)
	print("[ORIGEM_R6_EASTERN_RHYTHM_FINAL] vestigios_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
