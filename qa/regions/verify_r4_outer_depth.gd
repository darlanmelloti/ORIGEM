extends SceneTree

const EXPECTED_ADJUSTED: int = 3
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
	var forest: Node3D = region.get_node_or_null("FlorestaDensaRegional") as Node3D
	if forest == null:
		issues.append("floresta R4 ausente")
	else:
		if not bool(forest.get_meta("r4_outer_depth_applied", false)):
			issues.append("profundidade exterior R4 não foi aplicada")
		if int(forest.get_meta("r4_outer_depth_dynamic_lights", -1)) != 0:
			issues.append("profundidade exterior R4 não pode criar luzes")
		var adjusted: int = 0
		for child: Node in forest.get_children():
			if not child is Node3D or not bool(child.get_meta("r4_outer_depth_static", false)):
				continue
			var tree: Node3D = child as Node3D
			adjusted += 1
			if not bool(tree.get_meta("r4_outer_rhythm_static", false)):
				issues.append("profundidade aplicada fora do ritmo exterior: %s" % tree.name)
			var tree_id: String = String(tree.name).trim_prefix("ArvoreDaFloresta_")
			if forest.get_node_or_null("ColisorTroncoFloresta_%s" % tree_id) != null:
				issues.append("árvore com colisor recebeu profundidade exterior: %s" % tree.name)
			if abs(tree.position.x - float(region.call("_path_x", tree.position.z))) < MIN_PATH_CLEARANCE:
				issues.append("árvore exterior aproximada do trilho: %s" % tree.name)
		if adjusted != EXPECTED_ADJUSTED:
			issues.append("profundidade exterior deve ajustar %d árvores; encontrou %d" % [EXPECTED_ADJUSTED, adjusted])
	if issues.is_empty():
		print("[ORIGEM_R4_OUTER_DEPTH_OK] três árvores existentes do ritmo exterior ajustadas, corredor >= %.2fm e zero luzes." % MIN_PATH_CLEARANCE)
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R4_OUTER_DEPTH_ERROR] %s" % issue)
	quit(1)
