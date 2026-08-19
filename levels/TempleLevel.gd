## TempleLevel.gd
## Orquestra o Vale de Kheper como ambiente 3D real de alto realismo.
## Removidas todas as caixas grossas do greybox inicial em favor de arquitetura orgânica e arruinada.

extends Node3D

const TERRAIN_PATCH_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const VALLEY_BIOME_SCRIPT: Script = preload("res://levels/ValleyBiome.gd")
const SANCTUARY_SLICE_SCRIPT: Script = preload("res://levels/SanctuarySlice.gd")
const SANCTUARY_INTERIOR_SCRIPT: Script = preload("res://levels/SanctuaryInterior.gd")
const ORGANIC_RUIN_KIT_SCRIPT: Script = preload("res://levels/OrganicRuinKit.gd")
const ASSET_PASS_KIT_SCRIPT: Script = preload("res://levels/AssetPassKit.gd")
const VOSS_HOUSE_SCRIPT: Script = preload("res://levels/VossHouse.gd")
const EXPLORABLE_MOUNTAINS_SCRIPT: Script = preload("res://levels/ExplorableMountains.gd")
const DAYLIGHT_VALLEY_SCRIPT: Script = preload("res://levels/DaylightValley.gd")
const RIVER_ROAD_JOURNEY_SCRIPT: Script = preload("res://levels/RiverRoadJourney.gd")
const FOREST_LAKE_REGION_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const HIGHLAND_REGION_SCRIPT: Script = preload("res://levels/HighlandRegion.gd")
const ORION_DESTINATION_REGION_SCRIPT: Script = preload("res://levels/OrionDestinationRegion.gd")
const REGIONAL_CINEMATIC_DIRECTOR_SCRIPT: Script = preload("res://levels/RegionalCinematicDirector.gd")
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")
const CARTOGRAPHIC_HANDOFF_PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const DAYLIGHT_VARIANT_ENABLED: bool = true

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var dark_stone_material: StandardMaterial3D
var moss_material: StandardMaterial3D
var mountain_material: StandardMaterial3D
var snow_material: StandardMaterial3D
var glow_material: StandardMaterial3D
var fireflies: Array[MeshInstance3D] = []
var elapsed_time: float = 0.0
var voss_house: Node3D
var orion_mountains: Node3D

func _ready() -> void:
	if has_node("TerrainPatch"):
		# O mundo pode já ter sido restaurado na cena; os spawns de QA continuam obrigatórios para validar rotas físicas.
		_queue_regional_qa_modes()
		return
	_create_materials()
	_create_terrain()
	_build_orion_mountains()
	_build_voss_house()
	# A captura técnica precisa da geografia regional já construída antes de ativar a câmara do take; o fluxo jogável mantém os atrasos cinematográficos normais.
	if OS.has_environment("ORIGEM_CAPTURE_TAKE") or OS.has_environment("ORIGEM_QA_INTERACT") or OS.has_environment("ORIGEM_QA_ROUTE") or OS.has_environment("ORIGEM_QA_CINE48_HANDOFF"):
		# Capturas, rotas e interações de QA requerem o mundo regional antes da contagem do roteiro; o jogo normal mantém o carregamento encenado.
		_enforce_voss_opening_daylight()
		_build_world_after_voss_prologue()
	else:
		# A variante diurna mantém a tempestade guardada como opção temporal, mas inicia o vale legível sob sol oblíquo.
		get_tree().create_timer(0.70).timeout.connect(_enforce_voss_opening_daylight)
		# O vale diurno entra cedo para que o percurso, o rio e os marcos sejam visíveis logo depois da saída da Casa Voss.
		get_tree().create_timer(1.20).timeout.connect(_build_world_after_voss_prologue)
	_queue_regional_qa_modes()

func _queue_regional_qa_modes() -> void:
	if OS.get_environment("ORIGEM_QA_ROUTE") == "majestic_to_lake" or OS.get_environment("ORIGEM_QA_ROUTE") == "forest_to_majestic":
		# O mundo regional já foi construído antes desta fila; o spawn imediato deixa a janela de captura disponível para a travessia.
		call_deferred("_prepare_majestic_lake_route_qa")
	elif OS.get_environment("ORIGEM_QA_ROUTE") == "forest_to_ruins" or OS.get_environment("ORIGEM_QA_ROUTE") == "ruins_arrival":
		# Provas cartográficas do trilho e da chegada à margem, isoladas das Regiões 7–12 e do fluxo normal do jogo.
		call_deferred("_prepare_lake_approach_route_qa")
	elif OS.get_environment("ORIGEM_QA_ROUTE") == "bridge_crossing":
		get_tree().create_timer(2.40).timeout.connect(_prepare_valley_bridge_route_qa)
	elif OS.get_environment("ORIGEM_QA_ROUTE") == "positive_bridge":
		call_deferred("_prepare_positive_bridge_route_qa")
	elif OS.get_environment("ORIGEM_QA_ROUTE") == "road_return_voss":
		call_deferred("_prepare_road_return_voss_qa")
	elif OS.get_environment("ORIGEM_QA_ROUTE") == "road_to_arch":
		call_deferred("_prepare_road_to_arch_route_qa")
	elif OS.get_environment("ORIGEM_QA_ROUTE") == "handoff_to_village":
		get_tree().create_timer(2.40).timeout.connect(_prepare_village_handoff_route_qa)
	elif OS.get_environment("ORIGEM_QA_ROUTE") == "arch_to_forest":
		# O modo cartográfico não aguarda tempo de jogo: a construção regional já terminou antes desta fila.
		# Isto evita que o llvmpipe consuma a janela de captura sem chegar ao spawn técnico.
		call_deferred("_prepare_arch_forest_route_qa")
	var carto_route: String = OS.get_environment("ORIGEM_QA_ROUTE")
	if carto_route != "" and carto_route != "arch_to_forest" and OS.get_environment("ORIGEM_QA_CARTO_RULER") == "1":
		# A telemetria só corre no harness e aguarda o spawn específico de cada rota.
		get_tree().create_timer(1.10).timeout.connect(_emit_cartographic_ruler_qa.bind(carto_route))
	if OS.get_environment("ORIGEM_QA_INTERACT") == "lake_stela":
		get_tree().create_timer(2.40).timeout.connect(_prepare_lake_stela_interaction_qa)
	elif OS.get_environment("ORIGEM_QA_INTERACT") == "majestic_stela":
		get_tree().create_timer(2.40).timeout.connect(_prepare_majestic_stela_interaction_qa)
	# CP-CARTO-83 QA: a captura é chamada pelo spawn específico após a câmara receber a posição final.

func _save_viewport_snapshot_qa() -> void:
	var snapshot_path: String = OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT")
	if snapshot_path == "":
		return
	# Aguarda duas composições reais do viewport; evita gravar o splash do Xvfb antes do mundo ser apresentado.
	await get_tree().process_frame
	await get_tree().process_frame
	var image: Image = get_viewport().get_texture().get_image()
	var result: Error = image.save_png(snapshot_path)
	print("[ORIGEM_QA_SNAPSHOT] path=%s result=%s" % [snapshot_path, result])

func _run_arch_forest_floor_probe_qa() -> void:
	# A sonda conta frames de física, não segundos de render, para sobreviver ao llvmpipe lento.
	var previous_frame: int = 0
	for sample_frame: int in [0, 30, 90, 180, 360]:
		for _frame in range(sample_frame - previous_frame):
			await get_tree().physics_frame
		_emit_arch_forest_floor_probe(float(sample_frame) / 60.0)
		previous_frame = sample_frame

func _emit_arch_forest_floor_probe(sample_seconds: float) -> void:
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		print("[CP_CARTO80_FLOOR] t=%.1fs jogador=ausente" % sample_seconds)
		return
	var expected_y: float = _terrain_height_for_qa(player.global_position.x, player.global_position.z) + 1.25
	print("[CP_CARTO80_FLOOR] t=%.1fs pos=(%.2f,%.2f,%.2f) esperado_y=%.2f no_chao=%s" % [sample_seconds, player.global_position.x, player.global_position.y, player.global_position.z, expected_y, str(player.is_on_floor())])

func _emit_cartographic_ruler_qa(route_name: String) -> void:
	# CP-CARTO-78: converte a posição física de Elias numa leitura auditável do mapa oficial.
	# Não desloca actores, não altera geometria e não é chamado no jogo normal.
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		push_warning("[CP_CARTO78] Jogador indisponível para a régua cartográfica.")
		return
	var world: Vector2 = Vector2(player.global_position.x, player.global_position.z)
	var specs: Array[Dictionary] = [
		{"id": 1, "name": "Casa Voss", "anchor": CARTOGRAPHIC_ANCHORS.CASA_VOSS},
		{"id": 2, "name": "Estrada do Rio", "anchor": CARTOGRAPHIC_ANCHORS.ESTRADA_RIO_INICIO},
		{"id": 3, "name": "Arco das Ruínas", "anchor": CARTOGRAPHIC_ANCHORS.ARCO_RUINAS},
		{"id": 4, "name": "Floresta Densa", "anchor": CARTOGRAPHIC_ANCHORS.FLORESTA_DENSA_ENTRADA},
		{"id": 5, "name": "Acampamento Majestic", "anchor": CARTOGRAPHIC_ANCHORS.ACAMPAMENTO_MAJESTIC},
		{"id": 6, "name": "Ruínas Submersas", "anchor": CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS}
	]
	var nearest: Dictionary = specs[0]
	var nearest_distance: float = world.distance_to(nearest["anchor"] as Vector2)
	for spec: Dictionary in specs:
		var distance: float = world.distance_to(spec["anchor"] as Vector2)
		print("[CP_CARTO78_DISTANCE] rota=%s marco=%d:%s distancia=%.2fm" % [route_name, spec["id"], spec["name"], distance])
		if distance < nearest_distance:
			nearest = spec
			nearest_distance = distance
	var map_position: Vector2 = CARTOGRAPHIC_ANCHORS.map_texture_position(world)
	var next_destination: Dictionary = CARTOGRAPHIC_ANCHORS.next_dev1_destination(world)
	print("[CP_CARTO78_RULER] rota=%s mundo=(%.2f,%.2f) marco_proximo=%d:%s distancia=%.2fm mapa=(%.1f,%.1f) proximo=%d:%s" % [route_name, world.x, world.y, nearest["id"], nearest["name"], nearest_distance, map_position.x, map_position.y, next_destination["anchor_id"], next_destination["label"]])

func _prepare_majestic_stela_interaction_qa() -> void:
	# Prova isolada da Estela de Memória: o jogador nasce fora do anel de tendas e de frente para o colisor interactivo.
	if not has_node("RegiaoFlorestaLagoExploravel"):
		get_tree().create_timer(0.75).timeout.connect(_prepare_majestic_stela_interaction_qa)
		return
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		get_tree().create_timer(0.25).timeout.connect(_prepare_majestic_stela_interaction_qa)
		return
	var stela: StaticBody3D = get_node_or_null("RegiaoFlorestaLagoExploravel/AcampamentoMajestic/RuneP0_01") as StaticBody3D
	if stela == null:
		get_tree().create_timer(0.50).timeout.connect(_prepare_majestic_stela_interaction_qa)
		return
	# Aproximação pelo exterior norte: mantém uma linha de visão livre para o raio de 2,5 m e não atravessa as tendas.
	var approach: Vector3 = stela.global_position + Vector3(0.0, 0.0, 2.0)
	player.velocity = Vector3.ZERO
	player.global_position = Vector3(approach.x, _terrain_height_for_qa(approach.x, approach.z) + 1.25, approach.z)
	# A câmara de primeira pessoa aponta no eixo -Z; não usar a frente +Z de um modelo de personagem neste spawn técnico.
	player.look_at(Vector3(stela.global_position.x, player.global_position.y, stela.global_position.z), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_INTERACT] Elias posicionado diante da Estela Majestic em %s; estela=%s" % [player.global_position, stela.global_position])

func _prepare_lake_stela_interaction_qa() -> void:
	# A região é procedural e pode ocupar mais do que a primeira janela de temporizador em llvmpipe.
	# Reagenda a prova até o lago existir, sem alterar o fluxo normal de jogo.
	if not has_node("RegiaoFlorestaLagoExploravel"):
		get_tree().create_timer(0.75).timeout.connect(_prepare_lake_stela_interaction_qa)
		return
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		get_tree().create_timer(0.25).timeout.connect(_prepare_lake_stela_interaction_qa)
		return
	var stela: StaticBody3D = get_node_or_null("RegiaoFlorestaLagoExploravel/RuinasSubmersasDoLago/RuneP0_02") as StaticBody3D
	if stela == null:
		get_tree().create_timer(0.50).timeout.connect(_prepare_lake_stela_interaction_qa)
		return
	# A aproximação usa o nó real da estela para acompanhar a cota de água e qualquer refinamento futuro da margem.
	var approach: Vector3 = stela.global_position + Vector3(0.0, 0.0, 2.0)
	player.velocity = Vector3.ZERO
	player.global_position = Vector3(approach.x, _terrain_height_for_qa(approach.x, approach.z) + 1.25, approach.z)
	player.look_at(Vector3(stela.global_position.x, player.global_position.y, stela.global_position.z), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_INTERACT] Elias posicionado diante da Estela do Lago em %s; estela=%s" % [player.global_position, stela.global_position])

func _prepare_road_return_voss_qa() -> void:
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		get_tree().create_timer(0.25).timeout.connect(_prepare_road_return_voss_qa)
		return
	# Vista de retorno no eixo real da Estrada: Casa Voss é observada como origem, sem alterar a rota do jogo.
	var spawn: Vector3 = Vector3(-20.4, 0.0, 34.0)
	var focus: Vector3 = Vector3(-22.0, 0.0, 8.0)
	player.velocity = Vector3.ZERO
	player.set("player_velocity", Vector3.ZERO)
	player.global_position = Vector3(spawn.x, _terrain_height_for_qa(spawn.x, spawn.z) + 1.25, spawn.z)
	player.look_at(Vector3(focus.x, player.global_position.y, focus.z), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_ROUTE] Spawn RetornoCasaVoss ativo em %s; foco=%s" % [player.global_position, focus])

func _prepare_road_to_arch_route_qa() -> void:
	# Harness de evidência macro R1–R3: Elias nasce no mesmo primeiro segmento livre da Estrada e aponta para o Arco físico recuado.
	# A tomada usa a câmara do jogador, evitando o conflito de câmara que produziu um frame negro no modo cinematic capture OpenGL.
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		get_tree().create_timer(0.25).timeout.connect(_prepare_road_to_arch_route_qa)
		return
	var spawn_x: float = CartographicAnchors.ESTRADA_RIO_INICIO.x + 1.35
	var spawn_z: float = CartographicAnchors.ESTRADA_RIO_INICIO.y + 10.0
	var focus: Vector3 = Vector3(-13.8, 0.0, 92.0)
	player.velocity = Vector3.ZERO
	player.set("player_velocity", Vector3.ZERO)
	player.global_position = Vector3(spawn_x, _terrain_height_for_qa(spawn_x, spawn_z) + 1.30, spawn_z)
	player.look_at(Vector3(focus.x, player.global_position.y, focus.z), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_ROUTE] Spawn Estrada–Arco ativo em %s; foco=%s" % [player.global_position, focus])
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_viewport_snapshot_qa")

func _prepare_positive_bridge_route_qa() -> void:
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		get_tree().create_timer(0.25).timeout.connect(_prepare_positive_bridge_route_qa)
		return
	# A ponte canónica da Estrada do Rio está no eixo positivo z=58; esta tomada olha para a silhueta lateral a partir do próprio trilho.
	var spawn: Vector3 = Vector3(-16.6, 0.0, 51.0)
	var focus: Vector3 = Vector3(6.8, 0.0, 58.0)
	player.velocity = Vector3.ZERO
	player.set("player_velocity", Vector3.ZERO)
	player.global_position = Vector3(spawn.x, _terrain_height_for_qa(spawn.x, spawn.z) + 1.25, spawn.z)
	player.look_at(Vector3(focus.x, player.global_position.y, focus.z), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_ROUTE] Spawn PontePositiva ativo em %s; foco=%s" % [player.global_position, focus])

func _prepare_valley_bridge_route_qa() -> void:
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		push_warning("[ORIGEM_QA_ROUTE] Jogador indisponível para a ponte do vale.")
		return
	var bridge_start_x: float = -7.0
	var bridge_z: float = -57.0
	player.global_position = Vector3(bridge_start_x, _terrain_height_for_qa(bridge_start_x, bridge_z) + 2.20, bridge_z)
	player.rotation.y = -PI * 0.5
	# O Player conserva a rotação de cabeça da Casa Voss; limpa-a apenas no modo QA para que W e a câmara apontem para o tabuleiro.
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_ROUTE] Elias posicionado na entrada da Ponte de Pedra em %s" % player.global_position)

func _prepare_majestic_lake_route_qa() -> void:
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		push_warning("[ORIGEM_QA_ROUTE] Jogador indisponível para a rota Majestic–lago.")
		return
	var reverse_from_forest: bool = OS.get_environment("ORIGEM_QA_ROUTE") == "forest_to_majestic"
	var spawn_x: float = -2.5 if reverse_from_forest else -77.4
	var spawn_z: float = 178.0
	# Anula a queda acumulada antes do teleport, tal como no harness Arco–Floresta.
	player.velocity = Vector3.ZERO
	player.set("player_velocity", Vector3.ZERO)
	player.global_position = Vector3(spawn_x, _terrain_height_for_qa(spawn_x, spawn_z) + 1.25, spawn_z)
	# A mesma sequência de lajes é atravessada nas duas direcções, sem corte diagonal pelo terreno aberto.
	var connector_target: Vector3 = Vector3(-77.4 if reverse_from_forest else -2.5, player.global_position.y, spawn_z)
	if not reverse_from_forest:
		# CP-CARTO-84: o take de saída Majestic deve olhar para a nova ligação e a primeira laje real da margem R6, não regressar para a Floresta.
		var region: Node3D = get_node_or_null("RegiaoFlorestaLagoExploravel") as Node3D
		if region != null and region.has_method("_lake_shore_x"):
			var shore_x: float = float(region.call("_lake_shore_x", spawn_z))
			connector_target = Vector3(shore_x, player.global_position.y, spawn_z + 8.0)
	player.look_at(connector_target, Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	var route_label: String = "Floresta–Majestic" if reverse_from_forest else "Majestic–lago"
	print("[ORIGEM_QA_ROUTE] Spawn %s ativo em %s; primeira_perna=%s" % [route_label, player.global_position, connector_target])
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "" and OS.get_environment("ORIGEM_QA_CARTO_LINK_WALK") != "1":
		call_deferred("_save_viewport_snapshot_qa")

func _prepare_lake_approach_route_qa() -> void:
	var region: Node3D = get_node_or_null("RegiaoFlorestaLagoExploravel") as Node3D
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if region == null or player == null:
		get_tree().create_timer(0.35).timeout.connect(_prepare_lake_approach_route_qa)
		return
	var arrival_focus: bool = OS.get_environment("ORIGEM_QA_ROUTE") == "ruins_arrival"
	var start_z: float = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.y - (30.0 if arrival_focus else 58.0)
	var target_z: float = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.y - (12.0 if arrival_focus else 27.0)
	var start_x: float = float(region.call("_lake_shore_x", start_z))
	var target_x: float = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.x - 6.0 if arrival_focus else float(region.call("_lake_shore_x", target_z))
	if arrival_focus:
		target_z = CARTOGRAPHIC_ANCHORS.RUINAS_SUBMERSAS.y
	player.velocity = Vector3.ZERO
	player.set("player_velocity", Vector3.ZERO)
	player.global_position = Vector3(start_x, _terrain_height_for_qa(start_x, start_z) + 1.25, start_z)
	player.look_at(Vector3(target_x, player.global_position.y, target_z), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	var route_label: String = "Chegada Ruínas" if arrival_focus else "Floresta–Ruínas"
	print("[ORIGEM_QA_ROUTE] Spawn %s ativo em %s; alvo=%s" % [route_label, player.global_position, Vector3(target_x, player.global_position.y, target_z)])
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_viewport_snapshot_qa")

func _prepare_arch_forest_route_qa() -> void:
	# Exclusivo de QA: a prova inicia poucos metros antes do marco 4, no eixo de saída do Arco para a Floresta Densa.
	# Não altera a rota Casa Voss → Arco usada no jogo normal e mantém a orientação local -Z de Elias voltada para Z crescente.
	if not has_node("RegiaoFlorestaLagoExploravel"):
		get_tree().create_timer(0.75).timeout.connect(_prepare_arch_forest_route_qa)
		return
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		get_tree().create_timer(0.25).timeout.connect(_prepare_arch_forest_route_qa)
		return
	var spawn_x: float = CARTOGRAPHIC_ANCHORS.FLORESTA_DENSA_ENTRADA.x
	var spawn_z: float = CARTOGRAPHIC_ANCHORS.FLORESTA_DENSA_ENTRADA.y - 9.0
	player.velocity = Vector3.ZERO
	# Player.gd mantém a velocidade de queda num acumulador próprio; anulá-lo evita que um frame anterior ao teleport atravesse o TerrainPatch.
	player.set("player_velocity", Vector3.ZERO)
	player.global_position = Vector3(spawn_x, _terrain_height_for_qa(spawn_x, spawn_z) + 1.25, spawn_z)
	# `look_at` fixa uma linha de horizonte física; evita reutilizar qualquer orientação de câmara da Casa Voss no harness.
	player.look_at(Vector3(spawn_x, player.global_position.y, spawn_z + 22.0), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_ROUTE] Spawn Arco–Floresta ativo em %s" % player.global_position)
	# Este spawn é enfileirado por `call_deferred`; em alguns ambientes llvmpipe, timers globais podem ser suprimidos após o take.
	# Emite a régua directamente quando o jogador já existe, mantendo a telemetria restrita ao modo QA.
	if OS.get_environment("ORIGEM_QA_CARTO_RULER") == "1":
		call_deferred("_emit_cartographic_ruler_qa", "arch_to_forest")
	if OS.get_environment("ORIGEM_QA_FLOOR_PROBE") == "1":
		call_deferred("_run_arch_forest_floor_probe_qa")

func _prepare_village_handoff_route_qa() -> void:
	# Exclusivo de QA: começa no início do trilho Dev1 e desloca-se para a abertura central do portão.
	var player: CharacterBody3D = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player == null:
		push_warning("[ORIGEM_QA_ROUTE] Jogador indisponível para o handoff da Vila Elevada.")
		return
	var handoff_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.VILA_ELEVADA
	var spawn_z: float = handoff_anchor.y - 64.0
	player.velocity = Vector3.ZERO
	player.global_position = Vector3(handoff_anchor.x, _terrain_height_for_qa(handoff_anchor.x, spawn_z) + 1.25, spawn_z)
	# Em primeira pessoa, W segue o eixo local -Z; PI orienta o corredor no sentido de Z crescente.
	player.rotation.y = PI
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	print("[ORIGEM_QA_ROUTE] Spawn handoff Vila Elevada ativo em %s" % player.global_position)

func _terrain_height_for_qa(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _enforce_voss_opening_daylight() -> void:
	var level_environment: Node = get_parent().get_node_or_null("LevelEnvironment")
	if level_environment != null and level_environment.has_method("apply_voss_daylight"):
		level_environment.call("apply_voss_daylight")

func _process(delta: float) -> void:
	elapsed_time += delta
	for index: int in range(fireflies.size()):
		var firefly: MeshInstance3D = fireflies[index]
		firefly.position.y = 0.82 + sin(elapsed_time * 1.1 + float(index)) * 0.16
		firefly.position.x += sin(elapsed_time * 0.34 + float(index)) * 0.002

func _create_materials() -> void:
	stone_material = _make_material(Color(0.26, 0.28, 0.25), 0.88)
	dark_stone_material = _make_material(Color(0.12, 0.15, 0.13), 0.94)
	moss_material = _make_material(Color(0.09, 0.28, 0.11), 0.96)
	mountain_material = _make_material(Color.WHITE, 1.0)
	mountain_material.vertex_color_use_as_albedo = true
	snow_material = _make_material(Color(0.82, 0.90, 0.94), 0.75)

	glow_material = StandardMaterial3D.new()
	glow_material.albedo_color = Color(0.24, 0.52, 0.88)
	glow_material.emission_enabled = true
	glow_material.emission = Color(0.04, 0.16, 0.45)
	glow_material.emission_energy_multiplier = 1.2
	glow_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

func _create_terrain() -> void:
	terrain_patch = TERRAIN_PATCH_SCRIPT.new() as Node3D
	terrain_patch.name = "TerrainPatch"
	add_child(terrain_patch)

func _build_world_after_voss_prologue() -> void:
	if has_node("ValeDiurnoExploravel"):
		return
	if DAYLIGHT_VARIANT_ENABLED:
		var daylight_valley: Node3D = DAYLIGHT_VALLEY_SCRIPT.new() as Node3D
		daylight_valley.name = "ValeDiurnoExploravel"
		add_child(daylight_valley)
		var river_road: Node3D = RIVER_ROAD_JOURNEY_SCRIPT.new() as Node3D
		river_road.name = "EstradaDoRioExploravel"
		add_child(river_road)
		var forest_lake: Node3D = FOREST_LAKE_REGION_SCRIPT.new() as Node3D
		forest_lake.name = "RegiaoFlorestaLagoExploravel"
		add_child(forest_lake)
		# A prova Arco–Floresta avalia exclusivamente o corredor Dev1 (Regiões 1–6). A omissão temporária dos módulos Dev2
		# reduz o custo de arranque em llvmpipe e não altera o mundo, os activos ou os limites de produção das Regiões 7–12.
		var qa_route: String = OS.get_environment("ORIGEM_QA_ROUTE")
		if qa_route == "road_to_arch" or qa_route == "arch_to_forest" or qa_route == "majestic_to_lake" or qa_route == "forest_to_ruins" or qa_route == "ruins_arrival":
			print("[ORIGEM_QA_ROUTE] Mundo reduzido às Regiões 1–6 para a validação cartográfica.")
			return
		var highlands: Node3D = HIGHLAND_REGION_SCRIPT.new() as Node3D
		highlands.name = "RegiaoVilaMontanhaExploravel"
		add_child(highlands)
		_build_region7_transition()
		_build_region7_corridor_ecology()
		_build_cartographic_region7_handoff_vista()
		var orion_destinations: Node3D = ORION_DESTINATION_REGION_SCRIPT.new() as Node3D
		orion_destinations.name = "DestinosOrionEHubTemporal"
		add_child(orion_destinations)
		var cinematic_director: Node = REGIONAL_CINEMATIC_DIRECTOR_SCRIPT.new() as Node
		cinematic_director.name = "DiretorCinematograficoRegional"
		add_child(cinematic_director)
		# A cadeia secundária ocupa somente o horizonte; ruínas, NPCs e templos centrais da variante antiga não são carregados.
		_build_distant_mountains()
		_build_chronos_beacon()
		return

	var biome: Node3D = VALLEY_BIOME_SCRIPT.new() as Node3D
	biome.name = "BiomeDoVale"
	add_child(biome)
	_build_organic_ruin_kit()
	_build_asset_pass()
	_build_landmarks()
	_build_distant_mountains()
	_build_waterfall()
	_build_fireflies()
	_build_sanctuary_interior()

func _build_orion_mountains() -> void:
	# Manto rochoso real diante da Casa Voss: mantém o destino Orion como geometria explorável, nunca como painel de fundo.
	orion_mountains = EXPLORABLE_MOUNTAINS_SCRIPT.new() as Node3D
	orion_mountains.name = "MaciçoOrionExplorável"
	# Variante diurna: Orion recua para a cadeia remota, deixando o vale respirável e mantendo-o como destino explorável futuro.
	orion_mountains.position = Vector3(-184.0, 0.0, -188.0)
	orion_mountains.scale = Vector3(1.30, 1.30, 1.30)
	add_child(orion_mountains)

func _build_chronos_beacon() -> void:
	# Marco azul pequeno e emissivo na face de Orion: indica o futuro Cubo Áureo sem transformar a montanha em painel ou farol próximo.
	var beacon: Node3D = Node3D.new()
	beacon.name = "MarcoChronosAzulRemoto"
	beacon.position = Vector3(-181.0, 54.0, -185.0)
	add_child(beacon)
	var crystal_mesh: SphereMesh = SphereMesh.new()
	crystal_mesh.radius = 1.25
	crystal_mesh.height = 3.6
	crystal_mesh.radial_segments = 12
	var crystal_material: StandardMaterial3D = StandardMaterial3D.new()
	crystal_material.albedo_color = Color(0.06, 0.30, 0.78, 1.0)
	crystal_material.emission_enabled = true
	crystal_material.emission = Color(0.02, 0.22, 1.0, 1.0)
	crystal_material.emission_energy_multiplier = 2.4
	crystal_material.roughness = 0.22
	crystal_mesh.material = crystal_material
	var crystal: MeshInstance3D = MeshInstance3D.new()
	crystal.name = "CristalDoMarcoChronos"
	crystal.mesh = crystal_mesh
	crystal.scale = Vector3(0.64, 1.0, 0.64)
	beacon.add_child(crystal)
	var beacon_light: OmniLight3D = OmniLight3D.new()
	beacon_light.name = "BrilhoAzulChronos"
	beacon_light.light_color = Color(0.10, 0.40, 1.0, 1.0)
	beacon_light.light_energy = 2.1
	beacon_light.omni_range = 16.0
	beacon_light.shadow_enabled = false
	beacon.add_child(beacon_light)

func _build_voss_house() -> void:
	# A Casa Voss é construída imediatamente após o terreno, para que a sua estrada e a câmara de prólogo tenham solo real.
	voss_house = VOSS_HOUSE_SCRIPT.new() as Node3D
	voss_house.name = "VossHouse"
	add_child(voss_house)

func _build_organic_ruin_kit() -> void:
	var organic_kit: Node3D = ORGANIC_RUIN_KIT_SCRIPT.new() as Node3D
	organic_kit.name = "KitDeRuinasOrganicas"
	add_child(organic_kit)

func _build_asset_pass() -> void:
	var asset_pass: Node3D = ASSET_PASS_KIT_SCRIPT.new() as Node3D
	asset_pass.name = "ModelosGLB_Reais"
	add_child(asset_pass)

func _build_sanctuary_interior() -> void:
	var interior: Node3D = SANCTUARY_INTERIOR_SCRIPT.new() as Node3D
	interior.name = "InteriorDoSantuario"
	add_child(interior)

func _build_landmarks() -> void:
	var landmarks: Node3D = Node3D.new()
	landmarks.name = "MarcosDoVale"
	add_child(landmarks)

	_build_starting_ruins(landmarks)
	_build_stone_path(landmarks)
	_build_tide_arch(landmarks)
	_build_spring_sanctuary(landmarks)
	_build_lakeside_observatory(landmarks)

func _build_starting_ruins(parent: Node3D) -> void:
	var ruins: Node3D = Node3D.new()
	ruins.name = "RuinasDoDespertar"
	parent.add_child(ruins)

	# Substituição de bases quadradas por plataformas de pedra natural e pilares esbeltos erosionados
	for position_value: Vector3 in [Vector3(-7.0, 0.0, 8.0), Vector3(7.0, 0.0, 8.0), Vector3(-7.0, 0.0, 0.0), Vector3(7.0, 0.0, 0.0)]:
		_add_organic_pillar(ruins, position_value, 6.2, stone_material)

	_add_box(ruins, Vector3(-4.5, 0.6, 2.0), Vector3(1.4, 1.2, 1.4), dark_stone_material, "AltarDeOrion")
	_add_light(ruins, Vector3(-4.5, 2.8, 2.0), Color(0.18, 0.52, 0.95), 1.5, 8.0, "LuzDoAltar")

func _build_stone_path(parent: Node3D) -> void:
	var path: Node3D = Node3D.new()
	path.name = "CaminhoDoLago"
	parent.add_child(path)
	for index: int in range(20):
		var progress: float = float(index)
		var z_position: float = -5.0 - progress * 3.5
		var x_position: float = sin(progress * 0.28) * 3.5
		var y_position: float = _ground_height(x_position, z_position) + 0.05
		_add_box(path, Vector3(x_position, y_position, z_position), Vector3(2.4, 0.12, 1.8), stone_material, "Laje_%02d" % index)

func _build_tide_arch(parent: Node3D) -> void:
	var arch: Node3D = Node3D.new()
	arch.name = "ArcoDasMares"
	arch.position = Vector3(0.0, _ground_height(0.0, -32.0), -32.0)
	parent.add_child(arch)
	_add_organic_pillar(arch, Vector3(-3.0, 0.0, 0.0), 8.0, dark_stone_material)
	_add_organic_pillar(arch, Vector3(3.0, 0.0, 0.0), 8.0, dark_stone_material)
	_add_box(arch, Vector3(0.0, 7.5, 0.0), Vector3(6.8, 0.8, 1.4), stone_material, "LintelDoArco")
	_add_light(arch, Vector3(0.0, 5.0, 0.0), Color(0.22, 0.78, 0.42), 1.0, 10.0, "LuzDoArco")

func _build_spring_sanctuary(parent: Node3D) -> void:
	var sanctuary: Node3D = SANCTUARY_SLICE_SCRIPT.new() as Node3D
	sanctuary.name = "SantuarioDaNascente"
	sanctuary.position = Vector3(-25.0, _ground_height(-25.0, -70.0), -70.0)
	parent.add_child(sanctuary)

func _build_lakeside_observatory(parent: Node3D) -> void:
	var observatory: Node3D = Node3D.new()
	observatory.name = "ObservatorioAfogado"
	observatory.position = Vector3(40.0, _ground_height(40.0, -72.0), -72.0)
	parent.add_child(observatory)
	for point: Vector3 in [Vector3(-3.0, 0.0, -2.5), Vector3(3.0, 0.0, -2.5), Vector3(-3.0, 0.0, 2.5), Vector3(3.0, 0.0, 2.5)]:
		_add_organic_pillar(observatory, point, 5.5, stone_material)
	_add_light(observatory, Vector3(0.0, 4.0, 0.0), Color(0.18, 0.52, 0.95), 1.2, 12.0, "LuzDoObservatorio")

func _build_distant_mountains() -> void:
	var mountains: Node3D = Node3D.new()
	mountains.name = "MontanhasReais"
	add_child(mountains)
	var mountain_data: Array[Dictionary] = [
		{"position": Vector3(-90.0, 0.0, -140.0), "radius": 32.0, "height": 48.0},
		{"position": Vector3(-45.0, 0.0, -165.0), "radius": 28.0, "height": 68.0},
		{"position": Vector3(0.0, 0.0, -180.0), "radius": 40.0, "height": 90.0},
		{"position": Vector3(50.0, 0.0, -170.0), "radius": 32.0, "height": 70.0},
		{"position": Vector3(95.0, 0.0, -145.0), "radius": 35.0, "height": 55.0}
	]
	for mountain: Dictionary in mountain_data:
		_add_mountain(mountains, mountain["position"] as Vector3, mountain["radius"] as float, mountain["height"] as float)

func _build_waterfall() -> void:
	var waterfall: Node3D = Node3D.new()
	waterfall.name = "QuedaDaMemoria"
	waterfall.position = Vector3(18.0, 20.0, -120.0)
	add_child(waterfall)

	var water_sheet_mesh: QuadMesh = QuadMesh.new()
	water_sheet_mesh.size = Vector2(6.0, 26.0)
	var water_material: StandardMaterial3D = StandardMaterial3D.new()
	water_material.albedo_color = Color(0.50, 0.85, 0.95, 0.78)
	water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	water_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	water_sheet_mesh.material = water_material
	var water_sheet: MeshInstance3D = MeshInstance3D.new()
	water_sheet.name = "CortinaDeAgua"
	water_sheet.mesh = water_sheet_mesh
	waterfall.add_child(water_sheet)
	_add_light(waterfall, Vector3(0.0, 0.0, 2.0), Color(0.20, 0.60, 0.98), 1.0, 12.0, "ReflexoDaQueda")

func _build_fireflies() -> void:
	var lights: Node3D = Node3D.new()
	lights.name = "LuzesDoVale"
	add_child(lights)
	for index: int in range(12):
		var sphere_mesh: SphereMesh = SphereMesh.new()
		sphere_mesh.radius = 0.06
		sphere_mesh.height = 0.12
		sphere_mesh.material = glow_material
		var firefly: MeshInstance3D = MeshInstance3D.new()
		firefly.name = "Luz_%02d" % index
		firefly.mesh = sphere_mesh
		firefly.position = Vector3(-10.0 + float(index % 5) * 4.0, 0.75 + float(index % 3) * 0.25, -15.0 - float(index / 5) * 10.0)
		lights.add_child(firefly)
		fireflies.append(firefly)

func _add_mountain(parent: Node3D, position_value: Vector3, radius: float, height: float) -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = int(abs(position_value.x) * 29.0 + abs(position_value.z) * 13.0)
	var radial_segments: int = 10
	var ring_count: int = 5
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)

	for ring: int in range(ring_count):
		var next_ring: int = ring + 1
		var t0: float = float(ring) / float(ring_count)
		var t1: float = float(next_ring) / float(ring_count)
		for segment: int in range(radial_segments):
			var next_segment: int = (segment + 1) % radial_segments
			var p00: Vector3 = _mountain_point(position_value, radius, height, t0, segment, radial_segments)
			var p10: Vector3 = _mountain_point(position_value, radius, height, t0, next_segment, radial_segments)
			var p01: Vector3 = _mountain_point(position_value, radius, height, t1, segment, radial_segments)
			var p11: Vector3 = _mountain_point(position_value, radius, height, t1, next_segment, radial_segments)
			var color0: Color = _mountain_color(t0)
			var color1: Color = _mountain_color(t1)
			_add_mountain_triangle(surface, p00, p01, p10, color0, color1, color0)
			_add_mountain_triangle(surface, p10, p01, p11, color0, color1, color1)

	surface.generate_normals()
	var mountain_mesh: ArrayMesh = surface.commit()
	mountain_mesh.surface_set_material(0, mountain_material)
	var mountain: MeshInstance3D = MeshInstance3D.new()
	mountain.name = "CristaDoVale"
	mountain.mesh = mountain_mesh
	mountain.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	parent.add_child(mountain)

func _mountain_point(origin: Vector3, radius: float, height: float, t: float, segment: int, segments: int) -> Vector3:
	var angle: float = TAU * float(segment) / float(segments)
	var ridge_variation: float = 0.85 + sin(angle * 3.0 + float(segment) * 0.5) * 0.1
	var ring_radius: float = radius * (1.0 - t * 0.8) * ridge_variation
	return origin + Vector3(cos(angle) * ring_radius, t * height, sin(angle) * ring_radius * 0.7)

func _mountain_color(height_ratio: float) -> Color:
	# Paleta de cadeia remota: vegetação fria na base, rocha azulada no meio e neve apenas nas cristas.
	if height_ratio > 0.78:
		return Color(0.78, 0.86, 0.90)
	if height_ratio > 0.56:
		return Color(0.31, 0.40, 0.43)
	if height_ratio > 0.30:
		return Color(0.17, 0.32, 0.20)
	return Color(0.10, 0.23, 0.13)

func _add_mountain_triangle(surface: SurfaceTool, first: Vector3, second: Vector3, third: Vector3, first_color: Color, second_color: Color, third_color: Color) -> void:
	surface.set_color(first_color)
	surface.add_vertex(first)
	surface.set_color(second_color)
	surface.add_vertex(second)
	surface.set_color(third_color)
	surface.add_vertex(third)

func _add_organic_pillar(parent: Node3D, position_value: Vector3, height: float, material: StandardMaterial3D) -> void:
	var shaft_mesh: CylinderMesh = CylinderMesh.new()
	shaft_mesh.top_radius = 0.32
	shaft_mesh.bottom_radius = 0.48
	shaft_mesh.height = height
	shaft_mesh.radial_segments = 16
	shaft_mesh.material = material
	var shaft: MeshInstance3D = MeshInstance3D.new()
	shaft.name = "ColunaOrganica"
	shaft.mesh = shaft_mesh
	shaft.position = position_value + Vector3(0.0, height * 0.5, 0.0)
	parent.add_child(shaft)

func _add_light(parent: Node3D, position_value: Vector3, color: Color, energy: float, light_range: float, node_name: String) -> void:
	var light: OmniLight3D = OmniLight3D.new()
	light.name = node_name
	light.position = position_value
	light.light_color = color
	light.light_energy = energy
	light.omni_range = light_range
	light.shadow_enabled = false
	parent.add_child(light)

func _add_box(parent: Node3D, position_value: Vector3, size_value: Vector3, material: StandardMaterial3D, node_name: String) -> void:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.name = node_name
	var box_mesh: BoxMesh = BoxMesh.new()
	box_mesh.size = size_value
	box_mesh.material = material
	mesh_instance.mesh = box_mesh
	mesh_instance.position = position_value
	parent.add_child(mesh_instance)

func _apply_material(root: Node, material: Material) -> void:
	if root is MeshInstance3D:
		(root as MeshInstance3D).material_override = material
	for child: Node in root.get_children():
		_apply_material(child, material)

func _ground_height(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _build_region7_transition() -> void:
	# CP 201: Ponte de integração física Região 6 → Região 7 (Vila Elevada).
	# Liga a margem norte das Ruínas Submersas (z≈282) à entrada da Vila Elevada (z≈352).
	# Este nó é o ponto de handoff entre a branch dev1 e a branch dev2.
	# O Dev2 deve posicionar o spawn da Região 7 em Vector3(140, y, 352).
	var gate_root: Node3D = Node3D.new()
	gate_root.name = "Region7TransitionGate"
	add_child(gate_root)
	
	var stone_mat: StandardMaterial3D = StandardMaterial3D.new()
	stone_mat.albedo_color = Color(0.18, 0.155, 0.105, 1.0)
	stone_mat.roughness = 0.92
	# Material dedicado às pedras de base: preserva o contraste de musgo sem depender de variável externa.
	var moss_mat: StandardMaterial3D = StandardMaterial3D.new()
	moss_mat.albedo_color = Color(0.095, 0.145, 0.070, 1.0)
	moss_mat.roughness = 0.94
	
	# Trilho de acesso no lado Dev1: termina antes do handoff oficial e é derivado da âncora da Vila Elevada.
	var handoff_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.VILA_ELEVADA
	var trail_start_z: float = handoff_anchor.y - 67.0
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 72801
	for step: int in range(12):
		var sz: float = trail_start_z + float(step) * 5.0
		var sx: float = handoff_anchor.x + rng.randf_range(-1.2, 1.2)
		var sy: float = _terrain_height_for_qa(sx, sz) + 0.04
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeTrilhoR7_%02d" % step
		var box: BoxMesh = BoxMesh.new()
		box.size = Vector3(
			rng.randf_range(1.8, 2.4),
			0.18,
			rng.randf_range(1.4, 1.9)
		)
		slab.mesh = box
		slab.material_override = stone_mat
		slab.position = Vector3(sx, sy, sz)
		slab.rotation.y = rng.randf_range(-0.12, 0.12)
		var slab_body: StaticBody3D = StaticBody3D.new()
		var slab_shape: CollisionShape3D = CollisionShape3D.new()
		slab_shape.shape = BoxShape3D.new()
		(slab_shape.shape as BoxShape3D).size = box.size
		slab_body.add_child(slab_shape)
		slab.add_child(slab_body)
		gate_root.add_child(slab)
	
	# Portão de transição: dois pilares e uma verga em z=348
	var gate_x: float = CARTOGRAPHIC_ANCHORS.VILA_ELEVADA.x
	var gate_z: float = CARTOGRAPHIC_ANCHORS.VILA_ELEVADA.y - 4.0
	var gate_y: float = _terrain_height_for_qa(gate_x, gate_z)
	for pillar_side: int in range(2):
		var px: float = gate_x + (float(pillar_side) * 2.0 - 1.0) * 3.2
		# Coluna de ruína real: substitui a leitura de bloco regular por uma silhueta arqueológica já usada no vale.
		var pillar: Node3D = CARTOGRAPHIC_HANDOFF_PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarPortaoR7_%d" % pillar_side
		pillar.position = Vector3(px, gate_y, gate_z)
		pillar.scale = Vector3(1.08, 2.10 + float(pillar_side) * 0.12, 1.08)
		pillar.rotation = Vector3(0.025 * float(pillar_side), 0.10 * (float(pillar_side) * 2.0 - 1.0), -0.035 * (float(pillar_side) * 2.0 - 1.0))
		_apply_material(pillar, stone_mat)
		gate_root.add_child(pillar)
		# Colisor simples mantém a abertura central livre e não depende da malha detalhada do activo.
		var pb: StaticBody3D = StaticBody3D.new()
		pb.name = "ColisorPilarPortaoR7_%d" % pillar_side
		pb.position = Vector3(px, gate_y + 2.4, gate_z)
		var ps: CollisionShape3D = CollisionShape3D.new()
		var pillar_shape: BoxShape3D = BoxShape3D.new()
		pillar_shape.size = Vector3(0.92, 4.80, 0.92)
		ps.shape = pillar_shape
		pb.add_child(ps)
		gate_root.add_child(pb)
	# Bases e verga usam o kit de ruína real; os colisores dos pilares mantêm a abertura central jogável.
	for base_side: int in range(2):
		var bx: float = gate_x + (float(base_side) * 2.0 - 1.0) * 3.2
		var base_rock: Node3D = CARTOGRAPHIC_HANDOFF_PILLAR.instantiate() as Node3D
		if base_rock == null:
			continue
		base_rock.name = "PedraBasePilar_%d" % base_side
		base_rock.scale = Vector3(0.54 + float(base_side) * 0.03, 0.16, 0.50)
		base_rock.position = Vector3(bx, gate_y + 0.12, gate_z + (float(base_side) * 2.0 - 1.0) * 0.20)
		base_rock.rotation = Vector3(0.04, float(base_side) * 0.12 - 0.06, 0.05 * (float(base_side) * 2.0 - 1.0))
		_apply_material(base_rock, moss_mat)
		gate_root.add_child(base_rock)
	# Verga fragmentada: três pedras orgânicas quebram a silhueta perfeita sem fechar o vão do portão.
	for lintel_index: int in range(3):
		var lintel: Node3D = CARTOGRAPHIC_HANDOFF_PILLAR.instantiate() as Node3D
		if lintel == null:
			continue
		lintel.name = "FragmentoVergaPortaoR7_%d" % lintel_index
		lintel.scale = Vector3(0.62 + float(lintel_index % 2) * 0.05, 0.25, 0.34)
		lintel.position = Vector3(gate_x + (float(lintel_index) - 1.0) * 2.32, gate_y + 4.84 + float(lintel_index % 2) * 0.10, gate_z + 0.03 * float(lintel_index - 1))
		lintel.rotation = Vector3(0.08 * float(lintel_index - 1), 0.05 * float(lintel_index - 1), PI * 0.5 + 0.06 * float(lintel_index - 1))
		_apply_material(lintel, stone_mat)
		gate_root.add_child(lintel)
	
	# Marcador de spawn para o Dev2 (invisível em runtime, visível no editor)
	var spawn_marker: Node3D = Node3D.new()
	spawn_marker.name = "SpawnRegiao7_Dev2_HandoffPoint"
	spawn_marker.position = CARTOGRAPHIC_ANCHORS.world_position(CARTOGRAPHIC_ANCHORS.VILA_ELEVADA, _terrain_height_for_qa(CARTOGRAPHIC_ANCHORS.VILA_ELEVADA.x, CARTOGRAPHIC_ANCHORS.VILA_ELEVADA.y), 1.5)
	gate_root.add_child(spawn_marker)
	
	# Luz de sinalização no portão (discreta, cor âmbar)
	var gate_light: OmniLight3D = OmniLight3D.new()
	gate_light.name = "LuzPortaoR7"
	gate_light.position = Vector3(gate_x, gate_y + 5.5, gate_z)
	gate_light.light_color = Color(0.85, 0.68, 0.32, 1.0)
	gate_light.light_energy = 0.65
	gate_light.omni_range = 12.0
	gate_light.shadow_enabled = false
	gate_root.add_child(gate_light)


func _build_region7_corridor_ecology() -> void:
	# CP 202: Ecologia lateral do corredor de acesso à Região 7 (z=285-345, x≈140).
	# Pedras e fetos nas margens do trilho para que a transição não pareça um corredor vazio.
	var eco_root: Node3D = Node3D.new()
	eco_root.name = "Region7CorridorEcology"
	add_child(eco_root)
	
	var rock_mat: StandardMaterial3D = StandardMaterial3D.new()
	rock_mat.albedo_color = Color(0.20, 0.17, 0.11, 1.0)
	rock_mat.roughness = 0.92
	
	var fern_mat: StandardMaterial3D = StandardMaterial3D.new()
	fern_mat.albedo_color = Color(0.12, 0.22, 0.09, 1.0)
	fern_mat.roughness = 0.75
	
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = 72802
	
	# 8 grupos de pedras alternados esquerda/direita ao longo do corredor
	var rock_positions: Array = [
		[135.5, 290.0, -1], [144.8, 295.0, 1],
		[134.8, 302.0, -1], [145.5, 308.0, 1],
		[135.2, 316.0, -1], [144.6, 322.0, 1],
		[135.8, 330.0, -1], [144.2, 338.0, 1]
	]
	for rp: Array in rock_positions:
		var rx: float = float(rp[0]) + rng.randf_range(-0.4, 0.4)
		var rz: float = float(rp[1]) + rng.randf_range(-0.6, 0.6)
		var ry: float = _terrain_height_for_qa(rx, rz) + 0.05
		var rock: MeshInstance3D = MeshInstance3D.new()
		rock.name = "RochaCorredorR7_%d" % rock_positions.find(rp)
		var rock_mesh: BoxMesh = BoxMesh.new()
		rock_mesh.size = Vector3(
			rng.randf_range(0.55, 1.1),
			rng.randf_range(0.35, 0.75),
			rng.randf_range(0.55, 1.0)
		)
		rock.mesh = rock_mesh
		rock.material_override = rock_mat
		rock.position = Vector3(rx, ry + rock_mesh.size.y * 0.5, rz)
		rock.rotation.y = rng.randf_range(0.0, TAU)
		eco_root.add_child(rock)
	
	# 6 fetos nas margens do corredor
	var fern_positions: Array = [
		[136.2, 293.0], [143.8, 299.0],
		[135.6, 311.0], [144.4, 318.0],
		[136.0, 326.0], [143.6, 334.0]
	]
	for fp: Array in fern_positions:
		var fx: float = float(fp[0]) + rng.randf_range(-0.3, 0.3)
		var fz: float = float(fp[1]) + rng.randf_range(-0.5, 0.5)
		var fy: float = _terrain_height_for_qa(fx, fz)
		var fern: MeshInstance3D = MeshInstance3D.new()
		fern.name = "FetoCorredorR7_%d" % fern_positions.find(fp)
		var fern_mesh: BoxMesh = BoxMesh.new()
		var fern_scale: float = rng.randf_range(0.55, 0.80)
		fern_mesh.size = Vector3(fern_scale * 1.4, fern_scale * 0.9, fern_scale * 1.4)
		fern.mesh = fern_mesh
		fern.material_override = fern_mat
		fern.position = Vector3(fx, fy + fern_mesh.size.y * 0.5, fz)
		fern.rotation.y = rng.randf_range(0.0, TAU)
		eco_root.add_child(fern)


func _build_cartographic_region7_handoff_vista() -> void:
	# CP 221 — Última vista da Região 6: o lago fica atrás e a subida para a Vila Elevada torna-se legível à frente.
	# Os vestígios ficam antes do handoff técnico (z<285), sem criar geometria, colisores ou luzes dentro da Região 7.
	var vista_root: Node3D = Node3D.new()
	vista_root.name = "VistaCartograficaLagoParaVila"
	add_child(vista_root)
	var marker_specs: Array[Dictionary] = [
		{"x": 132.0, "z": 276.0, "scale": 0.38, "yaw": -0.46},
		{"x": 148.0, "z": 281.0, "scale": 0.46, "yaw": 0.32},
	]
	for marker_index: int in range(marker_specs.size()):
		var spec: Dictionary = marker_specs[marker_index]
		var x_value: float = float(spec["x"])
		var z_value: float = float(spec["z"])
		var marker: Node3D = CARTOGRAPHIC_HANDOFF_PILLAR.instantiate() as Node3D
		if marker == null:
			continue
		marker.name = "EstelaDaSubida_%02d" % marker_index
		marker.position = Vector3(x_value, _terrain_height_for_qa(x_value, z_value), z_value)
		var scale_value: float = float(spec["scale"])
		marker.scale = Vector3(scale_value, scale_value * (1.08 + float(marker_index) * 0.10), scale_value)
		marker.rotation = Vector3(0.05 * float(marker_index), float(spec["yaw"]), 0.04 * (1.0 if marker_index == 0 else -1.0))
		vista_root.add_child(marker)
		var base_mesh: BoxMesh = BoxMesh.new()
		base_mesh.size = Vector3(1.15 + float(marker_index) * 0.18, 0.28, 1.05)
		base_mesh.material = moss_material
		var base: MeshInstance3D = MeshInstance3D.new()
		base.name = "BaseDaEstelaDaSubida_%02d" % marker_index
		base.mesh = base_mesh
		base.position = marker.position + Vector3(0.0, 0.14, 0.0)
		base.rotation.y = marker.rotation.y
		vista_root.add_child(base)
	# Dois vestígios laterais confirmam a subida no horizonte da Bacia, deixando o eixo x=140 inteiramente livre.
	# Permanecem em z<285: são orientação Dev1, não geometria da Vila Elevada.
	for side: float in [-1.0, 1.0]:
		var edge_x: float = CARTOGRAPHIC_ANCHORS.VILA_ELEVADA.x + side * 6.2
		var edge_z: float = 272.0 + side * 1.4
		var edge: Node3D = CARTOGRAPHIC_HANDOFF_PILLAR.instantiate() as Node3D
		if edge == null:
			continue
		edge.name = "VestigioLateralDaVistaVila_%s" % ("Oeste" if side < 0.0 else "Este")
		edge.position = Vector3(edge_x, _terrain_height_for_qa(edge_x, edge_z) + 0.05, edge_z)
		edge.scale = Vector3(0.34, 0.62 + 0.06 * side, 0.34)
		edge.rotation = Vector3(0.06 * side, side * 0.30, -0.04 * side)
		_apply_material(edge, moss_material)
		vista_root.add_child(edge)

func _make_material(color: Color, roughness_value: float) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness_value
	return material
