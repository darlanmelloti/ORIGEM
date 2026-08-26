## ForestOuterMargin.gd
## DEV4-R4-FOREST-OUTER-MARGIN-019
## Reorganiza raízes ambientais existentes no bordo exterior sem criar geometrias, luzes, colisores ou efeitos.

class_name R4ForestOuterMargin
extends Node3D

const NODE_NAME: String = "R4MargemExteriorDaFloresta"
const BAND_START_Z: float = 182.0
const BAND_END_Z: float = 190.0
const MIN_PATH_CLEARANCE: float = 8.75

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, details_root: Node) -> R4ForestOuterMargin:
	if parent == null or details_root == null or not path_x_at.is_valid() or not height_at.is_valid():
		return null
	var existing: R4ForestOuterMargin = parent.get_node_or_null(NODE_NAME) as R4ForestOuterMargin
	if existing != null:
		return existing
	var margin: R4ForestOuterMargin = R4ForestOuterMargin.new()
	margin.name = NODE_NAME
	parent.add_child(margin)
	margin._apply(path_x_at, height_at, details_root)
	return margin

func _apply(path_x_at: Callable, height_at: Callable, details_root: Node) -> void:
	var adjusted: int = 0
	var protected_or_rejected: int = 0
	var ordinal: int = 0
	for child: Node in details_root.get_children():
		if not child is MeshInstance3D or not String(child.name).begins_with("RaizExpostaFlorestal_"):
			continue
		var root: MeshInstance3D = child as MeshInstance3D
		var original_z: float = root.position.z
		if original_z < BAND_START_Z or original_z > BAND_END_Z:
			continue
		var side: float = -1.0 if root.position.x < float(path_x_at.call(original_z)) else 1.0
		var target_z: float = clampf(original_z + (-0.18 if ordinal % 2 == 0 else 0.20), BAND_START_Z, BAND_END_Z)
		var target_x: float = float(path_x_at.call(target_z)) + side * (MIN_PATH_CLEARANCE + float(ordinal) * 0.45)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			protected_or_rejected += 1
			ordinal += 1
			continue
		root.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + 0.075, target_z)
		root.rotation.y += -0.14 + float(ordinal) * 0.17
		root.set_meta("r4_outer_margin_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_outer_margin_adjusted", adjusted)
	set_meta("r4_outer_margin_rejected", protected_or_rejected)
	set_meta("r4_outer_margin_min_clearance", MIN_PATH_CLEARANCE)
	set_meta("r4_outer_margin_dynamic_lights", 0)
	print("[ORIGEM_R4_OUTER_MARGIN] ajustadas=%d rejeitadas=%d luzes=0" % [adjusted, protected_or_rejected])
