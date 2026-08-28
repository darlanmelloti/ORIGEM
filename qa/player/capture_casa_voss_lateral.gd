extends Node
## Captura QA tardia: usa a textura real do viewport após a rota lateral estar ativa.

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().create_timer(8.0).timeout.connect(_capture)

func _capture() -> void:
	var output_dir := OS.get_environment("ORIGEM_QA_OUTPUT_DIR")
	if output_dir.is_empty():
		print("[QA-CASA-VOSS-LATERAL-FAIL] ORIGEM_QA_OUTPUT_DIR em falta")
		get_tree().quit(1)
		return
	var image := get_viewport().get_texture().get_image()
	if image == null:
		print("[QA-CASA-VOSS-LATERAL-FAIL] viewport indisponível")
		get_tree().quit(1)
		return
	var path := output_dir.path_join("casa_voss_lateral_loaded_1600x900.png")
	var result := image.save_png(path)
	print("[QA-CASA-VOSS-LATERAL] caminho=%s resultado=%d" % [path, result])
	get_tree().quit(0 if result == OK else 1)
