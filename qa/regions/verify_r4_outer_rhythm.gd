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
	var rhythm: Node3D = region.get_node_or_null("R4RitmoExteriorDaFloresta") as Node3D
	if rhythm == null:
		issues.append("camada de ritmo exterior R4 ausente")
	else:
		if int(rhythm.get_meta("r4_outer_rhythm_dynamic_lights", -1)) != 0:
			issues.append("ritmo exterior R4 não pode criar luzes")
		if not rhythm.find_children("*", "Light3D", true, false).is_empty() or not rhythm.find_children("*", "StaticBody3D", true, false).is_empty():
			issues.append("ritmo exterior R4 contém luz ou colisão proibida")
	var forest: Node = region.get_node_or_null("FlorestaDensaRegional")
	if forest == null:
		issues.append("floresta R4 ausente")
	else:
		var adjusted: int = 0
		for child: Node in forest.get_children():
			if not child is Node3D or not String(child.name).begins_with("ArvoreDaFloresta_"):
				continue
			var tree: Node3D = child as Node3D
			if not bool(tree.get_meta("r4_outer_rhythm_static", false)):
				continue
			adjusted += 1
			if tree.position.z < BAND_START_Z or tree.position.z > BAND_END_Z:
				issues.append("árvore exterior fora da faixa R4: %s" % tree.name)
			var tree_id: String = String(tree.name).trim_prefix("ArvoreDaFloresta_")
			if forest.get_node_or_null("ColisorTroncoFloresta_%s" % tree_id) != null:
				issues.append("árvore com colisor foi ajustada: %s" % tree.name)
			if abs(tree.position.x - float(region.call("_path_x", tree.position.z))) < MIN_PATH_CLEARANCE:
				issues.append("árvore exterior demasiado próxima do trilho: %s" % tree.name)
		if adjusted < 1:
			issues.append("nenhuma árvore R4 foi marcada para ritmo exterior")
	if issues.is_empty():
		print("[ORIGEM_R4_OUTER_RHYTHM_OK] árvores existentes em ritmo exterior, corredor >= %.2fm e zero luzes." % MIN_PATH_CLEARANCE)
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R4_OUTER_RHYTHM_ERROR] %s" % issue)
	quit(1)
