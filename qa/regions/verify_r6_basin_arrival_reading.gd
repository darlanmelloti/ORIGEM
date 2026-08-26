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
	var reading: Node = region.get_node_or_null("R6LeituraDaChegadaDaBacia")
	var frame: Node3D = region.get_node_or_null("LimiarDasRuinasSubmersas") as Node3D
	if reading == null:
		issues.append("a leitura de chegada R6 não foi instanciada")
	else:
		if int(reading.get_meta("r6_basin_arrival_pillars", -1)) != 2:
			issues.append("a leitura R6 deve reutilizar exactamente dois pilares")
		if int(reading.get_meta("r6_basin_arrival_dynamic_lights", -1)) != 0:
			issues.append("a leitura R6 não pode adicionar luz dinâmica")
		if int(reading.get_meta("r6_basin_arrival_added_nodes", -1)) != 0:
			issues.append("a leitura R6 não pode criar geometria adicional")
		if not reading.find_children("*", "Light3D", true, false).is_empty():
			issues.append("a leitura R6 contém Light3D proibida")
		if not reading.find_children("*", "StaticBody3D", true, false).is_empty():
			issues.append("a leitura R6 contém colisão proibida")
	if frame == null:
		issues.append("o limiar físico existente da bacia está ausente")
	else:
		var left: Node3D = frame.get_node_or_null("VestigioDaEntradaDaBacia_00") as Node3D
		var right: Node3D = frame.get_node_or_null("VestigioDaEntradaDaBacia_01") as Node3D
		if left == null or right == null:
			issues.append("os pilares existentes de chegada estão incompletos")
		else:
			if String(left.get_meta("r6_basin_arrival_role", "")) != "abre_vista":
				issues.append("o pilar ocidental não recebeu leitura de abertura")
			if String(right.get_meta("r6_basin_arrival_role", "")) != "conduz_para_bacia":
				issues.append("o pilar oriental não recebeu leitura de condução")
	if issues.is_empty():
		print("[ORIGEM_R6_ARRIVAL_OK] limiar R6 reutilizado com dois pilares, zero luzes, colisores e geometria adicional.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_ARRIVAL_ERROR] %s" % issue)
	quit(1)
