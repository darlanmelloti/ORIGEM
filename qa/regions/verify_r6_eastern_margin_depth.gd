extends SceneTree

const EXPECTED_POSITIONS: Array[Vector2] = [Vector2(104.6, 234.2), Vector2(110.7, 246.6), Vector2(107.1, 259.8)]

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var issues: PackedStringArray = PackedStringArray()
	var waterline: Node3D = region.get_node_or_null("R6LeituraArqueologicaDaLinhaDeAgua") as Node3D
	if waterline == null:
		issues.append("leitura R6 da linha de água ausente")
	else:
		if not bool(waterline.get_meta("r6_eastern_margin_depth_applied", false)) or int(waterline.get_meta("r6_eastern_margin_depth_dynamic_lights", -1)) != 0:
			issues.append("profundidade oriental R6 não confirma aplicação estática sem luz")
		var cluster: Node3D = waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
		var adjusted: int = 0
		if cluster == null:
			issues.append("conjunto oriental R6 ausente")
		else:
			for index: int in range(EXPECTED_POSITIONS.size()):
				var relic: Node3D = cluster.get_node_or_null("VestigioLinhaAgua_03_%02d" % (index + 1)) as Node3D
				if relic == null or not bool(relic.get_meta("r6_eastern_margin_depth_static", false)) or not bool(relic.get_meta("r6_eastern_margin_reading_static", false)):
					issues.append("vestígio oriental sem cadeia estática válida: %d" % (index + 1))
					continue
				adjusted += 1
				var expected: Vector2 = EXPECTED_POSITIONS[index]
				if not is_equal_approx(relic.position.x, expected.x) or not is_equal_approx(relic.position.z, expected.y):
					issues.append("base espacial alterada: %s" % relic.name)
			if adjusted != 3:
				issues.append("profundidade oriental deve ajustar três vestígios; encontrou %d" % adjusted)
	var light_names: PackedStringArray = PackedStringArray(["PreenchimentoMundialDoLago", "PreenchimentoOpostoDoLago", "PreenchimentoAzulDaMargem", "LuzSubaquaticaCentral"])
	var lights: int = 0
	for light_name: String in light_names:
		if region.find_child(light_name, true, false) is Light3D:
			lights += 1
	if lights != 4:
		issues.append("orçamento R6 diferente de quatro luzes")
	if issues.is_empty():
		print("[ORIGEM_R6_EASTERN_DEPTH_OK] três vestígios existentes aprofundados, bases preservadas e quatro luzes.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_EASTERN_DEPTH_ERROR] %s" % issue)
	quit(1)
