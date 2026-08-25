extends Node

## QA-GROUND-01: confirma que Elias estabiliza sobre uma superfície física válida.
## É injetado por scripts/main.gd quando ORIGEM_QA_GROUNDING está definido.

const WARMUP_PHYSICS_FRAMES: int = 45
const SAMPLE_PHYSICS_FRAMES: int = 180
const MIN_SAFE_Y: float = -6.0
const MAX_DOWNWARD_SPEED: float = 18.0

var elapsed_frames: int = 0
var grounded_frames: int = 0
var lowest_y: float = INF
var worst_downward_speed: float = 0.0
var post_warmup_reference_y: float = INF
var max_post_warmup_y_delta: float = 0.0
var player: CharacterBody3D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("_find_player")

func _find_player() -> void:
	player = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		printerr("[QA-GROUND-01] player_missing")
		get_tree().quit(2)

func _physics_process(_delta: float) -> void:
	if player == null:
		return
	elapsed_frames += 1
	lowest_y = minf(lowest_y, player.global_position.y)
	worst_downward_speed = maxf(worst_downward_speed, -player.velocity.y)
	if elapsed_frames > WARMUP_PHYSICS_FRAMES:
		if player.is_on_floor():
			grounded_frames += 1
		# Alguns StaticBody/CSG regionais estabilizam o CharacterBody antes de is_on_floor() devolver true.
		# A variação vertical é a segunda evidência física: queda livre produz desvio crescente, mesmo nesse caso.
		if is_inf(post_warmup_reference_y):
			post_warmup_reference_y = player.global_position.y
		else:
			max_post_warmup_y_delta = maxf(max_post_warmup_y_delta, absf(player.global_position.y - post_warmup_reference_y))
	if player.global_position.y < MIN_SAFE_Y:
		_finish(false, "player_below_safe_height")
		return
	if elapsed_frames >= WARMUP_PHYSICS_FRAMES + SAMPLE_PHYSICS_FRAMES:
		var vertically_stable: bool = max_post_warmup_y_delta <= 0.25
		_finish(grounded_frames >= 24 or vertically_stable, "insufficient_floor_contact")

func _finish(passed: bool, failure_reason: String) -> void:
	set_physics_process(false)
	var result: Dictionary = {
		"probe": "QA-GROUND-01",
		"passed": passed,
		"reason": "ok" if passed else failure_reason,
		"grounded_frames": grounded_frames,
		"lowest_y": lowest_y,
		"worst_downward_speed": worst_downward_speed,
		"max_post_warmup_y_delta": max_post_warmup_y_delta,
		"position": [player.global_position.x, player.global_position.y, player.global_position.z] if player != null else [],
	}
	print("[QA-GROUND-01-RESULT] %s" % JSON.stringify(result))
	get_tree().quit(0 if passed else 3)
