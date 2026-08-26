extends SceneTree

const LAYER_SCRIPT: Script = preload("res://levels/regions/r3/ArchMarginSilence.gd")

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
	var layer: Node = arch.get_node_or_null("R3SilencioDeMargem") if arch != null else null
	if layer == null:
		issues.append("camada de silêncio de margem ausente")
	else:
		for key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
			if bool((layer.call("get_contract") as Dictionary).get(key, true)):
				issues.append("recurso proibido: %s" % key)
	var marked: Array[Node] = arch.find_children("*", "MeshInstance3D", true, false).filter(func(node: Node) -> bool: return node.has_meta("r3_margin_silence")) if arch != null else []
	if marked.is_empty():
		issues.append("nenhuma pátina lateral recebeu silêncio de margem")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_MARGIN_SILENCE_OK] pátina lateral discreta sem recursos adicionais")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_MARGIN_SILENCE_ERROR] %s" % issue)
	quit(1)
