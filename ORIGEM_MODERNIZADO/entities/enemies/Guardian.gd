## Guardian.gd
## IA do Guardião P-47 — patrulha, deteção e perseguição do jogador.
## Comunica com outros sistemas via EventBus.
class_name Guardian
extends CharacterBody3D

# O NavigationRegion3D da cena principal precisa de ser configurado manualmente no editor Godot
# (com o bake da malha de navegação) para que o NavigationAgent3D funcione corretamente.
enum GuardianState { PATROL, ALERT, CHASE, STUNNED, RETURN }

@onready var eyes: OmniLight3D = $Eyes
@onready var nav: NavigationAgent3D = $NavAgent

var guardian_state: GuardianState = GuardianState.PATROL
var guardian_patrol_pts: Array = []
var guardian_patrol_idx: int = 0
var guardian_home: Vector3
var guardian_stun_timer: float = 0.0

var _player: Player

# ═══════════════════════════════════════════════════════════════
func _ready() -> void:
	guardian_home = global_position
	_setup_guardian_patrol()
	_player = get_tree().get_first_node_in_group("player") as Player
	EventBus.guardian_chase_forced.connect(_on_chase_forced)

func _physics_process(delta: float) -> void:
	_handle_guardian(delta)

# ─── IA ───────────────────────────────────────────────────────
func _handle_guardian(delta: float) -> void:
	if _player == null:
		return

	var dist = global_position.distance_to(_player.global_position)
	var player_moving = _player.velocity.length() > 0.3
	var flashlight_on: bool = _player.flashlight_on
	var is_sprinting: bool = _player.is_sprinting

	if guardian_state == GuardianState.STUNNED:
		guardian_stun_timer -= delta
		eyes.light_color = Color(0.5, 0.5, 0.5, 1)
		if guardian_stun_timer <= 0:
			guardian_state = GuardianState.RETURN
		return

	match guardian_state:
		GuardianState.PATROL:
			_guardian_patrol()
			eyes.light_color = Color(0.15, 0.7, 0.5, 1)
			eyes.light_energy = 0.4
			var hear_range = 13.0 if is_sprinting else 6.0
			if dist < hear_range and player_moving:
				guardian_state = GuardianState.ALERT
				EventBus.guardian_alert.emit("O Guardião detectou movimento...", 2.0)
			if dist < (10.0 + (7.0 if flashlight_on else 0.0)):
				guardian_state = GuardianState.CHASE
				EventBus.guardian_alert.emit("O Guardião viu-te! FOGE!", 2.5)

		GuardianState.ALERT:
			eyes.light_color = Color(0.9, 0.7, 0.1, 1)
			eyes.light_energy = 0.8
			nav.set_target_position(_player.global_position)
			_guardian_move(2.2)
			if dist < 8.0:
				guardian_state = GuardianState.CHASE
			if dist > 18.0:
				guardian_state = GuardianState.RETURN

		GuardianState.CHASE:
			eyes.light_color = Color(1.0, 0.05, 0.05, 1)
			eyes.light_energy = 1.5
			nav.set_target_position(_player.global_position)
			_guardian_move(4.5)
			if dist < 1.1:
				_player_caught()
			if dist > 22.0:
				guardian_state = GuardianState.RETURN

		GuardianState.RETURN:
			eyes.light_color = Color(0.15, 0.7, 0.5, 1)
			eyes.light_energy = 0.3
			nav.set_target_position(guardian_home)
			_guardian_move(2.0)
			if global_position.distance_to(guardian_home) < 1.2:
				guardian_state = GuardianState.PATROL

func _guardian_patrol() -> void:
	if nav.is_navigation_finished():
		guardian_patrol_idx = (guardian_patrol_idx + 1) % guardian_patrol_pts.size()
		nav.set_target_position(guardian_patrol_pts[guardian_patrol_idx])
	_guardian_move(1.5)

func _guardian_move(speed: float) -> void:
	var next = nav.get_next_path_position()
	var dir = (next - global_position).normalized()
	velocity = dir * speed
	move_and_slide()
	if dir.length() > 0.1:
		var look = global_position + Vector3(dir.x, 0, dir.z)
		if look != global_position:
			look_at(look, Vector3.UP)

func _player_caught() -> void:
	EventBus.guardian_player_caught.emit()

func _setup_guardian_patrol() -> void:
	guardian_patrol_pts = [
		guardian_home + Vector3(10, 0, 0),
		guardian_home + Vector3(0, 0, 10),
		guardian_home + Vector3(-10, 0, 0),
		guardian_home + Vector3(5, 0, -8),
	]
	nav.set_target_position(guardian_patrol_pts[0])

func _on_chase_forced() -> void:
	guardian_state = GuardianState.CHASE
