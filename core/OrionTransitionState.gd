## OrionTransitionState.gd
## Estado mínimo e transitório para a passagem física Garganta Orion <-> Orion Interior.

extends Node

const EXTERIOR_SCENE: String = "res://scenes/main.tscn"
const INTERIOR_SCENE: String = "res://scenes/orion_interior.tscn"
# O centro do CharacterBody fica acima do piso da soleira; 0,18 deixava a câmara enterrada ao abrir a cena directamente.
const INTERIOR_SPAWN: Vector3 = Vector3(0.0, 0.90, 0.45)
const EXTERIOR_RETURN: Vector3 = Vector3(-116.0, 0.0, 552.2)

var _has_return_state: bool = false
var _return_position: Vector3 = EXTERIOR_RETURN
var _return_rotation_y: float = PI
var _saved_health: int = 100
var _saved_stamina: float = 100.0

func begin_entry(player: Node3D) -> void:
	_has_return_state = true
	_return_position = player.global_position
	_return_rotation_y = player.rotation.y
	_capture_player_state(player)
	get_tree().change_scene_to_file(INTERIOR_SCENE)

func begin_return(player: Node3D) -> void:
	_capture_player_state(player)
	get_tree().change_scene_to_file(EXTERIOR_SCENE)

func restore_interior_player(player: Node3D) -> void:
	player.global_position = INTERIOR_SPAWN
	# A captura CP-CINE-61 confirmou que o eixo oeste enquadra o arco navegável com maior clareza desde a soleira.
	player.look_at(Vector3(-1.55, player.global_position.y, 5.30), Vector3.UP)
	_restore_player_state(player)
	EventBus.player_message_requested.emit("A garganta fecha-se atrás de Elias.", 1.8)

func restore_exterior_player(player: Node3D) -> void:
	if _has_return_state:
		player.global_position = _return_position
		player.rotation.y = _return_rotation_y
	else:
		player.global_position = EXTERIOR_RETURN
	_restore_player_state(player)
	_has_return_state = false
	EventBus.player_message_requested.emit("Elias regressa à garganta Orion.", 1.8)

func _capture_player_state(player: Node3D) -> void:
	if player is Player:
		var elias: Player = player as Player
		_saved_health = elias.current_health
		_saved_stamina = elias.current_stamina

func _restore_player_state(player: Node3D) -> void:
	if player is Player:
		var elias: Player = player as Player
		elias.current_health = _saved_health
		elias.current_stamina = _saved_stamina
		EventBus.player_health_changed.emit(elias.current_health, elias.MAX_HEALTH)
		EventBus.player_stamina_changed.emit(elias.current_stamina, elias.MAX_STAMINA)
