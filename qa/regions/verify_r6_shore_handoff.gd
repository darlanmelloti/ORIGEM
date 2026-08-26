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
	var handoff: Node = region.get_node_or_null("HandoffR6ParaVilaElevada")
	if handoff == null:
		issues.append("o handoff R6→R7 não foi instanciado")
	else:
		var route: Node = handoff.get_node_or_null("ContinuacaoFisicaDaMargemR6")
		if route == null:
			issues.append("a continuação física de lajes está ausente")
		else:
			for index: int in range(4):
				var suffix: String = "%02d" % (index + 1)
				if route.get_node_or_null("LajeHandoffR6_%s" % suffix) == null:
					issues.append("laje física ausente: %s" % suffix)
				if route.get_node_or_null("ColisorLajeHandoffR6_%s" % suffix) == null:
					issues.append("colisor de laje ausente: %s" % suffix)
		for marker_name: String in PackedStringArray(["MarcoR6R7Ocidental", "MarcoR6R7Oriental"]):
			var marker: Node3D = handoff.get_node_or_null(marker_name) as Node3D
			if marker == null:
				issues.append("marco arqueológico ausente: %s" % marker_name)
			elif marker.global_position.x < 60.0 or marker.global_position.x > 140.0 or marker.global_position.z < 252.0 or marker.global_position.z > 320.0:
				issues.append("marco fora da fronteira R6: %s" % marker_name)
		if not handoff.find_children("*", "Light3D", true, false).is_empty():
			issues.append("o handoff R6 não pode adicionar Light3D")
	if issues.is_empty():
		print("[ORIGEM_R6_HANDOFF_OK] lajes físicas, marcos R6 e passagem visual para R7 aprovados.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_HANDOFF_ERROR] %s" % issue)
	quit(1)
