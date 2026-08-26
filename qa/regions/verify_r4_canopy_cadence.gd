## verify_r4_canopy_cadence.gd
## DEV4-R4-CANOPY-CADENCE-004
## Executar com:
## godot --headless --path . --script res://qa/regions/verify_r4_canopy_cadence.gd

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const CANOPY_NODE_NAME: String = "R4CadenciaEstaticaDasCopas"
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

	var cadence: Node = region.get_node_or_null(CANOPY_NODE_NAME)
	if cadence == null:
		_fail("Módulo de cadência de copas não foi instalado.")
	else:
		_validate_module(cadence)
	_validate_trees(region)

	if _issues.is_empty():
		print("[ORIGEM_R4_CANOPY_OK] cadência estática lateral, clareira Orion e corredor R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_CANOPY_ERROR] %s" % issue)
	quit(1)

func _validate_module(cadence: Node) -> void:
	if int(cadence.get_meta("r4_canopy_adjusted", 0)) <= 0:
		_fail("Nenhuma copa existente recebeu variação estática.")
	if int(cadence.get_meta("r4_canopy_clearing_protected", 0)) <= 0:
		_fail("Não houve confirmação de proteção da clareira Orion.")
	if int(cadence.get_meta("r4_canopy_dynamic_lights", -1)) != 0:
		_fail("A cadência declarou luz dinâmica nova.")
	if not cadence.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo de cadência criou nó de luz.")
	if not cadence.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo de cadência criou colisão nova.")

func _validate_trees(region: Node3D) -> void:
	var roots: Array[String] = ["FlorestaDensaRegional", "CopasFocaisDaFlorestaDensa"]
	var inspected: int = 0
	for root_name: String in roots:
		var canopy_root: Node = region.get_node_or_null(root_name)
		if canopy_root == null:
			_fail("Massa de copa R4 ausente: %s." % root_name)
			continue
		for child: Node in canopy_root.get_children():
			if not (child is Node3D) or not String(child.name).begins_with("ArvoreDaFloresta_") and not String(child.name).begins_with("CopaFocalFlorestal_"):
				continue
			var tree: Node3D = child as Node3D
			var z_value: float = tree.position.z
			var path_x: float = _path_x(z_value)
			if abs(tree.position.x - path_x) < MIN_PATH_CLEARANCE:
				_fail("Copa %s invade a faixa mínima do trilho." % tree.name)
			if z_value >= CLEARING_START_Z and z_value <= CLEARING_END_Z and tree.has_meta("r4_canopy_cadence_static"):
				_fail("Copa %s foi modulada dentro da clareira protegida." % tree.name)
			inspected += 1
	if inspected <= 0:
		_fail("Nenhuma copa R4 foi inspecionada.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
