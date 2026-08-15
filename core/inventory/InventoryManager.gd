## InventoryManager.gd
## Gestor central do inventário do jogador.
## Gere a adição, remoção e consulta de itens.
## Deve ser registado como Autoload: Projeto > Globais > Carregamento Automático
## Parte do módulo: Core / Inventory


extends Node

# ============================================================
# ESTADO DO INVENTÁRIO
# ============================================================

## Dicionário: { item_id: String -> quantidade: int }
var items: Dictionary = {}

## Itens especiais de missão (tábuas, fragmentos) guardados separadamente
var key_items: Array[String] = []

# ============================================================
# CICLO DE VIDA
# ============================================================

func _ready() -> void:
	# Ouve o EventBus para adicionar itens automaticamente
	EventBus.item_added.connect(_on_item_added)
	EventBus.item_removed.connect(_on_item_removed)

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

## Adiciona um item ao inventário pelo seu ID.
func add_item(item_id: String, quantity: int = 1) -> void:
	if items.has(item_id):
		items[item_id] += quantity
	else:
		items[item_id] = quantity
	EventBus.item_added.emit(item_id)
	print("[InventoryManager] Adicionado: %s x%d" % [item_id, quantity])

## Remove um item do inventário. Retorna true se bem-sucedido.
func remove_item(item_id: String, quantity: int = 1) -> bool:
	if not has_item(item_id, quantity):
		return false
	items[item_id] -= quantity
	if items[item_id] <= 0:
		items.erase(item_id)
	EventBus.item_removed.emit(item_id)
	return true

## Verifica se o inventário tem um item em quantidade suficiente.
func has_item(item_id: String, quantity: int = 1) -> bool:
	return items.get(item_id, 0) >= quantity

## Retorna a quantidade de um item no inventário.
func get_quantity(item_id: String) -> int:
	return items.get(item_id, 0)

## Adiciona um item de missão (key item) — não empilhável, não descartável.
func add_key_item(item_id: String) -> void:
	if item_id not in key_items:
		key_items.append(item_id)
		EventBus.item_added.emit(item_id)
		print("[InventoryManager] Key item adicionado: %s" % item_id)

## Verifica se o jogador tem um key item específico.
func has_key_item(item_id: String) -> bool:
	return item_id in key_items

## Retorna o número total de key items recolhidos.
func get_key_item_count() -> int:
	return key_items.size()

## Limpa todo o inventário (usado no game over / novo jogo).
func clear() -> void:
	items.clear()
	key_items.clear()

## Retorna os dados do inventário para o sistema de Save.
func save_data() -> Dictionary:
	return {
		"items": items.duplicate(),
		"key_items": key_items.duplicate()
	}

## Restaura o inventário a partir dos dados de Save.
func load_data(data: Dictionary) -> void:
	items = data.get("items", {})
	key_items = data.get("key_items", [])

# ============================================================
# CALLBACKS DO EVENTBUS
# ============================================================

func _on_item_added(_item_id: String) -> void:
	pass  # Pode ser usado para atualizar a UI

func _on_item_removed(_item_id: String) -> void:
	pass  # Pode ser usado para atualizar a UI
