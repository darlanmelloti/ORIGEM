## ForestLiminalDepth.gd
## DEV4-R4-FOREST-LIMINAL-DEPTH-018
## Reforço estático da profundidade lateral no limiar exterior R4, sem criar nós, física ou efeitos.

class_name R4ForestLiminalDepth
extends Node3D

const NODE_NAME: String = "R4ProfundidadeLiminarFlorestal"
const BAND_START_Z: float = 175.0
const BAND_END_Z: float = 181.0
const MIN_PATH_CLEARANCE: float = 9.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, forest_root: Node) -> R4ForestLiminalDepth:
	if parent == null or forest_root == null:
		return null
	var existing: R4ForestLiminalDepth = parent.get_node_or_null(NODE_NAME) as R4ForestLiminalDepth
	if existing != null:
		return existing
	var depth: R4ForestLiminalDepth = R4ForestLiminalDepth.new()
	depth.name = NODE_NAME
	parent.add_child(depth)
	depth._apply(path_x_at, height_at, forest_root)
	return depth

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
		var target_z: float = z_value + (-0.32 if ordinal % 2 == 0 else 0.28)
		var target_x: float = float(path_x_at.call(target_z)) + side * (11.20 + float(ordinal % 3) * 1.15)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		tree.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		tree.rotation.y += -0.11 + float((ordinal * 3) % 5) * 0.08
		tree.set_meta("r4_liminal_depth_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_liminal_depth_adjusted", adjusted)
	set_meta("r4_liminal_depth_collision_preserved", collision_preserved)
	set_meta("r4_liminal_depth_dynamic_lights", 0)
	print("[ORIGEM_R4_LIMINAL_DEPTH] ajustadas=%d colisores_preservados=%d luzes=0" % [adjusted, collision_preserved])
