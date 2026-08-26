extends SceneTree

const ARCH_EXIT_ECHO_SCRIPT: Script = preload("res://levels/regions/r3/ArchExitEcho.gd")

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_ARCH_EXIT_ECHO_ERROR] Não foi possível carregar o mundo principal.")
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
		issues.append_array(ARCH_EXIT_ECHO_SCRIPT.call("validate", arch) as PackedStringArray)
		var echo: Node = arch.get_node_or_null("R3EcoArqueologicoDeSaida")
		if echo != null:
			var contract: Dictionary = echo.call("get_contract") as Dictionary
			for prohibited_key: String in ["adds_geometry", "adds_lights", "adds_vfx", "adds_collision", "uses_ui"]:
				if bool(contract.get(prohibited_key, true)):
					issues.append("o eco de saída R3 declarou alteração proibida: %s" % prohibited_key)
			if not bool(contract.get("stays_before_r4", false)):
				issues.append("o eco de saída R3 não declarou permanência antes de R4")
		var trigger: Area3D = arch.get_node_or_null("R3ArchAwakening/R3GatilhoDeTravessia") as Area3D
		if trigger == null:
			issues.append("o gatilho de travessia R3 deixou de existir")
		else:
			var shape_node: CollisionShape3D = trigger.get_node_or_null("R3VolumeDeTravessia") as CollisionShape3D
			var shape: BoxShape3D = shape_node.shape as BoxShape3D if shape_node != null else null
			if shape == null or shape.size.x < 5.50:
				issues.append("o eco de saída R3 reduziu a folga do gatilho central")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_EXIT_ECHO_OK] Dois vestígios R3 laterais reforçam a saída sem antecipar R4 ou criar bloqueio.")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_EXIT_ECHO_ERROR] %s" % issue)
	quit(1)
