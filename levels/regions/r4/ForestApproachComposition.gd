## ForestApproachComposition.gd
## DEV4-R4-FOREST-APPROACH-COMPOSITION-014
## Ajuste estático de copas focais R4 sem colisores associados para equilibrar a leitura da aproximação.

class_name R4ForestApproachComposition
extends Node3D

const NODE_NAME: String = "R4ComposicaoDaAproximacao"
const BAND_START_Z: float = 152.0
const BAND_END_Z: float = 174.0
const MIN_PATH_CLEARANCE: float = 6.0

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, canopy_root: Node) -> R4ForestApproachComposition:
	if parent == null or canopy_root == null:
		return null
	var existing: R4ForestApproachComposition = parent.get_node_or_null(NODE_NAME) as R4ForestApproachComposition
	if existing != null:
		return existing
	var composition: R4ForestApproachComposition = R4ForestApproachComposition.new()
	composition.name = NODE_NAME
	parent.add_child(composition)
	composition._apply(path_x_at, height_at, canopy_root)
	return composition

func _apply(path_x_at: Callable, height_at: Callable, canopy_root: Node) -> void:
	var adjusted: int = 0
	var skipped_collision: int = 0
	var rejected_for_corridor: int = 0
	var ordinal: int = 0
	for child: Node in canopy_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("CopaFocalFlorestal_"):
			continue
		var canopy: Node3D = child as Node3D
		var z_value: float = canopy.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var canopy_id: String = String(canopy.name).trim_prefix("CopaFocalFlorestal_")
		if canopy_root.get_node_or_null("ColisorCopaFocalFlorestal_%s" % canopy_id) != null:
			skipped_collision += 1
			continue
		var side: float = -1.0 if canopy.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = z_value + (-0.22 if ordinal % 2 == 0 else 0.20)
		var target_x: float = float(path_x_at.call(target_z)) + side * (8.10 + float(ordinal % 2) * 0.72)
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			rejected_for_corridor += 1
			ordinal += 1
			continue
		canopy.position = Vector3(target_x, float(height_at.call(target_x, target_z)), target_z)
		var scale_factor: float = 0.95 + float(ordinal % 2) * 0.08
		canopy.scale *= scale_factor
		canopy.rotation.y += -0.16 + float((ordinal * 5) % 4) * 0.10
		canopy.set_meta("r4_approach_composition_static", true)
		adjusted += 1
		ordinal += 1
	set_meta("r4_approach_composition_adjusted", adjusted)
	set_meta("r4_approach_composition_collision_skipped", skipped_collision)
	set_meta("r4_approach_composition_corridor_rejected", rejected_for_corridor)
	set_meta("r4_approach_composition_dynamic_lights", 0)
	print("[ORIGEM_R4_COMPOSITION] ajustadas=%d colisores_ignorados=%d corredor_rejeitado=%d luzes=0" % [adjusted, skipped_collision, rejected_for_corridor])
