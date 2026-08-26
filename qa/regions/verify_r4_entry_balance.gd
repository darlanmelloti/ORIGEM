## verify_r4_entry_balance.gd
## DEV4-R4-FOREST-ENTRY-BALANCE-017

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const ENTRY_NODE_NAME: String = "R4EquilibrioDaEntradaFlorestal"
const BAND_START_Z: float = 116.0
const BAND_END_Z: float = 125.5
const MIN_PATH_CLEARANCE: float = 6.0

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

	var balance: Node = region.get_node_or_null(ENTRY_NODE_NAME)
	var forest_root: Node = region.get_node_or_null("FlorestaDensaRegional")
	if balance == null:
		_fail("Módulo de equilíbrio da entrada R4 ausente.")
	else:
		_validate_module(balance)
	if forest_root == null:
		_fail("Contentor de vegetação R4 ausente.")
	else:
		_validate_ferns(forest_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_ENTRY_BALANCE_OK] entrada, clareira Orion, corredor e física R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_ENTRY_BALANCE_ERROR] %s" % issue)
	quit(1)

func _validate_module(balance: Node) -> void:
	if int(balance.get_meta("r4_entry_balance_adjusted", 0)) <= 0:
		_fail("Nenhum feto R4 recebeu equilíbrio estático de entrada.")
	if int(balance.get_meta("r4_entry_balance_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not balance.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not balance.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_ferns(forest_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in forest_root.get_children():
		if not child is Node3D or not child.has_meta("r4_entry_balance_static"):
			continue
		var fern: Node3D = child as Node3D
		if not String(fern.name).begins_with("FetoFloresta_"):
			_fail("O módulo alterou um elemento que não é feto R4.")
		if fern.position.z < BAND_START_Z or fern.position.z > BAND_END_Z:
			_fail("Feto %s excede a faixa de entrada R4." % fern.name)
		if abs(fern.position.x - _path_x(fern.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Feto %s invade o corredor R4." % fern.name)
		adjusted += 1
	if adjusted <= 0:
		_fail("Nenhum feto R4 foi marcado pelo equilíbrio da entrada.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
