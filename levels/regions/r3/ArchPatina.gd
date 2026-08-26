## ArchPatina.gd
## DEV3-R3-ARCH-PATINA-007
## Pátina material localizada em malhas já existentes do Arco, sem adicionar geometria, luz, emissão ou colisão.

class_name R3ArchPatina
extends Node

const TARGET_ROOTS: PackedStringArray = [
	"FragmentoDaCoroaDoArco_00",
	"FragmentoDaCoroaDoArco_02",
	"FragmentoDaCoroaDoArco_04",
	"GrupoDeBaseArco_01",
	"GrupoDeBaseArco_04"
]

var applied_meshes: Array[MeshInstance3D] = []

static func install(arch: Node3D) -> R3ArchPatina:
	if arch == null:
		return null
	var existing: R3ArchPatina = arch.get_node_or_null("R3PatinaArqueologica") as R3ArchPatina
	if existing != null:
		return existing
	var patina: R3ArchPatina = R3ArchPatina.new()
	patina.name = "R3PatinaArqueologica"
	arch.add_child(patina)
	return patina

func _ready() -> void:
	_apply_to_existing_arch_meshes()

func _apply_to_existing_arch_meshes() -> void:
	var arch: Node3D = get_parent() as Node3D
	if arch == null:
		return
	var patina_material: StandardMaterial3D = _make_patina_material()
	for target_name: String in TARGET_ROOTS:
		var target_root: Node = arch.get_node_or_null(target_name)
		if target_root == null:
			continue
		var target_meshes: Array[Node] = target_root.find_children("*", "MeshInstance3D", true, false)
		if target_root is MeshInstance3D:
			target_meshes.append(target_root)
		for mesh_node: Node in target_meshes:
			var mesh: MeshInstance3D = mesh_node as MeshInstance3D
			if mesh == null:
				continue
			mesh.material_override = patina_material
			mesh.set_meta("r3_arch_patina", true)
			applied_meshes.append(mesh)

func get_contract() -> Dictionary:
	return {
		"target_roots": TARGET_ROOTS.size(),
		"applied_meshes": applied_meshes.size(),
		"adds_geometry": false,
		"adds_lights": false,
		"adds_vfx": false,
		"adds_collision": false
	}

func _make_patina_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.19, 0.20, 0.155, 1.0)
	material.roughness = 0.93
	material.metallic = 0.0
	material.emission_enabled = false
	return material

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("a pátina não recebeu o Arco R3")
		return issues
	var patina: R3ArchPatina = arch.get_node_or_null("R3PatinaArqueologica") as R3ArchPatina
	if patina == null:
		issues.append("a camada de pátina arqueológica R3 está em falta")
		return issues
	var contract: Dictionary = patina.get_contract()
	if int(contract.get("target_roots", 0)) != TARGET_ROOTS.size():
		issues.append("a pátina R3 perdeu a declaração dos cinco alvos existentes")
	if int(contract.get("applied_meshes", 0)) < TARGET_ROOTS.size():
		issues.append("a pátina R3 não atingiu todos os fragmentos materiais previstos")
	for target_name: String in TARGET_ROOTS:
		var target_root: Node = arch.get_node_or_null(target_name)
		if target_root == null:
			issues.append("um alvo existente da pátina R3 está em falta: %s" % target_name)
			continue
		var meshes: Array[Node] = target_root.find_children("*", "MeshInstance3D", true, false)
		if target_root is MeshInstance3D:
			meshes.append(target_root)
		if meshes.is_empty():
			issues.append("um alvo da pátina R3 não contém malha existente: %s" % target_name)
		for mesh_node: Node in meshes:
			var mesh: MeshInstance3D = mesh_node as MeshInstance3D
			if mesh == null or not mesh.has_meta("r3_arch_patina") or mesh.material_override == null:
				issues.append("a pátina R3 não foi aplicada à malha de %s" % target_name)
	if not patina.find_children("*", "CollisionShape3D", true, false).is_empty() or not patina.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("a pátina R3 não pode criar colisores")
	if not patina.find_children("*", "Light3D", true, false).is_empty() or not patina.find_children("*", "GPUParticles3D", true, false).is_empty() or not patina.find_children("*", "AudioStreamPlayer", true, false).is_empty():
		issues.append("a pátina R3 não pode criar luz, VFX ou áudio")
	return issues
