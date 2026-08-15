## TimelineManager.gd
## Gestor do sistema de Timeline do ORIGEM.
## Controla as eras temporais, as consequências das ações do jogador
## e os eventos que afetam o passado/futuro da narrativa.
## Deve ser registado como Autoload: Projeto > Globais > Carregamento Automático
## Parte do módulo: Core / Timeline


extends Node

# ============================================================
# ENUMERAÇÕES
# ============================================================

## Eras temporais disponíveis no ORIGEM
enum Era {
	PREHISTORIC,   # ~47.000 a.C. — Origem da humanidade P-0
	ANCIENT,       # ~3.000 a.C. — Egito, Suméria, Atlântida
	MEDIEVAL,      # ~1.200 d.C. — Cruzadas, manuscritos ocultos
	MODERN,        # 2026 d.C. — Lisboa, ponto de partida
	FUTURE_47K,    # +47.000 — Terra devastada, P-47 no subsolo
	FUTURE_52K,    # +52.000 — Origem de Seraph, civilização P-52
}

# ============================================================
# ESTADO
# ============================================================

var current_era: Era = Era.MODERN
var visited_eras: Array[Era] = [Era.MODERN]

## Registo de eventos temporais e as suas consequências
## { event_id: { era, description, consequence, triggered: bool } }
var timeline_events: Dictionary = {}

## Consequências ativas que afetam o mundo atual
var active_consequences: Array[String] = []

# ============================================================
# CICLO DE VIDA
# ============================================================

func _ready() -> void:
	_register_base_events()
	EventBus.timeline_era_changed.connect(_on_era_changed)
	EventBus.timeline_event_triggered.connect(_on_event_triggered)

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

## Viaja para uma nova era temporal.
func travel_to_era(new_era: Era) -> void:
	if new_era == current_era:
		return
	var from_name: String = Era.keys()[current_era]
	var to_name: String = Era.keys()[new_era]
	current_era = new_era
	if new_era not in visited_eras:
		visited_eras.append(new_era)
	EventBus.timeline_era_changed.emit(from_name, to_name)
	print("[TimelineManager] Viagem temporal: %s → %s" % [from_name, to_name])

## Regista um evento temporal com consequências.
func trigger_event(event_id: String) -> void:
	if not timeline_events.has(event_id):
		push_warning("[TimelineManager] Evento não encontrado: " + event_id)
		return
	var event: Dictionary = timeline_events[event_id]
	if event.get("triggered", false):
		return
	event["triggered"] = true
	var era_name: String = Era.keys()[current_era]
	EventBus.timeline_event_triggered.emit(event_id, era_name)
	# Aplica consequência
	var consequence: String = event.get("consequence", "")
	if consequence != "" and consequence not in active_consequences:
		active_consequences.append(consequence)
	print("[TimelineManager] Evento temporal: %s | Consequência: %s" % [event_id, consequence])

## Verifica se uma consequência temporal está ativa.
func has_consequence(consequence_id: String) -> bool:
	return consequence_id in active_consequences

## Retorna o nome da era atual como String legível.
func get_current_era_name() -> String:
	match current_era:
		Era.PREHISTORIC: return "Pré-histórico (~47.000 a.C.)"
		Era.ANCIENT: return "Antiguidade (~3.000 a.C.)"
		Era.MEDIEVAL: return "Medieval (~1.200 d.C.)"
		Era.MODERN: return "Moderno (2026 d.C.)"
		Era.FUTURE_47K: return "Futuro (+47.000)"
		Era.FUTURE_52K: return "Futuro Distante (+52.000)"
	return "Desconhecido"

# ============================================================
# SAVE / LOAD
# ============================================================

func save_data() -> Dictionary:
	return {
		"current_era": current_era,
		"visited_eras": visited_eras.duplicate(),
		"active_consequences": active_consequences.duplicate(),
		"timeline_events": timeline_events.duplicate(true)
	}

func load_data(data: Dictionary) -> void:
	current_era = data.get("current_era", Era.MODERN)
	visited_eras = data.get("visited_eras", [Era.MODERN])
	active_consequences = data.get("active_consequences", [])
	timeline_events = data.get("timeline_events", {})

# ============================================================
# EVENTOS BASE DO ORIGEM
# ============================================================

func _register_base_events() -> void:
	timeline_events = {
		"orion_cube_activated": {
			"era": Era.MODERN,
			"description": "O Cubo de Orion foi ativado por Elias Voss em 2026.",
			"consequence": "temporal_window_open",
			"triggered": false
		},
		"tablets_united": {
			"era": Era.MODERN,
			"description": "Os três fragmentos de tradução foram reunidos.",
			"consequence": "p47_alerted",
			"triggered": false
		},
		"guardian_defeated": {
			"era": Era.MODERN,
			"description": "O Guardião P-47 foi neutralizado.",
			"consequence": "p47_retreat",
			"triggered": false
		},
	}

# ============================================================
# CALLBACKS DO EVENTBUS
# ============================================================

func _on_era_changed(from_era: String, to_era: String) -> void:
	print("[TimelineManager] Era alterada: %s → %s" % [from_era, to_era])

func _on_event_triggered(event_id: String, era: String) -> void:
	print("[TimelineManager] Evento '%s' na era '%s'" % [event_id, era])
