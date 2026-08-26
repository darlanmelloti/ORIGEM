## ForestOuterRhythm.gd
## DEV4-R4-FOREST-OUTER-RHYTHM-022
## Variação estática apenas em fetos R4 existentes na borda exterior antes de Majestic.

class_name R4ForestOuterRhythm
extends Node3D

const NODE_NAME: String = "R4RitmoExteriorDaFloresta"
const BAND_START_Z: float = 181.0
const BAND_END_Z: float = 190.0
const MIN_PATH_CLEARANCE: float = 8.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestOuterRhythm:
	if parent == null or forest_root == null or not path_x_at.is_valid() or not height_at.is_valid():
		return null
	var existing: R4ForestOuterRhythm = parent.get_node_or_null(NODE_NAME) as R4ForestOuterRhythm
	if existing != null:
		return existing
	var rhythm: R4ForestOuterRhythm = R4ForestOuterRhythm.new()
	rhythm.name = NODE_NAME
	parent.add_child(rhythm)
	rhythm._apply(path_x_at, height_at, forest_root)
	return rhythm

func _apply(path_x_at: Callable, height_at: Callable, forest_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("ArvoreDaFloresta_"):
			continue
		var tree: Node3D = child as Node3D
		var z_value: float = tree.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var tree_id: String = String(tree.name).trim_prefix("ArvoreDaFloresta_")
		if forest_root.get_node_or_null("ColisorTroncoFloresta_%s" % tree_id) != null:
			continue
		var side: float = -1.0 if tree.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = clampf(z_value + (0.18 if adjusted % 2 == 0 else -0.16), BAND_START_Z, BAND_END_Z)
		var target_x: float = float(path_x_at.call(target_z)) + side * (MIN_PATH_CLEARANCE + 0.42 + float(adjusted % 3) * 0.22)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		tree.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		tree.scale = Vector3(tree.scale.x * 0.985, tree.scale.y * (1.01 + float(adjusted % 2) * 0.015), tree.scale.z * 0.985)
		tree.rotation.y += side * (0.14 + float(adjusted % 2) * 0.06)
		tree.set_meta("r4_outer_rhythm_static", true)
		adjusted += 1
	set_meta("r4_outer_rhythm_adjusted", adjusted)
	set_meta("r4_outer_rhythm_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_RHYTHM] arvores_existentes_ajustadas=%d luzes=0" % adjusted)
