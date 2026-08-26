## verify_r4_forest_approach_rhythm.gd
## DEV4-R4-FOREST-APPROACH-RHYTHM-007

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const RHYTHM_NODE_NAME: String = "R4CadenciaDaAproximacaoMajestic"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const APPROACH_START_Z: float = 152.0
const APPROACH_END_Z: float = 170.0
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

	var rhythm: Node = region.get_node_or_null(RHYTHM_NODE_NAME)
	if rhythm == null:
		_fail("Módulo de cadência de aproximação R4 ausente.")
	else:
		_validate_module(rhythm)
	_validate_roots(region)

	if _issues.is_empty():
		print("[ORIGEM_R4_APPROACH_OK] aproximação R4, clareira, corredor e fronteira Dev5 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_APPROACH_ERROR] %s" % issue)
	quit(1)

func _validate_module(rhythm: Node) -> void:
	if int(rhythm.get_meta("r4_forest_approach_adjusted", 0)) <= 0:
		_fail("Nenhuma instância existente recebeu cadência de aproximação.")
	if int(rhythm.get_meta("r4_forest_approach_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not rhythm.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not rhythm.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_roots(region: Node3D) -> void:
	var roots: Array[String] = ["FlorestaDensaRegional", "CopasFocaisDaFlorestaDensa"]
	var adjusted: int = 0
	for root_name: String in roots:
		var source_root: Node = region.get_node_or_null(root_name)
		if source_root == null:
			_fail("Massa R4 ausente: %s." % root_name)
			continue
		for child: Node in source_root.get_children():
			if not (child is Node3D):
				continue
			var element: Node3D = child as Node3D
			if not element.has_meta("r4_forest_approach_static"):
				continue
			if element.position.z < APPROACH_START_Z or element.position.z > APPROACH_END_Z:
				_fail("Elemento %s excede a faixa R4 antes do conector Majestic." % element.name)
			if element.position.z >= CLEARING_START_Z and element.position.z <= CLEARING_END_Z:
				_fail("Elemento %s invadiu a clareira Orion." % element.name)
			if abs(element.position.x - _path_x(element.position.z)) < MIN_PATH_CLEARANCE:
				_fail("Elemento %s entra na faixa física de 6 m do trilho." % element.name)
			adjusted += 1
	if adjusted <= 0:
		_fail("Nenhum elemento R4 marcado pela cadência de aproximação.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
