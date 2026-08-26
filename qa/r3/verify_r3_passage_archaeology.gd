extends SceneTree

const MIN_LATERAL_OFFSET: float = 4.20
const MIN_TRACE_Z: float = 95.0
const MAX_TRACE_Z: float = 108.0

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_ERROR] Não foi possível carregar o mundo principal.")
		quit(1)
		return
	await process_frame
	await create_timer(2.2).timeout
	var issues: PackedStringArray = PackedStringArray()
	var world: Node = current_scene
	var handoff: Node3D = world.find_child("R3HandoffParaFloresta", true, false) as Node3D if world != null else null
	if handoff == null:
		issues.append("o handoff R3 para a floresta não foi encontrado")
	else:
		var traces: Array[Node] = handoff.find_children("VestigioDePassagem*", "Node3D", false, false)
		if traces.size() != 3:
			issues.append("a passagem R3 deve conter exatamente três vestígios arqueológicos")
		for trace: Node in traces:
			var trace_3d: Node3D = trace as Node3D
			if trace_3d == null:
				continue
			if not trace_3d.has_meta("r3_road_offset") or absf(float(trace_3d.get_meta("r3_road_offset"))) < MIN_LATERAL_OFFSET:
				issues.append("um vestígio R3 invade a faixa central navegável")
			if not trace_3d.has_meta("r3_trace_z"):
				issues.append("um vestígio R3 não declara a posição longitudinal")
			else:
				var trace_z: float = float(trace_3d.get_meta("r3_trace_z"))
				if trace_z < MIN_TRACE_Z or trace_z > MAX_TRACE_Z:
					issues.append("um vestígio R3 ultrapassa a janela pós-Arco permitida")
			var fragments: Array[Node] = trace_3d.find_children("FragmentoArqueologico*", "Node3D", true, false)
			if fragments.size() != 1:
				issues.append("um vestígio R3 não possui exatamente um fragmento baixo")
			elif (fragments[0] as Node3D).scale.y > 0.08:
				issues.append("um fragmento arqueológico R3 deixou de ser baixo")
		if not handoff.find_children("VestigioDePassagem*", "StaticBody3D", true, false).is_empty() or not handoff.find_children("VestigioDePassagem*", "CollisionShape3D", true, false).is_empty():
			issues.append("os vestígios R3 não podem criar colisores")
		if not handoff.find_children("VestigioDePassagem*", "Light3D", true, false).is_empty():
			issues.append("os vestígios R3 não podem criar luz dinâmica")
		if not handoff.find_children("VestigioDePassagem*", "Control", true, false).is_empty() or not handoff.find_children("VestigioDePassagem*", "CanvasLayer", true, false).is_empty():
			issues.append("os vestígios R3 não podem criar UI")
	if issues.is_empty():
		print("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_OK] Três vestígios baixos e laterais preservam o corredor R3 para a floresta.")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_ERROR] %s" % issue)
	quit(1)
