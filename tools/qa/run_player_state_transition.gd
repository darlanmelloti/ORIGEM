extends Node

## QA-STATE-01: runner transitório montado em /root pelo controlador principal.
## Usa relógio de parede para manter a janela de 30 s mesmo quando o llvmpipe reduz os frames.

const STATE_PROBE_SCRIPT: Script = preload("res://tools/qa/audit_player_state_transition.gd")
const PRE_ENTRY_MSEC: int = 15000
const COMPLETE_MSEC: int = 33000

var state_probe: Node
var started_msec: int = 0
var entry_started: bool = false
var before_state: Dictionary = {}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	state_probe = STATE_PROBE_SCRIPT.new()
	get_tree().root.call_deferred("add_child", state_probe)
	started_msec = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	var elapsed_msec: int = Time.get_ticks_msec() - started_msec
	if not entry_started and elapsed_msec >= PRE_ENTRY_MSEC:
		_start_orion_entry()
	if entry_started and elapsed_msec >= COMPLETE_MSEC:
		_finish()

func _start_orion_entry() -> void:
	entry_started = true
	if not is_instance_valid(state_probe):
		printerr("[QA-STATE-01] probe_unavailable_before")
		get_tree().quit(2)
		return
	before_state = state_probe.capture_player_state("before_orion_entry")
	var player: Node3D = get_tree().get_first_node_in_group("player") as Node3D
	if player == null:
		printerr("[QA-STATE-01] player_missing_before_entry")
		get_tree().quit(2)
		return
	OrionTransitionState.begin_entry(player)

func _finish() -> void:
	var after_state: Dictionary = state_probe.capture_player_state("after_orion_entry") if is_instance_valid(state_probe) else {}
	var result: Dictionary = {
		"probe": "QA-STATE-01",
		"duration_seconds": 33,
		"before": before_state,
		"after": after_state,
		"entry_transition_completed": not after_state.is_empty(),
		"scope": "telemetria Dev4; sem alteração de Player.gd"
	}
	print("[QA-STATE-01-RESULT] %s" % JSON.stringify(result))
	if is_instance_valid(state_probe):
		state_probe.queue_free()
	get_tree().quit(0 if not after_state.is_empty() else 3)
