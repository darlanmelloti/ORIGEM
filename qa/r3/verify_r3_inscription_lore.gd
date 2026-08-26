extends SceneTree

const INSCRIPTION_LORE_SCRIPT: Script = preload("res://levels/regions/r3/ArchInscriptionLore.gd")

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_INSCRIPTION_LORE_ERROR] Não foi possível carregar o mundo principal.")
		quit(1)
		return
	await process_frame
	await create_timer(2.2).timeout
	var issues: PackedStringArray = PackedStringArray()
	var world: Node = current_scene
	var arch: Node3D = world.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D if world != null else null
	if arch == null:
		issues.append("o Arco físico R3 não foi encontrado no mundo integrado")
	else:
		issues.append_array(INSCRIPTION_LORE_SCRIPT.call("validate", arch) as PackedStringArray)
		var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
		var awakening: Node = arch.get_node_or_null("R3ArchAwakening")
		if lore != null and awakening != null and awakening.has_method("awake_once"):
			var awakened_now: bool = bool(awakening.call("awake_once"))
			if not awakened_now:
				issues.append("a prova não conseguiu observar o primeiro despertar R3")
			var labels: Array[Node] = lore.find_children("TextoDaPlaca*", "Label3D", true, false)
			for label_node: Node in labels:
				var label: Label3D = label_node as Label3D
				if label != null and label.modulate.g < 0.55:
					issues.append("a leitura das placas não acompanha discretamente o despertar")
	if issues.is_empty():
		print("[ORIGEM_R3_INSCRIPTION_LORE_OK] Duas placas laterais, memória do rio, aviso da luz e orçamento físico R3 aprovados.")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_INSCRIPTION_LORE_ERROR] %s" % issue)
	quit(1)
