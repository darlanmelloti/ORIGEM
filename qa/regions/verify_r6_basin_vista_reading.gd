extends SceneTree

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var issues: PackedStringArray = PackedStringArray()
	var silhouette: Node3D = region.get_node_or_null("SilhuetaCartograficaDaBacia") as Node3D
	if silhouette == null:
		issues.append("silhueta cartográfica da bacia ausente")
	else:
		if not bool(silhouette.get_meta("r6_basin_vista_applied", false)):
			issues.append("leitura estática da bacia não foi aplicada")
		if int(silhouette.get_meta("r6_basin_vista_dynamic_lights", -1)) != 0:
			issues.append("leitura da bacia não pode criar luzes")
		if not silhouette.find_children("*", "Light3D", true, false).is_empty():
			issues.append("silhueta contém Light3D inesperada")
		var adjusted: int = 0
		for child: Node in silhouette.get_children():
			if not child is Node3D or not String(child.name).begins_with("PromontorioOrientalDaBacia_"):
				continue
			var rock: Node3D = child as Node3D
			if bool(rock.get_meta("r6_basin_vista_static", false)):
				adjusted += 1
		if adjusted != 3:
			issues.append("a leitura deve ajustar as três rochas existentes do promontório; encontrou %d" % adjusted)
	if issues.is_empty():
		print("[ORIGEM_R6_BASIN_VISTA_OK] três rochas existentes ajustadas, sem luzes, água, colisores ou geometria nova.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_BASIN_VISTA_ERROR] %s" % issue)
	quit(1)
