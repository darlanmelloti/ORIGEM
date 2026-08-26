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
	var layer: Node = arch.get_node_or_null("R3ImobilidadeMateLateral") if arch != null else null
	if layer == null:
		issues.append("camada de imobilidade mate lateral ausente")
	else:
		var contract: Dictionary = layer.call("get_contract") as Dictionary
		for key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
			if bool(contract.get(key, true)):
				issues.append("recurso proibido: %s" % key)
	var marked: Array[Node] = arch.find_children("*", "MeshInstance3D", true, false).filter(func(node: Node) -> bool: return node.has_meta("r3_lateral_still_matte")) if arch != null else []
	if marked.is_empty():
		issues.append("nenhuma superfície recebeu imobilidade mate lateral")
	for mesh_node: Node in marked:
		var mesh := mesh_node as MeshInstance3D
		var material := mesh.material_override as StandardMaterial3D if mesh != null else null
		if not mesh_node.has_meta("r3_margin_calm_matte"):
			issues.append("a imobilidade lateral não herdou a calma da margem")
			break
		if material == null or material.roughness < 1.0 or material.metallic != 0.0 or material.emission_enabled:
			issues.append("o material lateral não preserva imobilidade mate sem emissão")
			break
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_LATERAL_STILL_MATTE_OK] imobilidade lateral preservada sem recursos adicionais")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_LATERAL_STILL_MATTE_ERROR] %s" % issue)
	quit(1)
