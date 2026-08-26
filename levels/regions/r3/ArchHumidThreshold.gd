## ArchHumidThreshold.gd
## DEV3-R3-ARCH-HUMID-THRESHOLD-015
## Continuidade húmida lateral por materiais existentes de seixos e marcos R3, sem trilho, texto, UI, geometria, luz, emissão, VFX, áudio ou colisão.

class_name R3ArchHumidThreshold
extends Node

const CORRIDOR_CLEARANCE_X: float = 4.20
const PEBBLE_COLOR: Color = Color(0.095, 0.135, 0.140, 1.0)
const MARKER_COLOR: Color = Color(0.100, 0.130, 0.112, 1.0)
const PEBBLE_ROUGHNESS: float = 0.92
const MARKER_ROUGHNESS: float = 0.88

var adjusted_materials: Array[StandardMaterial3D] = []

static func install(arch: Node3D) -> R3ArchHumidThreshold:
	if arch == null:
		return null
	var existing: R3ArchHumidThreshold = arch.get_node_or_null("R3LimiarHumidoLateral") as R3ArchHumidThreshold
	if existing != null:
		return existing
	var threshold: R3ArchHumidThreshold = R3ArchHumidThreshold.new()
	threshold.name = "R3LimiarHumidoLateral"
	arch.add_child(threshold)
	return threshold

func _ready() -> void:
	var arch: Node3D = get_parent() as Node3D
	if arch == null:
		return
	_apply_river_memory(arch)
	_apply_existing_plate_margins(arch)
	_apply_existing_handoff_markers(arch)

func _apply_river_memory(arch: Node3D) -> void:
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	var memory: Node3D = lore.get_node_or_null("MemoriaMaterialDoRio") as Node3D if lore != null else null
	if memory == null:
		return
	for pebble_node: Node in memory.find_children("SeixoLavado*", "MeshInstance3D", false, false):
		_apply_existing_material(pebble_node as MeshInstance3D, PEBBLE_COLOR, PEBBLE_ROUGHNESS, "r3_humid_threshold_pebble")

func _apply_existing_plate_margins(arch: Node3D) -> void:
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	if lore == null:
		return
	for plate_node: Node in lore.find_children("PlacaArqueologica*", "Node3D", false, false):
		var plate: Node3D = plate_node as Node3D
		if plate == null or absf(plate.position.x) < CORRIDOR_CLEARANCE_X:
			continue
		_apply_existing_material(plate.get_node_or_null("FragmentoDaFratura"), MARKER_COLOR, MARKER_ROUGHNESS, "r3_humid_threshold_margin")

func _apply_existing_handoff_markers(arch: Node3D) -> void:
	var road: Node = arch.get_parent()
	var handoff: Node3D = road.get_node_or_null("R3HandoffParaFloresta") as Node3D if road != null else null
	if handoff == null:
		return
	for marker_node: Node in handoff.find_children("PedraDeOrientacao_*", "Node3D", true, false):
		var marker_3d: Node3D = marker_node as Node3D
		if marker_3d == null:
			continue
		var marker_offset: float = absf(marker_3d.global_position.x - arch.global_position.x)
		if marker_offset < CORRIDOR_CLEARANCE_X:
			continue
		_apply_existing_material(marker_3d, MARKER_COLOR, MARKER_ROUGHNESS, "r3_humid_threshold_marker")

func _apply_existing_material(surface: Node, color_value: Color, roughness_value: float, marker: String) -> void:
	if surface == null:
		return
	var material: StandardMaterial3D = surface.get("material_override") as StandardMaterial3D
	if material == null:
		return
	material.albedo_color = color_value
	material.roughness = roughness_value
	material.metallic = 0.0
	material.emission_enabled = false
	surface.set_meta(marker, true)
	if not adjusted_materials.has(material):
		adjusted_materials.append(material)

func get_contract() -> Dictionary:
	return {
		"adjusted_material_count": adjusted_materials.size(),
		"adds_geometry": false,
		"adds_trail": false,
		"adds_text": false,
		"adds_ui": false,
		"adds_lights": false,
		"adds_emission": false,
		"adds_vfx": false,
		"adds_audio": false,
		"adds_collision": false,
		"central_clearance_preserved": true
	}

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("o limiar húmido lateral não recebeu o Arco R3")
		return issues
	var threshold: R3ArchHumidThreshold = arch.get_node_or_null("R3LimiarHumidoLateral") as R3ArchHumidThreshold
	if threshold == null:
		issues.append("a camada de limiar húmido lateral R3 está em falta")
		return issues
	var contract: Dictionary = threshold.get_contract()
	if int(contract.get("adjusted_material_count", 0)) < 2:
		issues.append("o limiar húmido não ajustou as superfícies laterais existentes")
	for prohibited_key: String in ["adds_geometry", "adds_trail", "adds_text", "adds_ui", "adds_lights", "adds_emission", "adds_vfx", "adds_audio", "adds_collision"]:
		if bool(contract.get(prohibited_key, true)):
			issues.append("o limiar húmido declarou recurso proibido: %s" % prohibited_key)
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	var memory: Node3D = lore.get_node_or_null("MemoriaMaterialDoRio") as Node3D if lore != null else null
	if memory == null or not memory.has_meta("r3_road_offset") or absf(float(memory.get_meta("r3_road_offset"))) < CORRIDOR_CLEARANCE_X:
		issues.append("a memória húmida do rio não permanece lateral")
	elif memory.find_children("SeixoLavado*", "MeshInstance3D", false, false).any(func(node: Node) -> bool: return not node.has_meta("r3_humid_threshold_pebble")):
		issues.append("um seixo existente não recebeu continuidade húmida")
	var lore_margin: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	var marked_margins: Array[Node] = lore_margin.find_children("FragmentoDaFratura", "MeshInstance3D", true, false).filter(func(node: Node) -> bool: return node.has_meta("r3_humid_threshold_margin")) if lore_margin != null else []
	if marked_margins.size() != 2:
		issues.append("as duas fraturas laterais existentes não receberam continuidade húmida")
	if threshold.get_child_count() != 0:
		issues.append("o limiar húmido não pode criar objetos filhos")
	if not threshold.find_children("*", "CollisionShape3D", true, false).is_empty() or not threshold.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("o limiar húmido não pode criar colisores")
	if not threshold.find_children("*", "Light3D", true, false).is_empty() or not threshold.find_children("*", "GPUParticles3D", true, false).is_empty() or not threshold.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("o limiar húmido não pode criar luz, VFX ou áudio")
	return issues
