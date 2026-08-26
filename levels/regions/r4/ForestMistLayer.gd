## ForestMistLayer.gd
## DEV4-R4-MIST-LAYER-002
## Perspetiva atmosférica local aplicada aos materiais já existentes em R4.
## Não cria geometria, partículas, volumes de neblina, pós-processamento ou luzes.

class_name R4ForestMistLayer
extends Node3D

const NODE_NAME: String = "R4CamadaNeblinaLocal"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const MIST_START_Z: float = 112.0
const MIST_END_Z: float = 188.0
const MIST_TINT: Color = Color(0.46, 0.55, 0.52, 1.0)
const MAX_TINT_FACTOR: float = 0.14

static func install(parent: Node3D, targets: Array[Node]) -> R4ForestMistLayer:
	if parent == null:
		return null
	var existing: R4ForestMistLayer = parent.get_node_or_null(NODE_NAME) as R4ForestMistLayer
	if existing != null:
		return existing
	var layer: R4ForestMistLayer = R4ForestMistLayer.new()
	layer.name = NODE_NAME
	parent.add_child(layer)
	layer._apply(targets)
	return layer

func _apply(targets: Array[Node]) -> void:
	var treated_meshes: int = 0
	var protected_clearing_meshes: int = 0
	for target: Node in targets:
		if target == null:
			continue
		for mesh_node: Node in target.find_children("*", "MeshInstance3D", true, false):
			var mesh: MeshInstance3D = mesh_node as MeshInstance3D
			if mesh == null or mesh.mesh == null:
				continue
			var weight: float = _mist_weight(mesh.global_position.z)
			if weight <= 0.0:
				if mesh.global_position.z >= CLEARING_START_Z and mesh.global_position.z <= CLEARING_END_Z:
					protected_clearing_meshes += 1
				continue
			if _apply_material_mist(mesh, weight):
				mesh.set_meta("r4_mist_weight", weight)
				treated_meshes += 1
	set_meta("r4_mist_treated_meshes", treated_meshes)
	set_meta("r4_mist_protected_clearing_meshes", protected_clearing_meshes)
	set_meta("r4_mist_dynamic_lights", 0)
	print("[ORIGEM_R4_MIST] materiais=%d clareira_protegida=%d luzes=0" % [treated_meshes, protected_clearing_meshes])

func _mist_weight(world_z: float) -> float:
	if world_z >= CLEARING_START_Z and world_z <= CLEARING_END_Z:
		return 0.0
	var normalized_distance: float = clampf((world_z - MIST_START_Z) / (MIST_END_Z - MIST_START_Z), 0.0, 1.0)
	# Atenuação próxima do limiar e da saída: a camada separa massas, nunca encobre o caminho ou Orion.
	return sin(normalized_distance * PI) * MAX_TINT_FACTOR

func _apply_material_mist(mesh: MeshInstance3D, weight: float) -> bool:
	var changed: bool = false
	for surface_index: int in range(mesh.mesh.get_surface_count()):
		var source: StandardMaterial3D = mesh.get_active_material(surface_index) as StandardMaterial3D
		if source == null:
			continue
		var mist_material: StandardMaterial3D = source.duplicate() as StandardMaterial3D
		mist_material.albedo_color = source.albedo_color.lerp(MIST_TINT, weight)
		mist_material.roughness = minf(1.0, source.roughness + weight * 0.18)
		mist_material.emission_enabled = false
		mesh.set_surface_override_material(surface_index, mist_material)
		changed = true
	return changed
