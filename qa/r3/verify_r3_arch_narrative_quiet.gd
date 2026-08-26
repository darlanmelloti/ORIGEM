extends SceneTree

const MAIN_SCENE: String = "res://scenes/main.tscn"
const ARCH_SCRIPT: Script = preload("res://levels/regions/r3/ArchNarrativeQuiet.gd")
const INSCRIPTION_SCRIPT: Script = preload("res://levels/regions/r3/ArchInscriptionLore.gd")

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file(MAIN_SCENE)
	if change_error != OK:
		_fail("não foi possível carregar o mundo principal")
		return
	await process_frame
	await create_timer(2.2).timeout
	var issues: PackedStringArray = PackedStringArray()
	var world: Node = current_scene
	var arch: Node3D = world.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D if world != null else null
	if arch == null:
		issues.append("o Arco físico R3 não foi encontrado")
	else:
		issues.append_array(ARCH_SCRIPT.call("validate", arch) as PackedStringArray)
		var narrative: Node = arch.get_node_or_null("R3NarrativaSilenciosa")
		if narrative == null:
			issues.append("a camada narrativa silenciosa não foi montada")
		else:
			var contract: Dictionary = narrative.call("get_contract") as Dictionary
			for key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
				if bool(contract.get(key, true)):
					issues.append("o contrato narrativo declarou recurso proibido: %s" % key)
			if int(contract.get("narrative_target_count", 0)) != 4:
				issues.append("a narrativa silenciosa não relacionou os quatro marcos existentes")
			if not bool(contract.get("central_clearance_preserved", false)) or not bool(contract.get("stays_before_r4", false)):
				issues.append("o contrato narrativo não preserva corredor e fronteira R4")
			if narrative.get_child_count() != 0:
				issues.append("a camada narrativa criou objetos filhos proibidos")
		var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
		if lore == null:
			issues.append("a leitura arqueológica existente foi removida")
		else:
			var labels: Array[Node] = lore.find_children("TextoDaPlaca*", "Label3D", true, false)
			if labels.size() != 2:
				issues.append("a narrativa alterou as leituras ambientais existentes")
			else:
				var texts: PackedStringArray = PackedStringArray()
				for label_node: Node in labels:
					texts.append((label_node as Label3D).text)
				if not texts.has(INSCRIPTION_SCRIPT.LEFT_TEXT) or not texts.has(INSCRIPTION_SCRIPT.RIGHT_TEXT):
					issues.append("a narrativa alterou o texto das placas existentes")
		var trigger: Area3D = arch.get_node_or_null("R3ArchAwakening/R3GatilhoDeTravessia") as Area3D
		var collision: CollisionShape3D = trigger.get_node_or_null("R3VolumeDeTravessia") as CollisionShape3D if trigger != null else null
		var shape: BoxShape3D = collision.shape as BoxShape3D if collision != null else null
		if shape == null or shape.size.x < 5.50:
			issues.append("a narrativa silenciosa reduziu a folga do gatilho central")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_NARRATIVE_QUIET_OK] leitura silenciosa relaciona memória, passagem e saída sem criar objetos ou recursos proibidos")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_NARRATIVE_QUIET_ERROR] %s" % issue)
	quit(1)

func _fail(message: String) -> void:
	printerr("[ORIGEM_R3_ARCH_NARRATIVE_QUIET_ERROR] %s" % message)
	quit(1)
