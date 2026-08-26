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
	var margin: Node3D = region.get_node_or_null("MargensRochosasDoLago") as Node3D
	if margin == null:
		issues.append("margem rochosa R6 ausente")
	else:
		if not bool(margin.get_meta("r6_outer_waterline_silhouette_applied", false)):
			issues.append("silhueta exterior da linha de água não foi aplicada")
		if int(margin.get_meta("r6_outer_waterline_silhouette_dynamic_lights", -1)) != 0:
			issues.append("silhueta exterior R6 não pode criar luzes")
		var adjusted: int = 0
		for child: Node in margin.get_children():
			if not child is Node3D or not String(child.name).begins_with("AcentoRochosoMargem_"):
				continue
			var rock: Node3D = child as Node3D
			if bool(rock.get_meta("r6_outer_waterline_silhouette_static", false)):
				adjusted += 1
		if adjusted != 5:
			issues.append("a silhueta exterior deve ajustar os cinco acentos existentes; encontrou %d" % adjusted)
	var r6_light_names: PackedStringArray = PackedStringArray([
		"PreenchimentoMundialDoLago",
		"PreenchimentoOpostoDoLago",
		"PreenchimentoAzulDaMargem",
		"LuzSubaquaticaCentral"
	])
	var r6_lights: int = 0
	for light_name: String in r6_light_names:
		var light: Light3D = region.find_child(light_name, true, false) as Light3D
		if light == null:
			issues.append("luz R6 esperada ausente: %s" % light_name)
		else:
			r6_lights += 1
	if r6_lights != 4:
		issues.append("o orçamento R6 deve permanecer em quatro luzes")
	if issues.is_empty():
		print("[ORIGEM_R6_OUTER_WATERLINE_OK] cinco acentos existentes ajustados, quatro luzes e nenhuma geometria ou física nova.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_OUTER_WATERLINE_ERROR] %s" % issue)
	quit(1)
