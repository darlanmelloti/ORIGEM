extends SceneTree

const EXPECTED_POSITIONS: Array[Vector2] = [
	Vector2(104.6, 234.2),
	Vector2(110.7, 246.6),
	Vector2(107.1, 259.8)
]
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
		issues.append("leitura da linha de água R6 ausente")
	else:
		if not bool(waterline.get_meta("r6_eastern_margin_reading_applied", false)):
			issues.append("leitura estática da margem oriental não foi aplicada")
		if int(waterline.get_meta("r6_eastern_margin_reading_dynamic_lights", -1)) != 0:
			issues.append("leitura da margem oriental não pode criar luzes")
		if not waterline.find_children("*", "Light3D", true, false).is_empty() or not waterline.find_children("*", "StaticBody3D", true, false).is_empty():
			issues.append("linha de água contém luz ou física incompatível com a leitura estática")
		var eastern_cluster: Node3D = waterline.get_node_or_null("ConjuntoDaMargemOriental") as Node3D
		if eastern_cluster == null:
			issues.append("conjunto de vestígios da margem oriental ausente")
		else:
			var adjusted: int = 0
			for index: int in range(EXPECTED_POSITIONS.size()):
				var relic: Node3D = eastern_cluster.get_node_or_null("VestigioLinhaAgua_03_%02d" % (index + 1)) as Node3D
				if relic == null:
					issues.append("vestígio oriental ausente: %d" % (index + 1))
					continue
				if not bool(relic.get_meta("r6_eastern_margin_reading_static", false)):
					issues.append("vestígio oriental não marcado como estático: %s" % relic.name)
					continue
				adjusted += 1
				var expected: Vector2 = EXPECTED_POSITIONS[index]
				if not is_equal_approx(relic.position.x, expected.x) or not is_equal_approx(relic.position.z, expected.y):
					issues.append("base espacial alterada no vestígio oriental: %s" % relic.name)
				if relic.position.x < 0.0 or relic.position.x > 120.0 or relic.position.z < 212.0 or relic.position.z > 292.0:
					issues.append("vestígio fora dos limites R6: %s" % relic.name)
				if relic.scale.x <= 0.0 or relic.scale.y <= 0.0 or relic.scale.z <= 0.0:
					issues.append("escala inválida no vestígio oriental: %s" % relic.name)
			if adjusted != 3:
				issues.append("a leitura oriental deve ajustar os três vestígios existentes; encontrou %d" % adjusted)
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
		issues.append("o orçamento R6 deve permanecer exatamente em quatro luzes")
	if issues.is_empty():
		print("[ORIGEM_R6_EASTERN_MARGIN_OK] três vestígios existentes ajustados, base espacial preservada, quatro luzes e zero física nova.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_EASTERN_MARGIN_ERROR] %s" % issue)
	quit(1)
