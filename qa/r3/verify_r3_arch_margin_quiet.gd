extends SceneTree

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	if change_scene_to_file("res://scenes/main.tscn") != OK:
		quit(1)
		return
	await process_frame
	await create_timer(2.2).timeout
	var arch: Node3D = current_scene.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D
	var issues: PackedStringArray = PackedStringArray()
	var layer: Node = arch.get_node_or_null("R3QuietudeDaMargem") if arch != null else null
	if layer == null:
		issues.append("camada de quietude da margem ausente")
	else:
		var contract: Dictionary = layer.call("get_contract") as Dictionary
		for key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
			if bool(contract.get(key, true)):
				issues.append("recurso proibido: %s" % key)
	var marked: Array[Node] = arch.find_children("*", "MeshInstance3D", true, false).filter(func(node: Node) -> bool: return node.has_meta("r3_margin_quiet")) if arch != null else []
	if marked.is_empty():
		issues.append("nenhuma superfície lateral recebeu quietude da margem")
	for mesh_node: Node in marked:
		if not mesh_node.has_meta("r3_lateral_velvet"):
			issues.append("a quietude da margem não herdou a leitura aveludada")
			break
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_MARGIN_QUIET_OK] quietude da margem preservada sem recursos adicionais")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_MARGIN_QUIET_ERROR] %s" % issue)
	quit(1)
