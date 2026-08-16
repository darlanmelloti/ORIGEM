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

static func world_position(anchor: Vector2, terrain_y: float, vertical_offset: float = 0.0) -> Vector3:
	return Vector3(anchor.x, terrain_y + vertical_offset, anchor.y)

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
