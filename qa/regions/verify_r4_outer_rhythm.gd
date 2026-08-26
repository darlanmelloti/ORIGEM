## verify_r4_outer_rhythm.gd
## DEV4-R4-FOREST-OUTER-RHYTHM-024

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const RHYTHM_NODE_NAME: String = "R4RitmoExteriorFlorestal"
const BAND_START_Z: float = 187.5
const BAND_END_Z: float = 192.0
const MIN_PATH_CLEARANCE: float = 11.0

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

	var rhythm: Node = region.get_node_or_null(RHYTHM_NODE_NAME)
	var forest_root: Node = region.get_node_or_null("FlorestaDensaRegional")
	if rhythm == null:
		_fail("Módulo de ritmo exterior R4 ausente.")
	else:
		_validate_module(rhythm)
	if forest_root == null:
		_fail("Contentor de vegetação R4 ausente.")
	else:
		_validate_trees(forest_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_OUTER_RHYTHM_OK] ritmo, conector, corredor e física R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_OUTER_RHYTHM_ERROR] %s" % issue)
	quit(1)

func _validate_module(rhythm: Node) -> void:
	if int(rhythm.get_meta("r4_outer_rhythm_adjusted", 0)) <= 0:
		_fail("Nenhuma árvore R4 recebeu modulação estática de ritmo exterior.")
	if int(rhythm.get_meta("r4_outer_rhythm_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not rhythm.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not rhythm.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_trees(forest_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not child.has_meta("r4_outer_rhythm_static"):
			continue
		var tree: Node3D = child as Node3D
		if not String(tree.name).begins_with("ArvoreDaFloresta_"):
			_fail("O módulo alterou um elemento que não é árvore R4.")
		var tree_index: int = int(String(tree.name).trim_prefix("ArvoreDaFloresta_"))
		if tree_index % 6 == 0:
			_fail("O módulo alterou árvore R4 com colisor associado.")
		if tree.position.z < BAND_START_Z or tree.position.z > BAND_END_Z:
			_fail("Árvore %s excede a faixa exterior R4." % tree.name)
		if abs(tree.position.x - _path_x(tree.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Árvore %s aproxima-se excessivamente do corredor." % tree.name)
		adjusted += 1
	if adjusted <= 0:
		_fail("Nenhuma árvore R4 foi marcada pelo ritmo exterior.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
