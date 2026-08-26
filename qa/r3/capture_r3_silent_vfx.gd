extends SceneTree

const OUTPUT_PATH: String = "res://qa/r3/evidence/r3_silent_vfx_cadence_1600x900.png"

func _init() -> void:
	call_deferred("_capture")

func _capture() -> void:
	root.size = Vector2i(1600, 900)
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_SILENT_VFX_CAPTURE_ERROR] Não foi possível carregar o mundo principal.")
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
	var arch: Node3D = world.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D if world != null else null
	if arch == null:
		printerr("[ORIGEM_R3_SILENT_VFX_CAPTURE_ERROR] Arco R3 não encontrado para captura.")
		quit(1)
		return
	var awakening: Node = arch.get_node_or_null("R3ArchAwakening")
	if awakening == null or not awakening.has_method("awake_once") or not bool(awakening.call("awake_once")):
		printerr("[ORIGEM_R3_SILENT_VFX_CAPTURE_ERROR] Não foi possível iniciar a cadência do despertar.")
		quit(1)
		return
	var camera: Camera3D = Camera3D.new()
	camera.name = "CameraCapturaCadenciaSilenciosaR3"
	camera.fov = 44.0
	world.add_child(camera)
	var origin: Vector3 = arch.global_position
	camera.global_position = origin + Vector3(-7.4, 4.7, 7.2)
	camera.look_at(origin + Vector3(-1.1, 4.45, -0.55), Vector3.UP)
	camera.current = true
	await create_timer(0.24).timeout
	var viewport_texture: ViewportTexture = root.get_texture()
	if viewport_texture == null:
		printerr("[ORIGEM_R3_SILENT_VFX_CAPTURE_ERROR] Textura de viewport indisponível.")
		quit(1)
		return
	var save_error: Error = viewport_texture.get_image().save_png(OUTPUT_PATH)
	camera.queue_free()
	if save_error != OK:
		printerr("[ORIGEM_R3_SILENT_VFX_CAPTURE_ERROR] Não foi possível gravar a imagem: %s" % save_error)
		quit(1)
		return
	print("[ORIGEM_R3_SILENT_VFX_CAPTURE_OK] %s" % OUTPUT_PATH)
	quit(0)
