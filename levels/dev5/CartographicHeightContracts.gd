## Dev5 — CP-D5-023: contratos de altura para candidatos cartográficos R1–R6.
## Este catálogo descreve integração; não consulta nem altera módulos regionais em produção.

class_name CartographicHeightContracts
extends RefCounted

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")

const CONTRACTS: Dictionary = {
	1: {
		"terrain_owner": "VossHouse.gd",
		"height_source": "_ground_height() sobre TerrainPatch do pai",
		"expected_collider": "solo contínuo TerrainPatch; soleira panorâmica sem colisor próprio",
		"eligible_candidate": "anexo_casa_voss",
		"grounding_mode": "raycast obrigatório antes de propor integração",
	},
	2: {
		"terrain_owner": "RiverRoadJourney.gd",
		"height_source": "TerrainPatch regional + altura das lajes de estrada",
		"expected_collider": "ColisorLajeEstradaRio_* (BoxShape3D) ou TerrainPatch fora da rota",
		"eligible_candidate": "ponte_marco_2",
		"grounding_mode": "raycast no terreno; nunca alterar o tabuleiro físico da estrada",
	},
	3: {
		"terrain_owner": "RiverRoadJourney.gd",
		"height_source": "TerrainPatch regional; pilares do arco são obstáculos, não solo",
		"expected_collider": "TerrainPatch no bordo; ColisorPilarArco_* excluído da aterragem",
		"eligible_candidate": "nenhum — arco estrutural foi rejeitado em CP-D5-010",
		"grounding_mode": "reservado para futuro activo lateral aprovado; não repetir arco rejeitado",
	},
	4: {
		"terrain_owner": "ForestLakeRegion.gd",
		"height_source": "TerrainPatch regional sob corredor florestal",
		"expected_collider": "TerrainPatch; ColisorLajeFloresta_* (BoxShape3D) apenas na faixa de rota",
		"eligible_candidate": "vegetacao_media_r4",
		"grounding_mode": "raycast no TerrainPatch, fora da laje e do corredor jogável",
	},
	5: {
		"terrain_owner": "ForestLakeRegion.gd",
		"height_source": "TerrainPatch regional e patamar do acampamento",
		"expected_collider": "TerrainPatch; ColisorTendaMajestic_* e ColisorLigacaoMajestic_* excluídos",
		"eligible_candidate": "pavilhao_majestic",
		"grounding_mode": "raycast no terreno lateral; preservar o anel e a ligação física",
	},
	6: {
		"terrain_owner": "ForestLakeRegion.gd",
		"height_source": "TerrainPatch/margem; lajes rasas e pilares são obstáculos de chegada",
		"expected_collider": "TerrainPatch na margem; ColisorLajeDeChegada_* e ColisorPilarSubmerso_* excluídos",
		"eligible_candidate": "nenhum — cais de lajes foi rejeitado em CP-D5-017",
		"grounding_mode": "reservado para futuro activo de margem aprovado; não repetir cais rejeitado",
	},
}

static func contract(anchor_id: int) -> Dictionary:
	assert(CONTRACTS.has(anchor_id), "CP-D5-023 só cobre marcos R1–R6.")
	var result: Dictionary = CONTRACTS[anchor_id].duplicate(true)
	var record := PLACEMENT.placement_record("height_contract_%d" % anchor_id, anchor_id, Vector2.ZERO, 0.0)
	result["anchor_id"] = anchor_id
	result["anchor_name"] = record["anchor_name"]
	result["world_xz"] = record["world_xz"]
	result["map_canvas"] = record["map_canvas"]
	return result

static func all_contracts() -> Array[Dictionary]:
	var catalog: Array[Dictionary] = []
	for anchor_id: int in range(1, 7):
		catalog.append(contract(anchor_id))
	return catalog

static func validate_contract(contract_data: Dictionary) -> bool:
	var anchor_id: int = int(contract_data["anchor_id"])
	var expected_xz: Vector2 = PLACEMENT.DEV5_SUPPORTED_ANCHORS[anchor_id] as Vector2
	return (
		contract_data["world_xz"] == expected_xz
		and not str(contract_data["terrain_owner"]).is_empty()
		and not str(contract_data["height_source"]).is_empty()
		and not str(contract_data["expected_collider"]).is_empty()
		and not str(contract_data["grounding_mode"]).is_empty()
	)
