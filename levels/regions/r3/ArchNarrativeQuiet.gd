## ArchNarrativeQuiet.gd
## DEV3-R3-ARCH-NARRATIVE-QUIET-013
## Relação espacial silenciosa entre marcas arqueológicas existentes, sem texto, UI, malha, luz, emissão, VFX, áudio ou colisão novos.

class_name R3ArchNarrativeQuiet
extends Node

const CORRIDOR_CLEARANCE_X: float = 4.20
const LORE_TARGETS: Dictionary = {
	"PlacaArqueologicaOeste": {"z_shift": -0.09, "yaw_delta": 0.045},
	"MemoriaMaterialDoRio": {"z_shift": 0.08, "yaw_delta": -0.030}
}
const EXIT_TARGETS: Dictionary = {
	"VestigioDePassagem_02": {"z_shift": 0.07, "yaw_delta": -0.035},
	"VestigioDePassagem_03": {"z_shift": 0.10, "yaw_delta": 0.030}
}

var narrative_targets: Array[Node3D] = []

static func install(arch: Node3D) -> R3ArchNarrativeQuiet:
	if arch == null:
		return null
	var existing: R3ArchNarrativeQuiet = arch.get_node_or_null("R3NarrativaSilenciosa") as R3ArchNarrativeQuiet
	if existing != null:
		return existing
	var narrative: R3ArchNarrativeQuiet = R3ArchNarrativeQuiet.new()
	narrative.name = "R3NarrativaSilenciosa"
	arch.add_child(narrative)
	return narrative

func _ready() -> void:
	_apply_existing_lore_relation()
	_apply_existing_exit_relation()

func _apply_existing_lore_relation() -> void:
	var arch: Node3D = get_parent() as Node3D
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D if arch != null else null
	if lore == null:
		return
	for target_name: String in LORE_TARGETS:
		var target: Node3D = lore.get_node_or_null(target_name) as Node3D
		if target == null:
			continue
		var spec: Dictionary = LORE_TARGETS[target_name] as Dictionary
		target.position.z += float(spec["z_shift"])
		target.rotation.y += float(spec["yaw_delta"])
		target.set_meta("r3_narrative_quiet", true)
		target.set_meta("r3_narrative_relation", "rio_para_passagem")
		narrative_targets.append(target)

func _apply_existing_exit_relation() -> void:
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
		target.set_meta("r3_narrative_quiet", true)
		target.set_meta("r3_narrative_relation", "passagem_para_floresta")
		narrative_targets.append(target)

func get_contract() -> Dictionary:
	return {
		"lore_target_count": LORE_TARGETS.size(),
		"exit_target_count": EXIT_TARGETS.size(),
		"narrative_target_count": narrative_targets.size(),
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
		issues.append("a narrativa silenciosa não recebeu o Arco R3")
		return issues
	var narrative: R3ArchNarrativeQuiet = arch.get_node_or_null("R3NarrativaSilenciosa") as R3ArchNarrativeQuiet
	if narrative == null:
		issues.append("a camada de narrativa silenciosa R3 está em falta")
		return issues
	var contract: Dictionary = narrative.get_contract()
	var expected_count: int = LORE_TARGETS.size() + EXIT_TARGETS.size()
	if int(contract.get("narrative_target_count", 0)) != expected_count:
		issues.append("a narrativa silenciosa R3 não relacionou todos os elementos existentes previstos")
	for prohibited_key: String in ["adds_geometry", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
		if bool(contract.get(prohibited_key, true)):
			issues.append("a narrativa silenciosa declarou recurso proibido: %s" % prohibited_key)
	if not bool(contract.get("central_clearance_preserved", false)) or not bool(contract.get("stays_before_r4", false)):
		issues.append("a narrativa silenciosa não declarou passagem segura dentro de R3")
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	if lore == null:
		issues.append("a narrativa silenciosa perdeu a leitura arqueológica existente")
	else:
		for target_name: String in LORE_TARGETS:
			var target: Node3D = lore.get_node_or_null(target_name) as Node3D
			if target == null or not target.has_meta("r3_narrative_quiet"):
				issues.append("a narrativa silenciosa não relacionou o marco existente: %s" % target_name)
			elif target_name == "MemoriaMaterialDoRio" and (not target.has_meta("r3_road_offset") or absf(float(target.get_meta("r3_road_offset"))) < CORRIDOR_CLEARANCE_X):
				issues.append("a memória do rio aproximou-se perigosamente do vão")
			elif target_name != "MemoriaMaterialDoRio" and absf(target.position.x) < CORRIDOR_CLEARANCE_X:
				issues.append("um marco narrativo aproximou-se perigosamente do vão: %s" % target_name)
	var road: Node = arch.get_parent()
	var handoff: Node3D = road.get_node_or_null("R3HandoffParaFloresta") as Node3D if road != null else null
	if handoff == null:
		issues.append("a narrativa silenciosa não encontrou o handoff R3")
	else:
		for target_name: String in EXIT_TARGETS:
			var trace_root: Node3D = handoff.get_node_or_null(target_name) as Node3D
			var fragment_index: int = 2 if target_name.ends_with("02") else 3
			var target: Node3D = trace_root.get_node_or_null("FragmentoArqueologico_%02d" % fragment_index) as Node3D if trace_root != null else null
			if target == null or not target.has_meta("r3_narrative_quiet"):
				issues.append("a narrativa silenciosa não relacionou o vestígio: %s" % target_name)
			if trace_root == null or not trace_root.has_meta("r3_road_offset") or absf(float(trace_root.get_meta("r3_road_offset"))) < CORRIDOR_CLEARANCE_X:
				issues.append("um vestígio narrativo aproximou-se do corredor: %s" % target_name)
	if narrative.get_child_count() != 0:
		issues.append("a narrativa silenciosa não pode criar objetos filhos")
	if not narrative.find_children("*", "CollisionShape3D", true, false).is_empty() or not narrative.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("a narrativa silenciosa não pode criar colisores")
	if not narrative.find_children("*", "Light3D", true, false).is_empty() or not narrative.find_children("*", "GPUParticles3D", true, false).is_empty() or not narrative.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("a narrativa silenciosa não pode criar luz, VFX ou áudio")
	if not narrative.find_children("*", "Control", true, false).is_empty() or not narrative.find_children("*", "CanvasLayer", true, false).is_empty() or not narrative.find_children("*", "Label3D", true, false).is_empty():
		issues.append("a narrativa silenciosa não pode criar UI ou texto")
	return issues
