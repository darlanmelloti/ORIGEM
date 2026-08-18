## GameManager.gd
## Gestor de estado global do jogo. Controla a fase atual, o modo de jogo
## e serve como ponto central de acesso ao estado da sessão.
## Parte do módulo: Core / Framework

extends Node

# ============================================================
# ENUMERAÇÕES
# ============================================================

## Fases da narrativa principal do jogo ORIGEM.
enum GameEra {
	PREHISTORIC,    # Era Pré-histórica
	ANCIENT,        # Antiguidade (Egito, Grécia, Roma)
	MEDIEVAL,       # Era Medieval
	INDUSTRIAL,     # Revolução Industrial
	MODERN,         # Era Moderna
	FUTURE          # Futuro
}

## Modos de estado do jogo.
enum GameState {
	MAIN_MENU,
	EXPLORING,
	IN_DIALOGUE,
	IN_COMBAT,
	IN_INVENTORY,
	CUTSCENE,
	PAUSED,
	LOADING,
	GAME_OVER
}

# ============================================================
# VARIÁVEIS DE ESTADO
# ============================================================

## Era atual em que o jogador se encontra.
var current_era: GameEra = GameEra.PREHISTORIC

## Estado atual do jogo.
var current_state: GameState = GameState.MAIN_MENU

## Nome do jogador (definido na criação do personagem).
var player_name: String = "Explorador"

## Tempo total de jogo em segundos.
var play_time: float = 0.0

## Indica se o jogo está em pausa.
var is_paused: bool = false

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

func _ready() -> void:
	# O caminho explícito em project.godot garante a criação de EventBus. A guarda evita encerrar o jogo caso um projecto recém-extraído ainda esteja a reconstruir autoloads.
	var event_bus: Node = get_node_or_null("/root/EventBus")
	if event_bus != null and event_bus.has_signal("game_paused"):
		event_bus.connect("game_paused", Callable(self, "_on_game_paused"))
	else:
		push_warning("EventBus indisponível durante a inicialização; o GameManager continuará sem o sinal de pausa até ao próximo arranque.")

## Muda o estado atual do jogo e notifica os sistemas.
func change_state(new_state: GameState) -> void:
	current_state = new_state
	# Pausa o motor de física quando em menus ou diálogos
	get_tree().paused = new_state in [GameState.PAUSED, GameState.IN_DIALOGUE, GameState.MAIN_MENU]

## Muda a era temporal e emite o evento correspondente.
func change_era(new_era: GameEra) -> void:
	var from_era: String = GameEra.keys()[current_era]
	var to_era: String = GameEra.keys()[new_era]
	current_era = new_era
	var event_bus: Node = get_node_or_null("/root/EventBus")
	if event_bus != null and event_bus.has_signal("timeline_era_changed"):
		event_bus.emit_signal("timeline_era_changed", from_era, to_era)

## Retorna o nome da era atual como String.
func get_current_era_name() -> String:
	return GameEra.keys()[current_era]

## Pausa ou retoma o jogo.
func toggle_pause() -> void:
	is_paused = !is_paused
	var event_bus: Node = get_node_or_null("/root/EventBus")
	if event_bus != null and event_bus.has_signal("game_paused"):
		event_bus.emit_signal("game_paused", is_paused)
	else:
		_on_game_paused(is_paused)

# ============================================================
# FUNÇÕES PRIVADAS
# ============================================================

func _process(delta: float) -> void:
	# Conta o tempo de jogo apenas quando a explorar
	if current_state == GameState.EXPLORING:
		play_time += delta

func _on_game_paused(paused: bool) -> void:
	get_tree().paused = paused
