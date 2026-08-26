## ArchMaterialConsistency.gd
## DEV3-R3-ARCH-MATERIAL-CONSISTENCY-012
## Harmoniza materiais já existentes de placas, seixos e pátina sem criar geometria, UI, emissão, luz, VFX, áudio ou colisão.

class_name R3ArchMaterialConsistency
extends Node

const PLATE_STONE: Color = Color(0.145, 0.180, 0.160, 1.0)
const FRACTURE_STONE: Color = Color(0.090, 0.120, 0.108, 1.0)
const RIVER_STONE: Color = Color(0.100, 0.140, 0.145, 1.0)
const PATINA_STONE: Color = Color(0.160, 0.170, 0.135, 1.0)

var adjusted_materials: Array[StandardMaterial3D] = []

static func install(arch: Node3D) -> R3ArchMaterialConsistency:
	if arch == null:
		return null
	var existing: R3ArchMaterialConsistency = arch.get_node_or_null("R3CoerenciaMaterial") as R3ArchMaterialConsistency
	if existing != null:
		return existing
	var consistency: R3ArchMaterialConsistency = R3ArchMaterialConsistency.new()
	consistency.name = "R3CoerenciaMaterial"
	arch.add_child(consistency)
	return consistency

func _ready() -> void:
	var arch: Node3D = get_parent() as Node3D
	if arch == null:
		return
	_apply_lore_materials(arch)
	_apply_patina_materials(arch)

func _apply_lore_materials(arch: Node3D) -> void:
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	if lore == null:
		return
	for plate: Node in lore.find_children("PlacaArqueologica*", "Node3D", false, false):
		_apply_existing_material(plate.get_node_or_null("PedraQuebrada") as MeshInstance3D, PLATE_STONE, 0.90, "r3_material_plate")
		_apply_existing_material(plate.get_node_or_null("FragmentoDaFratura") as MeshInstance3D, FRACTURE_STONE, 0.94, "r3_material_fracture")
	var memory_root: Node3D = lore.get_node_or_null("MemoriaMaterialDoRio") as Node3D
	if memory_root != null:
		for pebble_node: Node in memory_root.find_children("SeixoLavado*", "MeshInstance3D", false, false):
			_apply_existing_material(pebble_node as MeshInstance3D, RIVER_STONE, 0.90, "r3_material_river")

func _apply_patina_materials(arch: Node3D) -> void:
	for mesh_node: Node in arch.find_children("*", "MeshInstance3D", true, false):
		var mesh: MeshInstance3D = mesh_node as MeshInstance3D
		if mesh != null and mesh.has_meta("r3_arch_patina"):
			_apply_existing_material(mesh, PATINA_STONE, 0.94, "r3_material_patina")

func _apply_existing_material(mesh: MeshInstance3D, color_value: Color, roughness_value: float, marker: String) -> void:
	if mesh == null:
		return
	var material: StandardMaterial3D = mesh.material_override as StandardMaterial3D
	if material == null:
		return
	material.albedo_color = color_value
	material.roughness = roughness_value
	material.metallic = 0.0
	material.emission_enabled = false
	mesh.set_meta(marker, true)
	if not adjusted_materials.has(material):
		adjusted_materials.append(material)

func get_contract() -> Dictionary:
	return {
		"adjusted_materials": adjusted_materials.size(),
		"adds_geometry": false,
		"adds_lights": false,
		"adds_emission": false,
		"adds_vfx": false,
		"adds_collision": false,
		"uses_ui": false
	}

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("a coerência material não recebeu o Arco R3")
		return issues
	var consistency: R3ArchMaterialConsistency = arch.get_node_or_null("R3CoerenciaMaterial") as R3ArchMaterialConsistency
	if consistency == null:
		issues.append("a camada de coerência material R3 está em falta")
		return issues
	var contract: Dictionary = consistency.get_contract()
	if int(contract.get("adjusted_materials", 0)) < 4:
		issues.append("a coerência material R3 não ajustou as famílias mínimas de superfície")
	for prohibited_key: String in ["adds_geometry", "adds_lights", "adds_emission", "adds_vfx", "adds_collision", "uses_ui"]:
		if bool(contract.get(prohibited_key, true)):
			issues.append("a coerência material R3 declarou alteração proibida: %s" % prohibited_key)
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	if lore == null:
		issues.append("a leitura arqueológica R3 está em falta")
		return issues
	var plates: Array[Node] = lore.find_children("PlacaArqueologica*", "Node3D", false, false)
	if plates.size() != 2:
		issues.append("a coerência material R3 perdeu as duas placas existentes")
	for plate: Node in plates:
		var slab: MeshInstance3D = plate.get_node_or_null("PedraQuebrada") as MeshInstance3D
		var fracture: MeshInstance3D = plate.get_node_or_null("FragmentoDaFratura") as MeshInstance3D
		if slab == null or not slab.has_meta("r3_material_plate"):
			issues.append("uma placa não recebeu coerência material")
		if fracture == null or not fracture.has_meta("r3_material_fracture"):
			issues.append("uma fratura não recebeu coerência material")
	var river_memory: Node3D = lore.get_node_or_null("MemoriaMaterialDoRio") as Node3D
	if river_memory == null:
		issues.append("a memória material do rio está em falta")
	else:
		var pebbles: Array[Node] = river_memory.find_children("SeixoLavado*", "MeshInstance3D", false, false)
		if pebbles.size() != 3:
			issues.append("a coerência material R3 perdeu os três seixos existentes")
		for pebble_node: Node in pebbles:
			if not pebble_node.has_meta("r3_material_river"):
				issues.append("um seixo não recebeu coerência material")
	var patina_meshes: Array[Node] = arch.find_children("*", "MeshInstance3D", true, false).filter(func(node: Node) -> bool: return node.has_meta("r3_arch_patina"))
	if patina_meshes.is_empty():
		issues.append("a pátina arqueológica não foi encontrada para coerência material")
	else:
		for patina_mesh: Node in patina_meshes:
			if not patina_mesh.has_meta("r3_material_patina"):
				issues.append("uma malha de pátina não recebeu coerência material")
	if not consistency.find_children("*", "CollisionShape3D", true, false).is_empty() or not consistency.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("a coerência material R3 não pode criar colisores")
	if not consistency.find_children("*", "Light3D", true, false).is_empty() or not consistency.find_children("*", "GPUParticles3D", true, false).is_empty() or not consistency.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("a coerência material R3 não pode criar luz, VFX ou áudio")
	return issues
