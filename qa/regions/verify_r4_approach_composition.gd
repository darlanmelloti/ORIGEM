## verify_r4_approach_composition.gd
## DEV4-R4-FOREST-APPROACH-COMPOSITION-014

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const COMPOSITION_NODE_NAME: String = "R4ComposicaoDaAproximacao"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 174.0
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

	var composition: Node = region.get_node_or_null(COMPOSITION_NODE_NAME)
	var canopy_root: Node = region.get_node_or_null("CopasFocaisDaFlorestaDensa")
	if composition == null:
		_fail("Módulo de composição da aproximação R4 ausente.")
	else:
		_validate_module(composition)
	if canopy_root == null:
		_fail("Copas focais R4 ausentes.")
	else:
		_validate_canopies(canopy_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_COMPOSITION_OK] composição, corredor, clareira e física R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_COMPOSITION_ERROR] %s" % issue)
	quit(1)

func _validate_module(composition: Node) -> void:
	if int(composition.get_meta("r4_approach_composition_adjusted", 0)) <= 0:
		_fail("Nenhuma copa R4 recebeu composição estática.")
	if int(composition.get_meta("r4_approach_composition_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not composition.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not composition.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_canopies(canopy_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in canopy_root.get_children():
		if not (child is Node3D):
			continue
		var canopy: Node3D = child as Node3D
		if not canopy.has_meta("r4_approach_composition_static"):
			continue
		if canopy.position.z < BAND_START_Z or canopy.position.z > BAND_END_Z:
			_fail("Copa %s excede a faixa de composição R4." % canopy.name)
		if abs(canopy.position.x - _path_x(canopy.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Copa %s invade o corredor físico." % canopy.name)
		var canopy_id: String = String(canopy.name).trim_prefix("CopaFocalFlorestal_")
		if canopy_root.get_node_or_null("ColisorCopaFocalFlorestal_%s" % canopy_id) != null:
			_fail("Copa com colisão associada foi transformada: %s." % canopy.name)
		adjusted += 1
	if adjusted <= 0:
		_fail("Nenhuma copa focal R4 foi marcada pela composição.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
