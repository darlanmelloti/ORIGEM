## TimelineManager.gd
## Núcleo Chronos: estado temporal, consequências narrativas e perfis atmosféricos modulares.

extends Node

enum Era {
	PREHISTORIC, # ~47.000 a.C. — origem P-0
	ANCIENT, # ~3.000 a.C. — Egito e templos de P-0
	MEDIEVAL, # ~1.200 d.C. — manuscritos e rotas ocultas
	MODERN, # 2026 d.C. — Vale de Kheper
	FUTURE_47K, # +47.000 — colapso P-47
	FUTURE_52K, # +52.000 — metrópole P-52
}

var current_era: Era = Era.MODERN
var visited_eras: Array[Era] = [Era.MODERN]
var timeline_events: Dictionary = {}
var active_consequences: Array[String] = []
var chronos_profiles: Dictionary = {}
var active_profile_id: String = "KHEPER_TWILIGHT"

func _ready() -> void:
	add_to_group("Persist")
	_register_chronos_profiles()
	_register_base_events()
	EventBus.timeline_era_changed.connect(_on_era_changed)
	EventBus.timeline_event_triggered.connect(_on_event_triggered)
	call_deferred("emit_active_profile")

## Aplica uma viagem lógica e emite o perfil visual correspondente.
func travel_to_era(new_era: Era) -> void:
	if new_era == current_era:
		return
	var from_name: String = Era.keys()[current_era]
	var to_name: String = Era.keys()[new_era]
	current_era = new_era
	if new_era not in visited_eras:
		visited_eras.append(new_era)
	EventBus.timeline_era_changed.emit(from_name, to_name)
	apply_profile(_profile_for_era(new_era))
	print("[Chronos] Viagem temporal: %s → %s" % [from_name, to_name])

## Aplicação visual independente da troca de cena. As futuras eras usarão este mesmo contrato.
func apply_profile(profile_id: String) -> bool:
	if not chronos_profiles.has(profile_id):
		push_warning("[Chronos] Perfil inexistente: " + profile_id)
		return false
	if profile_id == active_profile_id:
		emit_active_profile()
		return true
	var previous_profile: String = active_profile_id
	active_profile_id = profile_id
	EventBus.chronos_transition_started.emit(previous_profile, active_profile_id)
	emit_active_profile()
	return true

func emit_active_profile() -> void:
	if chronos_profiles.has(active_profile_id):
		EventBus.chronos_profile_changed.emit(active_profile_id, get_active_profile())

func get_active_profile() -> Dictionary:
	return chronos_profiles.get(active_profile_id, {}).duplicate(true)

func get_profile(profile_id: String) -> Dictionary:
	return chronos_profiles.get(profile_id, {}).duplicate(true)

func get_current_era_name() -> String:
	match current_era:
		Era.PREHISTORIC: return "Pré-histórico (~47.000 a.C.)"
		Era.ANCIENT: return "Antiguidade (~3.000 a.C.)"
		Era.MEDIEVAL: return "Medieval (~1.200 d.C.)"
		Era.MODERN: return "Moderno (2026 d.C.)"
		Era.FUTURE_47K: return "Futuro (+47.000)"
		Era.FUTURE_52K: return "Futuro Distante (+52.000)"
	return "Desconhecido"

func trigger_event(event_id: String) -> void:
	if not timeline_events.has(event_id):
		push_warning("[TimelineManager] Evento não encontrado: " + event_id)
		return
	var event: Dictionary = timeline_events[event_id]
	if event.get("triggered", false):
		return
	event["triggered"] = true
	timeline_events[event_id] = event
	var era_name: String = Era.keys()[current_era]
	EventBus.timeline_event_triggered.emit(event_id, era_name)
	var consequence: String = event.get("consequence", "")
	if consequence != "" and consequence not in active_consequences:
		active_consequences.append(consequence)

func has_consequence(consequence_id: String) -> bool:
	return consequence_id in active_consequences

func save_data() -> Dictionary:
	return {
		"current_era": current_era,
		"visited_eras": visited_eras.duplicate(),
		"active_consequences": active_consequences.duplicate(),
		"timeline_events": timeline_events.duplicate(true),
		"active_profile_id": active_profile_id,
	}

func load_data(data: Dictionary) -> void:
	current_era = data.get("current_era", Era.MODERN)
	visited_eras = data.get("visited_eras", [Era.MODERN])
	active_consequences = data.get("active_consequences", [])
	timeline_events = data.get("timeline_events", {})
	active_profile_id = data.get("active_profile_id", _profile_for_era(current_era))
	emit_active_profile()

func _profile_for_era(era: Era) -> String:
	match era:
		Era.PREHISTORIC: return "PRIMAL_NIGHT"
		Era.ANCIENT: return "EGYPT_SUN"
		Era.MEDIEVAL: return "ASHEN_TWILIGHT"
		Era.MODERN: return "KHEPER_TWILIGHT"
		Era.FUTURE_47K: return "FUTURE_ASH"
		Era.FUTURE_52K: return "NEW_YORK_100K"
	return "KHEPER_TWILIGHT"

func _register_chronos_profiles() -> void:
	chronos_profiles = {
		"KHEPER_TWILIGHT": {
			"display_name": "Vale de Kheper — Crepúsculo",
			"sky_top": Color(0.055, 0.10, 0.18),
			"sky_horizon": Color(0.33, 0.40, 0.43),
			"ambient": Color(0.24, 0.30, 0.32),
			"ambient_energy": 0.48,
			"sun_color": Color(0.82, 0.74, 0.59),
			"sun_energy": 0.92,
			"fog_color": Color(0.26, 0.33, 0.39),
			"fog_density": 0.0028,
			"saturation": 0.74,
		},
		"EGYPT_SUN": {
			"display_name": "Egito Antigo — Sol do Vale dos Reis",
			"sky_top": Color(0.17, 0.42, 0.72),
			"sky_horizon": Color(0.92, 0.63, 0.30),
			"ambient": Color(0.62, 0.42, 0.20),
			"ambient_energy": 0.74,
			"sun_color": Color(1.0, 0.74, 0.36),
			"sun_energy": 1.28,
			"fog_color": Color(0.78, 0.49, 0.23),
			"fog_density": 0.0018,
			"saturation": 0.92,
		},
		"NEW_YORK_100K": {
			"display_name": "Nova Iorque 100.000 DC — Selva P-52",
			"sky_top": Color(0.025, 0.06, 0.10),
			"sky_horizon": Color(0.10, 0.28, 0.20),
			"ambient": Color(0.08, 0.20, 0.17),
			"ambient_energy": 0.55,
			"sun_color": Color(0.36, 0.72, 0.62),
			"sun_energy": 0.76,
			"fog_color": Color(0.08, 0.24, 0.16),
			"fog_density": 0.0044,
			"saturation": 0.68,
		},
		"PRIMAL_NIGHT": {
			"display_name": "Origem P-0 — Noite Primordial",
			"sky_top": Color(0.018, 0.028, 0.065),
			"sky_horizon": Color(0.10, 0.08, 0.16),
			"ambient": Color(0.08, 0.09, 0.16),
			"ambient_energy": 0.30,
			"sun_color": Color(0.36, 0.44, 0.76),
			"sun_energy": 0.42,
			"fog_color": Color(0.07, 0.08, 0.16),
			"fog_density": 0.0038,
			"saturation": 0.58,
		},
		"ASHEN_TWILIGHT": {
			"display_name": "Era Medieval — Crepúsculo de Cinzas",
			"sky_top": Color(0.10, 0.07, 0.09),
			"sky_horizon": Color(0.32, 0.20, 0.17),
			"ambient": Color(0.20, 0.15, 0.14),
			"ambient_energy": 0.46,
			"sun_color": Color(0.70, 0.38, 0.22),
			"sun_energy": 0.70,
			"fog_color": Color(0.23, 0.17, 0.16),
			"fog_density": 0.0036,
			"saturation": 0.52,
		},
		"FUTURE_ASH": {
			"display_name": "Futuro +47.000 — Cinza e Ruína",
			"sky_top": Color(0.025, 0.035, 0.040),
			"sky_horizon": Color(0.17, 0.18, 0.18),
			"ambient": Color(0.14, 0.15, 0.15),
			"ambient_energy": 0.40,
			"sun_color": Color(0.52, 0.50, 0.44),
			"sun_energy": 0.56,
			"fog_color": Color(0.19, 0.20, 0.19),
			"fog_density": 0.0048,
			"saturation": 0.26,
		},
	}

func _register_base_events() -> void:
	timeline_events = {
		"orion_cube_activated": {"era": Era.MODERN, "description": "O Cubo de Orion foi ativado.", "consequence": "temporal_window_open", "triggered": false},
		"tablets_united": {"era": Era.MODERN, "description": "Os três fragmentos foram reunidos.", "consequence": "chronos_key_awake", "triggered": false},
		"captain_kharu_defeated": {"era": Era.MODERN, "description": "O Sentinela Kharu caiu no Santuário da Nascente.", "consequence": "sanctuary_unsealed", "triggered": false},
		"voss_door_opened": {"era": Era.MODERN, "description": "Elias abriu a porta E da Casa Voss e revelou a Estrada do Rio.", "consequence": "road_to_orion_revealed", "triggered": false},
	}

func _on_era_changed(from_era: String, to_era: String) -> void:
	print("[Chronos] Era alterada: %s → %s" % [from_era, to_era])

func _on_event_triggered(event_id: String, era: String) -> void:
	print("[Chronos] Evento '%s' na era '%s'" % [event_id, era])
