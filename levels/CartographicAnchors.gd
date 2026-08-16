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

static func anchor_name(anchor_id: int) -> String:
	var names: Array[String] = [
		"Casa Voss", "Estrada do Rio", "Arco das Ruínas", "Floresta Densa",
		"Acampamento Majestic", "Ruínas Submersas", "Vila Elevada", "Observatório",
		"Trilha da Montanha", "Caverna do Orion", "Câmara do Orion Cube", "Hub Temporal"
	]
	if anchor_id < 1 or anchor_id > names.size():
		return "Marco desconhecido"
	return names[anchor_id - 1]
