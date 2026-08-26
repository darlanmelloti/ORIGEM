extends SceneTree

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_SILENT_VFX_ERROR] Não foi possível carregar o mundo principal.")
		quit(1)
		return
	await process_frame
	await create_timer(2.2).timeout
	var issues: PackedStringArray = PackedStringArray()
	var world: Node = current_scene
	var arch: Node3D = world.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D if world != null else null
	if arch == null:
		issues.append("o Arco físico R3 não foi encontrado")
	else:
		var awakening: Node = arch.get_node_or_null("R3ArchAwakening")
		if awakening == null or not awakening.has_method("get_silent_cadence_contract") or not awakening.has_method("awake_once"):
			issues.append("o controlador de cadência silenciosa R3 está em falta")
		else:
			var contract: Dictionary = awakening.call("get_silent_cadence_contract") as Dictionary
			if not is_equal_approx(float(contract.get("duration_seconds", 0.0)), 1.35):
				issues.append("a cadência silenciosa R3 não preserva a duração de 1,35 s")
			if int(contract.get("beats", 0)) != 3:
				issues.append("a cadência silenciosa R3 não possui três pulsos")
			if not is_equal_approx(float(contract.get("scale_delta", 0.0)), 0.12):
				issues.append("a amplitude da cadência R3 divergiu do limite discreto")
			if bool(contract.get("adds_lights", true)) or bool(contract.get("adds_emitters", true)) or bool(contract.get("adds_audio", true)):
				issues.append("a cadência R3 declarou dependência proibida de luz, emissor ou áudio")
			var arch_lights: Array[Node] = arch.find_children("*", "OmniLight3D", true, false)
			if arch_lights.size() != 2:
				issues.append("a cadência R3 alterou o orçamento das duas luzes locais")
			if not arch.find_children("*", "AudioStreamPlayer", true, false).is_empty():
				issues.append("a cadência R3 introduziu áudio")
			if not arch.find_children("*", "GPUParticles3D", true, false).is_empty():
				issues.append("a cadência R3 introduziu partículas densas")
			if not bool(awakening.call("awake_once")):
				issues.append("a prova não conseguiu iniciar o despertar único")
			await create_timer(0.24).timeout
			var effects: Node3D = arch.get_node_or_null("R3ArchAwakening/EfeitosDoDespertar") as Node3D
			if effects == null or effects.scale.x < 1.075:
				issues.append("o primeiro pulso silencioso não atingiu a leitura mínima")
			await create_timer(1.25).timeout
			if effects != null and effects.scale.x > 1.040:
				issues.append("a cadência R3 não regressou a uma pulsação residual discreta")
	if issues.is_empty():
		print("[ORIGEM_R3_SILENT_VFX_OK] Cadência silenciosa de três pulsos, sem áudio, emissores ou luz adicional, aprovada.")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_SILENT_VFX_ERROR] %s" % issue)
	quit(1)
