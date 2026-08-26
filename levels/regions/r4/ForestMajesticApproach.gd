## ForestMajesticApproach.gd
## DEV4-R4-FOREST-MAJESTIC-APPROACH-029
## Aproximação estática a Majestic com uma árvore R4 existente sem colisor, preservando o trilho e o conector.

class_name R4ForestMajesticApproach
extends Node3D

const NODE_NAME: String = "R4AproximacaoFlorestalMajestic"
const BAND_START_Z: float = 181.5
const BAND_END_Z: float = 184.0
const MIN_PATH_CLEARANCE: float = 11.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestMajesticApproach:
	if parent == null or forest_root == null:
		return null
	var existing: R4ForestMajesticApproach = parent.get_node_or_null(NODE_NAME) as R4ForestMajesticApproach
	if existing != null:
		return existing
	var approach: R4ForestMajesticApproach = R4ForestMajesticApproach.new()
	approach.name = NODE_NAME
	parent.add_child(approach)
	approach._apply(path_x_at, height_at, forest_root)
	return approach

func _apply(path_x_at: Callable, height_at: Callable, forest_root: Node) -> void:
	var adjusted: int = 0
	var collision_preserved: int = 0
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
		var target_z: float = z_value - 0.12
		var target_x: float = float(path_x_at.call(target_z)) + side * 12.30
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		tree.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		tree.rotation.y += 0.08
		tree.set_meta("r4_majestic_approach_static", true)
		adjusted = 1
		break
	set_meta("r4_majestic_approach_adjusted", adjusted)
	set_meta("r4_majestic_approach_collision_preserved", collision_preserved)
	set_meta("r4_majestic_approach_dynamic_lights", 0)
	print("[ORIGEM_R4_MAJESTIC_APPROACH] ajustadas=%d colisores_preservados=%d luzes=0" % [adjusted, collision_preserved])
