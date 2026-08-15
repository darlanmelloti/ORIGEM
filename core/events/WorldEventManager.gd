extends Node

signal world_event_triggered(event_id: String)

var active_events: Dictionary = {}

func trigger_event(event_id: String, payload: Dictionary = {}) -> void:
	active_events[event_id] = payload
	world_event_triggered.emit(event_id)
	print("[WorldEventManager] Evento disparado: %s" % event_id)

func clear_event(event_id: String) -> void:
	if active_events.has(event_id):
		active_events.erase(event_id)

func has_event(event_id: String) -> bool:
	return active_events.has(event_id)
