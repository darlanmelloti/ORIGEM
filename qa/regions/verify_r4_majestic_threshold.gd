## verify_r4_majestic_threshold.gd
## DEV4-R4-FOREST-MAJESTIC-THRESHOLD-022

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const THRESHOLD_NODE_NAME: String = "R4LimiarMajesticFlorestal"
const BAND_START_Z: float = 182.0
const BAND_END_Z: float = 186.0
const MIN_PATH_CLEARANCE: float = 6.4

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

	var threshold: Node = region.get_node_or_null(THRESHOLD_NODE_NAME)
	var details_root: Node = region.get_node_or_null("RaizesPedrasESinaisP0")
	if threshold == null:
		_fail("Módulo de limiar Majestic R4 ausente.")
	else:
		_validate_module(threshold)
	if details_root == null:
		_fail("Contentor de detalhes R4 ausente.")
	else:
		_validate_rocks(details_root)

	if _issues.is_empty():
		print("[ORIGEM_R4_MAJESTIC_THRESHOLD_OK] limiar, conector, corredor e física R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_MAJESTIC_THRESHOLD_ERROR] %s" % issue)
	quit(1)

func _validate_module(threshold: Node) -> void:
	if int(threshold.get_meta("r4_majestic_threshold_adjusted", 0)) <= 0:
		_fail("Nenhuma pedra húmida R4 recebeu clarificação estática do limiar.")
	if int(threshold.get_meta("r4_majestic_threshold_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not threshold.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not threshold.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_rocks(details_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in details_root.get_children():
		if not child is Node3D or not child.has_meta("r4_majestic_threshold_static"):
			continue
		var rock: Node3D = child as Node3D
		if not String(rock.name).begins_with("PedraHumidaFlorestal_"):
			_fail("O módulo alterou um elemento que não é pedra húmida R4.")
		if rock.position.z < BAND_START_Z or rock.position.z > BAND_END_Z:
			_fail("Pedra %s excede a faixa do limiar R4." % rock.name)
		if abs(rock.position.x - _path_x(rock.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Pedra %s aproxima-se excessivamente do corredor." % rock.name)
		adjusted += 1
	if adjusted <= 0:
		_fail("Nenhuma pedra húmida R4 foi marcada pelo limiar Majestic.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
