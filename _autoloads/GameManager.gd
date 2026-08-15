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
	# Liga-se ao EventBus para ouvir eventos globais
	EventBus.game_paused.connect(_on_game_paused)

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
	EventBus.timeline_era_changed.emit(from_era, to_era)

## Retorna o nome da era atual como String.
func get_current_era_name() -> String:
	return GameEra.keys()[current_era]

## Pausa ou retoma o jogo.
func toggle_pause() -> void:
	is_paused = !is_paused
	EventBus.game_paused.emit(is_paused)

# ============================================================
# FUNÇÕES PRIVADAS
# ============================================================

func _process(delta: float) -> void:
	# Conta o tempo de jogo apenas quando a explorar
	if current_state == GameState.EXPLORING:
		play_time += delta

func _on_game_paused(paused: bool) -> void:
	get_tree().paused = paused
