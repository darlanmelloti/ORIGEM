## QA-POST-PROLOGUE-INPUT-060
## Prova de uma sessão real de 60 s após o prólogo. Não injeta Input.action_press().
## As teclas são fornecidas externamente pelo sistema de janelas e lidas por Input no jogo.
extends Node

const PROBE_ID: String = "QA-POST-PROLOGUE-INPUT-060"
const DURATION_MSEC: int = 60_000
const SAMPLE_INTERVAL_MSEC: int = 1_000
const MIN_SEGMENT_DISTANCE: float = 1.00
const MIN_TOTAL_PATH_DISTANCE: float = 12.0

var player: CharacterBody3D
var voss_house: Node
var hud_layer: CanvasLayer
var hud_label: Label
var started: bool = false
var finished: bool = false
var start_msec: int = 0
var last_sample_msec: int = 0
var last_wait_report_msec: int = 0
var start_position: Vector3 = Vector3.ZERO
var previous_position: Vector3 = Vector3.ZERO
var total_path_distance: float = 0.0
var max_horizontal_speed: float = 0.0
var min_player_y: float = INF
var max_player_y: float = -INF
var grounded_frames: int = 0
var samples: Array = []
var key_down: Dictionary = {}
var segment_start_position: Dictionary = {}
var segment_start_msec: Dictionary = {}
var segments: Array = []

const W_KEY_CODE: int = KEY_W
const A_KEY_CODE: int = KEY_A
const S_KEY_CODE: int = KEY_S
const D_KEY_CODE: int = KEY_D
const KEY_LABELS: Dictionary = {W_KEY_CODE: "W", A_KEY_CODE: "A", S_KEY_CODE: "S", D_KEY_CODE: "D"}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_create_visible_hud()
	for key_code: int in KEY_LABELS:
		key_down[key_code] = false
	_set_hud("A aguardar pela conclusão do prólogo…")

func _process(_delta: float) -> void:
	if finished:
		return
	if not started:
		_try_start_after_opening()
		return
	_sample_realtime()

func _try_start_after_opening() -> void:
	if voss_house == null or not is_instance_valid(voss_house):
		voss_house = get_tree().get_first_node_in_group("voss_house_controller")
	if player == null or not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player") as CharacterBody3D
	var now_msec: int = Time.get_ticks_msec()
	var opening_state: String = "NULO" if voss_house == null else str(bool(voss_house.get("opening_active")))
	if now_msec - last_wait_report_msec >= SAMPLE_INTERVAL_MSEC:
		last_wait_report_msec = now_msec
		print("[%s-WAIT] voss=%s player=%s opening_active=%s camera=%s" % [PROBE_ID, str(voss_house != null), str(player != null), opening_state, _active_camera_name()])
	if voss_house == null or player == null:
		_set_hud("A aguardar pelos nós do prólogo e de Elias…")
		return
	if bool(voss_house.get("opening_active")):
		_set_hud("Prólogo ativo — a prova iniciará ao terminar normalmente.")
		return
	started = true
	start_msec = Time.get_ticks_msec()
	last_sample_msec = start_msec
	start_position = player.global_position
	previous_position = player.global_position
	min_player_y = player.global_position.y
	max_player_y = player.global_position.y
	print("[%s-START] pos=%s camera=%s" % [PROBE_ID, str(start_position), _active_camera_name()])
	_set_hud("Sessão iniciada. Entrada física e deslocamento são registados por 60 s.")

func _sample_realtime() -> void:
	var now_msec: int = Time.get_ticks_msec()
	var elapsed_msec: int = now_msec - start_msec
	var current_position: Vector3 = player.global_position
	var frame_delta: Vector3 = current_position - previous_position
	var horizontal_step: float = Vector2(frame_delta.x, frame_delta.z).length()
	total_path_distance += horizontal_step
	previous_position = current_position
	var horizontal_speed: float = Vector2(player.velocity.x, player.velocity.z).length()
	max_horizontal_speed = maxf(max_horizontal_speed, horizontal_speed)
	min_player_y = minf(min_player_y, current_position.y)
	max_player_y = maxf(max_player_y, current_position.y)
	if player.is_on_floor():
		grounded_frames += 1
	_track_physical_key_segments(now_msec, current_position)
	_update_visible_hud(elapsed_msec, current_position, horizontal_speed)
	if now_msec - last_sample_msec >= SAMPLE_INTERVAL_MSEC:
		last_sample_msec = now_msec
		var sample: Dictionary = _make_sample(elapsed_msec, current_position, horizontal_speed)
		samples.append(sample)
		print("[%s-SAMPLE] %s" % [PROBE_ID, JSON.stringify(sample)])
	if elapsed_msec >= DURATION_MSEC:
		_finish()

func _track_physical_key_segments(now_msec: int, position: Vector3) -> void:
	for key_code: int in KEY_LABELS:
		var pressed_now: bool = Input.is_key_pressed(key_code)
		var pressed_before: bool = bool(key_down.get(key_code, false))
		if pressed_now and not pressed_before:
			key_down[key_code] = true
			segment_start_position[key_code] = position
			segment_start_msec[key_code] = now_msec
			print("[%s-KEY-DOWN] key=%s t=%.2f pos=%s" % [PROBE_ID, KEY_LABELS[key_code], float(now_msec - start_msec) / 1000.0, str(position)])
		elif not pressed_now and pressed_before:
			key_down[key_code] = false
			var segment_origin: Vector3 = segment_start_position.get(key_code, position) as Vector3
			var segment_distance: float = Vector2(position.x - segment_origin.x, position.z - segment_origin.z).length()
			var started_at: int = int(segment_start_msec.get(key_code, now_msec))
			var segment: Dictionary = {
				"key": KEY_LABELS[key_code],
				"duration_seconds": snappedf(float(now_msec - started_at) / 1000.0, 0.01),
				"distance": snappedf(segment_distance, 0.001),
				"start": [segment_origin.x, segment_origin.y, segment_origin.z],
				"finish": [position.x, position.y, position.z]
			}
			segments.append(segment)
			print("[%s-KEY-UP] %s" % [PROBE_ID, JSON.stringify(segment)])

func _make_sample(elapsed_msec: int, position: Vector3, horizontal_speed: float) -> Dictionary:
	var keys: Dictionary = {}
	for key_code: int in KEY_LABELS:
		keys[KEY_LABELS[key_code]] = Input.is_key_pressed(key_code)
	return {
		"t_seconds": snappedf(float(elapsed_msec) / 1000.0, 0.01),
		"keys": keys,
		"input_vector": [Input.get_vector("move_left", "move_right", "move_forward", "move_backward").x, Input.get_vector("move_left", "move_right", "move_forward", "move_backward").y],
		"position": [position.x, position.y, position.z],
		"velocity": [player.velocity.x, player.velocity.y, player.velocity.z],
		"horizontal_speed": snappedf(horizontal_speed, 0.001),
		"on_floor": player.is_on_floor(),
		"slide_collisions": player.get_slide_collision_count(),
		"colliders": _collision_labels(),
		"path_distance": snappedf(total_path_distance, 0.001),
		"camera": _active_camera_name(),
		"tree_paused": get_tree().paused,
		"mouse_captured": Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	}

func _update_visible_hud(elapsed_msec: int, position: Vector3, horizontal_speed: float) -> void:
	if hud_label == null:
		return
	var key_line: String = " ".join([
		"W:%s" % ("ON" if Input.is_key_pressed(W_KEY_CODE) else "--"),
		"A:%s" % ("ON" if Input.is_key_pressed(A_KEY_CODE) else "--"),
		"S:%s" % ("ON" if Input.is_key_pressed(S_KEY_CODE) else "--"),
		"D:%s" % ("ON" if Input.is_key_pressed(D_KEY_CODE) else "--")
	])
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var colliders: PackedStringArray = _collision_labels()
	hud_label.text = "QA — INPUT FÍSICO PÓS-PRÓLOGO\nTempo: %.1f / 60.0 s | Janela: %s | Rato: %s\nTeclas: %s | Vetor: (%.2f, %.2f)\nPosição: (%.2f, %.2f, %.2f) | Velocidade horizontal: %.2f m/s\nCaminho percorrido: %.2f m | No chão: %s (%d frames) | Colisões: %d\nCorpos: %s\nCâmara ativa: %s\nEsta telemetria existe apenas nesta prova QA." % [
		float(elapsed_msec) / 1000.0,
		"ATIVA" if not get_tree().paused else "PAUSADA",
		"CAPTURADO" if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else "LIVRE",
		key_line,
		input_vector.x, input_vector.y,
		position.x, position.y, position.z,
		horizontal_speed,
		total_path_distance,
		"SIM" if player.is_on_floor() else "NÃO",
		grounded_frames,
		player.get_slide_collision_count(),
		", ".join(colliders),
		_active_camera_name()
	]

func _collision_labels() -> PackedStringArray:
	var labels: PackedStringArray = PackedStringArray()
	for index: int in range(player.get_slide_collision_count()):
		var collision: KinematicCollision3D = player.get_slide_collision(index)
		if collision == null:
			continue
		var collider: Object = collision.get_collider()
		var label: String = collider.get_class() if collider != null else "NULO"
		if collider is Node:
			label = str((collider as Node).get_path())
		labels.append(label)
	return labels

func _finish() -> void:
	finished = true
	# Regista também teclas que ainda estejam pressionadas no fim da janela.
	_track_physical_key_segments(Time.get_ticks_msec(), player.global_position)
	var evaluated_segments: Array = []
	var distinct_keys_with_motion: Dictionary = {}
	for segment: Dictionary in segments:
		var moved: bool = float(segment.get("distance", 0.0)) >= MIN_SEGMENT_DISTANCE
		var enriched: Dictionary = segment.duplicate()
		enriched["moved"] = moved
		evaluated_segments.append(enriched)
		if moved:
			distinct_keys_with_motion[String(segment.get("key", ""))] = true
	var required_keys: Array[String] = ["W", "A", "S", "D"]
	var all_directions_moved: bool = true
	for required_key: String in required_keys:
		if not distinct_keys_with_motion.has(required_key):
			all_directions_moved = false
	var final_position: Vector3 = player.global_position
	var result: Dictionary = {
		"probe": PROBE_ID,
		"duration_seconds": snappedf(float(Time.get_ticks_msec() - start_msec) / 1000.0, 0.01),
		"post_prologue": true,
		"start": [start_position.x, start_position.y, start_position.z],
		"finish": [final_position.x, final_position.y, final_position.z],
		"path_distance": snappedf(total_path_distance, 0.001),
		"max_horizontal_speed": snappedf(max_horizontal_speed, 0.001),
		"y_range": [snappedf(min_player_y, 0.001), snappedf(max_player_y, 0.001)],
		"grounded_frames": grounded_frames,
		"all_directions_moved": all_directions_moved,
		"segments": evaluated_segments,
		"sample_count": samples.size(),
		"passed": total_path_distance >= MIN_TOTAL_PATH_DISTANCE and all_directions_moved and max_horizontal_speed >= 0.5 and grounded_frames >= 30 and not get_tree().paused
	}
	_set_hud("Prova concluída. Consulte o resultado QA no registo da sessão.")
	print("[%s-RESULT] %s" % [PROBE_ID, JSON.stringify(result)])
	await get_tree().create_timer(2.0).timeout
	get_tree().quit()

func _active_camera_name() -> String:
	var active_camera: Camera3D = get_viewport().get_camera_3d()
	return active_camera.name if active_camera != null else "NULA"

func _create_visible_hud() -> void:
	hud_layer = CanvasLayer.new()
	hud_layer.name = "QA_PostPrologueInputHUD"
	hud_layer.layer = 32
	var panel: ColorRect = ColorRect.new()
	panel.color = Color(0.015, 0.03, 0.055, 0.88)
	panel.position = Vector2(24, 24)
	panel.size = Vector2(690, 226)
	hud_layer.add_child(panel)
	hud_label = Label.new()
	hud_label.name = "TextoTelemetria"
	hud_label.position = Vector2(40, 38)
	hud_label.size = Vector2(658, 200)
	hud_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	hud_label.add_theme_font_size_override("font_size", 16)
	hud_label.add_theme_color_override("font_color", Color(0.87, 0.94, 1.0, 1.0))
	hud_layer.add_child(hud_label)
	get_tree().root.call_deferred("add_child", hud_layer)

func _set_hud(message: String) -> void:
	if hud_label != null:
		hud_label.text = "QA — INPUT FÍSICO PÓS-PRÓLOGO\n%s\nEsta telemetria existe apenas nesta prova QA." % message
