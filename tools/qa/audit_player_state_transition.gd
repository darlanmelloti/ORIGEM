extends Node

# QA-STATE-01: base de telemetria para a futura prova de retorno Orion.
# Não altera Player.gd nem o estado guardado; apenas serializa o estado observável de Elias.

func capture_player_state(label: String) -> Dictionary:
	var players := get_tree().get_nodes_in_group("player")
	if players.is_empty() or not (players[0] is CharacterBody3D):
		push_error("[QA-STATE-01] player_missing label=%s" % label)
		return {}
	var elias := players[0] as CharacterBody3D
	var state := {
		"label": label,
		"position": [elias.global_position.x, elias.global_position.y, elias.global_position.z],
		"rotation_y": elias.global_rotation.y,
		"health": elias.get("current_health"),
		"stamina": elias.get("current_stamina"),
	}
	print("[QA-STATE-01] %s" % JSON.stringify(state))
	return state
