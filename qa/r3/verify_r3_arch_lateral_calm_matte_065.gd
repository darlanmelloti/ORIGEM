extends SceneTree

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	if change_scene_to_file("res://scenes/main.tscn") != OK:
		quit(1)
		return
	await process_frame
	await create_timer(2.2).timeout
	var arch := current_scene.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D
	var issues: PackedStringArray = []
	var layer: Node = arch.get_node_or_null("R3CalmaMateLateral065") if arch != null else null
	if layer == null:
		issues.append("camada ausente")
	else:
		for key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
			if bool((layer.call("get_contract") as Dictionary).get(key, true)):
				issues.append("recurso proibido: %s" % key)
	var marked: Array[Node] = arch.find_children("*", "MeshInstance3D", true, false).filter(func(n: Node) -> bool: return n.has_meta("r3_lateral_calm_matte_065")) if arch != null else []
	if marked.is_empty():
		issues.append("nenhuma superfície marcada")
	for node: Node in marked:
		var mat := (node as MeshInstance3D).material_override as StandardMaterial3D
		if not node.has_meta("r3_margin_rest_matte_064") or mat == null or mat.roughness < 1.0 or mat.metallic != 0.0 or mat.emission_enabled:
			issues.append("herança ou material inválido")
			break
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_LATERAL_CALM_MATTE_065_OK] calma lateral preservada sem recursos adicionais")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_LATERAL_CALM_MATTE_065_ERROR] %s" % issue)
	quit(1)
