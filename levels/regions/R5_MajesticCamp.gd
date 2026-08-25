## R5_MajesticCamp.gd
## Contrato de trabalho da Região 5 — Acampamento Majestic.
## A geometria existente permanece em levels/ForestLakeRegion.gd; este módulo fixa a fronteira funcional.

class_name R5MajesticCampRegion
extends RefCounted

const CONTRACT_SCRIPT: Script = preload("res://levels/contracts/RegionContract.gd")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

func create_contract():
	var contract = CONTRACT_SCRIPT.new()
	contract.configure(
		5,
		"Acampamento Majestic",
		"Dev5",
		CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC,
		CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS,
		AABB(Vector3(-112.0, -8.0, 156.0), Vector3(75.0, 42.0, 63.0)),
		4,
		PackedStringArray(["forest_to_majestic", "majestic_to_lake"]),
		"res://levels/ForestLakeRegion.gd",
		"Desvio ocidental, acampamento abandonado, artefacto azul e ligação física obrigatória à margem R6."
	)
	return contract

static func integration_node_name() -> String:
	return "RegiaoFlorestaLagoExploravel"

static func acceptance_criteria() -> PackedStringArray:
	return PackedStringArray([
		"A rota da Floresta entra no acampamento e a ligação à margem R6 permanece física.",
		"Tendas, mapas, ferramentas e fogueira contam que alguém chegou antes de Elias.",
		"O artefacto azul comunica a assinatura Orion sem revelar o Cube.",
		"Máximo de quatro luzes dinâmicas locais ativas."
	])
