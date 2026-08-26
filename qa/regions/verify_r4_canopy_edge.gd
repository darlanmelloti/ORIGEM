extends SceneTree

const BAND_START_Z: float = 190.0
const BAND_END_Z: float = 202.0
const MIN_PATH_CLEARANCE: float = 7.0

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var issues: PackedStringArray = PackedStringArray()
	var edge: Node3D = region.get_node_or_null("R4CadenciaDaBordaDasCopas") as Node3D
	if edge == null:
		issues.append("a camada de cadência de copas R4 não foi instanciada")
	else:
		if int(edge.get_meta("r4_canopy_edge_dynamic_lights", -1)) != 0:
			issues.append("a cadência de copas R4 não pode criar luzes")
		if not edge.find_children("*", "Light3D", true, false).is_empty():
			issues.append("a cadência de copas R4 contém Light3D proibida")
		if not edge.find_children("*", "StaticBody3D", true, false).is_empty():
			issues.append("a cadência de copas R4 contém colisão proibida")
		if int(edge.get_meta("r4_canopy_edge_adjusted", 0)) < 1:
			issues.append("nenhuma copa existente foi ajustada na borda R4")
	var canopy_root: Node = region.get_node_or_null("CopasFocaisDaFlorestaDensa")
	if canopy_root == null:
		issues.append("as copas focais R4 estão ausentes")
	else:
		var adjusted: int = 0
		for child: Node in canopy_root.get_children():
			if not child is Node3D or not String(child.name).begins_with("CopaFocalFlorestal_"):
				continue
			var canopy: Node3D = child as Node3D
			if not bool(canopy.get_meta("r4_canopy_edge_static", false)):
				continue
			adjusted += 1
			var z_value: float = canopy.position.z
			if z_value < BAND_START_Z or z_value > BAND_END_Z:
				issues.append("copa de borda fora da faixa R4: %s" % canopy.name)
			var suffix: String = String(canopy.name).replace("CopaFocalFlorestal_", "")
			if canopy_root.get_node_or_null("ColisorCopaFocalFlorestal_%s" % suffix) != null:
				issues.append("copa com colisor foi ajustada: %s" % canopy.name)
			var clearance: float = abs(canopy.position.x - float(region.call("_path_x", z_value)))
			if clearance < MIN_PATH_CLEARANCE:
				issues.append("copa demasiado próxima do trilho R4: %s" % canopy.name)
		if adjusted < 1:
			issues.append("a prova não encontrou copas R4 marcadas como borda")
	if issues.is_empty():
		print("[ORIGEM_R4_CANOPY_EDGE_OK] copas existentes na borda, colisores protegidos, corredor >= %.2fm e zero luzes." % MIN_PATH_CLEARANCE)
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R4_CANOPY_EDGE_ERROR] %s" % issue)
	quit(1)
