extends SceneTree
const MIN_PATH_CLEARANCE: float = 8.0
func _init() -> void: call_deferred("_verify")
func _verify() -> void:
	var script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var forest: Node3D = region.get_node_or_null("FlorestaDensaRegional") as Node3D
	var count := 0
	var valid := forest != null and bool(forest.get_meta("r4_outer_lateral_balance_applied", false)) and int(forest.get_meta("r4_outer_lateral_balance_dynamic_lights", -1)) == 0
	if forest != null:
		for node: Node in forest.get_children():
			if node is Node3D and bool(node.get_meta("r4_outer_lateral_balance_static", false)):
				var tree := node as Node3D
				valid = valid and bool(tree.get_meta("r4_outer_rhythm_static", false)) and not bool(tree.get_meta("r4_outer_depth_static", false)) and abs(tree.position.x - float(region.call("_path_x", tree.position.z))) >= MIN_PATH_CLEARANCE
				count += 1
	if valid and count == 2:
		print("[ORIGEM_R4_OUTER_LATERAL_OK] duas árvores existentes equilibradas, corredor >= 8m e zero luzes."); quit(); return
	printerr("[ORIGEM_R4_OUTER_LATERAL_ERROR] árvores=%d" % count); quit(1)
