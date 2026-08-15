## ItemData.gd
## Define a estrutura de dados de um item do jogo ORIGEM.
## Usar como Custom Resource (.tres) para criar itens no Inspector do Godot.
## Parte do módulo: Core / Inventory

class_name ItemData
extends Resource

# ============================================================
# ENUMERAÇÕES
# ============================================================

enum ItemType {
	ARTIFACT,     # Artefacto arqueológico
	WEAPON,       # Arma
	ARMOR,        # Armadura
	CONSUMABLE,   # Consumível (poção, comida)
	KEY_ITEM,     # Item de missão (não pode ser descartado)
	DOCUMENT      # Documento, mapa, pergaminho
}

# ============================================================
# PROPRIEDADES EXPORTADAS
# ============================================================

@export var id: String = ""
@export var display_name: String = ""
@export var description: String = ""
@export var item_type: ItemType = ItemType.ARTIFACT
@export var icon: Texture2D
@export var is_stackable: bool = false
@export var max_stack_size: int = 1
@export var is_droppable: bool = true

## Era temporal de origem do item (usado pelo sistema de Timeline).
@export var origin_era: String = ""

## Valor arqueológico/histórico do item (usado em missões e diálogos).
@export var historical_value: int = 0
