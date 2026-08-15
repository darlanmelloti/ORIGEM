## InteractableComponent.gd
## Componente que torna qualquer objeto interativo (arqueologia, itens, NPCs, portas).
## Adicionar este nó (Area3D) a qualquer objeto para torná-lo interagível.
## Parte do módulo: Components / Interaction

class_name InteractableComponent
extends Area3D

# ============================================================
# SINAIS
# ============================================================

## Emitido quando o jogador interage com este objeto.
signal interacted(interactor: Node)

## Emitido quando o jogador entra na zona de interação.
signal player_entered()

## Emitido quando o jogador sai da zona de interação.
signal player_exited()

# ============================================================
# PROPRIEDADES EXPORTADAS
# ============================================================

@export var interaction_prompt: String = "Interagir"
@export var is_enabled: bool = true

# ============================================================
# VARIÁVEIS INTERNAS
# ============================================================

var _player_in_range: bool = false
var _player_ref: Node = null

# ============================================================
# CICLO DE VIDA
# ============================================================

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _unhandled_input(event: InputEvent) -> void:
	if not is_enabled or not _player_in_range:
		return
	if event.is_action_pressed("interact"):
		interacted.emit(_player_ref)

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

## Ativa ou desativa este interagível.
func set_enabled(enabled: bool) -> void:
	is_enabled = enabled

# ============================================================
# FUNÇÕES PRIVADAS
# ============================================================

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		_player_in_range = true
		_player_ref = body
		player_entered.emit()

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		_player_in_range = false
		_player_ref = null
		player_exited.emit()
