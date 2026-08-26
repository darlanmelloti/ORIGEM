## verify_r4_forest_depth_balance.gd
## DEV4-R4-FOREST-DEPTH-BALANCE-010

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const DEPTH_NODE_NAME: String = "R4EquilibrioDeProfundidadeLateral"
const BAND_START_Z: float = 153.0
const BAND_END_Z: float = 169.0
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

	var balance: Node = region.get_node_or_null(DEPTH_NODE_NAME)
	var forest_root: Node = region.get_node_or_null("FlorestaDensaRegional")
	if balance == null:
		_fail("Módulo de profundidade lateral R4 ausente.")
	else:
		_validate_module(balance)
	if forest_root == null:
		_fail("Massa de floresta R4 ausente.")
	else:
		_validate_ferns(forest_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_DEPTH_OK] profundidade lateral, corredor e clareira R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_DEPTH_ERROR] %s" % issue)
	quit(1)

func _validate_module(balance: Node) -> void:
	if int(balance.get_meta("r4_depth_balance_adjusted", 0)) <= 0:
		_fail("Nenhum feto R4 recebeu ajuste de profundidade.")
	if int(balance.get_meta("r4_depth_balance_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not balance.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not balance.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_ferns(forest_root: Node) -> void:
	var adjusted: int = 0
	var seen_near_plane: bool = false
	var seen_far_plane: bool = false
	for child: Node in forest_root.get_children():
		if not (child is Node3D):
			continue
		var fern: Node3D = child as Node3D
		if not fern.has_meta("r4_depth_balance_static"):
			continue
		if fern.position.z < BAND_START_Z or fern.position.z > BAND_END_Z:
			_fail("Feto %s excede a faixa de profundidade R4." % fern.name)
		var clearance: float = abs(fern.position.x - _path_x(fern.position.z))
		if clearance < MIN_PATH_CLEARANCE:
			_fail("Feto %s invade o corredor físico." % fern.name)
		if clearance < 7.20:
			seen_near_plane = true
		if clearance > 7.80:
			seen_far_plane = true
		adjusted += 1
	if adjusted <= 0:
		_fail("Nenhum feto foi marcado pelo ajuste de profundidade.")
	if adjusted > 1 and not (seen_near_plane and seen_far_plane):
		_fail("A profundidade lateral não preservou dois planos de leitura.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
