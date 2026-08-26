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
	if not (region.get_bounds() is AABB):
		issues.append("get_bounds() da R2 deve retornar AABB")
	if not (region.get_anchor() is Vector2):
		issues.append("get_anchor() da R2 deve retornar Vector2")
	if not (region.acceptance_criteria() is PackedStringArray):
		issues.append("acceptance_criteria() da R2 deve retornar PackedStringArray")
	var serialized: Dictionary = contract.to_dictionary()
	for field: String in ["id", "name", "owner", "entry_anchor", "exit_anchor", "bounds", "allowed_dynamic_lights", "qa_routes", "source_module", "notes"]:
		if not serialized.has(field):
			issues.append("serialização R2 perdeu o campo contratual: %s" % field)
	if int(serialized.get("id", -1)) != contract.region_id or serialized.get("owner") != contract.owner:
		issues.append("serialização R2 diverge dos identificadores do contrato")
	if serialized.get("qa_routes") != contract.qa_routes or serialized.get("source_module") != contract.source_module:
		issues.append("serialização R2 diverge das rotas ou origem do contrato")
	var qa_result: Dictionary = region.run_qa_contract()
	if not bool(qa_result.get("valid", false)):
		issues.append("run_qa_contract() reportou falha")
	if int(qa_result.get("region_id", -1)) != contract.region_id:
		issues.append("run_qa_contract() deve retornar o region_id canônico")
	if qa_result.get("bounds") != contract.bounds:
		issues.append("run_qa_contract() deve retornar a AABB contratual")
	if qa_result.get("anchor") != contract.entry_anchor:
		issues.append("run_qa_contract() deve retornar a âncora de entrada")
	if qa_result.get("qa_routes") != contract.qa_routes:
		issues.append("run_qa_contract() deve retornar as rotas canônicas")
	if not (qa_result.get("issues") is PackedStringArray and qa_result.get("issues").is_empty()):
		issues.append("run_qa_contract() válido deve retornar issues vazio")
	if contract.region_id != 2:
		issues.append("R2 deve declarar region_id=2")
	if contract.owner != "Dev2":
		issues.append("R2 deve permanecer sob propriedade do Dev2")
	if contract.display_name != "Estrada do Rio":
		issues.append("R2 deve preservar o nome de apresentação Estrada do Rio")
	if R2_SCRIPT.integration_node_name() != "EstradaDoRioExploravel":
		issues.append("R2 deve preservar o nome canônico EstradaDoRioExploravel")
	if contract.allowed_dynamic_lights > 2:
		issues.append("R2 excede o orçamento de duas luzes dinâmicas")
	if contract.allowed_dynamic_lights < 0 or contract.allowed_dynamic_lights != 2:
		issues.append("R2 deve declarar exatamente o orçamento global de duas luzes")
	if not contract.qa_routes.has("road_to_arch"):
		issues.append("R2 deve declarar a rota road_to_arch")
	if not contract.qa_routes.has("positive_bridge"):
		issues.append("R2 deve declarar a rota positive_bridge")
	if not contract.qa_routes.has("road_return_voss"):
		issues.append("R2 deve declarar a rota road_return_voss")
	var canonical_routes := PackedStringArray(["road_to_arch", "positive_bridge", "road_return_voss"])
	if contract.qa_routes.size() != canonical_routes.size():
		issues.append("R2 deve declarar exatamente três rotas canônicas")
	for route: String in canonical_routes:
		if contract.qa_routes.count(route) != 1:
			issues.append("rota R2 deve ocorrer exatamente uma vez: %s" % route)
	for route: String in contract.qa_routes:
		if not canonical_routes.has(route):
			issues.append("rota R2 não aprovada no contrato: %s" % route)
	if not contract.source_module.ends_with("levels/RiverRoadJourney.gd"):
		issues.append("R2 aponta para um módulo de origem inesperado")
	if contract.bounds.size.z < 88.0 or contract.bounds.size.x < 70.0:
		issues.append("AABB da R2 não cobre o corredor físico declarado")
	if contract.bounds.size.y <= 0.0 or contract.bounds.size.x <= 0.0 or contract.bounds.size.z <= 0.0:
		issues.append("AABB da R2 não pode ser degenerada")
	if contract.bounds.position.y > 0.0 or contract.bounds.end.y < 0.0:
		issues.append("AABB da R2 deve conter o plano físico y=0")
	var acceptance = R2_SCRIPT.acceptance_criteria()
	if acceptance.size() < 4:
		issues.append("R2 deve declarar pelo menos quatro critérios de aceitação")
	var acceptance_text: String = " ".join(acceptance).to_lower()
	for criterion: String in acceptance:
		if criterion.strip_edges().is_empty():
			issues.append("R2 não pode conter critério de aceitação vazio")
	for required_term: String in ["rota", "reflexo", "ponte", "luz"]:
		if not acceptance_text.contains(required_term):
			issues.append("critérios R2 devem cobrir explicitamente: %s" % required_term)
	for required_term: String in ["orion", "não torna a água emissiva", "não compete"]:
		if not acceptance_text.contains(required_term):
			issues.append("critérios R2 devem preservar a restrição: %s" % required_term)
	var description_text: String = contract.notes.to_lower()
	for described_term: String in ["estrada", "margens", "ponte", "reflet", "azul"]:
		if not description_text.contains(described_term):
			issues.append("notas contratuais R2 deve mencionar: %s" % described_term)
	if not acceptance_text.contains("rio") and not description_text.contains("rio"):
		issues.append("contrato R2 deve manter referência explícita ao rio")
	if not contract.is_world_position_inside(Vector3(-21.4, 0.0, 12.0)):
		issues.append("âncora física de entrada da R2 está fora da AABB")
	if not contract.is_world_position_inside(Vector3(-10.0, 0.0, 92.0)):
		issues.append("projeção física do Arco está fora da AABB da R2")
	var entry_world := Vector3(contract.entry_anchor.x, 0.0, contract.entry_anchor.y)
	var exit_world := Vector3(contract.exit_anchor.x, 0.0, contract.exit_anchor.y)
	if not contract.is_world_position_inside(entry_world):
		issues.append("âncora contratual de entrada da R2 está fora da AABB")
	if not contract.is_world_position_inside(exit_world):
		issues.append("âncora contratual de saída da R2 está fora da AABB")
	if contract.entry_anchor != R2_SCRIPT.CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO:
		issues.append("âncora de entrada R2 diverge da âncora cartográfica oficial")
	if contract.exit_anchor != R2_SCRIPT.CARTOGRAPHIC_ANCHORS.ARCO_RUINAS:
		issues.append("âncora de saída R2 diverge da âncora cartográfica oficial")
	var build_root := Node3D.new()
	var first_build: Node3D = region.build(build_root, {})
	var second_build: Node3D = region.build(build_root, {})
	if first_build == null or second_build == null or first_build != second_build:
		issues.append("build() da R2 deve ser idempotente e retornar o mesmo nó")
	if build_root.get_child_count() != 1 or first_build.name != R2_SCRIPT.integration_node_name():
		issues.append("build() da R2 deve manter um único nó com nome canônico")
	build_root.free()
	if not issues.is_empty():
		for issue: String in issues:
			printerr("[ORIGEM_R2_CONTRACT_ERROR] %s" % issue)
		quit(1)
		return
	print("[ORIGEM_R2_CONTRACT_OK] R2 válida: Dev2, duas luzes, estrada→arco, retorno e ponte lateral.")
	print("[ORIGEM_R2_RIVER_QA_014_OK] contrato R2 preserva as três rotas canônicas e o proprietário Dev2.")
	print("[ORIGEM_R2_RIVER_QA_015_OK] critérios de aceitação, origem e limites físicos R2 completos.")
	print("[ORIGEM_R2_RIVER_QA_016_OK] critérios R2 cobrem rota, reflexo, ponte e iluminação.")
	print("[ORIGEM_R2_RIVER_QA_017_OK] restrições de Orion, água não emissiva e ponte preservadas.")
	print("[ORIGEM_R2_RIVER_QA_018_OK] notas contratuais R2 consistente com os critérios essenciais.")
	print("[ORIGEM_R2_RIVER_QA_019_OK] âncoras contratuais de entrada e saída dentro da AABB R2.")
	print("[ORIGEM_R2_RIVER_QA_020_OK] build R2 idempotente e nó canônico preservado.")
	print("[ORIGEM_R2_RIVER_QA_021_OK] run_qa_contract R2 retorna metadados canônicos.")
	print("[ORIGEM_R2_RIVER_QA_022_OK] rotas R2 são canônicas, únicas e sem atalhos extras.")
	print("[ORIGEM_R2_RIVER_QA_023_OK] orçamento regional R2 coerente com o teto global de duas luzes.")
	print("[ORIGEM_R2_RIVER_QA_024_OK] interface regional R2 expõe métodos e tipos estáveis.")
	print("[ORIGEM_R2_RIVER_QA_025_OK] identificadores e nomes canônicos da R2 preservados.")
	print("[ORIGEM_R2_RIVER_QA_026_OK] AABB R2 não degenerada e com plano físico contido.")
	print("[ORIGEM_R2_RIVER_QA_027_OK] âncoras cartográficas R2 correspondem aos pontos físicos oficiais.")
	print("[ORIGEM_R2_RIVER_QA_028_OK] serialização R2 preserva todos os campos contratuais essenciais.")
	quit(0)
