## ForestOuterSilhouette.gd
## DEV4-R4-FOREST-OUTER-SILHOUETTE-021
## Ajuste estático de árvores R4 existentes na silhueta exterior, sem luz, física, geometria ou efeitos.

class_name R4ForestOuterSilhouette
extends Node3D

const NODE_NAME: String = "R4SilhuetaExteriorDaFloresta"
const BAND_START_Z: float = 181.0
const BAND_END_Z: float = 190.0
const MIN_PATH_CLEARANCE: float = 8.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestOuterSilhouette:
	if parent == null or forest_root == null or not path_x_at.is_valid() or not height_at.is_valid():
		return null
	var existing: R4ForestOuterSilhouette = parent.get_node_or_null(NODE_NAME) as R4ForestOuterSilhouette
	if existing != null:
		return existing
	var silhouette: R4ForestOuterSilhouette = R4ForestOuterSilhouette.new()
	silhouette.name = NODE_NAME
	parent.add_child(silhouette)
	silhouette._apply(path_x_at, height_at, forest_root)
	return silhouette

func _apply(path_x_at: Callable, height_at: Callable, forest_root: Node) -> void:
	var adjusted: int = 0
	var collision_skipped: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("ArvoreDaFloresta_"):
			continue
		var tree: Node3D = child as Node3D
		var z_value: float = tree.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var tree_id: String = String(tree.name).trim_prefix("ArvoreDaFloresta_")
		if forest_root.get_node_or_null("ColisorTroncoFloresta_%s" % tree_id) != null:
			collision_skipped += 1
			continue
		var side: float = -1.0 if tree.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = clampf(z_value + (0.17 if adjusted % 2 == 0 else -0.14), BAND_START_Z, BAND_END_Z)
		var target_x: float = float(path_x_at.call(target_z)) + side * (MIN_PATH_CLEARANCE + 0.42 + float(adjusted % 3) * 0.30)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		tree.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		tree.scale = Vector3(tree.scale.x * 0.96, tree.scale.y * 1.05, tree.scale.z * 0.96)
		tree.rotation.y += side * (0.12 + float(adjusted % 2) * 0.07)
		tree.set_meta("r4_outer_silhouette_static", true)
		adjusted += 1
	set_meta("r4_outer_silhouette_adjusted", adjusted)
	set_meta("r4_outer_silhouette_collision_skipped", collision_skipped)
	set_meta("r4_outer_silhouette_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_SILHOUETTE] ajustadas=%d colisores_preservados=%d luzes=0" % [adjusted, collision_skipped])
