## verify_r4_orion_return.gd
## DEV4-R4-FOREST-ORION-RETURN-031

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const RETURN_NODE_NAME: String = "R4RetornoFlorestalOrion"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 158.0
const MIN_PATH_CLEARANCE: float = 7.5

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

	var reading: Node = region.get_node_or_null(RETURN_NODE_NAME)
	var clusters_root: Node = region.get_node_or_null("CopasFocaisDaFlorestaDensa")
	if reading == null:
		_fail("Módulo de retorno Orion R4 ausente.")
	else:
		_validate_module(reading)
	if clusters_root == null:
		_fail("Contentor de copas focais R4 ausente.")
	else:
		_validate_canopies(clusters_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_ORION_RETURN_OK] retorno, clareira, corredor e física R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_ORION_RETURN_ERROR] %s" % issue)
	quit(1)

func _validate_module(reading: Node) -> void:
	if int(reading.get_meta("r4_orion_return_adjusted", 0)) != 1:
		_fail("O retorno Orion deve ajustar exactamente uma copa R4 existente.")
	if int(reading.get_meta("r4_orion_return_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not reading.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not reading.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_canopies(clusters_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in clusters_root.get_children():
		if not child is Node3D or not child.has_meta("r4_orion_return_static"):
			continue
		var canopy: Node3D = child as Node3D
		if not String(canopy.name).begins_with("CopaFocalFlorestal_"):
			_fail("O módulo alterou um elemento que não é copa focal R4.")
		var canopy_index: int = int(String(canopy.name).trim_prefix("CopaFocalFlorestal_"))
		if canopy_index in [0, 3, 5]:
			_fail("O módulo alterou copa R4 com colisor associado.")
		if canopy.position.z < BAND_START_Z or canopy.position.z > BAND_END_Z:
			_fail("Copa %s excede a faixa do retorno Orion R4." % canopy.name)
		if abs(canopy.position.x - _path_x(canopy.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Copa %s aproxima-se excessivamente do corredor." % canopy.name)
		adjusted += 1
	if adjusted != 1:
		_fail("O retorno Orion não marcou exactamente uma copa R4.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
