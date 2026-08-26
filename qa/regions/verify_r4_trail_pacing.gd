## verify_r4_trail_pacing.gd
## DEV4-R4-FOREST-TRAIL-PACING-012

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const PACING_NODE_NAME: String = "R4RitmoVisualDoTrilho"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 170.0
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

	var pacing: Node = region.get_node_or_null(PACING_NODE_NAME)
	var details_root: Node = region.get_node_or_null("RaizesPedrasESinaisP0")
	if pacing == null:
		_fail("Módulo de ritmo visual do trilho ausente.")
	else:
		_validate_module(pacing)
	if details_root == null:
		_fail("Detalhes florestais R4 ausentes.")
	else:
		_validate_stones(details_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_PACING_OK] ritmo visual, lajes, corredor e clareira R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_PACING_ERROR] %s" % issue)
	quit(1)

func _validate_module(pacing: Node) -> void:
	if int(pacing.get_meta("r4_trail_pacing_adjusted", 0)) <= 0:
		_fail("Nenhuma pedra R4 recebeu ritmo visual estático.")
	if int(pacing.get_meta("r4_trail_pacing_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not pacing.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not pacing.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_stones(details_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in details_root.get_children():
		if not (child is Node3D):
			continue
		var stone: Node3D = child as Node3D
		if not stone.has_meta("r4_trail_pacing_static"):
			continue
		if not String(stone.name).begins_with("PedraHumidaFlorestal_"):
			_fail("Elemento não elegível foi marcado: %s." % stone.name)
		if stone.position.z < BAND_START_Z or stone.position.z > BAND_END_Z:
			_fail("Pedra %s excede a faixa R4." % stone.name)
		if abs(stone.position.x - _path_x(stone.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Pedra %s invade o corredor físico." % stone.name)
		adjusted += 1
	if adjusted <= 0:
		_fail("Nenhuma pedra R4 foi marcada pelo ritmo visual.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
