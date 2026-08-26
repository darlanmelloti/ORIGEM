## verify_r4_margin_continuity.gd
## DEV4-R4-FOREST-MARGIN-CONTINUITY-013

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const MARGIN_NODE_NAME: String = "R4ContinuidadeDaMargemFlorestal"
const BAND_START_Z: float = 171.0
const BAND_END_Z: float = 181.0
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

	var continuity: Node = region.get_node_or_null(MARGIN_NODE_NAME)
	var details_root: Node = region.get_node_or_null("RaizesPedrasESinaisP0")
	if continuity == null:
		_fail("Módulo de continuidade da margem R4 ausente.")
	else:
		_validate_module(continuity)
	if details_root == null:
		_fail("Detalhes florestais R4 ausentes.")
	else:
		_validate_roots(details_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_MARGIN_OK] margem ambiental, corredor e clareira R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_MARGIN_ERROR] %s" % issue)
	quit(1)

func _validate_module(continuity: Node) -> void:
	if int(continuity.get_meta("r4_margin_continuity_adjusted", 0)) <= 0:
		_fail("Nenhuma raiz R4 recebeu continuidade estática de margem.")
	if int(continuity.get_meta("r4_margin_continuity_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not continuity.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not continuity.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_roots(details_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in details_root.get_children():
		if not (child is MeshInstance3D):
			continue
		var root_mesh: MeshInstance3D = child as MeshInstance3D
		if not root_mesh.has_meta("r4_margin_continuity_static"):
			continue
		if root_mesh.position.z < BAND_START_Z or root_mesh.position.z > BAND_END_Z:
			_fail("Raiz %s excede a faixa de margem R4." % root_mesh.name)
		if abs(root_mesh.position.x - _path_x(root_mesh.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Raiz %s invade o corredor físico." % root_mesh.name)
		adjusted += 1
	if adjusted <= 0:
		_fail("Nenhuma raiz R4 foi marcada pela continuidade de margem.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
