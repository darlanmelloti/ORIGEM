## CartographicAnchors.gd
## Autoridade espacial do mapa oficial do ORIGEM.
## X negativo = oeste, X positivo = este, Z crescente = norte.

class_name CartographicAnchors
extends RefCounted

const CASA_VOSS := Vector2(-22.0, 8.0)
const ESTRADA_RIO_INICIO := Vector2(-21.4, 12.0)
const ARCO_RUINAS := Vector2(-16.741, 48.0)
const FLORESTA_DENSA_ENTRADA := Vector2(-9.0, 116.0)
const ACAMPAMENTO_MAJESTIC := Vector2(-88.0, 178.0)
const RUINAS_SUBMERSAS := Vector2(60.0, 252.0)
const VILA_ELEVADA := Vector2(140.0, 352.0)
const OBSERVATORIO := Vector2(194.0, 404.0)
const TRILHA_MONTANHA_INICIO := Vector2(174.0, 414.0)
const CAVERNA_ORION := Vector2(-116.0, 548.0)
const CAMARA_ORION_CUBE := Vector2(-116.0, 562.0)
const HUB_TEMPORAL := Vector2(164.0, 210.0)

# Coordenadas no canvas nativo 800×600 do mapa cartográfico fornecido pela direcção.
# São a ponte entre as âncoras 3D e os marcos desenhados; não derivam de uma projecção rectangular genérica.
const MAP_TEXTURE_POSITIONS: Dictionary = {
	1: Vector2(80.0, 452.0), 2: Vector2(234.0, 462.0), 3: Vector2(362.0, 463.0),
	4: Vector2(334.0, 244.0), 5: Vector2(187.0, 258.0), 6: Vector2(408.0, 351.0),
	7: Vector2(542.0, 235.0), 8: Vector2(560.0, 165.0), 9: Vector2(440.0, 137.0),
	10: Vector2(466.0, 78.0), 11: Vector2(514.0, 33.0), 12: Vector2(564.0, 497.0)
}

# Contrato único consumido pelo mundo integrado e pelos harnesses de QA.
# Não duplica coordenadas: todas as posições são derivadas das constantes acima.
const DEV2_REGION_IDS: Array[int] = [7, 8, 9, 10, 11, 12]
const VALIDATION_STATES: Array[String] = ["UNBUILT", "BLOCKOUT_VALIDATED", "PHYSICAL_VALIDATED", "VISUAL_PASS", "INTEGRATED"]

static func _anchor_for_region(region_id: int) -> Vector2:
	match region_id:
		7: return VILA_ELEVADA
		8: return OBSERVATORIO
		9: return TRILHA_MONTANHA_INICIO
		10: return CAVERNA_ORION
		11: return CAMARA_ORION_CUBE
		12: return HUB_TEMPORAL
	return Vector2.ZERO

static func dev2_contract(terrain_heights: Dictionary = {}) -> Array[Dictionary]:
	var subjects: Dictionary = {
		7: "Vila Elevada", 8: "Observatório", 9: "Trilha da Montanha",
		10: "Caverna do Orion", 11: "Câmara do Orion Cube", 12: "Hub Temporal / Cúpula Final"
	}
	var states: Dictionary = {
		7: "PHYSICAL_VALIDATED", 8: "PHYSICAL_VALIDATED", 9: "PHYSICAL_VALIDATED",
		10: "PHYSICAL_VALIDATED", 11: "PHYSICAL_VALIDATED", 12: "VISUAL_PASS"
	}
	var contract: Array[Dictionary] = []
	for region_id: int in DEV2_REGION_IDS:
		var world_anchor := _anchor_for_region(region_id)
		var previous_anchor := _anchor_for_region(maxi(region_id - 1, 7)) if region_id > 7 else VILA_ELEVADA
		var next_anchor := _anchor_for_region(mini(region_id + 1, 12))
		var direction := (next_anchor - world_anchor).normalized() if region_id < 12 else (world_anchor - previous_anchor).normalized()
		var terrain_y: float = float(terrain_heights.get(region_id, 0.0))
		contract.append({
			"region_id": region_id,
			"world_position": world_position(world_anchor, terrain_y),
			"altitude_derived": terrain_y,
			"approach_direction": direction,
			"handoff_in": world_position(previous_anchor, terrain_y),
			"handoff_out": world_position(next_anchor, terrain_y),
			"subject_visual": subjects[region_id],
			"validation_state": states[region_id],
			"map_texture_position": MAP_TEXTURE_POSITIONS[region_id]
		})
	return contract

static func dev2_anchor_positions() -> Array[Vector3]:
	var positions: Array[Vector3] = []
	for item: Dictionary in dev2_contract():
		positions.append(item["world_position"] as Vector3)
	return positions

static func continuity_6_to_7(terrain_y: float = 0.0) -> Dictionary:
	var start := world_position(RUINAS_SUBMERSAS, terrain_y)
	var finish := world_position(VILA_ELEVADA, terrain_y)
	return {
		"from_region": 6,
		"to_region": 7,
		"handoff_in": start,
		"handoff_out": finish,
		"direction": (finish - start).normalized(),
		"distance": start.distance_to(finish),
		"subject_visual": "Transição Ruínas Submersas → Vila Elevada",
		"validation_state": "QA_BOUNDARY_PENDING"
	}

static func continuity_7_to_8(terrain_y: float = 0.0) -> Dictionary:
	var start := world_position(VILA_ELEVADA, terrain_y)
	var finish := world_position(OBSERVATORIO, terrain_y)
	return {
		"from_region": 7,
		"to_region": 8,
		"handoff_in": start,
		"handoff_out": finish,
		"direction": (finish - start).normalized(),
		"distance": start.distance_to(finish),
		"subject_visual": "Transição Vila Elevada → Observatório",
		"validation_state": "QA_BOUNDARY_PENDING"
	}


static func world_position(anchor: Vector2, terrain_y: float, vertical_offset: float = 0.0) -> Vector3:
	return Vector3(anchor.x, terrain_y + vertical_offset, anchor.y)

static func map_texture_position(world: Vector2) -> Vector2:
	# Interpolação ponderada pelas âncoras geográficas: mantém cada marco exactamente sobre a ilustração e acompanha Elias entre eles.
	var anchors: Array[Vector2] = [
		CASA_VOSS, ESTRADA_RIO_INICIO, ARCO_RUINAS, FLORESTA_DENSA_ENTRADA,
		ACAMPAMENTO_MAJESTIC, RUINAS_SUBMERSAS, VILA_ELEVADA, OBSERVATORIO,
		TRILHA_MONTANHA_INICIO, CAVERNA_ORION, CAMARA_ORION_CUBE
	]
	var weighted_position: Vector2 = Vector2.ZERO
	var total_weight: float = 0.0
	for index: int in range(anchors.size()):
		var distance_to_anchor: float = world.distance_to(anchors[index])
		if distance_to_anchor < 0.75:
			return MAP_TEXTURE_POSITIONS[index + 1] as Vector2
		var weight: float = 1.0 / maxf(distance_to_anchor * distance_to_anchor, 16.0)
		weighted_position += (MAP_TEXTURE_POSITIONS[index + 1] as Vector2) * weight
		total_weight += weight
	if total_weight <= 0.0:
		return MAP_TEXTURE_POSITIONS[1] as Vector2
	return weighted_position / total_weight

static func next_dev1_destination(player_z: float) -> Dictionary:
	# A sequência pertence à cartografia, não à UI: todas as telas e sistemas consultam a mesma rota.
	# O ponto 2 é um marco jogável real entre a Casa Voss e o Arco; não pode ser saltado pela orientação.
	if player_z < ESTRADA_RIO_INICIO.y + 8.0:
		return {"anchor": ESTRADA_RIO_INICIO, "label": "RUMO À ESTRADA DO RIO", "anchor_id": 2}
	if player_z >= RUINAS_SUBMERSAS.y - 18.0:
		return {"anchor": VILA_ELEVADA, "label": "PASSAGEM: VILA ELEVADA", "anchor_id": 7}
	if player_z >= ACAMPAMENTO_MAJESTIC.y - 12.0:
		return {"anchor": RUINAS_SUBMERSAS, "label": "RUMO ÀS RUÍNAS", "anchor_id": 6}
	if player_z >= FLORESTA_DENSA_ENTRADA.y + 20.0:
		return {"anchor": ACAMPAMENTO_MAJESTIC, "label": "RUMO AO MAJESTIC", "anchor_id": 5}
	if player_z >= ARCO_RUINAS.y + 12.0:
		return {"anchor": FLORESTA_DENSA_ENTRADA, "label": "RUMO À FLORESTA", "anchor_id": 4}
	return {"anchor": ARCO_RUINAS, "label": "RUMO AO ARCO", "anchor_id": 3}

static func anchor_name(anchor_id: int) -> String:
	var names: Array[String] = [
		"Casa Voss", "Estrada do Rio", "Arco das Ruínas", "Floresta Densa",
		"Acampamento Majestic", "Ruínas Submersas", "Vila Elevada", "Observatório",
		"Trilha da Montanha", "Caverna do Orion", "Câmara do Orion Cube", "Hub Temporal"
	]
	if anchor_id < 1 or anchor_id > names.size():
		return "Marco desconhecido"
	return names[anchor_id - 1]
