extends SceneTree
func _init() -> void: call_deferred("_verify")
func _verify() -> void:
	var script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = script.new() as Node3D
	root.add_child(region)
	await process_frame; await process_frame
	var camp := region.get_node_or_null("AcampamentoMajestic") as Node3D
	var count := 0
	var valid := camp != null and bool(camp.get_meta("r5_readability_final_applied", false)) and int(camp.get_meta("r5_readability_final_dynamic_lights", -1)) == 0
	if camp != null:
		for node: Node in camp.get_children():
			if node is MeshInstance3D and bool(node.get_meta("r5_readability_final_static", false)) and bool(node.get_meta("r5_closure_static", false)):
				var suffix := String(node.name).trim_prefix("CaixaDeCampo_")
				var collider: StaticBody3D = camp.get_node_or_null("ColisorCaixaDeCampo_" + suffix) as StaticBody3D
				valid = valid and collider != null and collider.get_child_count() > 0 and collider.get_child(0) is CollisionShape3D
				count += 1
	if valid and count == 2:
		print("[ORIGEM_R5_READABILITY_FINAL_OK] duas caixas existentes ajustadas, colisores preservados e zero luzes."); quit(); return
	printerr("[ORIGEM_R5_READABILITY_FINAL_ERROR] caixas=%d" % count); quit(1)
