## R3_ArchRuins.gd
## Contrato de trabalho da Região 3 — Arco das Ruínas.
## A geometria existente permanece em levels/RiverRoadJourney.gd; este módulo fixa a fronteira funcional.

class_name R3ArchRuinsRegion
extends RefCounted

const CONTRACT_SCRIPT: Script = preload("res://levels/contracts/RegionContract.gd")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

# O marco cartográfico mantém a âncora em Z=48, enquanto a silhueta física aprovada está em Z≈92.
const PHYSICAL_ARCH_FOCUS: Vector3 = Vector3(-13.8, 0.0, 92.0)

func create_contract():
	var contract = CONTRACT_SCRIPT.new()
	contract.configure(
		3,
		"Arco das Ruínas",
		"Dev3",
		CARTOGRAPHIC_ANCHORS.ARCO_RUINAS,
		CARTOGRAPHIC_ANCHORS.FLORESTA_DENSA_ENTRADA,
		AABB(Vector3(-58.0, -8.0, 70.0), Vector3(86.0, 38.0, 47.0)),
		2,
		PackedStringArray(["road_to_arch", "arch_to_forest"]),
		"res://levels/RiverRoadJourney.gd",
		"Marco arqueológico atravessável; inscrições e partículas respondem à passagem sem retirar controlo ao jogador."
	)
	return contract

static func get_physical_focus() -> Vector3:
	return PHYSICAL_ARCH_FOCUS

static func integration_node_name() -> String:
	return "EstradaDoRioExploravel"

static func acceptance_criteria() -> PackedStringArray:
	return PackedStringArray([
		"A silhueta do Arco mantém o alvo físico canónico Z≈92.",
		"A passagem é física e não introduz muro invisível ou corte de controlo.",
		"Inscrições e partículas azuis são uma ativação discreta e única.",
		"Máximo de duas luzes dinâmicas locais ativas."
	])
