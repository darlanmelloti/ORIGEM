extends CanvasLayer
## Orientação persistente da primeira jornada de Elias.
## O estado nasce de TimelineManager; não cria missões paralelas nem depende de uma cena dedicada.

var root_panel: PanelContainer
var title_label: Label
var objective_label: Label
var hint_label: Label
var route_revealed: bool = false

func _ready() -> void:
	layer = 11
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_interface()
	EventBus.timeline_event_triggered.connect(_on_timeline_event_triggered)
	_refresh_objective(false)

func _build_interface() -> void:
	root_panel = PanelContainer.new()
	root_panel.name = "ObjetivoDeJornada"
	root_panel.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	root_panel.position = Vector2(-352.0, 28.0)
	root_panel.size = Vector2(324.0, 104.0)
	root_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var panel_style: StyleBoxFlat = StyleBoxFlat.new()
	panel_style.bg_color = Color(0.025, 0.040, 0.060, 0.82)
	panel_style.border_color = Color(0.26, 0.67, 0.86, 0.68)
	panel_style.set_border_width_all(1)
	panel_style.corner_radius_top_left = 8
	panel_style.corner_radius_top_right = 8
	panel_style.corner_radius_bottom_left = 8
	panel_style.corner_radius_bottom_right = 8
	panel_style.content_margin_left = 16.0
	panel_style.content_margin_right = 16.0
	panel_style.content_margin_top = 12.0
	panel_style.content_margin_bottom = 10.0
	root_panel.add_theme_stylebox_override("panel", panel_style)
	add_child(root_panel)

	var content: VBoxContainer = VBoxContainer.new()
	content.add_theme_constant_override("separation", 3)
	root_panel.add_child(content)

	title_label = Label.new()
	title_label.name = "TituloObjetivo"
	title_label.text = "JORNADA"
	title_label.add_theme_font_size_override("font_size", 12)
	title_label.add_theme_color_override("font_color", Color(0.56, 0.82, 0.96, 1.0))
	content.add_child(title_label)

	objective_label = Label.new()
	objective_label.name = "TextoObjetivo"
	objective_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	objective_label.add_theme_font_size_override("font_size", 16)
	objective_label.add_theme_color_override("font_color", Color(0.94, 0.89, 0.72, 1.0))
	content.add_child(objective_label)

	hint_label = Label.new()
	hint_label.name = "DicaObjetivo"
	hint_label.add_theme_font_size_override("font_size", 12)
	hint_label.add_theme_color_override("font_color", Color(0.64, 0.70, 0.73, 1.0))
	content.add_child(hint_label)

func _on_timeline_event_triggered(event_id: String, _era_name: String) -> void:
	if event_id == "voss_door_opened":
		_refresh_objective(true)

func _refresh_objective(animate: bool) -> void:
	route_revealed = TimelineManager.has_consequence("road_to_orion_revealed")
	if route_revealed:
		title_label.text = "JORNADA ATIVA"
		objective_label.text = "Siga pela Estrada do Rio.\nEncontre o Arco das Ruínas."
		hint_label.text = "M — consultar a cartografia do vale"
	else:
		title_label.text = "PRÓLOGO"
		objective_label.text = "Procure uma saída na Casa Voss."
		hint_label.text = "As pistas de Tomás podem revelar o caminho"
	if animate and root_panel != null:
		root_panel.modulate.a = 0.25
		var tween: Tween = create_tween()
		tween.tween_property(root_panel, "modulate:a", 1.0, 0.42).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if OS.has_environment("ORIGEM_QA_JOURNEY_HUD"):
		print("[ORIGEM_JOURNEY_HUD] estrada_revelada=%s" % str(route_revealed))
