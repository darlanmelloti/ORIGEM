## CinePair49ActFourOpeningAudit.gd
## DEV4-ACT4-001 — auditoria contínua do início do Ato 4.
## Este script é QA/documentação de continuidade; não substitui geometria regional.
## Fronteira: Dev4 / bloco narrativo activo. Regiões 1–6 permanecem fora do escopo.

extends Node

const TASK_ID := "DEV4-ACT4-001"
const NEXT_TASK_ID := "DEV4-ACT4-002"
const CURRENT_ACT := "ACT_4_OPENING"
const SCOPE := "DEV4_NARRATIVE_BLOCK"

var audit_state: Dictionary = {
	"task_id": TASK_ID,
	"status_code": "ACTIVE_QUEUE",
	"current_act": CURRENT_ACT,
	"scope": SCOPE,
	"regions_1_to_6_locked": true,
	"narrative_handoff": "ACT_3_CLOSING_TO_ACT_4_OPENING",
	"camera_entry_required": true,
	"camera_exit_required": true,
	"physical_entry_required": true,
	"physical_exit_required": true,
	"next_task_active": NEXT_TASK_ID,
	"next_target_file": "levels/CinePair50ActFourPlayableHandoffAudit.gd",
	"wait_allowed": false,
}

func _ready() -> void:
	print("DEV4_CONTINUITY_TASK_ACTIVE id=%s next=%s scope=%s" % [TASK_ID, NEXT_TASK_ID, SCOPE])
	print("DEV4_CONTINUITY_LOCK regions_1_to_6=%s wait_allowed=%s" % [audit_state["regions_1_to_6_locked"], audit_state["wait_allowed"]])
	print("DEV4_HANDOFF target=%s entry_camera=%s exit_camera=%s physical_entry=%s physical_exit=%s" % [audit_state["narrative_handoff"], audit_state["camera_entry_required"], audit_state["camera_exit_required"], audit_state["physical_entry_required"], audit_state["physical_exit_required"]])
	assert(audit_state["regions_1_to_6_locked"] == true)
	assert(audit_state["next_task_active"] == NEXT_TASK_ID)
	assert(audit_state["wait_allowed"] == false)

func get_audit_state() -> Dictionary:
	return audit_state.duplicate(true)

func mark_visual_result(status_code: String, evidence_path: String) -> Dictionary:
	assert(status_code in ["PASSED", "REJECTED_VISUAL", "TECHNICAL_FAIL"])
	audit_state["status_code"] = status_code
	audit_state["evidence_path"] = evidence_path
	# A result never clears the queue: the next task remains active by contract.
	audit_state["next_task_active"] = NEXT_TASK_ID
	return get_audit_state()

func next_task_contract() -> Dictionary:
	return {
		"task_id": NEXT_TASK_ID,
		"target_file": audit_state["next_target_file"],
		"objective": "Integrar fisicamente o handoff jogável Ato 3→Ato 4 e iniciar a travessia de validação.",
		"required_evidence": ["gameplay_30s", "print_1600x900", "runtime_log", "scope_guard", "sha256"],
		"auto_start": true,
		"wait_for_instruction": false,
	}
