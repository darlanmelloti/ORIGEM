extends SceneTree

const OUTPUT_PATH: String = "res://qa/r3/evidence/r3_passage_archaeology_1600x900.png"

func _init() -> void:
	call_deferred("_capture")

func _capture() -> void:
	root.size = Vector2i(1600, 900)
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_CAPTURE_ERROR] Não foi possível carregar o mundo principal.")
		quit(1)
		return
	await process_frame
	await create_timer(2.3).timeout
	var world: Node = current_scene
	if world != null:
		for ui_layer: CanvasLayer in world.find_children("*", "CanvasLayer", true, false):
			ui_layer.visible = false
		for ui_control: Control in world.find_children("*", "Control", true, false):
			ui_control.visible = false
	var handoff: Node3D = world.find_child("R3HandoffParaFloresta", true, false) as Node3D if world != null else null
	if handoff == null:
		printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_CAPTURE_ERROR] Handoff R3 não encontrado para captura.")
		quit(1)
		return
	var traces: Array[Node] = handoff.find_children("VestigioDePassagem*", "Node3D", false, false)
	if traces.size() != 3:
		printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_CAPTURE_ERROR] Vestígios arqueológicos incompletos.")
		quit(1)
		return
	var center: Vector3 = Vector3.ZERO
	for trace: Node in traces:
		var fragment: Node3D = trace.find_child("FragmentoArqueologico*", true, false) as Node3D
		if fragment == null:
			printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_CAPTURE_ERROR] Fragmento arqueológico ausente.")
			quit(1)
			return
		center += fragment.global_position
	center /= float(traces.size())
	var camera: Camera3D = Camera3D.new()
	camera.name = "CameraCapturaPassagemArqueologicaR3"
	camera.fov = 49.0
	world.add_child(camera)
	camera.global_position = center + Vector3(-7.0, 3.2, -7.8)
	camera.look_at(center + Vector3(0.4, 0.30, 4.2), Vector3.UP)
	camera.current = true
	await create_timer(0.5).timeout
	var viewport_texture: ViewportTexture = root.get_texture()
	if viewport_texture == null:
		printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_CAPTURE_ERROR] Textura de viewport indisponível.")
		quit(1)
		return
	var save_error: Error = viewport_texture.get_image().save_png(OUTPUT_PATH)
	camera.queue_free()
	if save_error != OK:
		printerr("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_CAPTURE_ERROR] Não foi possível gravar a imagem: %s" % save_error)
		quit(1)
		return
	print("[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_CAPTURE_OK] %s" % OUTPUT_PATH)
	quit(0)
