## Dev5 — Sistema de colocação de objectos pelo mapa cartográfico.
## Os marcos definidos em CartographicAnchors são a única autoridade espacial.

class_name CartographicPlacementSystem
extends RefCounted

const ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

const DEV5_SUPPORTED_ANCHORS: Dictionary = {
	1: ANCHORS.CASA_VOSS,
	2: ANCHORS.ESTRADA_RIO_INICIO,
	3: ANCHORS.ARCO_RUINAS,
	4: ANCHORS.FLORESTA_DENSA_ENTRADA,
	5: ANCHORS.ACAMPAMENTO_MAJESTIC,
	6: ANCHORS.RUINAS_SUBMERSAS
}

static func placement_world_position(anchor_id: int, terrain_y: float, local_offset: Vector2 = Vector2.ZERO, vertical_offset: float = 0.0) -> Vector3:
	assert(DEV5_SUPPORTED_ANCHORS.has(anchor_id), "Dev5 só pode colocar objectos nos marcos 1–6.")
	var anchor: Vector2 = DEV5_SUPPORTED_ANCHORS[anchor_id] as Vector2
	return ANCHORS.world_position(anchor + local_offset, terrain_y, vertical_offset)

static func placement_record(object_id: String, anchor_id: int, local_offset: Vector2, terrain_y: float) -> Dictionary:
	var world: Vector3 = placement_world_position(anchor_id, terrain_y, local_offset)
	return {
		"object_id": object_id,
		"anchor_id": anchor_id,
		"anchor_name": ANCHORS.anchor_name(anchor_id),
		"map_canvas": ANCHORS.MAP_TEXTURE_POSITIONS[anchor_id] as Vector2,
		"world_xz": Vector2(world.x, world.z),
		"local_offset_xz": local_offset,
		"world_position": world,
		"owner": "Dev5 QA — integração exige revisão Dev1"
	}

static func assert_anchor_distance(record: Dictionary, maximum_offset_m: float = 36.0) -> bool:
	var local_offset: Vector2 = record["local_offset_xz"] as Vector2
	return local_offset.length() <= maximum_offset_m

static func supported_anchor_summary() -> Array[Dictionary]:
	var summary: Array[Dictionary] = []
	for anchor_id: int in DEV5_SUPPORTED_ANCHORS.keys():
		var anchor: Vector2 = DEV5_SUPPORTED_ANCHORS[anchor_id] as Vector2
		summary.append({
			"anchor_id": anchor_id,
			"name": ANCHORS.anchor_name(anchor_id),
			"world_xz": anchor,
			"map_canvas": ANCHORS.MAP_TEXTURE_POSITIONS[anchor_id] as Vector2
		})
	return summary
