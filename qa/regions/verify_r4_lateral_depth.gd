## verify_r4_lateral_depth.gd
## DEV4-R4-FOREST-LATERAL-DEPTH-026

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const DEPTH_NODE_NAME: String = "R4ProfundidadeLateralFlorestal"
const BAND_START_Z: float = 170.5
const BAND_END_Z: float = 174.5
const MIN_PATH_CLEARANCE: float = 10.0

var _issues: PackedStringArray = PackedStringArray()

class TerrainPatchStub:
	extends Node3D

	func height_at(_world_x: float, _world_z: float) -> float:
		return 0.0

func _initialize() -> void:
	var world: Node3D = Node3D.new()
	root.add_child(world)
	var terrain: Node3D = TerrainPatchStub.new()
	terrain.name = "TerrainPatch"
	world.add_child(terrain)
	var region: Node3D = FOREST_LAKE_SCRIPT.new() as Node3D
	region.name = "RegiaoFlorestaLagoExploravel"
	world.add_child(region)
	await process_frame
	await process_frame

	var depth: Node = region.get_node_or_null(DEPTH_NODE_NAME)
	var forest_root: Node = region.get_node_or_null("FlorestaDensaRegional")
	if depth == null:
		_fail("Módulo de profundidade lateral R4 ausente.")
	else:
		_validate_module(depth)
	if forest_root == null:
		_fail("Contentor de vegetação R4 ausente.")
	else:
		_validate_trees(forest_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_LATERAL_DEPTH_OK] profundidade, corredor, conector e física R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_LATERAL_DEPTH_ERROR] %s" % issue)
	quit(1)

func _validate_module(depth: Node) -> void:
	if int(depth.get_meta("r4_lateral_depth_adjusted", 0)) != 1:
		_fail("A profundidade lateral deve ajustar exactamente uma árvore R4 existente.")
	if int(depth.get_meta("r4_lateral_depth_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not depth.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not depth.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_trees(forest_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not child.has_meta("r4_lateral_depth_static"):
			continue
		var tree: Node3D = child as Node3D
		if not String(tree.name).begins_with("ArvoreDaFloresta_"):
			_fail("O módulo alterou um elemento que não é árvore R4.")
		var tree_index: int = int(String(tree.name).trim_prefix("ArvoreDaFloresta_"))
		if tree_index % 6 == 0:
			_fail("O módulo alterou árvore R4 com colisor associado.")
		if tree.position.z < BAND_START_Z or tree.position.z > BAND_END_Z:
			_fail("Árvore %s excede a faixa lateral R4." % tree.name)
		if abs(tree.position.x - _path_x(tree.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Árvore %s aproxima-se excessivamente do corredor." % tree.name)
		adjusted += 1
	if adjusted != 1:
		_fail("A profundidade lateral não marcou exactamente uma árvore R4.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
