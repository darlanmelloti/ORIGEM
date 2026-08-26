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
	var reading: Node3D = region.get_node_or_null("R6LeituraArqueologicaDaLinhaDeAgua") as Node3D
	if reading == null:
		issues.append("a leitura arqueológica modular R6 não foi instanciada")
	else:
		if int(reading.get_meta("r6_waterline_sets", -1)) != 3:
			issues.append("a leitura R6 deve possuir exactamente três conjuntos")
		if int(reading.get_meta("r6_waterline_pieces", -1)) != 9:
			issues.append("a leitura R6 deve possuir exactamente nove vestígios")
		if int(reading.get_meta("r6_waterline_dynamic_lights", -1)) != 0:
			issues.append("a leitura R6 não pode criar luz dinâmica")
		if not reading.find_children("*", "Light3D", true, false).is_empty():
			issues.append("a leitura R6 contém Light3D proibida")
		if not reading.find_children("*", "StaticBody3D", true, false).is_empty():
			issues.append("a leitura R6 não pode adicionar colisores no leito ou trilho")
		for cluster: Node in reading.get_children():
			if not cluster is Node3D:
				continue
			if cluster.get_child_count() != 3:
				issues.append("conjunto R6 deve conter três vestígios: %s" % cluster.name)
			for piece: Node in cluster.get_children():
				if not piece is Node3D:
					issues.append("vestígio R6 inválido: %s" % piece.name)
					continue
				var position_3d: Vector3 = (piece as Node3D).global_position
				if position_3d.x < 0.0 or position_3d.x > 120.0 or position_3d.z < 212.0 or position_3d.z > 292.0:
					issues.append("vestígio fora da margem R6: %s" % piece.name)
	if issues.is_empty():
		print("[ORIGEM_R6_WATERLINE_OK] três conjuntos assimétricos, nove vestígios e zero luzes ou colisores aprovados.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_WATERLINE_ERROR] %s" % issue)
	quit(1)
