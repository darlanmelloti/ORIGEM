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

func build(world_root: Node3D, context: Dictionary) -> Node3D:
	if world_root == null:
		return null
	var existing: Node3D = world_root.get_node_or_null(integration_node_name()) as Node3D
	if existing != null:
		return existing
	var region_node: Node3D = Node3D.new()
	region_node.name = integration_node_name()
	world_root.add_child(region_node)
	return region_node

func get_bounds() -> AABB:
	return create_contract().bounds

func get_anchor() -> Vector2:
	return create_contract().entry_anchor

func run_qa_contract() -> Dictionary:
	var contract = create_contract()
	var issues: PackedStringArray = contract.validate()
	if contract.owner != "Dev2":
		issues.append("owner deve ser Dev2")
	if contract.allowed_dynamic_lights > 2:
		issues.append("R2 excede o limite de duas luzes dinâmicas")
	if not contract.qa_routes.has("road_to_arch"):
		issues.append("rota road_to_arch ausente")
	return {
		"region_id": contract.region_id,
		"valid": issues.is_empty(),
		"issues": issues,
		"bounds": contract.bounds,
		"anchor": contract.entry_anchor,
		"qa_routes": contract.qa_routes,
	}

static func integration_node_name() -> String:
	return "EstradaDoRioExploravel"

static func acceptance_criteria() -> PackedStringArray:
	return PackedStringArray([
		"A rota até ao Arco mantém lajes físicas, solo e margens sem bloqueios.",
		"O reflexo azul é breve, orientado para Orion e não torna a água emissiva.",
		"A ponte lateral continua física, mas não compete com a leitura do Arco.",
		"Máximo de duas luzes dinâmicas locais ativas."
	])
