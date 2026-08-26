## ArchArrivalExitBalance.gd
## DEV3-R3-ARCH-ARRIVAL-EXIT-BALANCE-014
## Equilíbrio espacial de grupos laterais existentes entre chegada R2 e saída R3, sem criar objetos, texto, UI, malha, luz, emissão, VFX, áudio ou colisão.

class_name R3ArchArrivalExitBalance
extends Node

const CORRIDOR_CLEARANCE_X: float = 4.20
const ARRIVAL_TARGETS: Dictionary = {
	"GrupoDeBaseArco_00": {"z_shift": -0.05, "yaw_delta": 0.022},
	"GrupoDeBaseArco_05": {"z_shift": 0.06, "yaw_delta": -0.026}
}
const EXIT_TARGETS: Dictionary = {
	"VestigioDePassagem_02": {"z_shift": 0.045, "yaw_delta": -0.020},
	"VestigioDePassagem_03": {"z_shift": 0.065, "yaw_delta": 0.024}
}

var balanced_targets: Array[Node3D] = []

static func install(arch: Node3D) -> R3ArchArrivalExitBalance:
	if arch == null:
		return null
	var existing: R3ArchArrivalExitBalance = arch.get_node_or_null("R3EquilibrioChegadaSaida") as R3ArchArrivalExitBalance
	if existing != null:
		return existing
	var balance: R3ArchArrivalExitBalance = R3ArchArrivalExitBalance.new()
	balance.name = "R3EquilibrioChegadaSaida"
	arch.add_child(balance)
	return balance

func _ready() -> void:
	_apply_arrival_balance()
	_apply_exit_balance()

func _apply_arrival_balance() -> void:
	var arch: Node3D = get_parent() as Node3D
	if arch == null:
		return
	for target_name: String in ARRIVAL_TARGETS:
		var target: Node3D = arch.get_node_or_null(target_name) as Node3D
		if target == null:
			continue
		var spec: Dictionary = ARRIVAL_TARGETS[target_name] as Dictionary
		target.position.z += float(spec["z_shift"])
		target.rotation.y += float(spec["yaw_delta"])
		target.set_meta("r3_arrival_exit_balanced", true)
		target.set_meta("r3_arrival_exit_role", "chegada")
		balanced_targets.append(target)

func _apply_exit_balance() -> void:
	var arch: Node3D = get_parent() as Node3D
	var road: Node = arch.get_parent() if arch != null else null
	var handoff: Node3D = road.get_node_or_null("R3HandoffParaFloresta") as Node3D if road != null else null
	if handoff == null:
		return
	for target_name: String in EXIT_TARGETS:
		var trace_root: Node3D = handoff.get_node_or_null(target_name) as Node3D
		if trace_root == null:
			continue
		var fragment_index: int = 2 if target_name.ends_with("02") else 3
		var target: Node3D = trace_root.get_node_or_null("FragmentoArqueologico_%02d" % fragment_index) as Node3D
		if target == null:
			continue
		var spec: Dictionary = EXIT_TARGETS[target_name] as Dictionary
		target.position.z += float(spec["z_shift"])
		target.rotation.y += float(spec["yaw_delta"])
		target.set_meta("r3_arrival_exit_balanced", true)
		target.set_meta("r3_arrival_exit_role", "saida")
		balanced_targets.append(target)

func get_contract() -> Dictionary:
	return {
		"arrival_target_count": ARRIVAL_TARGETS.size(),
		"exit_target_count": EXIT_TARGETS.size(),
		"balanced_target_count": balanced_targets.size(),
		"adds_geometry": false,
		"adds_text": false,
		"adds_ui": false,
		"adds_lights": false,
		"adds_emission": false,
		"adds_vfx": false,
		"adds_audio": false,
		"adds_collision": false,
		"central_clearance_preserved": true,
		"stays_before_r4": true
	}

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("o equilíbrio chegada-saída não recebeu o Arco R3")
		return issues
	var balance: R3ArchArrivalExitBalance = arch.get_node_or_null("R3EquilibrioChegadaSaida") as R3ArchArrivalExitBalance
	if balance == null:
		issues.append("a camada de equilíbrio chegada-saída R3 está em falta")
		return issues
	var contract: Dictionary = balance.get_contract()
	var expected_count: int = ARRIVAL_TARGETS.size() + EXIT_TARGETS.size()
	if int(contract.get("balanced_target_count", 0)) != expected_count:
		issues.append("o equilíbrio chegada-saída não ajustou os grupos laterais previstos")
	for prohibited_key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
		if bool(contract.get(prohibited_key, true)):
			issues.append("o equilíbrio chegada-saída declarou recurso proibido: %s" % prohibited_key)
	if not bool(contract.get("central_clearance_preserved", false)) or not bool(contract.get("stays_before_r4", false)):
		issues.append("o equilíbrio chegada-saída não declarou passagem segura dentro de R3")
	for target_name: String in ARRIVAL_TARGETS:
		var target: Node3D = arch.get_node_or_null(target_name) as Node3D
		if target == null or not target.has_meta("r3_arrival_exit_balanced") or str(target.get_meta("r3_arrival_exit_role", "")) != "chegada":
			issues.append("o equilíbrio não marcou o grupo de chegada: %s" % target_name)
		elif absf(target.position.x) < CORRIDOR_CLEARANCE_X:
			issues.append("um grupo de chegada aproximou-se perigosamente do vão: %s" % target_name)
	var road: Node = arch.get_parent()
	var handoff: Node3D = road.get_node_or_null("R3HandoffParaFloresta") as Node3D if road != null else null
	if handoff == null:
		issues.append("o equilíbrio chegada-saída não encontrou o handoff R3")
	else:
		for target_name: String in EXIT_TARGETS:
			var trace_root: Node3D = handoff.get_node_or_null(target_name) as Node3D
			var fragment_index: int = 2 if target_name.ends_with("02") else 3
			var target: Node3D = trace_root.get_node_or_null("FragmentoArqueologico_%02d" % fragment_index) as Node3D if trace_root != null else null
			if target == null or not target.has_meta("r3_arrival_exit_balanced") or str(target.get_meta("r3_arrival_exit_role", "")) != "saida":
				issues.append("o equilíbrio não marcou o vestígio de saída: %s" % target_name)
			if trace_root == null or not trace_root.has_meta("r3_road_offset") or absf(float(trace_root.get_meta("r3_road_offset"))) < CORRIDOR_CLEARANCE_X:
				issues.append("um vestígio de saída aproximou-se do corredor: %s" % target_name)
	if balance.get_child_count() != 0:
		issues.append("o equilíbrio chegada-saída não pode criar objetos filhos")
	if not balance.find_children("*", "CollisionShape3D", true, false).is_empty() or not balance.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("o equilíbrio chegada-saída não pode criar colisores")
	if not balance.find_children("*", "Light3D", true, false).is_empty() or not balance.find_children("*", "GPUParticles3D", true, false).is_empty() or not balance.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("o equilíbrio chegada-saída não pode criar luz, VFX ou áudio")
	if not balance.find_children("*", "Control", true, false).is_empty() or not balance.find_children("*", "CanvasLayer", true, false).is_empty() or not balance.find_children("*", "Label3D", true, false).is_empty():
		issues.append("o equilíbrio chegada-saída não pode criar UI ou texto")
	return issues
