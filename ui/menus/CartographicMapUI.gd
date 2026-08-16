extends CanvasLayer
## Mapa cartográfico do ORIGEM — acessível durante o gameplay com a tecla M.

const MAP_TEXTURE: Texture2D = preload("res://assets/ui/mapa_cartografico_origem.png")

var map_root: Control
var is_open: bool = false

func _ready() -> void:
	layer = 12
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_interface()
	_set_open(OS.has_environment("ORIGEM_QA_OPEN_MAP"))

func _build_interface() -> void:
	map_root = Control.new()
	map_root.name = "MapaCartograficoUI"
	map_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	map_root.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(map_root)

	var backdrop := ColorRect.new()
	backdrop.name = "VéuEscuroDoMapa"
	backdrop.color = Color(0.015, 0.020, 0.028, 0.86)
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	backdrop.mouse_filter = Control.MOUSE_FILTER_STOP
	map_root.add_child(backdrop)

	var texture := TextureRect.new()
	texture.name = "MapaOficialDoVale"
	texture.texture = MAP_TEXTURE
	texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	# Canvas 4:3 de 800×600, centrado em qualquer resolução; preserva a cartografia completa sem corte lateral.
	texture.set_anchors_preset(Control.PRESET_CENTER)
	texture.offset_left = -400.0
	texture.offset_top = -300.0
	texture.offset_right = 400.0
	texture.offset_bottom = 300.0
	texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_root.add_child(texture)

	var title := Label.new()
	title.name = "TituloMapa"
	title.text = "CARTOGRAFIA DO VALE DE KHEPER"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color(0.93, 0.80, 0.53, 1.0))
	title.anchor_left = 0.0
	title.anchor_right = 1.0
	title.anchor_top = 0.0
	title.anchor_bottom = 0.0
	title.offset_left = 0.0
	title.offset_right = 0.0
	title.offset_top = 12.0
	title.offset_bottom = 38.0
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_root.add_child(title)

	var hint := Label.new()
	hint.name = "InstrucaoFecharMapa"
	hint.text = "M — FECHAR MAPA"
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.add_theme_font_size_override("font_size", 16)
	hint.add_theme_color_override("font_color", Color(0.78, 0.71, 0.56, 1.0))
	hint.anchor_left = 0.0
	hint.anchor_right = 1.0
	hint.anchor_top = 1.0
	hint.anchor_bottom = 1.0
	hint.offset_left = 0.0
	hint.offset_right = 0.0
	hint.offset_top = -42.0
	hint.offset_bottom = -12.0
	hint.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_root.add_child(hint)

func toggle_map() -> void:
	_set_open(not is_open)

func _set_open(value: bool) -> void:
	is_open = value
	if map_root != null:
		map_root.visible = is_open
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if is_open else Input.MOUSE_MODE_CAPTURED)
