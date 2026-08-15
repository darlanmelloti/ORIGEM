## HealthComponent.gd
## Componente reutilizável de vida e dano.
## Pode ser adicionado ao Jogador, NPCs ou Inimigos sem alterar o código deles.
## Parte do módulo: Components

class_name HealthComponent
extends Node

# ============================================================
# SINAIS
# ============================================================

## Emitido quando a vida muda.
signal health_changed(current_health: int, max_health: int)

## Emitido quando a entidade morre.
signal died()

# ============================================================
# PROPRIEDADES EXPORTADAS (editáveis no Inspector do Godot)
# ============================================================

@export var max_health: int = 100
@export var is_invincible: bool = false

# ============================================================
# VARIÁVEIS INTERNAS
# ============================================================

var current_health: int

# ============================================================
# CICLO DE VIDA
# ============================================================

func _ready() -> void:
	current_health = max_health

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

## Aplica dano à entidade. Ignora se for invencível.
func take_damage(amount: int) -> void:
	if is_invincible:
		return

	current_health = clamp(current_health - amount, 0, max_health)
	health_changed.emit(current_health, max_health)

	if current_health <= 0:
		_die()

## Cura a entidade pelo valor indicado.
func heal(amount: int) -> void:
	current_health = clamp(current_health + amount, 0, max_health)
	health_changed.emit(current_health, max_health)

## Retorna a percentagem de vida atual (0.0 a 1.0).
func get_health_percent() -> float:
	return float(current_health) / float(max_health)

## Verifica se a entidade está viva.
func is_alive() -> bool:
	return current_health > 0

# ============================================================
# FUNÇÕES PRIVADAS
# ============================================================

func _die() -> void:
	died.emit()
