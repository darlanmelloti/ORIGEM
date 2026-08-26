## verify_r4_silhouette_continuity.gd
## DEV4-R4-FOREST-SILHOUETTE-CONTINUITY-009

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const SILHOUETTE_NODE_NAME: String = "R4ContinuidadeDasSilhuetas"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 164.0
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

	var continuity: Node = region.get_node_or_null(SILHOUETTE_NODE_NAME)
	if continuity == null:
		_fail("Módulo de continuidade de silhuetas ausente.")
	else:
		_validate_module(continuity)
	_validate_adjusted_elements(region)

	if _issues.is_empty():
		print("[ORIGEM_R4_SILHOUETTE_OK] silhuetas R4, corredor, clareira e física existente preservados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_SILHOUETTE_ERROR] %s" % issue)
	quit(1)

func _validate_module(continuity: Node) -> void:
	if int(continuity.get_meta("r4_silhouette_adjusted", 0)) <= 0:
		_fail("Nenhuma silhueta R4 recebeu variação estática.")
	if int(continuity.get_meta("r4_silhouette_dynamic_lights", -1)) != 0:
		_fail("O módulo declarou luz dinâmica nova.")
	if not continuity.find_children("*", "Light3D", true, false).is_empty():
		_fail("O módulo criou uma luz.")
	if not continuity.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("O módulo criou uma colisão.")

func _validate_adjusted_elements(region: Node3D) -> void:
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
			if not element.has_meta("r4_silhouette_continuity_static"):
				continue
			if element.position.z < BAND_START_Z or element.position.z > BAND_END_Z:
				_fail("Elemento %s excede a faixa de continuidade R4." % element.name)
			if abs(element.position.x - _path_x(element.position.z)) < MIN_PATH_CLEARANCE:
				_fail("Elemento %s invade o corredor físico." % element.name)
			if _has_associated_collision(source_root, String(element.name)):
				_fail("Elemento com colisão associada foi transformado: %s." % element.name)
			adjusted += 1
	if adjusted <= 0:
		_fail("Nenhuma silhueta estática foi marcada.")

func _has_associated_collision(source_root: Node, name_value: String) -> bool:
	if name_value.begins_with("ArvoreDaFloresta_"):
		return source_root.get_node_or_null("ColisorTroncoFloresta_%s" % name_value.trim_prefix("ArvoreDaFloresta_")) != null
	if name_value.begins_with("CopaFocalFlorestal_"):
		return source_root.get_node_or_null("ColisorCopaFocalFlorestal_%s" % name_value.trim_prefix("CopaFocalFlorestal_")) != null
	return false

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
