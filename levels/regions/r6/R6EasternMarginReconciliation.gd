## R6EasternMarginReconciliation.gd
## DEV6-R6-EASTERN-MARGIN-RECONCILIATION-018
## Reconciliação estática em vestígios existentes, sem deslocar bases cartográficas.

class_name R6EasternMarginReconciliation
extends RefCounted

static func apply(waterline: Node3D) -> int:
	if waterline == null:
		return 0
	if bool(waterline.get_meta("r6_eastern_margin_reconciliation_applied", false)):
		return int(waterline.get_meta("r6_eastern_margin_reconciliation_adjusted", 0))
	var cluster: Node3D = waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
	if cluster == null:
		return 0
	var adjusted := 0
	for child: Node in cluster.get_children():
		if not child is Node3D or not bool(child.get_meta("r6_eastern_margin_stabilization_static", false)):
			continue
		var relic := child as Node3D
		relic.scale = Vector3(relic.scale.x * (1.0002 - 0.0002 * float(adjusted)), relic.scale.y, relic.scale.z * (0.9998 + 0.0004 * float(adjusted)))
		relic.rotation.y += -0.001 + 0.001 * float(adjusted)
		relic.set_meta("r6_eastern_margin_reconciliation_static", true)
		adjusted += 1
	waterline.set_meta("r6_eastern_margin_reconciliation_applied", true)
	waterline.set_meta("r6_eastern_margin_reconciliation_adjusted", adjusted)
	waterline.set_meta("r6_eastern_margin_reconciliation_dynamic_lights", 0)
	print("[ORIGEM_R6_EASTERN_RECONCILIATION] vestigios_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
