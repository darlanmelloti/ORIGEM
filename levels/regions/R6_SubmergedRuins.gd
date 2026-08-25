## R6_SubmergedRuins.gd
## Contrato de trabalho da Região 6 — Ruínas Submersas.
## A geometria existente permanece em levels/ForestLakeRegion.gd; este módulo fixa a fronteira funcional.

class_name R6SubmergedRuinsRegion
extends RefCounted

const CONTRACT_SCRIPT: Script = preload("res://levels/contracts/RegionContract.gd")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

func create_contract():
	var contract = CONTRACT_SCRIPT.new()
	contract.configure(
		6,
		"Ruínas Submersas",
		"Dev6",
		CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS,
		CARTOGRAPHIC_ANCHORS.VILA_ELEVADA,
		AABB(Vector3(-5.0, -12.0, 210.0), Vector3(150.0, 55.0, 102.0)),
		4,
		PackedStringArray(["majestic_to_lake", "forest_to_ruins", "ruins_arrival"]),
		"res://levels/ForestLakeRegion.gd",
		"Bacia terminal R1–R6; ruínas submersas legíveis, cascatas 3D e preparação visual do handoff R6→R7."
	)
	return contract

static func integration_node_name() -> String:
	return "RegiaoFlorestaLagoExploravel"

static func acceptance_criteria() -> PackedStringArray:
	return PackedStringArray([
		"A chegada desde Majestic usa a ligação de lajes e não contém lacuna física.",
		"O mapa UI mostra CHEGADA ÀS RUÍNAS na janela cartográfica correta.",
		"Colunas, cúpula e estruturas sob a água são geometria legível, não painéis planos.",
		"A cascata mantém filetes 3D, água sem emissão excessiva e máximo de quatro luzes locais."
	])
