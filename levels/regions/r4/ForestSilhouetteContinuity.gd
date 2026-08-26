## ForestSilhouetteContinuity.gd
## DEV4-R4-FOREST-SILHOUETTE-CONTINUITY-009
## Ajuste estático de silhuetas R4 sem tocar em instâncias com colisão associada, módulos Dev5 ou sistemas transversais.

class_name R4ForestSilhouetteContinuity
extends Node3D

const NODE_NAME: String = "R4ContinuidadeDasSilhuetas"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 164.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, roots: Array[Node]) -> R4ForestSilhouetteContinuity:
	if parent == null:
		return null
	var existing: R4ForestSilhouetteContinuity = parent.get_node_or_null(NODE_NAME) as R4ForestSilhouetteContinuity
	if existing != null:
		return existing
	var continuity: R4ForestSilhouetteContinuity = R4ForestSilhouetteContinuity.new()
	continuity.name = NODE_NAME
	parent.add_child(continuity)
	continuity._apply(path_x_at, height_at, roots)
	return continuity

func _apply(path_x_at: Callable, height_at: Callable, roots: Array[Node]) -> void:
	var adjusted: int = 0
	var skipped_collision: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for source_root: Node in roots:
		if source_root == null:
			continue
		for child: Node in source_root.get_children():
			if not child is Node3D:
				continue
			var name_value: String = String(child.name)
			if not name_value.begins_with("ArvoreDaFloresta_") and not name_value.begins_with("CopaFocalFlorestal_"):
				continue
			var element: Node3D = child as Node3D
			var z_value: float = element.position.z
			if z_value < BAND_START_Z or z_value > BAND_END_Z:
				continue
			if _has_associated_collision(source_root, name_value):
				skipped_collision += 1
				continue
			var path_x: float = float(path_x_at.call(z_value))
			var side: float = -1.0 if element.position.x < path_x else 1.0
			var target_z: float = z_value + (-0.12 if ordinal % 2 == 0 else 0.16)
			var target_x: float = float(path_x_at.call(target_z)) + side * (7.15 + float((ordinal * 5) % 4) * 0.26)
			if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
				rejected_for_corridor += 1
				ordinal += 1
				continue
			element.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
			var lateral_scale: float = 0.92 + float((ordinal * 7) % 6) * 0.025
			var vertical_scale: float = 0.97 + float((ordinal * 11) % 5) * 0.025
			element.scale = Vector3(element.scale.x * lateral_scale, element.scale.y * vertical_scale, element.scale.z * lateral_scale)
			element.rotation.y += -0.22 + float((ordinal * 3) % 7) * 0.065
			element.set_meta("r4_silhouette_continuity_static", true)
			adjusted += 1
			ordinal += 1
	set_meta("r4_silhouette_adjusted", adjusted)
	set_meta("r4_silhouette_collision_skipped", skipped_collision)
	set_meta("r4_silhouette_corridor_rejected", rejected_for_corridor)
	set_meta("r4_silhouette_dynamic_lights", 0)
	print("[ORIGEM_R4_SILHOUETTE] ajustadas=%d colisores_ignorados=%d corredor_rejeitado=%d luzes=0" % [adjusted, skipped_collision, rejected_for_corridor])

func _has_associated_collision(source_root: Node, name_value: String) -> bool:
	if name_value.begins_with("ArvoreDaFloresta_"):
		var tree_id: String = name_value.trim_prefix("ArvoreDaFloresta_")
		return source_root.get_node_or_null("ColisorTroncoFloresta_%s" % tree_id) != null
	if name_value.begins_with("CopaFocalFlorestal_"):
		var canopy_id: String = name_value.trim_prefix("CopaFocalFlorestal_")
		return source_root.get_node_or_null("ColisorCopaFocalFlorestal_%s" % canopy_id) != null
	return false
