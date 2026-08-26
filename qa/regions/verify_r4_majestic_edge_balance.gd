## verify_r4_majestic_edge_balance.gd
## DEV4-R4-MAJESTIC-EDGE-BALANCE-008

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const EDGE_NODE_NAME: String = "R4EquilibrioDaBordaMajestic"
const EDGE_START_Z: float = 165.0
const EDGE_END_Z: float = 174.0
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

	var balance: Node = region.get_node_or_null(EDGE_NODE_NAME)
	if balance == null:
		_fail("Módulo de equilíbrio da borda Majestic ausente.")
	else:
		_validate_module(balance)
	_validate_r4_elements(region)
	_validate_dev5_untouched(region)

	if _issues.is_empty():
		print("[ORIGEM_R4_EDGE_OK] borda R4→R5, corredor e módulos Dev5 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_EDGE_ERROR] %s" % issue)
	quit(1)

func _validate_module(balance: Node) -> void:
	if int(balance.get_meta("r4_majestic_edge_adjusted", 0)) <= 0:
		_fail("Nenhuma instância R4 recebeu equilíbrio de borda.")
	if int(balance.get_meta("r4_majestic_edge_dynamic_lights", -1)) != 0:
		_fail("O módulo declarou luz dinâmica nova.")
	if not balance.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not balance.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_r4_elements(region: Node3D) -> void:
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
			if not element.has_meta("r4_majestic_edge_static"):
				continue
			if element.position.z < EDGE_START_Z or element.position.z > EDGE_END_Z:
				_fail("Elemento %s excede a faixa exterior R4." % element.name)
			if abs(element.position.x - _path_x(element.position.z)) < MIN_PATH_CLEARANCE:
				_fail("Elemento %s invade o corredor físico." % element.name)
			adjusted += 1
	if adjusted <= 0:
		_fail("Nenhum elemento R4 marcado pelo equilíbrio de borda.")

func _validate_dev5_untouched(region: Node3D) -> void:
	for node: Node in region.find_children("*", "Node", true, false):
		if String(node.name).begins_with("R5") and node.has_meta("r4_majestic_edge_static"):
			_fail("Elemento Dev5 foi marcado pelo módulo R4: %s." % node.name)

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
