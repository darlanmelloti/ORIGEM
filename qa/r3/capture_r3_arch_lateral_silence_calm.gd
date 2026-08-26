extends SceneTree

const OUTPUT_PATH: String = "res://qa/r3/evidence/r3_arch_lateral_silence_calm_1600x900.png"

func _init() -> void:
	call_deferred("_capture")

func _capture() -> void:
	root.size = Vector2i(1600, 900)
	if change_scene_to_file("res://scenes/main.tscn") != OK:
		printerr("[ORIGEM_R3_ARCH_LATERAL_SILENCE_CALM_CAPTURE_ERROR] mundo principal indisponível")
		quit(1)
		return
	await process_frame
	await create_timer(2.3).timeout
	var world: Node = current_scene
	for layer: CanvasLayer in world.find_children("*", "CanvasLayer", true, false):
		layer.visible = false
	for control: Control in world.find_children("*", "Control", true, false):
		control.visible = false
	var arch: Node3D = world.find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D
	if arch == null or arch.get_node_or_null("R3SilencioLateralCalmo") == null:
		printerr("[ORIGEM_R3_ARCH_LATERAL_SILENCE_CALM_CAPTURE_ERROR] camada R3 ausente")
		quit(1)
		return
	var camera := Camera3D.new()
	world.add_child(camera)
	camera.global_position = arch.global_position + Vector3(8.4, 2.15, -1.15)
	camera.look_at(arch.global_position + Vector3(4.82, 0.78, 2.32), Vector3.UP)
	camera.current = true
	await create_timer(0.5).timeout
	var result: Error = root.get_texture().get_image().save_png(OUTPUT_PATH)
	camera.queue_free()
	if result != OK:
		printerr("[ORIGEM_R3_ARCH_LATERAL_SILENCE_CALM_CAPTURE_ERROR] falha ao gravar PNG")
		quit(1)
		return
	print("[ORIGEM_R3_ARCH_LATERAL_SILENCE_CALM_CAPTURE_OK] %s" % OUTPUT_PATH)
	quit(0)
