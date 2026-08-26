## verify_r4_clearing_lore.gd
## DEV4-R4-ORION-CLEARING-LORE-003

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const EXPECTED_CLUSTERS: int = 3
const EXPECTED_STONES_PER_CLUSTER: int = 3
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const MIN_PATH_CLEARANCE: float = 4.40

var _issues: PackedStringArray = PackedStringArray()

class TerrainPatchStub:
	extends Node3D

	func height_at(_world_x: float, _world_z: float) -> float:
		return 0.0

func _initialize() -> void:
	var world: Node3D = Node3D.new()
	world.name = "HarnessR4Lore"
	root.add_child(world)
	var terrain: Node3D = TerrainPatchStub.new()
	terrain.name = "TerrainPatch"
	world.add_child(terrain)
	var forest: Node3D = FOREST_LAKE_SCRIPT.new() as Node3D
	forest.name = "FlorestaELagoHarnessR4Lore"
	world.add_child(forest)
	await process_frame
	await process_frame

	var lore_root: Node3D = forest.get_node_or_null("R4LeituraArqueologicaDaClareira") as Node3D
	if lore_root == null:
		_fail("Raiz R4LeituraArqueologicaDaClareira ausente.")
	else:
		_validate_lore(lore_root)
	if _issues.is_empty():
		print("[ORIGEM_R4_LORE_OK] vestigios=%d pedras=%d luzes=0 clareira_aberta=true" % [EXPECTED_CLUSTERS, EXPECTED_CLUSTERS * EXPECTED_STONES_PER_CLUSTER])
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_LORE_ERROR] %s" % issue)
	quit(1)

func _validate_lore(lore_root: Node3D) -> void:
	var clusters: Array[Node] = lore_root.find_children("VestigioDePassagem_*", "Node3D", false, false)
	if clusters.size() != EXPECTED_CLUSTERS:
		_fail("Vestígios R4 inválidos: %d, esperado %d." % [clusters.size(), EXPECTED_CLUSTERS])
	for cluster: Node in clusters:
		var stones: Array[Node] = cluster.find_children("PedraGasta_*", "Node3D", false, false)
		if stones.size() != EXPECTED_STONES_PER_CLUSTER:
			_fail("%s contém %d pedras; esperado %d." % [cluster.name, stones.size(), EXPECTED_STONES_PER_CLUSTER])
		for stone_node: Node in stones:
			var stone: Node3D = stone_node as Node3D
			if stone == null:
				_fail("Pedra R4 sem transformação Node3D.")
				continue
			if stone.position.z < CLEARING_START_Z or stone.position.z > CLEARING_END_Z:
				_fail("%s saiu da faixa cartográfica da clareira em z=%.2f." % [stone.name, stone.position.z])
			if abs(stone.position.x - _path_x(stone.position.z)) < MIN_PATH_CLEARANCE:
				_fail("%s entrou no corredor aberto da clareira." % stone.name)
	var lights: Array[Node] = lore_root.find_children("*", "Light3D", true, false)
	if not lights.is_empty():
		_fail("A leitura R4 criou %d luzes; esperado zero." % lights.size())
	var colliders: Array[Node] = lore_root.find_children("*", "StaticBody3D", true, false)
	if not colliders.is_empty():
		_fail("A leitura R4 criou colisores; os vestígios devem permanecer laterais e não bloqueantes.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
