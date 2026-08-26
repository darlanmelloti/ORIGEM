extends SceneTree

const ARCH_MATERIAL_CONSISTENCY_SCRIPT: Script = preload("res://levels/regions/r3/ArchMaterialConsistency.gd")

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_ARCH_MATERIAL_CONSISTENCY_ERROR] Não foi possível carregar o mundo principal.")
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
		issues.append_array(ARCH_MATERIAL_CONSISTENCY_SCRIPT.call("validate", arch) as PackedStringArray)
		var consistency: Node = arch.get_node_or_null("R3CoerenciaMaterial")
		if consistency != null:
			var contract: Dictionary = consistency.call("get_contract") as Dictionary
			for prohibited_key: String in ["adds_geometry", "adds_lights", "adds_emission", "adds_vfx", "adds_collision", "uses_ui"]:
				if bool(contract.get(prohibited_key, true)):
					issues.append("a coerência material R3 declarou alteração proibida: %s" % prohibited_key)
		var trigger: Area3D = arch.get_node_or_null("R3ArchAwakening/R3GatilhoDeTravessia") as Area3D
		if trigger == null:
			issues.append("o gatilho de travessia R3 deixou de existir")
		else:
			var shape_node: CollisionShape3D = trigger.get_node_or_null("R3VolumeDeTravessia") as CollisionShape3D
			var shape: BoxShape3D = shape_node.shape as BoxShape3D if shape_node != null else null
			if shape == null or shape.size.x < 5.50:
				issues.append("a coerência material R3 reduziu a folga do gatilho central")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_MATERIAL_CONSISTENCY_OK] Materiais existentes de placas, seixos e pátina harmonizados sem ampliar o orçamento visual.")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_MATERIAL_CONSISTENCY_ERROR] %s" % issue)
	quit(1)
