## ArchGroundRhythm.gd
## DEV3-R3-ARCH-GROUND-RHYTHM-010
## Ritmo arqueológico baixo criado por ajustes em grupos laterais existentes, sem acrescentar lajes, colisão, luz, UI ou VFX.

class_name R3ArchGroundRhythm
extends Node

const TARGETS: Dictionary = {
	"GrupoDeBaseArco_01": {"lateral_push": 0.14, "z_shift": -0.06, "scale_multiplier": 1.02},
	"GrupoDeBaseArco_02": {"lateral_push": 0.13, "z_shift": 0.18, "scale_multiplier": 1.05},
	"GrupoDeBaseArco_03": {"lateral_push": 0.15, "z_shift": 0.16, "scale_multiplier": 1.06}
}

var rhythm_targets: Array[Node3D] = []

static func install(arch: Node3D) -> R3ArchGroundRhythm:
	if arch == null:
		return null
	var existing: R3ArchGroundRhythm = arch.get_node_or_null("R3RitmoArqueologicoDoSolo") as R3ArchGroundRhythm
	if existing != null:
		return existing
	var rhythm: R3ArchGroundRhythm = R3ArchGroundRhythm.new()
	rhythm.name = "R3RitmoArqueologicoDoSolo"
	arch.add_child(rhythm)
	return rhythm

func _ready() -> void:
	_apply_lateral_ground_rhythm()

func _apply_lateral_ground_rhythm() -> void:
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
		target.position.z += float(spec["z_shift"])
		target.scale *= float(spec["scale_multiplier"])
		target.set_meta("r3_ground_rhythm", true)
		target.set_meta("r3_ground_rhythm_lateral_offset", lateral_sign * float(spec["lateral_push"]))
		rhythm_targets.append(target)

func get_contract() -> Dictionary:
	return {
		"target_count": TARGETS.size(),
		"rhythm_count": rhythm_targets.size(),
		"adds_geometry": false,
		"adds_central_slabs": false,
		"adds_lights": false,
		"adds_vfx": false,
		"adds_collision": false
	}

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("o ritmo de solo não recebeu o Arco R3")
		return issues
	var rhythm: R3ArchGroundRhythm = arch.get_node_or_null("R3RitmoArqueologicoDoSolo") as R3ArchGroundRhythm
	if rhythm == null:
		issues.append("a camada de ritmo arqueológico do solo R3 está em falta")
		return issues
	var contract: Dictionary = rhythm.get_contract()
	if int(contract.get("target_count", 0)) != TARGETS.size() or int(contract.get("rhythm_count", 0)) != TARGETS.size():
		issues.append("o ritmo de solo R3 não ajustou os três grupos laterais previstos")
	if bool(contract.get("adds_central_slabs", true)):
		issues.append("o ritmo de solo R3 declarou lajes centrais proibidas")
	for target_name: String in TARGETS:
		var target: Node3D = arch.get_node_or_null(target_name) as Node3D
		if target == null:
			issues.append("um grupo de ritmo de solo está em falta: %s" % target_name)
			continue
		if not target.has_meta("r3_ground_rhythm") or not bool(target.get_meta("r3_ground_rhythm")):
			issues.append("um grupo lateral não recebeu ritmo de solo: %s" % target_name)
		if absf(target.position.x) < 4.20:
			issues.append("um grupo de ritmo aproximou-se perigosamente do vão: %s" % target_name)
	if not rhythm.find_children("*", "CollisionShape3D", true, false).is_empty() or not rhythm.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("o ritmo de solo R3 não pode criar colisores")
	if not rhythm.find_children("*", "Light3D", true, false).is_empty() or not rhythm.find_children("*", "GPUParticles3D", true, false).is_empty() or not rhythm.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("o ritmo de solo R3 não pode criar luz, VFX ou áudio")
	return issues
