extends Node
## QA-CASA-VOSS-HIGHLAND-060 — prova de teclado físico sobre a abertura elevada.
## O runner externo usa eventos X11 reais; esta sonda só observa posição, contacto e percurso.

const PROBE_ID := "QA-CASA-VOSS-HIGHLAND-060"
const REQUIRED_SECONDS := 60.0
const MIN_DISTANCE := 24.0
const MIN_GROUNDED_FRAMES := 120
const MIN_DESCENT := 1.20

var player: CharacterBody3D
var started := false
var elapsed := 0.0
var started_at_msec := 0
var grounded_frames := 0
var total_distance := 0.0
var start_position := Vector3.ZERO
var last_position := Vector3.ZERO
var lowest_y := INF
var key_seen: Dictionary = {"w": false, "a": false, "s": false, "d": false}
var start_snapshot_saved := false
var midpoint_snapshot_saved := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("_await_player")

func _await_player() -> void:
	player = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		get_tree().create_timer(0.25).timeout.connect(_await_player)
		return
	# A rota QA coloca Elias no primeiro patamar e orienta a vista para a Estrada do Rio.
	get_tree().create_timer(1.0).timeout.connect(_start)

func _start() -> void:
	if player == null:
		return
	started = true
	started_at_msec = Time.get_ticks_msec()
	start_position = player.global_position
	last_position = start_position
	lowest_y = start_position.y
	print("[%s-START] pos=%s grounded=%s" % [PROBE_ID, start_position, str(player.is_on_floor())])
	_save_snapshot("00_highland_start.png")
	start_snapshot_saved = true

func _physics_process(delta: float) -> void:
	if not started or player == null:
		return
	elapsed = float(Time.get_ticks_msec() - started_at_msec) / 1000.0
	var current := player.global_position
	total_distance += Vector2(current.x, current.z).distance_to(Vector2(last_position.x, last_position.z))
	last_position = current
	lowest_y = minf(lowest_y, current.y)
	if player.is_on_floor():
		grounded_frames += 1
	key_seen["w"] = bool(key_seen["w"]) or Input.is_key_pressed(KEY_W)
	key_seen["a"] = bool(key_seen["a"]) or Input.is_key_pressed(KEY_A)
	key_seen["s"] = bool(key_seen["s"]) or Input.is_key_pressed(KEY_S)
	key_seen["d"] = bool(key_seen["d"]) or Input.is_key_pressed(KEY_D)
	if elapsed >= 30.0 and not midpoint_snapshot_saved:
		_save_snapshot("30_highland_mid.png")
		midpoint_snapshot_saved = true
	if elapsed >= REQUIRED_SECONDS:
		_finish()

func _finish() -> void:
	if not started:
		return
	started = false
	_save_snapshot("60_highland_result.png")
	var descent: float = start_position.y - lowest_y
	var keys_complete: bool = bool(key_seen["w"]) and bool(key_seen["a"]) and bool(key_seen["s"]) and bool(key_seen["d"])
	var passed: bool = elapsed >= REQUIRED_SECONDS and total_distance >= MIN_DISTANCE and grounded_frames >= MIN_GROUNDED_FRAMES and descent >= MIN_DESCENT and keys_complete
	var evidence := {
		"passed": passed,
		"seconds": snappedf(elapsed, 0.01),
		"distance_m": snappedf(total_distance, 0.001),
		"grounded_frames": grounded_frames,
		"descent_m": snappedf(descent, 0.001),
		"input_wasd_seen": key_seen,
		"start_position": start_position,
		"lowest_y": snappedf(lowest_y, 0.001),
		"final_position": player.global_position
	}
	print("[%s-RESULT] %s" % [PROBE_ID, JSON.stringify(evidence)])
	get_tree().create_timer(1.0).timeout.connect(get_tree().quit.bind(0 if passed else 1))

func _save_snapshot(filename: String) -> void:
	var output_dir := OS.get_environment("ORIGEM_QA_OUTPUT_DIR")
	if output_dir.is_empty():
		return
	var image := get_viewport().get_texture().get_image()
	if image != null:
		image.save_png(output_dir.path_join(filename))
