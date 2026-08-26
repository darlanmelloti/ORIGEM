extends SceneTree

const OUTPUT_PATH: String = "res://qa/r3/evidence/r3_arch_arrival_cue_1600x900.png"

func _init() -> void:
	call_deferred("_capture")

func _capture() -> void:
	root.size = Vector2i(1600, 900)
	var change_error: Error = change_scene_to_file("res://scenes/main.tscn")
	if change_error != OK:
		printerr("[ORIGEM_R3_ARCH_ARRIVAL_CUE_CAPTURE_ERROR] Não foi possível carregar o mundo principal.")
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
	if arch == null or arch.get_node_or_null("R3LeituraDeChegada") == null:
		printerr("[ORIGEM_R3_ARCH_ARRIVAL_CUE_CAPTURE_ERROR] Arco ou leitura de chegada R3 não encontrado.")
		quit(1)
		return
	var camera: Camera3D = Camera3D.new()
	camera.name = "CameraCapturaChegadaArcoR3"
	camera.fov = 47.0
	world.add_child(camera)
	camera.global_position = arch.global_position + Vector3(-0.55, 3.05, -15.0)
	camera.look_at(arch.global_position + Vector3(0.0, 2.35, -0.15), Vector3.UP)
	camera.current = true
	await create_timer(0.5).timeout
	var viewport_texture: ViewportTexture = root.get_texture()
	if viewport_texture == null:
		printerr("[ORIGEM_R3_ARCH_ARRIVAL_CUE_CAPTURE_ERROR] Textura de viewport indisponível.")
		quit(1)
		return
	var save_error: Error = viewport_texture.get_image().save_png(OUTPUT_PATH)
	camera.queue_free()
	if save_error != OK:
		printerr("[ORIGEM_R3_ARCH_ARRIVAL_CUE_CAPTURE_ERROR] Não foi possível gravar a imagem: %s" % save_error)
		quit(1)
		return
	print("[ORIGEM_R3_ARCH_ARRIVAL_CUE_CAPTURE_OK] %s" % OUTPUT_PATH)
	quit(0)
