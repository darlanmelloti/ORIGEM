extends SceneTree

const MIN_CLEARANCE_X: float = 4.20

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_RIVER_MEMORY_ERROR] Não foi possível carregar o mundo principal.")
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
		var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
		if lore == null:
			issues.append("a camada arqueológica R3 não foi encontrada")
		else:
			var river_memory: Node3D = lore.get_node_or_null("MemoriaMaterialDoRio") as Node3D
			if river_memory == null:
				issues.append("a memória material do rio não foi instalada")
			else:
				if not river_memory.has_meta("r3_road_offset") or absf(float(river_memory.get_meta("r3_road_offset"))) < MIN_CLEARANCE_X:
					issues.append("a memória material do rio invade o vão navegável")
				var pebbles: Array[Node] = river_memory.find_children("SeixoLavado*", "MeshInstance3D", false, false)
				if pebbles.size() != 3:
					issues.append("a memória material do rio deve conter exatamente três seixos")
				for pebble_node: Node in pebbles:
					var pebble: MeshInstance3D = pebble_node as MeshInstance3D
					if pebble == null or not pebble.mesh is SphereMesh:
						issues.append("a memória do rio deve usar seixos arredondados, não painéis")
					elif pebble.scale.y > 0.08:
						issues.append("um seixo da memória do rio deixou de ser baixo")
				if not river_memory.find_children("*", "Label3D", true, false).is_empty():
					issues.append("a memória material do rio não pode acrescentar texto flutuante")
				if not river_memory.find_children("*", "CollisionShape3D", true, false).is_empty() or not river_memory.find_children("*", "StaticBody3D", true, false).is_empty():
					issues.append("a memória material do rio não pode criar colisores")
				if not river_memory.find_children("*", "Light3D", true, false).is_empty() or not river_memory.find_children("*", "AudioStreamPlayer", true, false).is_empty():
					issues.append("a memória material do rio não pode criar luz ou áudio")
				if not river_memory.find_children("*", "Control", true, false).is_empty() or not river_memory.find_children("*", "CanvasLayer", true, false).is_empty():
					issues.append("a memória material do rio não pode criar UI")
	if issues.is_empty():
		print("[ORIGEM_R3_RIVER_MEMORY_OK] Três seixos laterais preservam a memória material do rio sem invadir o Arco.")
		quit(0)
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_RIVER_MEMORY_ERROR] %s" % issue)
	quit(1)
