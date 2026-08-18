## CinePair51ActFourCinematicTakeAudit.gd
## DEV4-ACT4-003 — tarefa iniciada automaticamente após validação estática do handoff.
## O take só pode ser aceite com evidência jogável; este contrato não fabrica captura.

extends Node

const TASK_ID := "DEV4-ACT4-003"
const NEXT_TASK_ID := "DEV4-ACT4-004"
const TARGET := "ACT_4_FIRST_CINEMATIC_TAKE"

var contract: Dictionary = {
	"task_id": TASK_ID,
	"status_code": "ACTIVE_QUEUE",
	"target": TARGET,
	"camera_path_required": true,
	"narrative_subject_required": true,
	"physical_traversal_preserved": true,
	"gameplay_seconds_required": 30,
	"print_resolution_required": Vector2i(1600, 900),
	"scope_guard_required": true,
	"next_task_active": NEXT_TASK_ID,
	"next_target_file": "levels/CinePair52ActFourContinuityAudit.gd",
	"wait_for_instruction": false,
}

func _ready() -> void:
	print("DEV4_CONTINUITY_TASK_ACTIVE id=%s next=%s target=%s" % [TASK_ID, NEXT_TASK_ID, TARGET])
	print("DEV4_CINEMATIC_CONTRACT camera_path=%s subject=%s traversal=%s" % [contract["camera_path_required"], contract["narrative_subject_required"], contract["physical_traversal_preserved"]])
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
		"objective": "Auditar a continuidade física e narrativa do take seguinte do Ato 4.",
		"required_evidence": ["gameplay_30s", "print_1600x900", "runtime_log", "scope_guard", "sha256"],
		"auto_start": true,
		"wait_for_instruction": false,
	}
