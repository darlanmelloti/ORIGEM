## EliasCodexUI.gd
## Códice diegético de Elias: relê evidências encontradas e a rota atual.

extends CanvasLayer

var entry_order: PackedStringArray = PackedStringArray([
	"tomas_letter",
	"mountain_map",
	"miguel_tools",
	"river_road"
])

var root: Control
var entry_list: VBoxContainer
var title_label: Label
var body_label: Label
var progress_label: Label
var hint_label: Label
var is_open: bool = false
var entries: Dictionary = {}
var selected_id: String = ""

func _ready() -> void:
	layer = 18
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_interface()
	EventBus.game_loaded.connect(_on_game_loaded)
	EventBus.timeline_event_triggered.connect(_on_timeline_event)
	call_deferred("refresh_entries")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_codex") and not event.is_echo():
		_set_open(not is_open)
		get_viewport().set_input_as_handled()
		return
	if is_open and event.is_action_pressed("ui_cancel") and not event.is_echo():
		_set_open(false)
		get_viewport().set_input_as_handled()

func refresh_entries() -> void:
	entries.clear()
	var voss_house: Node = get_tree().get_first_node_in_group("voss_house_controller")
	if voss_house != null and voss_house.has_method("get_codex_entries"):
		var voss_entries: Variant = voss_house.call("get_codex_entries")
		if typeof(voss_entries) == TYPE_DICTIONARY:
			entries.merge(voss_entries as Dictionary, true)

	var road_revealed: bool = TimelineManager != null and TimelineManager.has_consequence("road_to_orion_revealed")
	entries["river_road"] = {
		"title": "ESTRADA DO RIO",
		"body": "A porta da Casa Voss abriu-se para o vale. Tomás deixou um aviso claro: segue as pedras junto à água até ao Arco das Ruínas. A luz azul não é o destino; é apenas o sinal de que Orion voltou a observar.",
		"seen": road_revealed
	}
	_rebuild_entry_list()
	if selected_id != "" and _is_entry_unlocked(selected_id):
		_show_entry(selected_id)
	else:
		_show_first_unlocked_entry()

func run_qa_probe() -> void:
	refresh_entries()
	var unlocked: PackedStringArray = PackedStringArray()
	for entry_id: String in entry_order:
		if _is_entry_unlocked(entry_id):
			unlocked.append(entry_id)
	print("[ORIGEM_CODEX_QA] unlocked=%s selected=%s" % [",".join(unlocked), selected_id])

func _set_open(open: bool) -> void:
	is_open = open
	if root == null:
		return
	if is_open:
		refresh_entries()
		root.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		root.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _build_interface() -> void:
	root = Control.new()
	root.name = "EliasCodex"
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_STOP
	root.visible = false
	add_child(root)

	var shade: ColorRect = ColorRect.new()
	shade.color = Color(0.012, 0.016, 0.025, 0.90)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_child(shade)

	var margin: MarginContainer = MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 90)
	margin.add_theme_constant_override("margin_right", 90)
	margin.add_theme_constant_override("margin_top", 62)
	margin.add_theme_constant_override("margin_bottom", 62)
	root.add_child(margin)

	var panel: PanelContainer = PanelContainer.new()
	panel.custom_minimum_size = Vector2(960, 560)
	panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	panel.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	var panel_style: StyleBoxFlat = StyleBoxFlat.new()
	panel_style.bg_color = Color(0.055, 0.071, 0.085, 0.985)
	panel_style.border_color = Color(0.50, 0.40, 0.22, 0.90)
	panel_style.set_border_width_all(2)
	panel_style.corner_radius_top_left = 8
	panel_style.corner_radius_top_right = 8
	panel_style.corner_radius_bottom_left = 8
	panel_style.corner_radius_bottom_right = 8
	panel_style.shadow_color = Color(0.0, 0.0, 0.0, 0.6)
	panel_style.shadow_size = 24
	panel.add_theme_stylebox_override("panel", panel_style)
	margin.add_child(panel)

	var content_margin: MarginContainer = MarginContainer.new()
	content_margin.add_theme_constant_override("margin_left", 28)
	content_margin.add_theme_constant_override("margin_right", 28)
	content_margin.add_theme_constant_override("margin_top", 24)
	content_margin.add_theme_constant_override("margin_bottom", 24)
	panel.add_child(content_margin)

	var layout: VBoxContainer = VBoxContainer.new()
	layout.add_theme_constant_override("separation", 14)
	content_margin.add_child(layout)

	var header: HBoxContainer = HBoxContainer.new()
	layout.add_child(header)
	var heading: Label = Label.new()
	heading.text = "CÓDICE DE ELIAS"
	heading.add_theme_font_size_override("font_size", 30)
	heading.add_theme_color_override("font_color", Color(0.86, 0.72, 0.39, 1.0))
	heading.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(heading)
	progress_label = Label.new()
	progress_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	progress_label.add_theme_font_size_override("font_size", 15)
	progress_label.add_theme_color_override("font_color", Color(0.61, 0.72, 0.77, 1.0))
	header.add_child(progress_label)

	var divider: HSeparator = HSeparator.new()
	layout.add_child(divider)

	var columns: HBoxContainer = HBoxContainer.new()
	columns.size_flags_vertical = Control.SIZE_EXPAND_FILL
	columns.add_theme_constant_override("separation", 22)
	layout.add_child(columns)

	var list_panel: PanelContainer = PanelContainer.new()
	list_panel.custom_minimum_size = Vector2(288, 0)
	var list_style: StyleBoxFlat = StyleBoxFlat.new()
	list_style.bg_color = Color(0.030, 0.042, 0.052, 1.0)
	list_style.border_color = Color(0.24, 0.31, 0.34, 0.85)
	list_style.set_border_width_all(1)
	list_style.content_margin_left = 12
	list_style.content_margin_right = 12
	list_style.content_margin_top = 12
	list_style.content_margin_bottom = 12
	list_panel.add_theme_stylebox_override("panel", list_style)
	columns.add_child(list_panel)
	entry_list = VBoxContainer.new()
	entry_list.add_theme_constant_override("separation", 8)
	list_panel.add_child(entry_list)

	var article_panel: PanelContainer = PanelContainer.new()
	article_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var article_style: StyleBoxFlat = StyleBoxFlat.new()
	article_style.bg_color = Color(0.070, 0.085, 0.091, 1.0)
	article_style.border_color = Color(0.24, 0.31, 0.34, 0.85)
	article_style.set_border_width_all(1)
	article_style.content_margin_left = 26
	article_style.content_margin_right = 26
	article_style.content_margin_top = 22
	article_style.content_margin_bottom = 22
	article_panel.add_theme_stylebox_override("panel", article_style)
	columns.add_child(article_panel)
	var article: VBoxContainer = VBoxContainer.new()
	article.add_theme_constant_override("separation", 18)
	article_panel.add_child(article)
	title_label = Label.new()
	title_label.add_theme_font_size_override("font_size", 24)
	title_label.add_theme_color_override("font_color", Color(0.90, 0.78, 0.48, 1.0))
	article.add_child(title_label)
	body_label = Label.new()
	body_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body_label.add_theme_font_size_override("font_size", 19)
	body_label.add_theme_color_override("font_color", Color(0.84, 0.88, 0.88, 1.0))
	article.add_child(body_label)

	hint_label = Label.new()
	hint_label.text = "[J] Fechar códice     [Esc] Fechar"
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	hint_label.add_theme_font_size_override("font_size", 14)
	hint_label.add_theme_color_override("font_color", Color(0.55, 0.63, 0.66, 1.0))
	layout.add_child(hint_label)

func _rebuild_entry_list() -> void:
	if entry_list == null:
		return
	for child: Node in entry_list.get_children():
		child.queue_free()
	var unlocked_count: int = 0
	for entry_id: String in entry_order:
		if _is_entry_unlocked(entry_id):
			unlocked_count += 1
	progress_label.text = "%d / %d MEMÓRIAS" % [unlocked_count, entry_order.size()]
	for entry_id: String in entry_order:
		var entry_data: Dictionary = entries.get(entry_id, {}) as Dictionary
		var button: Button = Button.new()
		button.custom_minimum_size = Vector2(0, 54)
		button.text = str(entry_data.get("title", "MEMÓRIA SELADA")) if _is_entry_unlocked(entry_id) else "MEMÓRIA SELADA"
		button.disabled = not _is_entry_unlocked(entry_id)
		button.tooltip_text = "Ainda não descoberta" if button.disabled else "Ler entrada"
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		button.pressed.connect(_show_entry.bind(entry_id))
		entry_list.add_child(button)

func _show_first_unlocked_entry() -> void:
	for entry_id: String in entry_order:
		if _is_entry_unlocked(entry_id):
			_show_entry(entry_id)
			return
	selected_id = ""
	title_label.text = "CADERNO EM BRANCO"
	body_label.text = "Elias ainda não registou nenhuma memória. Procura sinais dentro da Casa Voss antes de seguir para o vale."

func _show_entry(entry_id: String) -> void:
	if not _is_entry_unlocked(entry_id):
		return
	var entry_data: Dictionary = entries.get(entry_id, {}) as Dictionary
	selected_id = entry_id
	title_label.text = str(entry_data.get("title", "MEMÓRIA"))
	body_label.text = str(entry_data.get("body", ""))

func _is_entry_unlocked(entry_id: String) -> bool:
	var entry_data: Dictionary = entries.get(entry_id, {}) as Dictionary
	return bool(entry_data.get("seen", false))

func _on_game_loaded() -> void:
	refresh_entries()

func _on_timeline_event(event_id: String, _era: String) -> void:
	if event_id == "voss_door_opened":
		refresh_entries()
