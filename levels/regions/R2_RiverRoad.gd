## R2_RiverRoad.gd
## Contrato de trabalho da Região 2 — Estrada do Rio.
## A geometria existente permanece em levels/RiverRoadJourney.gd; este módulo não a recria.

class_name R2RiverRoadRegion
extends RefCounted

const CONTRACT_SCRIPT: Script = preload("res://levels/contracts/RegionContract.gd")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

func create_contract():
	var contract = CONTRACT_SCRIPT.new()
	contract.configure(
		2,
		"Estrada do Rio",
		"Dev2",
		CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO,
		CARTOGRAPHIC_ANCHORS.ARCO_RUINAS,
		AABB(Vector3(-50.0, -8.0, 12.0), Vector3(74.0, 32.0, 88.0)),
		2,
		PackedStringArray(["road_to_arch", "positive_bridge", "road_return_voss"]),
		"res://levels/RiverRoadJourney.gd",
		"Estrada física, margens, ponte lateral e primeira anomalia azul refletida no rio."
	)
	return contract

static func integration_node_name() -> String:
	return "EstradaDoRioExploravel"

static func acceptance_criteria() -> PackedStringArray:
	return PackedStringArray([
		"A rota até ao Arco mantém lajes físicas, solo e margens sem bloqueios.",
		"O reflexo azul é breve, orientado para Orion e não torna a água emissiva.",
		"A ponte lateral continua física, mas não compete com a leitura do Arco.",
		"Máximo de duas luzes dinâmicas locais ativas."
	])
