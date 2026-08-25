## R1_VossHouse.gd
## Contrato de trabalho da Região 1 — Casa Voss.
## A geometria existente permanece em levels/VossHouse.gd; este módulo não a recria.

class_name R1VossHouseRegion
extends RefCounted

const CONTRACT_SCRIPT: Script = preload("res://levels/contracts/RegionContract.gd")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")

func create_contract():
	var contract = CONTRACT_SCRIPT.new()
	contract.configure(
		1,
		"Casa Voss",
		"Dev1",
		CARTOGRAPHIC_ANCHORS.CASA_VOSS,
		CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO,
		AABB(Vector3(-39.0, -8.0, -12.0), Vector3(34.0, 28.0, 36.0)),
		3,
		PackedStringArray(["road_return_voss", "voss_to_road", "voss_lateral"]),
		"res://levels/VossHouse.gd",
		"Prólogo, interior habitado, porta E e vista exterior para o vale."
	)
	return contract

static func integration_node_name() -> String:
	return "VossHouse"

static func acceptance_criteria() -> PackedStringArray:
	return PackedStringArray([
		"Menu → Novo Jogo → prólogo → porta E → exterior sem bloqueio.",
		"A porta remove colisores e folhas visuais ao terminar a abertura.",
		"A vista exterior apresenta estrada, vale e Orion como destino distante.",
		"Máximo de três luzes dinâmicas locais ativas."
	])
