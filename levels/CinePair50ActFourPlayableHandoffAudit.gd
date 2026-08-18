## CinePair50ActFourPlayableHandoffAudit.gd
## DEV4-ACT4-002 — tarefa seguinte já activa após DEV4-ACT4-001.
## O auditor exige travessia física, entrada/saída de câmara e evidência real.

extends Node

const TASK_ID := "DEV4-ACT4-002"
const NEXT_TASK_ID := "DEV4-ACT4-003"
const TARGET := "ACT_3_TO_ACT_4_PLAYABLE_HANDOFF"

var contract: Dictionary = {
	"task_id": TASK_ID,
	"status_code": "ACTIVE_QUEUE",
	"target": TARGET,
	"entry_camera_required": true,
	"exit_camera_required": true,
	"physical_traversal_required": true,
	"gameplay_seconds_required": 30,
	"print_resolution_required": Vector2i(1600, 900),
	"scope_guard_required": true,
	"next_task_active": NEXT_TASK_ID,
	"next_target_file": "levels/CinePair51ActFourCinematicTakeAudit.gd",
	"wait_for_instruction": false,
}

func _ready() -> void:
	print("DEV4_CONTINUITY_TASK_ACTIVE id=%s next=%s target=%s" % [TASK_ID, NEXT_TASK_ID, TARGET])
	print("DEV4_EVIDENCE_CONTRACT gameplay_seconds=%d print=%s physical_traversal=%s" % [contract["gameplay_seconds_required"], contract["print_resolution_required"], contract["physical_traversal_required"]])
	assert(contract["next_task_active"] == NEXT_TASK_ID)
	assert(contract["wait_for_instruction"] == false)

func mark_result(status_code: String, evidence_path: String) -> Dictionary:
	assert(status_code in ["PASSED", "REJECTED_VISUAL", "TECHNICAL_FAIL"])
	contract["status_code"] = status_code
	contract["evidence_path"] = evidence_path
	contract["next_task_active"] = NEXT_TASK_ID
	return contract.duplicate(true)

func next_task_contract() -> Dictionary:
	return {
		"task_id": NEXT_TASK_ID,
		"target_file": contract["next_target_file"],
		"objective": "Auditar o primeiro take cinematográfico do Ato 4 sem perder a travessia física.",
		"required_evidence": ["gameplay_30s", "print_1600x900", "runtime_log", "scope_guard", "sha256"],
		"auto_start": true,
		"wait_for_instruction": false,
	}
