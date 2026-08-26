extends SceneTree

const ARCH_SCRIPT: Script = preload("res://levels/regions/r3/ArchHumidThreshold.gd")

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
		var threshold: Node = arch.get_node_or_null("R3LimiarHumidoLateral")
		if threshold == null:
			issues.append("a camada de limiar húmido não foi montada")
		else:
			var contract: Dictionary = threshold.call("get_contract") as Dictionary
			for key: String in ["adds_geometry", "adds_trail", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
				if bool(contract.get(key, true)):
					issues.append("o contrato húmido declarou recurso proibido: %s" % key)
			if int(contract.get("adjusted_material_count", 0)) < 2:
				issues.append("a continuidade húmida não ajustou materiais laterais suficientes")
			if threshold.get_child_count() != 0:
				issues.append("a camada húmida criou objetos filhos proibidos")
		var trigger: Area3D = arch.get_node_or_null("R3ArchAwakening/R3GatilhoDeTravessia") as Area3D
		var collision: CollisionShape3D = trigger.get_node_or_null("R3VolumeDeTravessia") as CollisionShape3D if trigger != null else null
		var shape: BoxShape3D = collision.shape as BoxShape3D if collision != null else null
		if shape == null or shape.size.x < 5.50:
			issues.append("a continuidade húmida reduziu a folga do gatilho central")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_HUMID_THRESHOLD_OK] materiais laterais existentes reforçam a humidade sem criar trilho ou recursos proibidos")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_HUMID_THRESHOLD_ERROR] %s" % issue)
	quit(1)

func _fail(message: String) -> void:
	printerr("[ORIGEM_R3_ARCH_HUMID_THRESHOLD_ERROR] %s" % message)
	quit(1)
