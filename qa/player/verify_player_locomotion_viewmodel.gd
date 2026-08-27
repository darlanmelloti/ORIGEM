extends Node

## QA-PLAYER-LOCO-026: prova que Elias se desloca no terreno e que a espada retrai ao olhar para baixo.
## É injetado por scripts/main.gd somente quando ORIGEM_QA_PLAYER_LOCOMOTION está definido.

const SETTLE_FRAMES: int = 75
const MOVE_FRAMES: int = 75
const MIN_HORIZONTAL_MOVEMENT: float = 1.00
const MAX_VIEWMODEL_DOWNWARD_REACH: float = 1.30
const MIN_HEAD_HEIGHT: float = 0.80

var player: CharacterBody3D
var head: Node3D
var camera: Camera3D
var sword_pivot: Node3D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("_run")

func _run() -> void:
	for _frame in SETTLE_FRAMES:
		await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		_finish(false, "player_missing", {})
		return
	head = player.get_node_or_null("Head") as Node3D
	camera = player.get_node_or_null("Head/Camera3D") as Camera3D
	sword_pivot = camera.get_node_or_null("SwordPivot") as Node3D if camera != null else null
	if head == null or camera == null or sword_pivot == null:
		_finish(false, "viewmodel_nodes_missing", {})
		return

	var movement: Dictionary = await _measure_best_directional_movement()
	var viewmodel: Dictionary = await _measure_downward_viewmodel_reach()
	var grounded: bool = player.is_on_floor()
	var head_height: float = head.position.y
	var passed: bool = float(movement.get("best_distance", 0.0)) >= MIN_HORIZONTAL_MOVEMENT \
		and float(viewmodel.get("downward_reach", INF)) <= MAX_VIEWMODEL_DOWNWARD_REACH \
		and head_height >= MIN_HEAD_HEIGHT \
		and grounded
	_finish(passed, "ok" if passed else "locomotion_or_viewmodel_threshold", {
		"grounded": grounded,
		"head_height": head_height,
		"head_path": String(head.get_path()),
		"head_transform_origin": [head.transform.origin.x, head.transform.origin.y, head.transform.origin.z],
		"camera_global_position": [camera.global_position.x, camera.global_position.y, camera.global_position.z],
		"player_position": [player.global_position.x, player.global_position.y, player.global_position.z],
		"movement": movement,
		"viewmodel": viewmodel,
	})

func _measure_best_directional_movement() -> Dictionary:
	var samples: Array[Dictionary] = []
	var actions: Array[StringName] = [&"move_forward", &"move_backward", &"move_left", &"move_right"]
	for action: StringName in actions:
		var start: Vector3 = player.global_position
		Input.action_press(action)
		for _frame in MOVE_FRAMES:
			await get_tree().physics_frame
		Input.action_release(action)
		for _frame in 8:
			await get_tree().physics_frame
		var finish: Vector3 = player.global_position
		var distance: float = Vector2(finish.x - start.x, finish.z - start.z).length()
		samples.append({"action": String(action), "distance": distance, "start": [start.x, start.y, start.z], "finish": [finish.x, finish.y, finish.z]})
	var best_distance: float = 0.0
	for sample: Dictionary in samples:
		best_distance = maxf(best_distance, float(sample["distance"]))
	return {"best_distance": best_distance, "samples": samples}

func _measure_downward_viewmodel_reach() -> Dictionary:
	var saved_pitch: float = head.rotation.x
	head.rotation.x = deg_to_rad(-82.0)
	await get_tree().process_frame
	var snapshot_path: String = OS.get_environment("ORIGEM_QA_PLAYER_VIEWMODEL_SNAPSHOT")
	if snapshot_path != "":
		var image: Image = get_viewport().get_texture().get_image()
		var snapshot_result: Error = image.save_png(snapshot_path)
		print("[QA-PLAYER-LOCO-026-SNAPSHOT] path=%s result=%d" % [snapshot_path, snapshot_result])
	var local_depth: float = maxf(0.0, -sword_pivot.position.z)
	var local_drop: float = maxf(0.0, -sword_pivot.position.y)
	var downward_reach: float = local_depth + local_drop
	head.rotation.x = saved_pitch
	return {
		"pivot_position": [sword_pivot.position.x, sword_pivot.position.y, sword_pivot.position.z],
		"downward_reach": downward_reach,
	}

func _finish(passed: bool, reason: String, payload: Dictionary) -> void:
	payload["probe"] = "QA-PLAYER-LOCO-026"
	payload["passed"] = passed
	payload["reason"] = reason
	print("[QA-PLAYER-LOCO-026-RESULT] %s" % JSON.stringify(payload))
	get_tree().quit(0 if passed else 4)
