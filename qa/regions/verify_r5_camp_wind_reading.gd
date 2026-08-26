## verify_r5_camp_wind_reading.gd
## DEV5-R5-CAMP-WIND-READING-002

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const EXPECTED_TARPS: int = 2
const EXPECTED_ROPES: int = 2

var _issues: PackedStringArray = PackedStringArray()

class TerrainPatchStub:
	extends Node3D

	func height_at(_world_x: float, _world_z: float) -> float:
		return 0.0

func _initialize() -> void:
	var world: Node3D = Node3D.new()
	world.name = "HarnessR5Wind"
	root.add_child(world)
	var terrain: Node3D = TerrainPatchStub.new()
	terrain.name = "TerrainPatch"
	world.add_child(terrain)
	var forest: Node3D = FOREST_LAKE_SCRIPT.new() as Node3D
	forest.name = "FlorestaELagoHarnessR5Wind"
	world.add_child(forest)
	await process_frame
	await process_frame

	var camp: Node3D = forest.get_node_or_null("AcampamentoMajestic") as Node3D
	var reading: Node = camp.get_node_or_null("R5LeituraDeVentoDoAcampamento") if camp != null else null
	if camp == null or reading == null:
		_fail("Acampamento ou módulo R5LeituraDeVentoDoAcampamento ausente.")
	else:
		await _validate_wind(camp, reading)
	if _issues.is_empty():
		print("[ORIGEM_R5_WIND_OK] lonas=%d cordas=%d movimento=true luzes=0" % [EXPECTED_TARPS, EXPECTED_ROPES])
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R5_WIND_ERROR] %s" % issue)
	quit(1)

func _validate_wind(camp: Node3D, reading: Node) -> void:
	var tarps: Array[Node] = camp.find_children("LonaDeChegadaMajestic_*", "MeshInstance3D", true, false)
	var ropes: Array[Node] = camp.find_children("CordaEnroladaMajestic_*", "MeshInstance3D", true, false)
	if tarps.size() != EXPECTED_TARPS:
		_fail("Lonas R5 inválidas: %d, esperado %d." % [tarps.size(), EXPECTED_TARPS])
	if ropes.size() != EXPECTED_ROPES:
		_fail("Cordas R5 inválidas: %d, esperado %d." % [ropes.size(), EXPECTED_ROPES])
	var lights: Array[Node] = reading.find_children("*", "Light3D", true, false)
	if not lights.is_empty():
		_fail("Leitura de vento R5 criou %d luzes." % lights.size())
	if int(reading.get_meta("r5_wind_dynamic_lights", -1)) != 0:
		_fail("Metadado de luz R5 não confirma zero luz dinâmica.")
	var before_tarps: Array[Transform3D] = _transforms(tarps)
	var before_ropes: Array[Transform3D] = _transforms(ropes)
	var target_node_count: int = tarps.size() + ropes.size()
	await create_timer(0.35).timeout
	var after_tarps: Array[Transform3D] = _transforms(tarps)
	var after_ropes: Array[Transform3D] = _transforms(ropes)
	if not _some_transform_changed(before_tarps, after_tarps):
		_fail("Lonas de chegada não receberam movimento local observável.")
	if not _some_transform_changed(before_ropes, after_ropes):
		_fail("Cordas do suporte não receberam movimento local observável.")
	var target_node_count_after: int = camp.find_children("LonaDeChegadaMajestic_*", "MeshInstance3D", true, false).size() + camp.find_children("CordaEnroladaMajestic_*", "MeshInstance3D", true, false).size()
	if target_node_count_after != target_node_count:
		_fail("Movimento R5 criou ou removeu nós alvo durante a execução.")

func _transforms(nodes: Array[Node]) -> Array[Transform3D]:
	var values: Array[Transform3D] = []
	for node: Node in nodes:
		var mesh: MeshInstance3D = node as MeshInstance3D
		if mesh != null:
			values.append(mesh.transform)
	return values

func _some_transform_changed(before: Array[Transform3D], after: Array[Transform3D]) -> bool:
	if before.size() != after.size():
		return false
	for index: int in range(before.size()):
		if not before[index].is_equal_approx(after[index]):
			return true
	return false

func _fail(issue: String) -> void:
	_issues.append(issue)
