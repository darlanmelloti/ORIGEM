## verify_r4_orion_vista_framing.gd
## DEV4-R4-ORION-VISTA-FRAMING-006

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const VISTA_NODE_NAME: String = "R4EnquadramentoLateralDeOrion"
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

	var framing: Node = region.get_node_or_null(VISTA_NODE_NAME)
	if framing == null:
		_fail("Módulo de enquadramento Orion não foi instalado.")
	else:
		_validate_module(framing)
	_validate_canopies(region)

	if _issues.is_empty():
		print("[ORIGEM_R4_VISTA_OK] enquadramento lateral de Orion, clareira e corredor R4 preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_VISTA_ERROR] %s" % issue)
	quit(1)

func _validate_module(framing: Node) -> void:
	if int(framing.get_meta("r4_orion_vista_adjusted", 0)) != 6:
		_fail("Foram esperadas 6 copas laterais ajustadas para o enquadramento Orion.")
	if int(framing.get_meta("r4_orion_vista_clearing_protected", 0)) != 2:
		_fail("As duas copas focais presentes na faixa protegida não foram preservadas.")
	if int(framing.get_meta("r4_orion_vista_dynamic_lights", -1)) != 0:
		_fail("O enquadramento declarou luz dinâmica nova.")
	if not framing.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo de enquadramento criou luz.")
	if not framing.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo de enquadramento criou colisão.")

func _validate_canopies(region: Node3D) -> void:
	var roots: Array[String] = ["TransicaoOrganicaArcoFloresta", "CopasFocaisDaFlorestaDensa"]
	var adjusted: int = 0
	for root_name: String in roots:
		var canopy_root: Node = region.get_node_or_null(root_name)
		if canopy_root == null:
			_fail("Massa lateral ausente: %s." % root_name)
			continue
		for child: Node in canopy_root.get_children():
			if not (child is Node3D):
				continue
			var name_value: String = String(child.name)
			if not name_value.begins_with("ArvoreTransicaoArco_") and not name_value.begins_with("CopaFocalFlorestal_"):
				continue
			var canopy: Node3D = child as Node3D
			if canopy.has_meta("r4_orion_vista_static"):
				if canopy.position.z >= CLEARING_START_Z and canopy.position.z <= CLEARING_END_Z:
					_fail("Copa %s foi modulada dentro da clareira Orion." % canopy.name)
				if abs(canopy.position.x - _path_x(canopy.position.z)) < MIN_PATH_CLEARANCE:
					_fail("Copa %s invade a faixa física de 6 m." % canopy.name)
				adjusted += 1
	if adjusted != 6:
		_fail("Foram encontradas %d copas moduladas; esperadas 6." % adjusted)

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
