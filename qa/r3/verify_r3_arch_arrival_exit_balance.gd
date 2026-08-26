extends SceneTree

const ARCH_SCRIPT: Script = preload("res://levels/regions/r3/ArchArrivalExitBalance.gd")

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
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
		var balance: Node = arch.get_node_or_null("R3EquilibrioChegadaSaida")
		if balance == null:
			issues.append("a camada de equilíbrio chegada-saída não foi montada")
		else:
			var contract: Dictionary = balance.call("get_contract") as Dictionary
			for key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
				if bool(contract.get(key, true)):
					issues.append("o contrato de equilíbrio declarou recurso proibido: %s" % key)
			if int(contract.get("balanced_target_count", 0)) != 4:
				issues.append("o equilíbrio não ajustou os quatro grupos laterais existentes")
			if not bool(contract.get("central_clearance_preserved", false)) or not bool(contract.get("stays_before_r4", false)):
				issues.append("o contrato de equilíbrio não preserva corredor e fronteira R4")
			if balance.get_child_count() != 0:
				issues.append("a camada de equilíbrio criou objetos filhos proibidos")
		var trigger: Area3D = arch.get_node_or_null("R3ArchAwakening/R3GatilhoDeTravessia") as Area3D
		var collision: CollisionShape3D = trigger.get_node_or_null("R3VolumeDeTravessia") as CollisionShape3D if trigger != null else null
		var shape: BoxShape3D = collision.shape as BoxShape3D if collision != null else null
		if shape == null or shape.size.x < 5.50:
			issues.append("o equilíbrio chegada-saída reduziu a folga do gatilho central")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_ARRIVAL_EXIT_BALANCE_OK] chegada e saída laterais equilibradas sem criar objetos ou estreitar a passagem")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_ARRIVAL_EXIT_BALANCE_ERROR] %s" % issue)
	quit(1)

func _fail(message: String) -> void:
	printerr("[ORIGEM_R3_ARCH_ARRIVAL_EXIT_BALANCE_ERROR] %s" % message)
	quit(1)
