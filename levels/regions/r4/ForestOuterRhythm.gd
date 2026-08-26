## ForestOuterRhythm.gd
## DEV4-R4-FOREST-OUTER-RHYTHM-024
## Ritmo estático da margem exterior R4 com árvores existentes sem colisor, sem criar barreiras ou sistemas dinâmicos.

class_name R4ForestOuterRhythm
extends Node3D

const NODE_NAME: String = "R4RitmoExteriorFlorestal"
const BAND_START_Z: float = 187.5
const BAND_END_Z: float = 192.0
const MIN_PATH_CLEARANCE: float = 11.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestOuterRhythm:
	if parent == null or forest_root == null:
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
	var collision_preserved: int = 0
	var ordinal: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("ArvoreDaFloresta_"):
			continue
		var tree: Node3D = child as Node3D
		var z_value: float = tree.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var tree_index: int = int(String(tree.name).trim_prefix("ArvoreDaFloresta_"))
		if tree_index % 6 == 0:
			collision_preserved += 1
			continue
		var side: float = -1.0 if tree.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = z_value + (-0.18 if ordinal % 2 == 0 else 0.16)
		var target_x: float = float(path_x_at.call(target_z)) + side * (12.30 + float(ordinal % 2) * 1.00)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		tree.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		tree.rotation.y += 0.07 + float((ordinal * 3) % 4) * 0.06
		tree.set_meta("r4_outer_rhythm_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_outer_rhythm_adjusted", adjusted)
	set_meta("r4_outer_rhythm_collision_preserved", collision_preserved)
	set_meta("r4_outer_rhythm_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_RHYTHM] ajustadas=%d colisores_preservados=%d luzes=0" % [adjusted, collision_preserved])
