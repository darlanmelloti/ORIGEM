extends SceneTree

const ARCH_PATINA_SCRIPT: Script = preload("res://levels/regions/r3/ArchPatina.gd")

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_ARCH_PATINA_ERROR] Não foi possível carregar o mundo principal.")
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
		issues.append_array(ARCH_PATINA_SCRIPT.call("validate", arch) as PackedStringArray)
		var patina: Node = arch.get_node_or_null("R3PatinaArqueologica")
		if patina != null:
			var contract: Dictionary = patina.call("get_contract") as Dictionary
			for prohibited_key: String in ["adds_geometry", "adds_lights", "adds_vfx", "adds_collision"]:
				if bool(contract.get(prohibited_key, true)):
					issues.append("a pátina R3 declarou alteração proibida: %s" % prohibited_key)
			if not patina.find_children("*", "AudioStreamPlayer", true, false).is_empty():
				issues.append("a pátina R3 não pode introduzir áudio")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_PATINA_OK] Cinco alvos materiais existentes receberam pátina sem alterar luzes, física ou VFX.")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_PATINA_ERROR] %s" % issue)
	quit(1)
