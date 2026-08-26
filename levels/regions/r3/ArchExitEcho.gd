## ArchExitEcho.gd
## DEV3-R3-ARCH-EXIT-ECHO-011
## Eco material discreto em vestígios pós-Arco já existentes, limitado ao território R3 antes da transição R4.

class_name R3ArchExitEcho
extends Node

const TARGETS: Dictionary = {
	"VestigioDePassagem_02": {"z_shift": 0.14, "yaw_delta": -0.12, "scale_multiplier": 1.05},
	"VestigioDePassagem_03": {"z_shift": 0.18, "yaw_delta": 0.14, "scale_multiplier": 1.07}
}

var echoed_fragments: Array[Node3D] = []

static func install(arch: Node3D) -> R3ArchExitEcho:
	if arch == null:
		return null
	var existing: R3ArchExitEcho = arch.get_node_or_null("R3EcoArqueologicoDeSaida") as R3ArchExitEcho
	if existing != null:
		return existing
	var echo: R3ArchExitEcho = R3ArchExitEcho.new()
	echo.name = "R3EcoArqueologicoDeSaida"
	arch.add_child(echo)
	return echo

func _ready() -> void:
	_apply_exit_echo()

func _apply_exit_echo() -> void:
	var arch: Node3D = get_parent() as Node3D
	var road: Node = arch.get_parent() if arch != null else null
	var handoff: Node3D = road.get_node_or_null("R3HandoffParaFloresta") as Node3D if road != null else null
	if handoff == null:
		return
	for target_name: String in TARGETS:
		var trace_root: Node3D = handoff.get_node_or_null(target_name) as Node3D
		if trace_root == null:
			continue
		var fragment: Node3D = trace_root.get_node_or_null("FragmentoArqueologico_%02d" % (2 if target_name.ends_with("02") else 3)) as Node3D
		if fragment == null:
			continue
		var spec: Dictionary = TARGETS[target_name] as Dictionary
		fragment.position.z += float(spec["z_shift"])
		fragment.rotation.y += float(spec["yaw_delta"])
		fragment.scale *= float(spec["scale_multiplier"])
		fragment.set_meta("r3_exit_echo", true)
		fragment.set_meta("r3_exit_echo_z_shift", float(spec["z_shift"]))
		echoed_fragments.append(fragment)

func get_contract() -> Dictionary:
	return {
		"target_count": TARGETS.size(),
		"echoed_count": echoed_fragments.size(),
		"adds_geometry": false,
		"adds_lights": false,
		"adds_vfx": false,
		"adds_collision": false,
		"uses_ui": false,
		"stays_before_r4": true
	}

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("o eco de saída não recebeu o Arco R3")
		return issues
	var echo: R3ArchExitEcho = arch.get_node_or_null("R3EcoArqueologicoDeSaida") as R3ArchExitEcho
	if echo == null:
		issues.append("a camada de eco arqueológico R3 está em falta")
		return issues
	var contract: Dictionary = echo.get_contract()
	if int(contract.get("target_count", 0)) != TARGETS.size() or int(contract.get("echoed_count", 0)) != TARGETS.size():
		issues.append("o eco de saída R3 não ajustou os dois vestígios previstos")
	if not bool(contract.get("stays_before_r4", false)) or bool(contract.get("uses_ui", true)):
		issues.append("o eco de saída R3 não preserva os limites de R4 ou UI")
	var road: Node = arch.get_parent()
	var handoff: Node3D = road.get_node_or_null("R3HandoffParaFloresta") as Node3D if road != null else null
	if handoff == null:
		issues.append("o handoff R3→R4 está em falta")
		return issues
	for target_name: String in TARGETS:
		var trace_root: Node3D = handoff.get_node_or_null(target_name) as Node3D
		if trace_root == null:
			issues.append("um vestígio de saída está em falta: %s" % target_name)
			continue
		if not trace_root.has_meta("r3_road_offset") or absf(float(trace_root.get_meta("r3_road_offset"))) < 4.20:
			issues.append("um vestígio de saída aproxima-se do corredor: %s" % target_name)
		var expected_index: int = 2 if target_name.ends_with("02") else 3
		var fragment: Node3D = trace_root.get_node_or_null("FragmentoArqueologico_%02d" % expected_index) as Node3D
		if fragment == null or not fragment.has_meta("r3_exit_echo") or not bool(fragment.get_meta("r3_exit_echo")):
			issues.append("o eco não foi aplicado ao vestígio: %s" % target_name)
	if not echo.find_children("*", "CollisionShape3D", true, false).is_empty() or not echo.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("o eco de saída R3 não pode criar colisores")
	if not echo.find_children("*", "Light3D", true, false).is_empty() or not echo.find_children("*", "GPUParticles3D", true, false).is_empty() or not echo.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("o eco de saída R3 não pode criar luz, VFX ou áudio")
	return issues
