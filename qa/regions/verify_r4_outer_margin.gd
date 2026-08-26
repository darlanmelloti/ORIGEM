extends SceneTree

const BAND_START_Z: float = 182.0
const BAND_END_Z: float = 190.0
const MIN_PATH_CLEARANCE: float = 8.75

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var issues: PackedStringArray = PackedStringArray()
	var margin: Node3D = region.get_node_or_null("R4MargemExteriorDaFloresta") as Node3D
	if margin == null:
		issues.append("a camada de margem exterior R4 não foi instanciada")
	else:
		if int(margin.get_meta("r4_outer_margin_dynamic_lights", -1)) != 0:
			issues.append("a margem exterior R4 não pode criar luzes")
		if not margin.find_children("*", "Light3D", true, false).is_empty():
			issues.append("a margem exterior R4 contém Light3D proibida")
		if not margin.find_children("*", "StaticBody3D", true, false).is_empty():
			issues.append("a margem exterior R4 contém colisão proibida")
		if int(margin.get_meta("r4_outer_margin_adjusted", 0)) < 1:
			issues.append("nenhuma raiz existente foi ajustada na margem exterior R4")
	var details: Node = region.get_node_or_null("RaizesPedrasESinaisP0")
	if details == null:
		issues.append("os detalhes ambientais R4 estão ausentes")
	else:
		var adjusted: int = 0
		for child: Node in details.get_children():
			if not child is MeshInstance3D or not String(child.name).begins_with("RaizExpostaFlorestal_"):
				continue
			var root_mesh: MeshInstance3D = child as MeshInstance3D
			if not bool(root_mesh.get_meta("r4_outer_margin_static", false)):
				continue
			adjusted += 1
			var z_value: float = root_mesh.position.z
			if z_value < BAND_START_Z or z_value > BAND_END_Z:
				issues.append("raiz da margem exterior fora da faixa R4: %s" % root_mesh.name)
			var clearance: float = abs(root_mesh.position.x - float(region.call("_path_x", z_value)))
			if clearance < MIN_PATH_CLEARANCE:
				issues.append("raiz demasiado próxima do trilho R4: %s" % root_mesh.name)
		if adjusted < 1:
			issues.append("a prova não encontrou raízes R4 marcadas como margem exterior")
	if issues.is_empty():
		print("[ORIGEM_R4_OUTER_MARGIN_OK] margem exterior estática, corredor >= %.2fm, clareira e custo técnico preservados." % MIN_PATH_CLEARANCE)
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R4_OUTER_MARGIN_ERROR] %s" % issue)
	quit(1)
