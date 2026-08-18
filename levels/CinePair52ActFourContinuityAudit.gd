## CinePair52ActFourContinuityAudit.gd
## DEV4-ACT4-004 — activado automaticamente pelo primeiro take do Ato 4.
## A fila permanece activa; qualquer resultado do take anterior conduz a este auditor.

extends Node

const TASK_ID := "DEV4-ACT4-004"
const NEXT_TASK_ID := "DEV4-ACT4-005"
const TARGET := "ACT_4_NEXT_TAKE_CONTINUITY"

var contract: Dictionary = {
	"task_id": TASK_ID,
	"status_code": "ACTIVE_QUEUE",
	"target": TARGET,
	"camera_continuity_required": true,
	"narrative_continuity_required": true,
	"physical_traversal_preserved": true,
	"gameplay_seconds_required": 30,
	"print_resolution_required": Vector2i(1600, 900),
	"runtime_log_required": true,
	"scope_guard_required": true,
	"next_task_active": NEXT_TASK_ID,
	"next_target_file": "levels/CinePair53ActFourIntegrationAudit.gd",
	"wait_for_instruction": false,
}

func _ready() -> void:
	print("DEV4_CONTINUITY_TASK_ACTIVE id=%s next=%s target=%s" % [TASK_ID, NEXT_TASK_ID, TARGET])
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
		"objective": "Auditar a integração do bloco Ato 4 e preparar o próximo ciclo sem interrupção.",
		"required_evidence": ["gameplay_30s", "print_1600x900", "runtime_log", "scope_guard", "sha256"],
		"auto_start": true,
		"wait_for_instruction": false,
	}
