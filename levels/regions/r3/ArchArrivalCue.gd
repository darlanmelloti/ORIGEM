## ArchArrivalCue.gd
## DEV3-R3-ARCH-ARRIVAL-CUE-009
## Leitura material estática de chegada por meio de grupos de base já existentes, sem UI, texto, luz, emissão, colisão ou VFX.

class_name R3ArchArrivalCue
extends Node

const TARGETS: Dictionary = {
	"GrupoDeBaseArco_00": {"lateral_push": 0.22, "approach_push": -0.34, "scale_multiplier": 1.08},
	"GrupoDeBaseArco_04": {"lateral_push": 0.16, "approach_push": -0.20, "scale_multiplier": 1.04},
	"GrupoDeBaseArco_05": {"lateral_push": 0.24, "approach_push": -0.30, "scale_multiplier": 1.06}
}

var cued_targets: Array[Node3D] = []

static func install(arch: Node3D) -> R3ArchArrivalCue:
	if arch == null:
		return null
	var existing: R3ArchArrivalCue = arch.get_node_or_null("R3LeituraDeChegada") as R3ArchArrivalCue
	if existing != null:
		return existing
	var cue: R3ArchArrivalCue = R3ArchArrivalCue.new()
	cue.name = "R3LeituraDeChegada"
	arch.add_child(cue)
	return cue

func _ready() -> void:
	_apply_material_arrival_cue()

func _apply_material_arrival_cue() -> void:
	var arch: Node3D = get_parent() as Node3D
	if arch == null:
		return
	for target_name: String in TARGETS:
		var target: Node3D = arch.get_node_or_null(target_name) as Node3D
		if target == null:
			continue
		var spec: Dictionary = TARGETS[target_name] as Dictionary
		var lateral_sign: float = -1.0 if target.position.x < 0.0 else 1.0
		target.position.x += lateral_sign * float(spec["lateral_push"])
		target.position.z += float(spec["approach_push"])
		target.scale *= float(spec["scale_multiplier"])
		target.set_meta("r3_arrival_cue", true)
		target.set_meta("r3_arrival_lateral_offset", lateral_sign * float(spec["lateral_push"]))
		cued_targets.append(target)

func get_contract() -> Dictionary:
	return {
		"target_count": TARGETS.size(),
		"cued_count": cued_targets.size(),
		"adds_geometry": false,
		"adds_lights": false,
		"adds_vfx": false,
		"adds_collision": false,
		"uses_ui": false,
		"central_clearance_preserved": true
	}

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("a leitura de chegada não recebeu o Arco R3")
		return issues
	var cue: R3ArchArrivalCue = arch.get_node_or_null("R3LeituraDeChegada") as R3ArchArrivalCue
	if cue == null:
		issues.append("a camada de chegada material R3 está em falta")
		return issues
	var contract: Dictionary = cue.get_contract()
	if int(contract.get("target_count", 0)) != TARGETS.size() or int(contract.get("cued_count", 0)) != TARGETS.size():
		issues.append("a leitura de chegada R3 não ajustou os três grupos laterais previstos")
	if not bool(contract.get("central_clearance_preserved", false)) or bool(contract.get("uses_ui", true)):
		issues.append("a leitura de chegada R3 não preserva os limites de corredor ou UI")
	for target_name: String in TARGETS:
		var target: Node3D = arch.get_node_or_null(target_name) as Node3D
		if target == null:
			issues.append("um grupo material de chegada está em falta: %s" % target_name)
			continue
		if not target.has_meta("r3_arrival_cue") or not bool(target.get_meta("r3_arrival_cue")):
			issues.append("um grupo lateral não recebeu leitura de chegada: %s" % target_name)
		if absf(target.position.x) < 4.20:
			issues.append("um grupo de chegada aproximou-se perigosamente do vão: %s" % target_name)
	if not cue.find_children("*", "CollisionShape3D", true, false).is_empty() or not cue.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("a leitura de chegada R3 não pode criar colisores")
	if not cue.find_children("*", "Light3D", true, false).is_empty() or not cue.find_children("*", "GPUParticles3D", true, false).is_empty() or not cue.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("a leitura de chegada R3 não pode criar luz, VFX ou áudio")
	if not cue.find_children("*", "Control", true, false).is_empty() or not cue.find_children("*", "CanvasLayer", true, false).is_empty() or not cue.find_children("*", "Label3D", true, false).is_empty():
		issues.append("a leitura de chegada R3 não pode criar UI ou texto flutuante")
	return issues
