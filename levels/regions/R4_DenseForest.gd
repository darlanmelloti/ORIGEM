## R4_DenseForest.gd
## Contrato de trabalho da Região 4 — Floresta Densa.
## A geometria existente permanece em levels/ForestLakeRegion.gd; este módulo fixa a fronteira funcional.

class_name R4DenseForestRegion
extends RefCounted

const CONTRACT_SCRIPT: Script = preload("res://levels/contracts/RegionContract.gd")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

func create_contract():
	var contract = CONTRACT_SCRIPT.new()
	contract.configure(
		4,
		"Floresta Densa",
		"Dev4",
		CARTOGRAPHIC_ANCHORS.FLORESTA_DENSA_ENTRADA,
		CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC,
		AABB(Vector3(-66.0, -8.0, 106.0), Vector3(94.0, 46.0, 80.0)),
		1,
		PackedStringArray(["arch_to_forest", "forest_to_majestic", "forest_to_ruins"]),
		"res://levels/ForestLakeRegion.gd",
		"Transição escura e orgânica; preserva a clareira aprovada e revela Orion sem parede de árvores."
	)
	return contract

static func integration_node_name() -> String:
	return "RegiaoFlorestaLagoExploravel"

static func acceptance_criteria() -> PackedStringArray:
	return PackedStringArray([
		"A transição Arco→Floresta conserva rota física e clareira focal aprovada.",
		"A vegetação usa massa lateral, variação de escala e não forma filas ou paredes artificiais.",
		"A neblina baixa melhora a profundidade sem ocultar a direção seguinte.",
		"Máximo de uma luz dinâmica local ativa."
	])
