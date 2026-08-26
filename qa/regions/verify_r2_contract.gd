## verify_r2_contract.gd
## Executar com:
## godot --headless --path . --script res://qa/regions/verify_r2_contract.gd

extends SceneTree

const R2_SCRIPT: Script = preload("res://levels/regions/R2_RiverRoad.gd")

func _init() -> void:
	var region = R2_SCRIPT.new()
	var contract = region.create_contract()
	var issues: PackedStringArray = contract.validate()
	if not region.has_method("build") or not region.has_method("get_bounds") or not region.has_method("get_anchor") or not region.has_method("run_qa_contract"):
		issues.append("R2 não expõe a interface regional mínima")
	var qa_result: Dictionary = region.run_qa_contract()
	if not bool(qa_result.get("valid", false)):
		issues.append("run_qa_contract() reportou falha")
	if contract.region_id != 2:
		issues.append("R2 deve declarar region_id=2")
	if contract.owner != "Dev2":
		issues.append("R2 deve permanecer sob propriedade do Dev2")
	if contract.allowed_dynamic_lights > 2:
		issues.append("R2 excede o orçamento de duas luzes dinâmicas")
	if not contract.qa_routes.has("road_to_arch"):
		issues.append("R2 deve declarar a rota road_to_arch")
	if not contract.qa_routes.has("positive_bridge"):
		issues.append("R2 deve declarar a rota positive_bridge")
	if not contract.qa_routes.has("road_return_voss"):
		issues.append("R2 deve declarar a rota road_return_voss")
	if not contract.source_module.ends_with("levels/RiverRoadJourney.gd"):
		issues.append("R2 aponta para um módulo de origem inesperado")
	if not contract.is_world_position_inside(Vector3(-21.4, 0.0, 12.0)):
		issues.append("âncora física de entrada da R2 está fora da AABB")
	if not contract.is_world_position_inside(Vector3(-10.0, 0.0, 92.0)):
		issues.append("projeção física do Arco está fora da AABB da R2")
	if not issues.is_empty():
		for issue: String in issues:
			printerr("[ORIGEM_R2_CONTRACT_ERROR] %s" % issue)
		quit(1)
		return
	print("[ORIGEM_R2_CONTRACT_OK] R2 válida: Dev2, duas luzes, estrada→arco, retorno e ponte lateral.")
	print("[ORIGEM_R2_RIVER_QA_014_OK] contrato R2 preserva as três rotas canônicas e o proprietário Dev2.")
	quit(0)
