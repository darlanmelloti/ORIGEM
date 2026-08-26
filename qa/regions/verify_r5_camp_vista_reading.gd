extends SceneTree
func _init() -> void: call_deferred("_verify")
func _verify() -> void:
	var script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = script.new() as Node3D
	root.add_child(region)
	await process_frame; await process_frame
	var camp := region.get_node_or_null("AcampamentoMajestic") as Node3D
	var count := 0
	var valid := camp != null and bool(camp.get_meta("r5_vista_reading_applied", false)) and int(camp.get_meta("r5_vista_reading_dynamic_lights", -1)) == 0
	if camp != null:
		for node: Node in camp.get_children():
			if node is MeshInstance3D and bool(node.get_meta("r5_vista_reading_static", false)) and String(node.name).begins_with("CosturaDaTenda_"):
				count += 1
	if valid and count == 2:
		print("[ORIGEM_R5_VISTA_OK] duas costuras existentes ajustadas, zero luzes."); quit(); return
	printerr("[ORIGEM_R5_VISTA_ERROR] costuras=%d" % count); quit(1)
