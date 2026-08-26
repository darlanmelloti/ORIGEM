## verify_r4_dense_forest.gd
## Executar com:
## godot --headless --path . --script res://qa/regions/verify_r4_dense_forest.gd
##
## Auditoria Dev4 da Região 4. O harness instancia ForestLakeRegion com um
## TerrainPatch determinístico, isolando R4 dos autoloads ainda não registados
## pela base e das geometrias pertencentes a R5 e R6.

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const R4_SCRIPT: Script = preload("res://levels/regions/R4_DenseForest.gd")
const MAIN_SCENE_CONFIGURATION_PATH: String = "res://scenes/main.tscn"
const MAX_DYNAMIC_LIGHTS: int = 1
const MAX_FERNS_IN_DENSE_FOREST: int = 12
const MIN_FOREST_PATH_SLABS: int = 12
const MIN_FOREST_TREE_CLEARANCE: float = 6.0

var _issues: PackedStringArray = PackedStringArray()

class TerrainPatchStub:
	extends Node3D

	func height_at(_world_x: float, _world_z: float) -> float:
		return 0.0

func _initialize() -> void:
	var world: Node3D = Node3D.new()
	world.name = "HarnessR4"
	root.add_child(world)
	var terrain: Node3D = TerrainPatchStub.new()
	terrain.name = "TerrainPatch"
	world.add_child(terrain)
	var forest_region: Node3D = FOREST_LAKE_SCRIPT.new() as Node3D
	forest_region.name = R4_SCRIPT.integration_node_name()
	world.add_child(forest_region)
	await process_frame
	await process_frame

	_validate_contract()
	_validate_route_and_threshold(forest_region)
	_validate_forest_ecology(forest_region)
	_validate_local_light_budget(forest_region)
	_validate_fog_configuration()

	if _issues.is_empty():
		print("[ORIGEM_R4_QA_OK] rota, clareira, ecologia, configuração de neblina e orçamento de uma luz local validados.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R4_QA_ERROR] %s" % issue)
	quit(1)

func _validate_contract() -> void:
	var contract = R4_SCRIPT.new().create_contract()
	var contract_issues: PackedStringArray = contract.validate()
	if contract.region_id != 4:
		_fail("Contrato R4 devolveu region_id inválido.")
	if contract.allowed_dynamic_lights != MAX_DYNAMIC_LIGHTS:
		_fail("Contrato R4 deve declarar exactamente uma luz dinâmica local.")
	if not contract.qa_routes.has("arch_to_forest") or not contract.qa_routes.has("forest_to_majestic"):
		_fail("Contrato R4 não declarou as rotas QA obrigatórias.")
	for issue: String in contract_issues:
		_fail("Contrato R4 inválido: %s" % issue)

func _validate_route_and_threshold(forest_region: Node) -> void:
	var path_root: Node = forest_region.find_child("TrilhoDaFlorestaDensa", true, false)
	var threshold: Node = forest_region.find_child("LimiarCartograficoDaFloresta", true, false)
	var transition: Node = forest_region.find_child("TransicaoOrganicaArcoFloresta", true, false)
	if path_root == null:
		_fail("Trilho físico da Floresta Densa ausente.")
	else:
		var slabs: Array[Node] = path_root.find_children("LajeFloresta_*", "MeshInstance3D", true, false)
		var colliders: Array[Node] = path_root.find_children("ColisorLajeFloresta_*", "StaticBody3D", true, false)
		if slabs.size() < MIN_FOREST_PATH_SLABS:
			_fail("Trilho R4 incompleto: %d lajes, mínimo %d." % [slabs.size(), MIN_FOREST_PATH_SLABS])
		if colliders.size() != slabs.size():
			_fail("Trilho R4 sem paridade física: %d lajes e %d colisores." % [slabs.size(), colliders.size()])
	if threshold == null or transition == null:
		_fail("Entrada Arco→Floresta sem limiar orgânico e transição declarados.")

func _validate_forest_ecology(forest_region: Node) -> void:
	var dense_forest: Node = forest_region.find_child("FlorestaDensaRegional", true, false)
	if dense_forest == null:
		_fail("Raiz ecológica FlorestaDensaRegional ausente.")
		return
	var focal_pines: Array[Node] = dense_forest.find_children("PinheiroFocalR4", "Node3D", true, false)
	var ferns: Array[Node] = dense_forest.find_children("FetoFloresta_*", "Node3D", true, false)
	var trees: Array[Node] = dense_forest.find_children("ArvoreDaFloresta_*", "Node3D", true, false)
	if focal_pines.size() != 1:
		_fail("R4 deve manter uma única copa PBR focal; foram encontradas %d." % focal_pines.size())
	if ferns.is_empty() or ferns.size() > MAX_FERNS_IN_DENSE_FOREST:
		_fail("Sub-bosque R4 fora do orçamento: %d fetos, máximo %d." % [ferns.size(), MAX_FERNS_IN_DENSE_FOREST])
	for tree: Node in trees:
		var tree_position: Vector3 = (tree as Node3D).position
		var path_distance: float = abs(tree_position.x - _path_x(tree_position.z))
		if path_distance < MIN_FOREST_TREE_CLEARANCE:
			_fail("Árvore entrou no corredor físico R4 em z=%.2f (distância %.2f)." % [tree_position.z, path_distance])
			break
		if tree_position.z >= 72.0 and tree_position.z <= 92.0:
			_fail("Árvore da dispersão bloqueia a clareira focal do Arco em z=%.2f." % tree_position.z)
			break

func _validate_local_light_budget(forest_region: Node) -> void:
	var r4_roots: Array[String] = [
		"BalizasDoTrilhoFlorestal",
		"RaizesPedrasESinaisP0",
		"PreenchimentoCorredorFloresta",
	]
	var dynamic_lights: int = 0
	for root_name: String in r4_roots:
		var r4_root: Node = forest_region.find_child(root_name, true, false)
		if r4_root != null:
			dynamic_lights += r4_root.find_children("*", "OmniLight3D", true, false).size()
			dynamic_lights += r4_root.find_children("*", "SpotLight3D", true, false).size()
	if dynamic_lights != MAX_DYNAMIC_LIGHTS:
		_fail("Orçamento R4 excedido: %d luzes dinâmicas locais; esperado %d." % [dynamic_lights, MAX_DYNAMIC_LIGHTS])

func _validate_fog_configuration() -> void:
	var main_scene_text: String = FileAccess.get_file_as_string(MAIN_SCENE_CONFIGURATION_PATH)
	if main_scene_text.is_empty() or not main_scene_text.contains("fog_density ="):
		_fail("A configuração de neblina do mundo não está declarada em scenes/main.tscn.")

func _path_x(world_z: float) -> float:
	var t: float = clampf((world_z - 116.0) / 124.0, 0.0, 1.0)
	return lerpf(-9.0, 4.0, t) + sin(t * PI * 2.0) * 2.4

func _fail(issue: String) -> void:
	_issues.append(issue)
