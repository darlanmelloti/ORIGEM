## verify_r4_understory_edge.gd
## DEV4-R4-UNDERSTORY-EDGE-005

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const EDGE_NODE_NAME: String = "R4TransicaoLateralDoSubBosque"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
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

	var edge: Node = region.get_node_or_null(EDGE_NODE_NAME)
	var understory: Node = region.get_node_or_null("SubBosqueDoLimiarArcoFloresta")
	if edge == null:
		_fail("Módulo de transição lateral do sub-bosque ausente.")
	else:
		_validate_module(edge)
	if understory == null:
		_fail("Grupo de sub-bosque R4 ausente.")
	else:
		_validate_understory(understory)

	if _issues.is_empty():
		print("[ORIGEM_R4_UNDERSTORY_OK] sub-bosque lateral, clareira Orion e corredor R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_UNDERSTORY_ERROR] %s" % issue)
	quit(1)

func _validate_module(edge: Node) -> void:
	if int(edge.get_meta("r4_understory_adjusted", 0)) != 12:
		_fail("A tarefa deve reorganizar exatamente os 12 elementos existentes do sub-bosque.")
	if float(edge.get_meta("r4_understory_min_clearance", 0.0)) < MIN_PATH_CLEARANCE:
		_fail("A métrica de afastamento mínimo do trilho ficou abaixo de 6 m.")
	if int(edge.get_meta("r4_understory_dynamic_lights", -1)) != 0:
		_fail("A tarefa declarou luz dinâmica nova.")
	if not edge.find_children("*", "Light3D", true, false).is_empty():
		_fail("A tarefa criou nó de luz.")
	if not edge.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("A tarefa criou colisão nova.")

func _validate_understory(understory: Node) -> void:
	var inspected: int = 0
	for child: Node in understory.get_children():
		if not (child is Node3D):
			continue
		var name_value: String = String(child.name)
		if not name_value.begins_with("FetoSubBosqueLimiar_") and not name_value.begins_with("RochaSubBosqueLimiar_"):
			continue
		var element: Node3D = child as Node3D
		if not element.has_meta("r4_understory_edge_static"):
			_fail("Elemento %s não foi marcado como reorganização estática." % element.name)
		if element.position.z >= CLEARING_START_Z and element.position.z <= CLEARING_END_Z:
			_fail("Elemento %s entrou na clareira Orion protegida." % element.name)
		if abs(element.position.x - _path_x(element.position.z)) < MIN_PATH_CLEARANCE:
			_fail("Elemento %s invade a faixa física de 6 m do trilho." % element.name)
		inspected += 1
	if inspected != 12:
		_fail("Foram inspecionados %d elementos; esperados 12." % inspected)

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
