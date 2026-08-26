extends SceneTree

const BAND_START_Z: float = 181.0
const BAND_END_Z: float = 190.0
const MIN_PATH_CLEARANCE: float = 8.0

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var issues: PackedStringArray = PackedStringArray()
	var silhouette: Node3D = region.get_node_or_null("R4SilhuetaExteriorDaFloresta") as Node3D
	if silhouette == null:
		issues.append("a camada R4 de silhueta exterior não foi instanciada")
	else:
		if int(silhouette.get_meta("r4_outer_silhouette_dynamic_lights", -1)) != 0:
			issues.append("a silhueta exterior R4 não pode criar luzes")
		if not silhouette.find_children("*", "Light3D", true, false).is_empty():
			issues.append("a silhueta exterior R4 contém Light3D proibida")
		if not silhouette.find_children("*", "StaticBody3D", true, false).is_empty():
			issues.append("a silhueta exterior R4 contém colisão proibida")
		if int(silhouette.get_meta("r4_outer_silhouette_adjusted", 0)) < 1:
			issues.append("nenhuma árvore R4 foi ajustada na silhueta exterior")
	var forest: Node = region.get_node_or_null("FlorestaDensaRegional")
	if forest == null:
		issues.append("a floresta R4 está ausente")
	else:
		var adjusted: int = 0
		for child: Node in forest.get_children():
			if not child is Node3D or not String(child.name).begins_with("ArvoreDaFloresta_"):
				continue
			var tree: Node3D = child as Node3D
			if not bool(tree.get_meta("r4_outer_silhouette_static", false)):
				continue
			adjusted += 1
			var z_value: float = tree.position.z
			if z_value < BAND_START_Z or z_value > BAND_END_Z:
				issues.append("árvore exterior fora da faixa R4: %s" % tree.name)
			var tree_id: String = String(tree.name).trim_prefix("ArvoreDaFloresta_")
			if forest.get_node_or_null("ColisorTroncoFloresta_%s" % tree_id) != null:
				issues.append("árvore com colisor foi ajustada: %s" % tree.name)
			var clearance: float = abs(tree.position.x - float(region.call("_path_x", z_value)))
			if clearance < MIN_PATH_CLEARANCE:
				issues.append("árvore exterior demasiado próxima do trilho: %s" % tree.name)
		if adjusted < 1:
			issues.append("a prova não encontrou árvores R4 marcadas como silhueta exterior")
	if issues.is_empty():
		print("[ORIGEM_R4_OUTER_SILHOUETTE_OK] árvores existentes sem colisores, corredor >= %.2fm e zero luzes." % MIN_PATH_CLEARANCE)
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R4_OUTER_SILHOUETTE_ERROR] %s" % issue)
	quit(1)
