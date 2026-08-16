extends CanvasLayer
## Mapa cartográfico do ORIGEM — acessível durante o gameplay com a tecla M.

const MAP_TEXTURE: Texture2D = preload("res://assets/ui/mapa_cartografico_origem.png")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

var map_root: Control
var map_texture: TextureRect
var player_marker: Panel
var player_marker_label: Label
var route_marker: Panel
var route_marker_label: Label
var is_open: bool = false

# Janela útil da cartografia, calibrada contra as âncoras do mundo: oeste→este e sul→norte.
const WORLD_MIN_X: float = -140.0
const WORLD_MAX_X: float = 210.0
const WORLD_MIN_Z: float = 0.0
const WORLD_MAX_Z: float = 570.0
const MAP_INSET_LEFT: float = 92.0
const MAP_INSET_TOP: float = 46.0
const MAP_INSET_WIDTH: float = 620.0
const MAP_INSET_HEIGHT: float = 500.0

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

	map_texture = TextureRect.new()
	map_texture.name = "MapaOficialDoVale"
	map_texture.texture = MAP_TEXTURE
	map_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	map_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	# Canvas 4:3 de 800×600, centrado em qualquer resolução; preserva a cartografia completa sem corte lateral.
	map_texture.set_anchors_preset(Control.PRESET_CENTER)
	map_texture.offset_left = -400.0
	map_texture.offset_top = -300.0
	map_texture.offset_right = 400.0
	map_texture.offset_bottom = 300.0
	map_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_root.add_child(map_texture)

	player_marker = Panel.new()
	player_marker.name = "MarcadorDeElias"
	player_marker.set_anchors_preset(Control.PRESET_TOP_LEFT)
	player_marker.size = Vector2(14.0, 14.0)
	player_marker.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var marker_style := StyleBoxFlat.new()
	marker_style.bg_color = Color(0.20, 0.72, 0.96, 1.0)
	marker_style.border_color = Color(0.94, 0.82, 0.45, 1.0)
	marker_style.set_border_width_all(2)
	marker_style.corner_radius_top_left = 7
	marker_style.corner_radius_top_right = 7
	marker_style.corner_radius_bottom_left = 7
	marker_style.corner_radius_bottom_right = 7
	player_marker.add_theme_stylebox_override("panel", marker_style)
	map_texture.add_child(player_marker)

	player_marker_label = Label.new()
	player_marker_label.name = "LegendaMarcadorElias"
	player_marker_label.text = "ELIAS"
	player_marker_label.add_theme_font_size_override("font_size", 12)
	player_marker_label.add_theme_color_override("font_color", Color(0.94, 0.86, 0.62, 1.0))
	player_marker_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_texture.add_child(player_marker_label)

	route_marker = Panel.new()
	route_marker.name = "DestinoInicialArcoDasRuinas"
	route_marker.set_anchors_preset(Control.PRESET_TOP_LEFT)
	route_marker.size = Vector2(16.0, 16.0)
	route_marker.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var route_style := StyleBoxFlat.new()
	route_style.bg_color = Color(0.94, 0.46, 0.10, 1.0)
	route_style.border_color = Color(1.0, 0.86, 0.48, 1.0)
	route_style.set_border_width_all(2)
	route_style.corner_radius_top_left = 8
	route_style.corner_radius_top_right = 8
	route_style.corner_radius_bottom_left = 8
	route_style.corner_radius_bottom_right = 8
	route_marker.add_theme_stylebox_override("panel", route_style)
	map_texture.add_child(route_marker)

	route_marker_label = Label.new()
	route_marker_label.name = "LegendaDestinoInicial"
	route_marker_label.text = "RUMO AO ARCO"
	route_marker_label.add_theme_font_size_override("font_size", 11)
	route_marker_label.add_theme_color_override("font_color", Color(1.0, 0.84, 0.47, 1.0))
	route_marker_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_texture.add_child(route_marker_label)
	_place_route_marker(CARTOGRAPHIC_ANCHORS.ARCO_RUINAS)

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

func _map_position(world_x: float, world_z: float) -> Vector2:
	var map_x: float = MAP_INSET_LEFT + inverse_lerp(WORLD_MIN_X, WORLD_MAX_X, world_x) * MAP_INSET_WIDTH
	# O eixo Z cresce para norte no mundo, mas cresce para baixo na textura do mapa.
	var map_y: float = MAP_INSET_TOP + (1.0 - inverse_lerp(WORLD_MIN_Z, WORLD_MAX_Z, world_z)) * MAP_INSET_HEIGHT
	return Vector2(
		clampf(map_x, MAP_INSET_LEFT, MAP_INSET_LEFT + MAP_INSET_WIDTH),
		clampf(map_y, MAP_INSET_TOP, MAP_INSET_TOP + MAP_INSET_HEIGHT)
	)

func _place_route_marker(destination: Vector2) -> void:
	if route_marker == null:
		return
	var map_position: Vector2 = _map_position(destination.x, destination.y)
	route_marker.position = map_position - route_marker.size * 0.5
	if route_marker_label != null:
		route_marker_label.position = route_marker.position + Vector2(12.0, -5.0)

func update_player_world_position(world_position: Vector3) -> void:
	if player_marker == null:
		return
	var map_position: Vector2 = _map_position(world_position.x, world_position.z)
	player_marker.position = map_position - player_marker.size * 0.5
	if player_marker_label != null:
		player_marker_label.position = player_marker.position + Vector2(10.0, -5.0)

func toggle_map() -> void:
	_set_open(not is_open)

func _set_open(value: bool) -> void:
	is_open = value
	if map_root != null:
		map_root.visible = is_open
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if is_open else Input.MOUSE_MODE_CAPTURED)
