extends SceneTree

func _init() -> void:
	call_deferred("_inspect")

func _inspect() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var lake: Node = region.get_node_or_null("RuinasSubmersasDoLago")
	if lake == null:
		printerr("[ORIGEM_R6_LIGHT_AUDIT_ERROR] Ruínas Submersas não foram instanciadas.")
		quit(1)
		return
	var lake_omni_count: int = lake.find_children("*", "OmniLight3D", true, false).size()
	var lake_spot_count: int = lake.find_children("*", "SpotLight3D", true, false).size()
	var world_fill: OmniLight3D = region.get_node_or_null("PreenchimentoMundialDoLago") as OmniLight3D
	var opposite_fill: OmniLight3D = region.get_node_or_null("PreenchimentoOpostoDoLago") as OmniLight3D
	var world_count: int = int(world_fill != null) + int(opposite_fill != null)
	var r6_total: int = world_count + lake_omni_count + lake_spot_count
	print("[ORIGEM_R6_LIGHT_AUDIT] world=%d lake_omni=%d lake_spot=%d r6_total=%d" % [world_count, lake_omni_count, lake_spot_count, r6_total])
	if r6_total != 4:
		printerr("[ORIGEM_R6_LIGHT_AUDIT_ERROR] orçamento R6 esperado=4 obtido=%d" % r6_total)
		quit(1)
		return
	quit()
