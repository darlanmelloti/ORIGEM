extends CanvasLayer
## Mapa cartográfico do ORIGEM — acessível durante o gameplay com a tecla M.

const MAP_TEXTURE: Texture2D = preload("res://assets/ui/mapa_cartografico_origem.png")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

var map_root: Control
var map_texture: TextureRect
var player_marker: Panel
var player_marker_label: Label
var player_heading: Polygon2D
var player_heading_shadow: Polygon2D
var route_marker: Panel
var route_marker_label: Label
var origin_marker: Panel
var origin_marker_label: Label
var r1_to_r2_link: Line2D
var r1_to_r2_label: Label
var route_to_river_revealed: bool = false
var is_open: bool = false

# A conversão mundo→mapa vive no registo de âncoras: a UI apenas apresenta a cartografia calibrada pela direcção.

func _ready() -> void:
	layer = 12
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_interface()
	EventBus.timeline_event_triggered.connect(_on_timeline_event_triggered)
	_refresh_r1_discovery_state()
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
	player_marker.size = Vector2(16.0, 16.0)
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

	# Seta geométrica: elimina a ambiguidade visual do glifo tipográfico quando o mapa é reduzido.
	var arrow_shape := PackedVector2Array([
		Vector2(0.0, -18.0), Vector2(11.0, 10.0),
		Vector2(0.0, 5.0), Vector2(-11.0, 10.0)
	])
	player_heading_shadow = Polygon2D.new()
	player_heading_shadow.name = "SombraDirecaoDeElias"
	player_heading_shadow.polygon = arrow_shape
	player_heading_shadow.color = Color(0.025, 0.045, 0.065, 0.94)
	player_heading_shadow.scale = Vector2(1.30, 1.30)
	map_texture.add_child(player_heading_shadow)

	player_heading = Polygon2D.new()
	player_heading.name = "DirecaoDeElias"
	player_heading.polygon = arrow_shape
	player_heading.color = Color(1.0, 0.90, 0.42, 1.0)
	map_texture.add_child(player_heading)

	player_marker_label = Label.new()
	player_marker_label.name = "LegendaMarcadorElias"
	player_marker_label.text = "ELIAS"
	player_marker_label.add_theme_font_size_override("font_size", 14)
	player_marker_label.add_theme_color_override("font_color", Color(0.94, 0.86, 0.62, 1.0))
	player_marker_label.add_theme_color_override("font_outline_color", Color(0.04, 0.03, 0.02, 0.96))
	player_marker_label.add_theme_constant_override("outline_size", 4)
	player_marker_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_texture.add_child(player_marker_label)

	route_marker = Panel.new()
	route_marker.name = "DestinoInicialArcoDasRuinas"
	route_marker.set_anchors_preset(Control.PRESET_TOP_LEFT)
	route_marker.size = Vector2(18.0, 18.0)
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
	route_marker_label.add_theme_font_size_override("font_size", 14)
	route_marker_label.add_theme_color_override("font_color", Color(1.0, 0.84, 0.47, 1.0))
	route_marker_label.add_theme_color_override("font_outline_color", Color(0.05, 0.025, 0.01, 0.96))
	route_marker_label.add_theme_constant_override("outline_size", 4)
	route_marker_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_texture.add_child(route_marker_label)
	_place_route_marker(CARTOGRAPHIC_ANCHORS.ARCO_RUINAS)
	_build_origin_marker()
	_build_r1_to_r2_link()

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

func _build_origin_marker() -> void:
	origin_marker = Panel.new()
	origin_marker.name = "MarcoCasaVossVisitada"
	origin_marker.size = Vector2(18.0, 18.0)
	origin_marker.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var marker_style: StyleBoxFlat = StyleBoxFlat.new()
	marker_style.bg_color = Color(0.18, 0.72, 0.52, 1.0)
	marker_style.border_color = Color(0.94, 0.86, 0.56, 1.0)
	marker_style.set_border_width_all(2)
	marker_style.corner_radius_top_left = 8
	marker_style.corner_radius_top_right = 8
	marker_style.corner_radius_bottom_left = 8
	marker_style.corner_radius_bottom_right = 8
	origin_marker.add_theme_stylebox_override("panel", marker_style)
	var map_position: Vector2 = _map_position(CARTOGRAPHIC_ANCHORS.CASA_VOSS.x, CARTOGRAPHIC_ANCHORS.CASA_VOSS.y)
	origin_marker.position = map_position - origin_marker.size * 0.5
	map_texture.add_child(origin_marker)
	origin_marker_label = Label.new()
	origin_marker_label.name = "LegendaCasaVossVisitada"
	origin_marker_label.text = "CASA VOSS"
	origin_marker_label.add_theme_font_size_override("font_size", 13)
	origin_marker_label.add_theme_color_override("font_color", Color(0.75, 0.95, 0.78, 1.0))
	origin_marker_label.add_theme_color_override("font_outline_color", Color(0.03, 0.05, 0.04, 0.96))
	origin_marker_label.add_theme_constant_override("outline_size", 4)
	origin_marker_label.position = origin_marker.position + Vector2(12.0, -5.0)
	origin_marker_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_texture.add_child(origin_marker_label)

func _build_r1_to_r2_link() -> void:
	r1_to_r2_link = Line2D.new()
	r1_to_r2_link.name = "LigacaoCasaVossEstradaDoRio"
	r1_to_r2_link.width = 4.0
	r1_to_r2_link.default_color = Color(0.18, 0.76, 0.98, 0.92)
	r1_to_r2_link.add_point(_map_position(CARTOGRAPHIC_ANCHORS.CASA_VOSS.x, CARTOGRAPHIC_ANCHORS.CASA_VOSS.y))
	r1_to_r2_link.add_point(_map_position(CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO.x, CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO.y))
	map_texture.add_child(r1_to_r2_link)
	r1_to_r2_label = Label.new()
	r1_to_r2_label.name = "LegendaLigacaoEstradaDoRio"
	r1_to_r2_label.text = "ESTRADA DO RIO REVELADA"
	r1_to_r2_label.add_theme_font_size_override("font_size", 12)
	r1_to_r2_label.add_theme_color_override("font_color", Color(0.62, 0.86, 1.0, 1.0))
	r1_to_r2_label.add_theme_color_override("font_outline_color", Color(0.02, 0.035, 0.06, 0.96))
	r1_to_r2_label.add_theme_constant_override("outline_size", 4)
	var river_position: Vector2 = _map_position(CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO.x, CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO.y)
	r1_to_r2_label.position = river_position + Vector2(12.0, -20.0)
	r1_to_r2_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_texture.add_child(r1_to_r2_label)

func _on_timeline_event_triggered(event_id: String, _era_name: String) -> void:
	if event_id == "voss_door_opened":
		_refresh_r1_discovery_state()

func _refresh_r1_discovery_state() -> void:
	route_to_river_revealed = TimelineManager.has_consequence("road_to_orion_revealed")
	if r1_to_r2_link != null:
		r1_to_r2_link.visible = route_to_river_revealed
	if r1_to_r2_label != null:
		r1_to_r2_label.visible = route_to_river_revealed
	if route_marker != null and route_marker_label != null and not route_to_river_revealed:
		_place_route_marker(CARTOGRAPHIC_ANCHORS.CASA_VOSS)
		route_marker_label.text = "CASA VOSS — ORIGEM"
	if OS.has_environment("ORIGEM_QA_OPEN_MAP"):
		print("[ORIGEM_MAP_R1] casa_visitada=true estrada_revelada=%s" % str(route_to_river_revealed))

func _map_position(world_x: float, world_z: float) -> Vector2:
	return CARTOGRAPHIC_ANCHORS.map_texture_position(Vector2(world_x, world_z))

func _place_route_marker(destination: Vector2) -> void:
	if route_marker == null:
		return
	var map_position: Vector2 = _map_position(destination.x, destination.y)
	route_marker.position = map_position - route_marker.size * 0.5
	if route_marker_label != null:
		route_marker_label.position = route_marker.position + Vector2(12.0, -5.0)

func _update_route_destination(world: Vector2) -> void:
	if not route_to_river_revealed:
		return
	var route: Dictionary = CARTOGRAPHIC_ANCHORS.next_dev1_destination(world)
	var destination: Vector2 = route["anchor"] as Vector2
	_place_route_marker(destination)
	if route_marker_label != null:
		route_marker_label.text = str(route["label"])

func update_player_world_position(world_position: Vector3, player_yaw: float = 0.0) -> void:
	if player_marker == null:
		return
	var map_position: Vector2 = _map_position(world_position.x, world_position.z)
	player_marker.position = map_position - player_marker.size * 0.5
	if player_heading != null:
		# No mundo +Z aponta para norte cartográfico e a frente de Elias é -Z quando yaw=0.
		player_heading.position = map_position
		player_heading.rotation = player_yaw + PI
		if player_heading_shadow != null:
			player_heading_shadow.position = map_position
			player_heading_shadow.rotation = player_yaw + PI
	if player_marker_label != null:
		player_marker_label.position = player_marker.position + Vector2(10.0, -5.0)
	_update_route_destination(Vector2(world_position.x, world_position.z))

func toggle_map() -> void:
	_set_open(not is_open)

func _set_open(value: bool) -> void:
	is_open = value
	if map_root != null:
		map_root.visible = is_open
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if is_open else Input.MOUSE_MODE_CAPTURED)
