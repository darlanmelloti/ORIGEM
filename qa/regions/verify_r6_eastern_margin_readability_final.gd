extends SceneTree
const POSITIONS: Array[Vector2] = [Vector2(104.6,234.2), Vector2(110.7,246.6), Vector2(107.1,259.8)]
func _init() -> void: call_deferred("_verify")
func _verify() -> void:
	var script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = script.new() as Node3D
	root.add_child(region)
	await process_frame; await process_frame
	var waterline := region.get_node_or_null("R6LeituraArqueologicaDaLinhaDeAgua") as Node3D
	var count := 0
	var valid := waterline != null and bool(waterline.get_meta("r6_eastern_margin_readability_final_applied", false)) and int(waterline.get_meta("r6_eastern_margin_readability_final_dynamic_lights", -1)) == 0
	if waterline != null:
		var cluster := waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
		if cluster != null:
			for index in range(POSITIONS.size()):
				var relic := cluster.get_node_or_null("VestigioLinhaAgua_03_%02d" % (index + 1)) as Node3D
				if relic != null and bool(relic.get_meta("r6_eastern_margin_readability_final_static", false)) and bool(relic.get_meta("r6_eastern_margin_closure_static", false)) and is_equal_approx(relic.position.x, POSITIONS[index].x) and is_equal_approx(relic.position.z, POSITIONS[index].y): count += 1
	if valid and count == 3:
		print("[ORIGEM_R6_EASTERN_READABILITY_FINAL_OK] três vestígios existentes ajustados, bases preservadas e zero luzes."); quit(); return
	printerr("[ORIGEM_R6_EASTERN_READABILITY_FINAL_ERROR] vestigios=%d" % count); quit(1)
