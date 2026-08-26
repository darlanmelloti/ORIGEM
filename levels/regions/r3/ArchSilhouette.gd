## ArchSilhouette.gd
## DEV3-R3-ARCH-SILHOUETTE-008
## Ajuste de leitura cartográfica limitado a fragmentos laterais existentes, sem criar malha, parede, lintel, luz ou colisão.

class_name R3ArchSilhouette
extends Node

const TARGETS: Dictionary = {
	"FragmentoDaCoroaDoArco_01": {"lateral_push": 0.26, "vertical_lift": 0.18, "scale_multiplier": 1.12},
	"FragmentoDaCoroaDoArco_02": {"lateral_push": 0.31, "vertical_lift": 0.24, "scale_multiplier": 1.16},
	"FragmentoDaCoroaDoArco_04": {"lateral_push": 0.28, "vertical_lift": 0.20, "scale_multiplier": 1.14}
}

var adjusted_targets: Array[Node3D] = []

static func install(arch: Node3D) -> R3ArchSilhouette:
	if arch == null:
		return null
	var existing: R3ArchSilhouette = arch.get_node_or_null("R3SilhuetaCartografica") as R3ArchSilhouette
	if existing != null:
		return existing
	var silhouette: R3ArchSilhouette = R3ArchSilhouette.new()
	silhouette.name = "R3SilhuetaCartografica"
	arch.add_child(silhouette)
	return silhouette

func _ready() -> void:
	_apply_lateral_adjustments()

func _apply_lateral_adjustments() -> void:
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
		target.position.y += float(spec["vertical_lift"])
		target.scale *= float(spec["scale_multiplier"])
		target.set_meta("r3_silhouette_adjusted", true)
		target.set_meta("r3_silhouette_lateral_push", lateral_sign * float(spec["lateral_push"]))
		adjusted_targets.append(target)

func get_contract() -> Dictionary:
	return {
		"target_count": TARGETS.size(),
		"adjusted_count": adjusted_targets.size(),
		"adds_geometry": false,
		"adds_lights": false,
		"adds_vfx": false,
		"adds_collision": false,
		"central_clearance_preserved": true
	}

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("a silhueta não recebeu o Arco R3")
		return issues
	var silhouette: R3ArchSilhouette = arch.get_node_or_null("R3SilhuetaCartografica") as R3ArchSilhouette
	if silhouette == null:
		issues.append("a camada de silhueta cartográfica R3 está em falta")
		return issues
	var contract: Dictionary = silhouette.get_contract()
	if int(contract.get("target_count", 0)) != TARGETS.size() or int(contract.get("adjusted_count", 0)) != TARGETS.size():
		issues.append("a silhueta R3 não ajustou os três fragmentos laterais previstos")
	if not bool(contract.get("central_clearance_preserved", false)):
		issues.append("a silhueta R3 não declarou a preservação do vão central")
	for target_name: String in TARGETS:
		var target: Node3D = arch.get_node_or_null(target_name) as Node3D
		if target == null:
			issues.append("um fragmento lateral da silhueta está em falta: %s" % target_name)
			continue
		if not target.has_meta("r3_silhouette_adjusted") or not bool(target.get_meta("r3_silhouette_adjusted")):
			issues.append("um fragmento lateral não recebeu ajuste de silhueta: %s" % target_name)
		if absf(target.position.x) < 4.20:
			issues.append("um fragmento de silhueta aproximou-se perigosamente do vão: %s" % target_name)
		if target.scale.length() <= 0.0:
			issues.append("um fragmento de silhueta perdeu escala válida: %s" % target_name)
	if not silhouette.find_children("*", "CollisionShape3D", true, false).is_empty() or not silhouette.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("a silhueta R3 não pode criar colisores")
	if not silhouette.find_children("*", "Light3D", true, false).is_empty() or not silhouette.find_children("*", "GPUParticles3D", true, false).is_empty() or not silhouette.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("a silhueta R3 não pode criar luz, VFX ou áudio")
	return issues
