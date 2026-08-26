## verify_r4_mist_layer.gd
## Executar com:
## godot --headless --path . --script res://qa/regions/verify_r4_mist_layer.gd

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const MIST_LAYER_NAME: String = "R4CamadaNeblinaLocal"
const CLEARING_NAME: String = "R4ClareiraDaVisadaOrion"

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

	var mist_layer: Node = region.get_node_or_null(MIST_LAYER_NAME)
	var clearing: Node = region.get_node_or_null(CLEARING_NAME)
	if mist_layer == null:
		_fail("Camada local R4 ausente.")
	else:
		_validate_mist_layer(mist_layer)
	if clearing == null:
		_fail("Clareira Orion aprovada ausente.")
	else:
		_validate_clearing(clearing)

	if _issues.is_empty():
		print("[ORIGEM_R4_MIST_OK] camada local subtil, sem luzes e com clareira Orion preservada.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_MIST_ERROR] %s" % issue)
	quit(1)

func _validate_mist_layer(mist_layer: Node) -> void:
	var treated_meshes: int = int(mist_layer.get_meta("r4_mist_treated_meshes", 0))
	var protected_meshes: int = int(mist_layer.get_meta("r4_mist_protected_clearing_meshes", 0))
	var dynamic_lights: int = int(mist_layer.get_meta("r4_mist_dynamic_lights", -1))
	if treated_meshes <= 0:
		_fail("A camada de neblina não tratou materiais R4.")
	if protected_meshes <= 0:
		_fail("A camada de neblina não preservou materiais na faixa da clareira.")
	if dynamic_lights != 0:
		_fail("A camada de neblina declarou %d luzes; são permitidas zero." % dynamic_lights)
	if not mist_layer.find_children("*", "Light3D", true, false).is_empty():
		_fail("A camada de neblina criou nós de luz.")
	if not mist_layer.find_children("*", "FogVolume", true, false).is_empty():
		_fail("A camada de neblina criou FogVolume proibido.")

func _validate_clearing(clearing: Node) -> void:
	var frames: Array[Node] = clearing.find_children("QuadroAbertoOrion_*", "Node3D", true, false)
	var ferns: Array[Node] = clearing.find_children("FetoLateralDaClareira_*", "Node3D", true, false)
	if frames.size() != 4:
		_fail("Clareira Orion deve manter quatro quadros laterais; encontrados %d." % frames.size())
	if ferns.size() != 8:
		_fail("Clareira Orion deve manter oito fetos laterais; encontrados %d." % ferns.size())

func _fail(issue: String) -> void:
	_issues.append(issue)
