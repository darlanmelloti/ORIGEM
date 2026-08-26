extends SceneTree

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	if change_scene_to_file("res://scenes/main.tscn") != OK:
		printerr("[ORIGEM_R3_ARCH_THRESHOLD_REST_ERROR] mundo principal indisponível")
		quit(1)
		return
	await process_frame
	await create_timer(2.2).timeout
	var arch: Node3D = current_scene.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("arco R3 ausente")
	else:
		var layer: Node = arch.get_node_or_null("R3RepousoDoLimiar")
		if layer == null:
			issues.append("camada de repouso do limiar ausente")
		else:
			var contract: Dictionary = layer.call("get_contract") as Dictionary
			for key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
				if bool(contract.get(key, true)):
					issues.append("recurso proibido: %s" % key)
		var marked: Array[Node] = arch.find_children("*", "MeshInstance3D", true, false).filter(func(node: Node) -> bool: return node.has_meta("r3_threshold_rest"))
		if marked.is_empty():
			issues.append("nenhuma superfície lateral herdou o repouso do limiar")
		var trigger: Area3D = arch.get_node_or_null("R3ArchAwakening/R3GatilhoDeTravessia") as Area3D
		var collision: CollisionShape3D = trigger.get_node_or_null("R3VolumeDeTravessia") as CollisionShape3D if trigger != null else null
		var shape: BoxShape3D = collision.shape as BoxShape3D if collision != null else null
		if shape == null or shape.size.x < 5.50:
			issues.append("o repouso do limiar reduziu a folga do gatilho central")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_THRESHOLD_REST_OK] repouso lateral do limiar preservado sem recursos adicionais")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_THRESHOLD_REST_ERROR] %s" % issue)
	quit(1)
