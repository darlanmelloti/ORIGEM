## InventoryUI.gd
## Interface do inventário do jogador — itens normais e fragmentos de missão.
extends Control

@onready var title_label: Label = $Background/VBoxContainer/TitleLabel
@onready var items_grid: GridContainer = $Background/VBoxContainer/ScrollContainer/ItemsGrid
@onready var key_items_list: VBoxContainer = $Background/VBoxContainer/KeyItemsSection/KeyItemsList
@onready var close_button: Button = $Background/VBoxContainer/CloseButton

var _is_open: bool = false

# ═══════════════════════════════════════════════════════════════
func _ready() -> void:
	visible = false
	close_button.pressed.connect(_close)
	EventBus.item_added.connect(_on_inventory_changed)
	EventBus.item_removed.connect(_on_inventory_changed)
	_refresh()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		toggle()
		get_viewport().set_input_as_handled()

# ─── VISIBILIDADE ─────────────────────────────────────────────
func toggle() -> void:
	if _is_open:
		_close()
	else:
		_open()

func _open() -> void:
	_is_open = true
	visible = true
	_refresh()
	EventBus.inventory_toggled.emit(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _close() -> void:
	_is_open = false
	visible = false
	EventBus.inventory_toggled.emit(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# ─── CONTEÚDO ─────────────────────────────────────────────────
func _refresh() -> void:
	_clear_container(items_grid)
	_clear_container(key_items_list)

	for item_id in InventoryManager.items:
		var qty: int = InventoryManager.items[item_id]
		var label := Label.new()
		label.text = "%s  x%d" % [item_id, qty]
		items_grid.add_child(label)

	for key_id in InventoryManager.key_items:
		var label := Label.new()
		label.text = "• %s" % key_id
		key_items_list.add_child(label)

	if InventoryManager.key_items.is_empty():
		var empty := Label.new()
		empty.text = "(nenhum)"
		key_items_list.add_child(empty)

func _clear_container(container: Node) -> void:
	for child in container.get_children():
		child.queue_free()

func _on_inventory_changed(_item_id = null) -> void:
	if _is_open:
		_refresh()
