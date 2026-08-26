extends SceneTree

const OUTPUT_PATH: String = "res://qa/r3/evidence/r3_inscription_lore_arch_to_forest_1600x900.png"

func _init() -> void:
	call_deferred("_capture")

func _capture() -> void:
	root.size = Vector2i(1600, 900)
	# O modo de rota evita a interface narrativa na evidência técnica sem alterar o jogo normal.
	OS.set_environment("ORIGEM_QA_ROUTE", "arch_to_forest")
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_INSCRIPTION_CAPTURE_ERROR] Não foi possível carregar o mundo principal.")
		quit(1)
		return
	await process_frame
	await create_timer(2.5).timeout
	var world: Node = current_scene
	if world != null:
		for ui_layer: CanvasLayer in world.find_children("*", "CanvasLayer", true, false):
			ui_layer.visible = false
		for ui_control: Control in world.find_children("*", "Control", true, false):
			ui_control.visible = false
	var arch: Node3D = world.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D if world != null else null
	if arch == null:
		printerr("[ORIGEM_R3_INSCRIPTION_CAPTURE_ERROR] Arco R3 não encontrado para captura.")
		quit(1)
		return
	var awakening: Node = arch.get_node_or_null("R3ArchAwakening")
	if awakening != null and awakening.has_method("awake_once"):
		awakening.call("awake_once")
	var camera: Camera3D = Camera3D.new()
	camera.name = "CameraCapturaLeituraArqueologicaR3"
	camera.fov = 47.0
	world.add_child(camera)
	var framing_origin: Vector3 = arch.global_position
	camera.global_position = framing_origin + Vector3(-7.2, 2.55, -4.8)
	camera.look_at(framing_origin + Vector3(-3.85, 0.95, 3.9), Vector3.UP)
	camera.current = true
	await create_timer(0.8).timeout
	var viewport_texture: ViewportTexture = root.get_texture()
	if viewport_texture == null:
		printerr("[ORIGEM_R3_INSCRIPTION_CAPTURE_ERROR] Textura de viewport indisponível.")
		quit(1)
		return
	var image: Image = viewport_texture.get_image()
	var save_error: Error = image.save_png(OUTPUT_PATH)
	camera.queue_free()
	if save_error != OK:
		printerr("[ORIGEM_R3_INSCRIPTION_CAPTURE_ERROR] Não foi possível gravar a imagem: %s" % save_error)
		quit(1)
		return
	print("[ORIGEM_R3_INSCRIPTION_CAPTURE_OK] %s" % OUTPUT_PATH)
	quit(0)
