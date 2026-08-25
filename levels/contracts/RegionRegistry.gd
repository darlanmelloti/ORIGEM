## RegionRegistry.gd
## Catálogo imutável das fronteiras de trabalho R1–R6.
## Usado por TempleLevel para anunciar contratos e por QA para detectar conflitos
## antes de uma região entrar na branch de integração.

class_name RegionRegistry
extends RefCounted

const R1_SCRIPT: Script = preload("res://levels/regions/R1_VossHouse.gd")
const R2_SCRIPT: Script = preload("res://levels/regions/R2_RiverRoad.gd")
const R3_SCRIPT: Script = preload("res://levels/regions/R3_ArchRuins.gd")
const R4_SCRIPT: Script = preload("res://levels/regions/R4_DenseForest.gd")
const R5_SCRIPT: Script = preload("res://levels/regions/R5_MajesticCamp.gd")
const R6_SCRIPT: Script = preload("res://levels/regions/R6_SubmergedRuins.gd")

static func create_r1_r6_contracts() -> Array:
	var contracts: Array = []
	contracts.append(R1_SCRIPT.new().create_contract())
	contracts.append(R2_SCRIPT.new().create_contract())
	contracts.append(R3_SCRIPT.new().create_contract())
	contracts.append(R4_SCRIPT.new().create_contract())
	contracts.append(R5_SCRIPT.new().create_contract())
	contracts.append(R6_SCRIPT.new().create_contract())
	return contracts

static func validate_r1_r6_contracts(contracts: Array) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if contracts.size() != 6:
		issues.append("A sprint R1–R6 exige exactamente seis contratos.")
	var expected_region_id: int = 1
	var previous_contract = null
	for contract in contracts:
		if contract == null:
			issues.append("Contrato regional nulo.")
			continue
		if contract.region_id != expected_region_id:
			issues.append("A ordem contratual deve ser R1→R6; recebido R%d onde era esperado R%d." % [contract.region_id, expected_region_id])
		issues.append_array(contract.validate())
		if previous_contract != null:
			var connection_distance: float = previous_contract.exit_anchor.distance_to(contract.entry_anchor)
			if connection_distance > 130.0:
				issues.append("Lacuna cartográfica excessiva entre R%d e R%d: %.2fm." % [previous_contract.region_id, contract.region_id, connection_distance])
		previous_contract = contract
		expected_region_id += 1
	return issues

static func emit_summary(contracts: Array) -> void:
	for contract in contracts:
		print("[ORIGEM_REGION_CONTRACT] %s" % contract.summary())
