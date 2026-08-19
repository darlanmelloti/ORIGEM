extends Node

## QA-STATE-02: auditoria material de ida e volta Orion, iniciada após QA-STATE-01.
## Mede posição, rotação, saúde e stamina antes da entrada, no interior e após o retorno.

const STATE_PROBE_SCRIPT: Script = preload("res://tools/qa/audit_player_state_transition.gd")
const ENTRY_MSEC: int = 10000
const RETURN_MSEC: int = 22000
const COMPLETE_MSEC: int = 35000

var state_probe: Node
var started_msec: int = 0
var entry_started: bool = false
var return_started: bool = false
var before_state: Dictionary = {}
var interior_state: Dictionary = {}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	state_probe = STATE_PROBE_SCRIPT.new()
	get_tree().root.call_deferred("add_child", state_probe)
	started_msec = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	var elapsed_msec: int = Time.get_ticks_msec() - started_msec
	if not entry_started and elapsed_msec >= ENTRY_MSEC:
		_start_entry()
	if entry_started and not return_started and elapsed_msec >= RETURN_MSEC:
		_start_return()
	if return_started and elapsed_msec >= COMPLETE_MSEC:
		_finish()

func _player() -> Node3D:
	return get_tree().get_first_node_in_group("player") as Node3D

func _start_entry() -> void:
	entry_started = true
	before_state = state_probe.capture_player_state("before_orion_roundtrip")
	var player: Node3D = _player()
	if player == null:
		printerr("[QA-STATE-02] player_missing_before_entry")
		get_tree().quit(2)
		return
	OrionTransitionState.begin_entry(player)

func _start_return() -> void:
	return_started = true
	interior_state = state_probe.capture_player_state("inside_orion_before_return")
	var player: Node3D = _player()
	if player == null:
		printerr("[QA-STATE-02] player_missing_before_return")
		get_tree().quit(2)
		return
	OrionTransitionState.begin_return(player)

func _finish() -> void:
	var after_state: Dictionary = state_probe.capture_player_state("after_orion_roundtrip")
	var restored: bool = not before_state.is_empty() and not after_state.is_empty() and before_state.get("health") == after_state.get("health") and is_equal_approx(float(before_state.get("stamina", -1.0)), float(after_state.get("stamina", -2.0)))
	print("[QA-STATE-02-RESULT] %s" % JSON.stringify({"probe":"QA-STATE-02","duration_seconds":35,"before":before_state,"interior":interior_state,"after":after_state,"health_stamina_restored":restored,"scope":"telemetria Dev4; sem alteração de Player.gd"}))
	state_probe.queue_free()
	get_tree().quit(0 if restored else 3)
