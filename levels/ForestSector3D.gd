## Floresta sectorizada reutilizável: instância uma malha 3D real por sector espacial.
## Não utiliza billboards, planos de fundo ou cards de vegetação.

extends Node3D
class_name ForestSector3D

func build_sector(sector_name: String, source_mesh: Mesh, instances: Array, cull_aabb: AABB, shadows_enabled: bool = false) -> void:
	if source_mesh == null or instances.is_empty():
		return
	var multimesh: MultiMesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = source_mesh
	multimesh.instance_count = instances.size()
	multimesh.visible_instance_count = instances.size()
	multimesh.custom_aabb = cull_aabb

	for index: int in range(instances.size()):
		var item: Dictionary = instances[index] as Dictionary
		var position_value: Vector3 = item.get("position", Vector3.ZERO) as Vector3
		var scale_value: float = float(item.get("scale", 1.0))
		var yaw: float = float(item.get("yaw", 0.0))
		var basis: Basis = Basis(Vector3.UP, yaw).scaled(Vector3.ONE * scale_value)
		multimesh.set_instance_transform(index, Transform3D(basis, position_value))

	var sector: MultiMeshInstance3D = MultiMeshInstance3D.new()
	sector.name = sector_name
	sector.multimesh = multimesh
	sector.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON if shadows_enabled else GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	sector.visibility_range_end = 92.0
	sector.visibility_range_end_margin = 14.0
	add_child(sector)
