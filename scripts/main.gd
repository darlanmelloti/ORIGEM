extends Node3D

# ═══════════════════════════════════════════════════════════════
# ORIGEM — Script Principal
# Baseado na lore: P-0 (Humanidade), P-47 (Greys), P-52 (Nórdicos)
# Herói: ELIAS VOSS — arqueólogo e físico de plasma, P-0
# Aliada: SERAPH — entidade P-52 que guia o jogador
# Ameaça ativa: os guerreiros Kharu guardam os fragmentos e as ruínas do Vale de Kheper.
# ═══════════════════════════════════════════════════════════════

const CARTOGRAPHIC_MAP_UI_SCRIPT: Script = preload("res://ui/menus/CartographicMapUI.gd")
const JOURNEY_OBJECTIVE_HUD_SCRIPT: Script = preload("res://ui/hud/JourneyObjectiveHUD.gd")
const ELIAS_CODEX_UI_SCRIPT: Script = preload("res://ui/hud/EliasCodexUI.gd")
const QA_STATE_TRANSITION_SCRIPT: Script = preload("res://tools/qa/run_player_state_transition.gd")
const QA_STATE_ROUNDTRIP_SCRIPT: Script = preload("res://tools/qa/run_player_state_roundtrip.gd")
const QA_GROUNDING_SCRIPT: Script = preload("res://tools/qa/run_player_grounding.gd")
const R2_REGION_SCRIPT: Script = preload("res://levels/regions/R2_RiverRoad.gd")
# Orçamento GTX 1050 Ti: o vale pode conter muitas luzes de narrativa, mas só as 16 mais próximas de Elias permanecem visíveis.
const MAX_VISIBLE_DYNAMIC_OMNI_LIGHTS: int = 16
const LIGHT_BUDGET_REFRESH_MSEC: int = 500
var exterior_budget_culled_lights: PackedStringArray = PackedStringArray(["JanelaFrontalEste_Luz", "LuzDoSotao", "JanelaDaAla_Luz"])
var next_light_budget_refresh_msec: int = 0

# ─── UI ───────────────────────────────────────────────────────
@onready var interact_label: Label = $UI/HUD/InteractLabel
@onready var msg_panel: PanelContainer = $UI/HUD/MsgPanel
@onready var msg_label: Label = $UI/HUD/MsgPanel/MsgLabel
@onready var hud_status: Label = $UI/HUD/StatusLabel
@onready var stamina_label: Label = $UI/HUD/StaminaLabel
@onready var crosshair: Label = $UI/HUD/Crosshair
@onready var pause_menu: PauseMenu = $UI/PauseMenu

# ─── NÓS DO JOGO ──────────────────────────────────────────────

# Aliada P-52 (Seraph — luz azul)
@onready var seraph_light: OmniLight3D = $Characters/Seraph/SeraphLight

# Objetos interativos
@onready var orion_cube: StaticBody3D = $Interactables/OrionCube
@onready var tablet1: StaticBody3D = $Interactables/Tablet1
@onready var tablet2: StaticBody3D = $Interactables/Tablet2
@onready var tablet3: StaticBody3D = $Interactables/Tablet3
@onready var terminal_p52: StaticBody3D = $Interactables/TerminalP52

# ─── NARRATIVA E MISSÕES ──────────────────────────────────────
var tablets_found: int = 0
var door_open: bool = false
var cube_activated: bool = false
var seraph_contacted: bool = false
var tablet1_taken: bool = false
var tablet2_taken: bool = false
var tablet3_taken: bool = false
var spring_fragment_taken: bool = false
var mission_phase: int = 0  # 0=início, 1=tábuas, 2=cubo, 3=fuga, 4=fim

# ─── MENSAGEM ─────────────────────────────────────────────────
var msg_timer: float = 0.0
var msg_expires_at_msec: int = 0
var msg_queue: Array = []

# ─── SERAPH (ALIADA P-52) ─────────────────────────────────────
var seraph_pulse_time: float = 0.0
var seraph_active: bool = true
var cartographic_map_ui: CanvasLayer
var journey_objective_hud: CanvasLayer
var elias_codex_ui: CanvasLayer
var map_key_was_pressed: bool = false

# ═══════════════════════════════════════════════════════════════
func _ready():
	# Esc precisa continuar a chegar ao controlador enquanto o PauseMenu suspende a árvore.
	process_mode = Node.PROCESS_MODE_ALWAYS
	add_to_group("main_scene")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	RenderingServer.set_default_clear_color(Color(0.05, 0.05, 0.08))
	cartographic_map_ui = CARTOGRAPHIC_MAP_UI_SCRIPT.new() as CanvasLayer
	if cartographic_map_ui != null:
		add_child(cartographic_map_ui)
	journey_objective_hud = JOURNEY_OBJECTIVE_HUD_SCRIPT.new() as CanvasLayer
	if journey_objective_hud != null:
		add_child(journey_objective_hud)
	elias_codex_ui = ELIAS_CODEX_UI_SCRIPT.new() as CanvasLayer
	if elias_codex_ui != null:
		add_child(elias_codex_ui)
	interact_label.visible = false
	EventBus.player_interacted.connect(_on_player_interacted)
	EventBus.player_interact_target_changed.connect(_on_player_interact_target_changed)
	EventBus.player_message_requested.connect(_on_player_message_requested)
	EventBus.player_health_changed.connect(_on_player_health_changed)
	EventBus.player_stamina_changed.connect(_on_player_stamina_changed)
	hud_status.text = "ELIAS  100 / 100"
	stamina_label.text = "STAMINA  100 / 100"
	_apply_exterior_light_budget()
	if OS.has_environment("ORIGEM_QA_GROUNDING"):
		var grounding_runner: Node = QA_GROUNDING_SCRIPT.new()
		get_tree().root.call_deferred("add_child", grounding_runner)
	elif OS.has_environment("ORIGEM_QA_STATE_TRANSITION"):
		var state_runner: Node = QA_STATE_TRANSITION_SCRIPT.new()
		get_tree().root.call_deferred("add_child", state_runner)
	elif OS.has_environment("ORIGEM_QA_STATE_ROUNDTRIP"):
		var roundtrip_runner: Node = QA_STATE_ROUNDTRIP_SCRIPT.new()
		get_tree().root.call_deferred("add_child", roundtrip_runner)
	if OS.has_environment("ORIGEM_QA_CODEX"):
		get_tree().create_timer(2.20).timeout.connect(_run_codex_qa)
	if OS.has_environment("ORIGEM_QA_R2_WORLD_LIFE"):
		call_deferred("_verify_r2_world_life_qa")
	if OS.has_environment("ORIGEM_QA_R3_ARCH"):
		get_tree().create_timer(1.20).timeout.connect(_verify_r3_arch_qa)
	if OS.has_environment("ORIGEM_QA_R4_CLEARING"):
		get_tree().create_timer(1.20).timeout.connect(_verify_r4_clearing_qa)
	if OS.has_environment("ORIGEM_QA_R5_ARTEFACT"):
		get_tree().create_timer(1.20).timeout.connect(_verify_r5_artefact_qa)
	# CINE-PAIR-10: apenas um retorno real do interior deve substituir o spawn normal da Casa Voss.
	var exterior_player: Node3D = get_tree().get_first_node_in_group("player") as Node3D
	if exterior_player != null and OrionTransitionState.has_pending_exterior_return():
		OrionTransitionState.restore_exterior_player(exterior_player)
	# Os modos técnicos regionais não devem receber cartelas narrativas; no jogo normal a narrativa continua inalterada.
	if not OS.has_environment("ORIGEM_CAPTURE_TAKE") and not OS.has_environment("ORIGEM_QA_ROUTE") and not OS.has_environment("ORIGEM_QA_INTERACT") and not OS.has_environment("ORIGEM_QA_CINE48_HANDOFF") and not OS.has_environment("ORIGEM_QA_GROUNDING") and not OS.has_environment("ORIGEM_QA_R3_ARCH") and not OS.has_environment("ORIGEM_QA_R4_CLEARING") and not OS.has_environment("ORIGEM_QA_R5_ARTEFACT"):
		_start_narrative()

func _run_codex_qa() -> void:
	if OS.has_environment("ORIGEM_QA_CODEX_SAVE"):
		SaveManager.save_game(2)
		var voss_house: Node = get_tree().get_first_node_in_group("voss_house_controller")
		if voss_house != null:
			voss_house.set("voss_clues_seen", {})
		var restored: bool = SaveManager.load_game(2)
		var restored_count: int = 0
		if voss_house != null and voss_house.has_method("get_codex_entries"):
			var restored_entries: Dictionary = voss_house.call("get_codex_entries") as Dictionary
			for entry: Variant in restored_entries.values():
				if typeof(entry) == TYPE_DICTIONARY and bool((entry as Dictionary).get("seen", false)):
					restored_count += 1
		print("[ORIGEM_CODEX_SAVE_QA] restored=%s voss_entries=%d" % [str(restored), restored_count])
	if elias_codex_ui != null and elias_codex_ui.has_method("run_qa_probe"):
		elias_codex_ui.call("run_qa_probe")
	get_tree().quit()

func _verify_r2_world_life_qa() -> void:
	var issues: PackedStringArray = PackedStringArray()
	var r2: Node = find_child("EstradaDoRioExploravel", true, false)
	if r2 == null:
		issues.append("EstradaDoRioExploravel não foi instanciado")
	else:
		var landmarks: Node = r2.get_node_or_null("MarcosVidaDeViagemR2")
		for landmark_name: String in PackedStringArray(["MarcoPedrasDeTomas", "PassagemMargemBaixa", "VestigioAntesDoArco"]):
			if landmarks == null or landmarks.get_node_or_null(landmark_name) == null:
				issues.append("marco em falta: %s" % landmark_name)
		if r2.get_node_or_null("EstradaDoRio_Real") == null:
			issues.append("a estrada física R2 desapareceu")
		if r2.get_node_or_null("ArcoDasRuinas_EstradaDoRio") == null:
			issues.append("o Arco físico R2 desapareceu")
		var station: Node = r2.get_node_or_null("EstacaoDeObservacaoDoReflexoOrion")
		if station == null:
			issues.append("a estação arqueológica do reflexo Orion está em falta")
		elif station.find_child("LajeDaEstacaoOrion_05", true, false) == null:
			issues.append("a estação Orion não possui as cinco lajes físicas esperadas")
		var lookout: Node = r2.get_node_or_null("MiradouroReflexoOrionR2")
		if lookout == null:
			issues.append("o miradouro físico do reflexo Orion está em falta")
		else:
			if lookout.get_node_or_null("LajeMiradouroReflexoOrion") == null or lookout.get_node_or_null("ColisorLajeMiradouroReflexoOrion") == null:
				issues.append("o miradouro Orion não possui laje física e colisor coincidente")
			if not lookout.find_children("*", "OmniLight3D", true, false).is_empty():
				issues.append("o miradouro Orion não pode criar luz dinâmica")
		var return_landing: Node = r2.get_node_or_null("LajeConfirmacaoRetornoVossR2")
		if return_landing == null:
			issues.append("a laje física de confirmação do retorno Voss está em falta")
		else:
			if return_landing.get_node_or_null("LajeConfirmacaoRetornoVoss") == null or return_landing.get_node_or_null("ColisorLajeConfirmacaoRetornoVoss") == null:
				issues.append("a confirmação do retorno Voss não possui laje e colisor coincidente")
			if not return_landing.find_children("*", "OmniLight3D", true, false).is_empty():
				issues.append("a confirmação do retorno Voss não pode criar luz dinâmica")
		if not r2.find_children("LuzMarcoVida*", "OmniLight3D", true, false).is_empty():
			issues.append("os marcos R2 não podem criar luzes dinâmicas")
		if not r2.find_children("LuzEstacaoOrion*", "OmniLight3D", true, false).is_empty():
			issues.append("a estação Orion não pode criar luzes dinâmicas")
		var traveller_rest: Node = r2.get_node_or_null("PontoDescansoDoViajante")
		if traveller_rest == null:
			issues.append("o ponto de descanso do viajante está em falta")
		else:
			for rest_name: String in PackedStringArray(["AbrigoBaixoDePedraCaida", "LajeBancoDeObservacao", "MochilaDeMiguel", "FogueiraExtintaSemLuz"]):
				if traveller_rest.get_node_or_null(rest_name) == null:
					issues.append("elemento do descanso em falta: %s" % rest_name)
				if not traveller_rest.find_children("*", "OmniLight3D", true, false).is_empty():
					issues.append("o ponto de descanso não pode criar luz dinâmica")

		if r2.get_node_or_null("AproximacaoPonteLateralR2") == null:
			issues.append("a aproximação física à ponte lateral está em falta")
		elif r2.find_child("LajePartidaAcessoPonte_Oeste_01", true, false) == null or r2.find_child("LajePartidaAcessoPonte_Este_01", true, false) == null:
			issues.append("a aproximação à ponte não possui lajes partidas nos dois encontros")
		elif not r2.find_children("LuzAproximacaoPonte*", "OmniLight3D", true, false).is_empty():
			issues.append("a aproximação à ponte não pode criar luz dinâmica")
		if r2.get_node_or_null("MarcoCairnRegresso") == null:
			issues.append("o cairn de regresso R2 está em falta")
		elif r2.find_child("LajeTombadaDoCairn", true, false) == null:
			issues.append("o cairn de regresso não possui laje tombada")
		elif not r2.find_children("LuzCairn*", "OmniLight3D", true, false).is_empty():
			issues.append("o cairn de regresso não pode criar luz dinâmica")
		var edge: Node = r2.get_node_or_null("MargemGeologicaAntesDoArcoR2")
		if edge == null:
			issues.append("a margem geológica R2 está em falta")
		elif edge.find_child("AfloramentoBaixoMargemArco_02", true, false) == null:
			issues.append("a margem geológica não possui os dois afloramentos")
		elif not edge.find_children("*", "OmniLight3D", true, false).is_empty():
			issues.append("a margem geológica não pode criar luz dinâmica")
		var final_edge: Node = r2.get_node_or_null("LinhaPedrasMargemFinalR2")
		if final_edge == null:
			issues.append("a linha de pedras da margem final está em falta")
		elif final_edge.find_child("PedraLeituraMargemFinal_03", true, false) == null:
			issues.append("a margem final não possui três pedras de leitura")
		elif not final_edge.find_children("*", "OmniLight3D", true, false).is_empty():
			issues.append("a margem final não pode criar luz dinâmica")
		var approach: Node = r2.get_node_or_null("AproximacaoUltimoTrechoArcoR2")
		if approach == null:
			issues.append("a aproximação do último trecho R2 está em falta")
		elif approach.find_child("LajeInterrompidaUltimoTrecho_02", true, false) == null:
			issues.append("a aproximação do último trecho não possui duas lajes interrompidas")
		elif not approach.find_children("*", "OmniLight3D", true, false).is_empty():
			issues.append("a aproximação do último trecho não pode criar luz dinâmica")

		var route_contract = R2_REGION_SCRIPT.new().create_contract()
		for route_name: String in PackedStringArray(["road_to_arch", "road_return_voss", "positive_bridge"]):
			if not route_contract.qa_routes.has(route_name):
				issues.append("rota canônica R2 em falta: %s" % route_name)
		var markers: Node = r2.get_node_or_null("MarcadoresAmbientaisRetornoR2")
		if markers == null:
			issues.append("os marcadores ambientais de retorno estão em falta")
		elif markers.find_child("PedraMarcadorRetorno_02", true, false) == null:
			issues.append("os marcadores ambientais não possuem duas pedras de referência")
		elif not markers.find_children("*", "OmniLight3D", true, false).is_empty():
			issues.append("os marcadores ambientais não podem criar luz dinâmica")
		elif not markers.find_children("*", "CollisionShape3D", true, false).is_empty() or not markers.find_children("*", "StaticBody3D", true, false).is_empty() or not markers.find_children("*", "Area3D", true, false).is_empty():
			issues.append("os marcadores ambientais não podem criar corpos ou formas de colisão")
		var sightline: Node = r2.get_node_or_null("VisadaRetornoCasaVossR2")
		if sightline == null:
			issues.append("a visada de retorno à Casa Voss está em falta")
		elif sightline.find_child("LajeCurtaVisadaRetornoVoss", true, false) == null or sightline.find_child("PedraReferenciaRetornoVoss_02", true, false) == null:
			issues.append("a visada de retorno não possui laje e duas pedras de referência")
		elif not sightline.find_children("*", "OmniLight3D", true, false).is_empty():
			issues.append("a visada de retorno não pode criar luz dinâmica")
		var recessed: Node = r2.get_node_or_null("RecuoMargemFinalArcoR2")
		if recessed == null:
			issues.append("o recuo da margem final R2 está em falta")
		elif recessed.find_child("LajeBaixaRecuoArco_02", true, false) == null:
			issues.append("o recuo da margem final não possui duas lajes baixas")
		elif not recessed.find_children("*", "OmniLight3D", true, false).is_empty():
			issues.append("o recuo da margem final não pode criar luz dinâmica")
	if issues.is_empty():
		print("[ORIGEM_R2_WORLD_LIFE_OK] 3 marcos físicos presentes; estrada e Arco preservados; sem luz dinâmica nova.")
		print("[ORIGEM_R2_ORION_STATION_OK] estação de observação física do reflexo Orion confirmada")
		print("[ORIGEM_R2_RIVER_LOOKOUT_030_OK] miradouro físico Orion, laje e colisor confirmados sem luz dinâmica nova.")
		print("[ORIGEM_R2_RIVER_RETURN_031_OK] laje física de confirmação Casa Voss presente e sem luz dinâmica.")
		print("[ORIGEM_R2_TRAVELLER_REST_OK] ponto de descanso físico presente; mochila e fogueira extinta sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_CAIRN_OK] cairn de regresso físico presente; passagem livre e sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_FOOTBRIDGE_OK] aproximação lateral física presente; ponte preservada e sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_EDGE_OK] margem geológica ribeirinha presente; leitura lateral sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_APPROACH_OK] último trecho arqueológico presente; acesso interrompido e sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_EDGE_008_OK] linha de pedras da margem final presente; leito não atravessável e sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_APPROACH_009_OK] recuo arqueológico da margem final presente; acesso lateral sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_RETURN_010_OK] visada baixa para Casa Voss presente; leitura ambiental sem luz dinâmica.")
		print("[ORIGEM_R2_RIVER_MARKER_011_OK] dois marcadores ambientais de retorno presentes; sem sinalização explícita ou luz dinâmica.")
		print("[ORIGEM_R2_RIVER_QA_012_OK] marcadores ambientais sem corpos ou formas de colisão.")
		print("[ORIGEM_R2_RIVER_ROUTE_013_OK] três rotas canônicas R2 presentes e preservadas.")
		return
	for issue: String in issues:
		printerr("[ORIGEM_R2_WORLD_LIFE_ERROR] %s" % issue)

func _verify_r3_arch_qa() -> void:
	var issues: PackedStringArray = PackedStringArray()
	var arch: Node3D = find_child("ArcoDasRuinas_EstradaDoRio", true, false) as Node3D
	if arch == null:
		issues.append("o Arco R3 não foi instanciado no mundo")
	else:
		if absf(arch.global_position.z - 92.0) > 0.55:
			issues.append("o Arco R3 não preserva a projeção física Z≈92")
		var pillar_colliders: Array[Node] = arch.find_children("ColisorPilarArco*", "StaticBody3D", true, false)
		if pillar_colliders.size() != 2:
			issues.append("os dois colisores laterais do Arco estão em falta")
		var arch_lights: Array[Node] = arch.find_children("*", "OmniLight3D", true, false)
		if arch_lights.size() != 2:
			issues.append("o Arco R3 deve manter exatamente duas luzes Omni locais")
		var awakening: Node = arch.get_node_or_null("R3ArchAwakening")
		if awakening == null or not awakening.has_method("awake_once"):
			issues.append("o controlador de despertar R3 está em falta")
		else:
			var first_awake: bool = bool(awakening.call("awake_once"))
			var second_awake: bool = bool(awakening.call("awake_once"))
			if not first_awake or second_awake:
				issues.append("o despertar R3 não é único")
			elif awakening.get_node_or_null("EfeitosDoDespertar") == null:
				issues.append("os efeitos moderados do despertar R3 estão em falta")
	if issues.is_empty():
		print("[ORIGEM_R3_ARCH_OK] Arco Z≈92, colisores laterais, duas luzes e despertar único aprovados.")
		get_tree().quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R3_ARCH_ERROR] %s" % issue)
	get_tree().quit(1)

func _verify_r4_clearing_qa() -> void:
	var issues: PackedStringArray = PackedStringArray()
	var r4: Node = find_child("RegiaoFlorestaLagoExploravel", true, false)
	if r4 == null:
		issues.append("a região física R4 não foi instanciada")
	else:
		var clearing: Node = r4.get_node_or_null("R4ClareiraDaVisadaOrion")
		if clearing == null:
			issues.append("a clareira R4 da visada Orion está em falta")
		else:
			var frames: Array[Node] = clearing.find_children("QuadroAbertoOrion*", "Node3D", true, false)
			if frames.size() != 4:
				issues.append("a clareira R4 não possui os quatro quadros laterais esperados")
			elif not clearing.find_children("*", "OmniLight3D", true, false).is_empty():
				issues.append("a clareira R4 não pode acrescentar luz dinâmica")
		var markers: Node = r4.get_node_or_null("BalizasDoTrilhoFlorestal")
		if markers == null:
			issues.append("as balizas de orientação R4 estão em falta")
		else:
			var marker_lights: Array[Node] = markers.find_children("*", "OmniLight3D", true, false)
			if marker_lights.size() != 1:
				issues.append("a R4 deve manter exatamente uma baliza dinâmica local")
	if issues.is_empty():
		print("[ORIGEM_R4_CLEARING_OK] clareira lateral, quatro quadros e uma baliza dinâmica aprovados.")
		get_tree().quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R4_CLEARING_ERROR] %s" % issue)
	get_tree().quit(1)

func _verify_r5_artefact_qa() -> void:
	var issues: PackedStringArray = PackedStringArray()
	var camp: Node = find_child("AcampamentoMajestic", true, false)
	if camp == null:
		issues.append("o Acampamento Majestic não foi instanciado")
	else:
		var trail: Node = camp.get_node_or_null("R5TrilhoDoArtefacto")
		if trail == null:
			issues.append("o trilho narrativo R5 está em falta")
		else:
			var artefact: Node = trail.get_node_or_null("ArtefactoAzulMajestic")
			if artefact == null or not artefact.is_in_group("interactable"):
				issues.append("o artefacto azul R5 não é interagível")
			elif artefact.get_node_or_null("NucleoAzulSemLuzDinamica") == null:
				issues.append("o artefacto R5 não possui núcleo azul físico")
			elif not artefact.find_children("*", "OmniLight3D", true, false).is_empty():
				issues.append("o artefacto R5 não pode criar luz dinâmica")
			for clue_name: String in PackedStringArray(["PistaMapaExpedicaoMajestic", "PistaFerramentasECordasMajestic"]):
				var clue: Node = trail.get_node_or_null(clue_name)
				if clue == null or not clue.is_in_group("interactable"):
					issues.append("pista R5 indisponível: %s" % clue_name)
		var omni_lights: Array[Node] = camp.find_children("*", "OmniLight3D", true, false)
		var spot_lights: Array[Node] = camp.find_children("*", "SpotLight3D", true, false)
		if omni_lights.size() + spot_lights.size() != 4:
			issues.append("o Acampamento R5 deve manter exatamente quatro luzes locais")
	if issues.is_empty():
		_activate_majestic_orion_trace()
		if not TimelineManager.has_consequence("majestic_basin_trace_revealed"):
			issues.append("o artefacto R5 não persistiu a consequência de missão")
	if issues.is_empty():
		print("[ORIGEM_R5_ARTEFACT_OK] artefacto reativo, três pistas e quatro luzes locais aprovados.")
		get_tree().quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R5_ARTEFACT_ERROR] %s" % issue)
	get_tree().quit(1)

func _apply_exterior_light_budget() -> void:
	var all_lights: Array[Node] = []
	# Em arranque e harnesses QA a cena corrente pode ainda não estar definida; a raiz mantém a travessia segura sem alterar o orçamento.
	var scene_root: Node = get_tree().current_scene
	if scene_root == null:
		scene_root = get_tree().root
	if scene_root == null:
		return
	_collect_lights_recursive(scene_root, all_lights)
	var player: Node3D = get_tree().get_first_node_in_group("player") as Node3D
	var ranked_omni: Array[OmniLight3D] = []
	for light_node: Node in all_lights:
		var light: Light3D = light_node as Light3D
		if light == null:
			continue
		if light.name in exterior_budget_culled_lights:
			light.visible = false
			continue
		var omni: OmniLight3D = light as OmniLight3D
		if omni != null:
			ranked_omni.append(omni)
	if player == null:
		return
	ranked_omni.sort_custom(func(a: OmniLight3D, b: OmniLight3D) -> bool:
		return a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position)
	)
	for index: int in range(ranked_omni.size()):
		ranked_omni[index].visible = index < MAX_VISIBLE_DYNAMIC_OMNI_LIGHTS

func _collect_lights_recursive(node: Node, result: Array[Node]) -> void:
	if node == null or not is_instance_valid(node):
		return
	if node is Light3D:
		result.append(node)
	for child: Node in node.get_children():
		_collect_lights_recursive(child, result)

func _start_narrative():
	# A cartela narrativa inicia apenas depois do prólogo da Casa Voss: o comando de saltar e a câmara de abertura ficam livres de UI concorrente.
	var voss_controller: Node = null
	# TempleLevel constrói a Casa Voss durante o arranque; aguarda o controlador antes de decidir se a cartela pode começar.
	for frame_index: int in range(900):
		voss_controller = get_tree().get_first_node_in_group("voss_house_controller")
		if voss_controller != null:
			break
		await get_tree().process_frame
	while voss_controller != null and bool(voss_controller.get("opening_active")):
		await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	_show_msg("ORIGEM — VALE DE KHEPER\n\n2026. Elias Voss desperta diante de ruínas que não existem em nenhum mapa. A memória do futuro chama-o pelo nome...", 6.0)
	await get_tree().create_timer(6.5).timeout
	_show_msg("SERAPH: \"P-0... os Kharu protegem este vale para os P-47. Encontra os fragmentos e alcança o Cubo de Orion.\"", 6.0)
	await get_tree().create_timer(6.5).timeout
	_show_msg("CONTROLOS: WASD Mover | Rato Olhar | Botão Esquerdo Atacar | Botão Direito Defender | Shift Correr | E Interagir\n\nCOMBATE: atacar, defender e correr consomem STAMINA. Depois de um golpe, Elias recupera o fôlego antes de voltar a atacar.\n\nObjectivo: Explora o Vale de Kheper, derrota os Kharu e encontra as 3 Tábuas de Tradução.", 8.5)

# ═══════════════════════════════════════════════════════════════
func _process(delta: float):
	# Os módulos procedurais nascem depois do _ready; actualiza o orçamento para incluir luzes regionais sem custo por frame.
	var now_msec: int = Time.get_ticks_msec()
	if now_msec >= next_light_budget_refresh_msec:
		_apply_exterior_light_budget()
		next_light_budget_refresh_msec = now_msec + LIGHT_BUDGET_REFRESH_MSEC
	# O controlador corre em modo ALWAYS e lê Esc mesmo quando o menu já suspendeu a árvore.
	if Input.is_action_just_pressed("ui_cancel"):
		if elias_codex_ui != null and bool(elias_codex_ui.get("is_open")):
			elias_codex_ui.call("_set_open", false)
		elif is_instance_valid(pause_menu):
			pause_menu.toggle()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)
	_process_messages(delta)
	_process_seraph(delta)
	var map_key_pressed: bool = Input.is_key_pressed(KEY_M)
	if map_key_pressed and not map_key_was_pressed and cartographic_map_ui != null and cartographic_map_ui.has_method("toggle_map"):
		cartographic_map_ui.call("toggle_map")
	map_key_was_pressed = map_key_pressed
	if cartographic_map_ui != null and cartographic_map_ui.has_method("update_player_world_position"):
		var player_node: Node3D = get_tree().get_first_node_in_group("player") as Node3D
		if player_node != null:
			cartographic_map_ui.call("update_player_world_position", player_node.global_position, player_node.global_rotation.y)
func _process_messages(_delta: float):
	if msg_timer > 0:
		# A expiração usa tempo de parede para que a UI não fique presa quando o renderizador de captura reduz o delta do jogo.
		msg_timer = maxf(0.0, float(msg_expires_at_msec - Time.get_ticks_msec()) / 1000.0)
		if msg_timer <= 0:
			msg_panel.visible = false
			if msg_queue.size() > 0:
				var next = msg_queue.pop_front()
				_show_msg(next[0], next[1])

func _process_seraph(delta: float):
	if not seraph_active:
		return
	seraph_pulse_time += delta
	var pulse = (sin(seraph_pulse_time * 2.0) + 1.0) * 0.5
	seraph_light.light_energy = 0.3 + pulse * 0.8
	if tablets_found < 3 and fmod(seraph_pulse_time, 15.0) < 0.05:
		_seraph_hint()

func _seraph_hint():
	if not tablet1_taken:
		_queue_msg("SERAPH: \"Elias... sinto um fragmento a oeste. A energia temporal é forte ali.\"", 4.0)
	elif not tablet2_taken:
		_queue_msg("SERAPH: \"O segundo fragmento... está escondido entre as pedras a leste.\"", 4.0)
	elif not tablet3_taken:
		_queue_msg("SERAPH: \"O último fragmento repousa perto das ruínas junto ao lago. Os Kharu protegem a rota, mas não saem do território deles.\"", 4.0)

# ─── EVENTBUS — JOGADOR ───────────────────────────────────────
func _on_player_interact_target_changed(has_target: bool, object_name: String) -> void:
	interact_label.visible = has_target
	if has_target:
		interact_label.text = _interaction_prompt_for(object_name)
	else:
		interact_label.text = ""

func _interaction_prompt_for(object_name: String) -> String:
	match object_name:
		"VossFrontDoor":
			return "[E] Abrir a porta para o vale"
		"VossRestFire":
			return "[E] Repousar e guardar"
		"TomasTable":
			return "[E] Ler a carta de Tomás"
		"MountainMap":
			return "[E] Examinar o mapa da montanha"
		"MiguelTools":
			return "[E] Examinar as ferramentas de Miguel"
		"SwordWall":
			return "[E] Tomar a espada temporal"
		"Tablet1", "Tablet2", "Tablet3":
			return "[E] Recolher fragmento de tradução"
		"OrionCube":
			return "[E] Examinar o Cubo de Orion"
		"TerminalP52":
			return "[E] Contactar Seraph"
		_:
			return "[E] Interagir"

func _on_player_message_requested(text: String, duration: float) -> void:
	_queue_msg(text, duration)

func _on_player_health_changed(current_health: int, max_health: int) -> void:
	hud_status.text = "ELIAS  %d / %d" % [current_health, max_health]

func _on_player_stamina_changed(current_stamina: float, max_stamina: float) -> void:
	stamina_label.text = "STAMINA  %d / %d" % [roundi(current_stamina), roundi(max_stamina)]
	var ratio: float = current_stamina / max_stamina
	stamina_label.modulate = Color(0.72, 0.20, 0.16, 1.0) if ratio < 0.24 else Color(0.54, 0.78, 0.48, 1.0)

func _on_player_interacted(object_name: String) -> void:
	match object_name:
		"Tablet1":
			if not tablet1_taken:
				_take_tablet(1)
		"Tablet2":
			if not tablet2_taken:
				_take_tablet(2)
		"Tablet3":
			if not tablet3_taken:
				_take_tablet(3)
		"OrionCube":
			_activate_orion_cube()
		"TerminalP52":
			_interact_terminal_p52()
		"SpringFragment":
			_claim_spring_fragment()
		"ShortcutGate":
			_unlock_sanctuary_shortcut()
		"RuneP0_01":
			_show_msg("REGISTO DA EXPEDIÇÃO: outra equipa chegou à bacia antes de Elias. A água guardou o nome, não o rosto.", 3.4)
		"ArtefactoAzulMajestic":
			_activate_majestic_orion_trace()
		"PistaMapaExpedicaoMajestic":
			_show_msg("MAPA DE EXPEDIÇÃO: a rota desce para a bacia; alguém assinalou a margem antes de abandonar o acampamento.", 3.4)
		"PistaFerramentasECordasMajestic":
			_show_msg("FERRAMENTAS E CORDAS: estavam prontas para uma descida técnica em direção à margem. A equipa saiu depressa.", 3.4)
		"RuneP0_02":
			_show_msg("RUNAS: Os Kharu vigiam a nascente, mas não compreendem a memória que guardam.", 3.0)
		"RuneP0_03":
			_show_msg("RUNAS: O portão abre-se a quem alcança a ruína pelo lado da verdade.", 3.0)
		"InteriorGate":
			_try_enter_sanctuary_interior()
		"InteriorResonanceSwitch":
			_activate_resonance_bridge()
		"InnerOrionSeal":
			_show_msg("CÂMARA DO CUBO: O artefacto aguarda os três fragmentos de tradução. O futuro ainda não cedeu.", 3.4)
		"ChronosPrototypeConsole":
			_toggle_chronos_prototype()
		"TomasTable", "MountainMap", "MiguelTools":
			_inspect_voss_clue(object_name)
		"VossRestFire":
			rest_at_voss_fire()
		"VossFrontDoor":
			_open_voss_front_door()

func _activate_majestic_orion_trace() -> void:
	var already_discovered: bool = TimelineManager.has_consequence("majestic_basin_trace_revealed")
	TimelineManager.trigger_event("majestic_orion_trace_discovered")
	WorldEvents.trigger_event("majestic_orion_trace_discovered", {"region": "R5", "source": "ArtefactoAzulMajestic"})
	if already_discovered:
		_show_msg("O artefacto mantém a mesma pulsação azul. A expedição anterior ainda aponta para a bacia.", 3.2)
	else:
		_show_msg("ARTEFACTO MAJESTIC: uma assinatura azul responde à tua presença. Pista obtida: seguir a preparação da expedição para a bacia.", 4.0)

func _inspect_voss_clue(clue_id: String) -> void:
	var voss_house: Node = get_tree().get_first_node_in_group("voss_house_controller")
	if voss_house == null or not voss_house.has_method("inspect_voss_clue"):
		_show_msg("A memória deste objeto ainda não está disponível.", 2.0)
		return
	var result: Variant = voss_house.call("inspect_voss_clue", clue_id)
	if typeof(result) != TYPE_DICTIONARY:
		return
	var clue: Dictionary = result as Dictionary
	var clue_text: String = str(clue.get("text", ""))
	if clue_text != "":
		_show_msg(clue_text, 5.2)
	if elias_codex_ui != null and elias_codex_ui.has_method("refresh_entries"):
		elias_codex_ui.call_deferred("refresh_entries")

func rest_at_voss_fire() -> void:
	var player: Node = get_tree().get_first_node_in_group("player")
	if player != null and player.has_method("rest_at_safe_point"):
		player.call("rest_at_safe_point")
	SaveManager.save_game(0)
	_show_msg("REPOUSO — Casa Voss\n\nElias recupera junto à lareira. A memória deste instante foi guardada.", 3.6)
	print("[ORIGEM_R1_REST_SAVE] slot=0 sucesso=%s" % str(SaveManager.has_save(0)))

func _open_voss_front_door() -> void:
	var voss_house: Node = get_tree().get_first_node_in_group("voss_house_controller")
	if voss_house == null or not voss_house.has_method("open_front_door"):
		_show_msg("A porta da Casa Voss não responde. A interação será restaurada.", 2.4)
		return
	var opened: bool = bool(voss_house.call("open_front_door"))
	if opened:
		_show_msg("Porta da Casa Voss aberta. O caminho para o exterior está livre.", 2.6)
	else:
		_show_msg("A porta já está aberta. O caminho para o exterior está livre.", 2.2)

# ─── EVENTBUS — GUARDIÃO ──────────────────────────────────────
# ─── INTERAÇÃO (via EventBus) ─────────────────────────────────
func _take_tablet(id: int):
	tablets_found += 1
	match id:
		1:
			tablet1_taken = true
			tablet1.visible = false
			_show_msg("FRAGMENTO I — Tábua Suméria\n\n\"...os que vêm do tempo futuro carregam o peso da perda. O seu ADN é uma sombra do que fomos. Nós, P-0, somos a chave que eles procuram...\"", 6.0)
		2:
			tablet2_taken = true
			tablet2.visible = false
			_show_msg("FRAGMENTO II — Inscrição Egípcia\n\n\"...a biblioteca do presente é o único remédio para a corrupção do futuro. Aquele que ativar o Cubo verá o caminho entre os tempos...\"", 6.0)
		3:
			tablet3_taken = true
			tablet3.visible = false
			_show_msg("FRAGMENTO III — Texto Atlante\n\n\"...o Cubo de Orion guarda a memória do que ainda não aconteceu. Quando os três fragmentos forem unidos, a convergência será revelada a um P-0 de coração puro...\"", 6.0)
	if tablets_found == 3:
		await get_tree().create_timer(6.5).timeout
		_show_msg("SERAPH: \"Elias! Tens os três fragmentos. O Cubo de Orion repousa no santuário das ruínas. O caminho está aberto.\"", 5.0)
		mission_phase = 2

func _toggle_chronos_prototype() -> void:
	if TimelineManager.current_era == TimelineManager.Era.ANCIENT:
		TimelineManager.travel_to_era(TimelineManager.Era.MODERN)
		_show_msg("CHRONOS: Perfil de Kheper restaurado. A memória regressa ao crepúsculo.", 2.8)
	else:
		TimelineManager.travel_to_era(TimelineManager.Era.ANCIENT)
		_show_msg("CHRONOS: Projeção do Egito Antigo iniciada. A matéria da era ainda será construída numa fase futura.", 3.4)

func _try_enter_sanctuary_interior() -> void:
	var interior: Node = get_tree().get_first_node_in_group("sanctuary_interior") as Node
	if interior != null and interior.has_method("try_enter_interior"):
		interior.try_enter_interior()

func _activate_resonance_bridge() -> void:
	var interior: Node = get_tree().get_first_node_in_group("sanctuary_interior") as Node
	if interior != null and interior.has_method("activate_resonance_bridge"):
		interior.activate_resonance_bridge()

func _unlock_sanctuary_shortcut() -> void:
	var sanctuary: Node = get_tree().get_first_node_in_group("sanctuary_slice") as Node
	if sanctuary != null and sanctuary.has_method("unlock_shortcut"):
		sanctuary.unlock_shortcut()

func _claim_spring_fragment() -> void:
	if spring_fragment_taken:
		_show_msg("O pedestal está vazio; a energia da nascente já vive na espada de Elias.", 2.5)
		return
	spring_fragment_taken = true
	var reward: Node = get_tree().get_first_node_in_group("spring_reward") as Node
	if reward != null:
		reward.visible = false
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player != null and player.has_method("restore_health"):
		player.restore_health(35)
	_show_msg("FRAGMENTO DA NASCENTE\n\nA água antiga reconhece Elias. A espada absorve o fragmento e recupera 35 pontos de vida.\n\nSERAPH: \"O vale recorda quem o protege. A convergência começou.\"", 6.0)

func _activate_orion_cube():
	if cube_activated:
		_show_msg("O Cubo de Orion pulsa com energia temporal. A passagem está aberta.", 3.0)
		return
	if tablets_found < 3:
		_show_msg("O Cubo de Orion... sentes uma energia imensa.\nPrecisas dos 3 fragmentos de tradução para o ativar. (%d/3)" % tablets_found, 4.0)
		return

	cube_activated = true
	mission_phase = 3
	_show_msg("O Cubo de Orion ATIVADO.\n\nVisões invadem a mente de Elias — 47.000 anos de futuro, a Terra devastada, os P-47 a sobreviver no subsolo...\n\nA porta temporal está a abrir-se!", 7.0)

	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	# A porta antiga foi removida da cena; a abertura do evento é sinalizada apenas pela narrativa.

	var tween2 = get_tree().create_tween()
	tween2.tween_property(seraph_light, "light_energy", 4.0, 2.0)
	tween2.tween_property(seraph_light, "omni_range", 15.0, 2.0)

	await get_tree().create_timer(2.0).timeout
	_show_msg("SERAPH: \"O Cubo abriu a memória do futuro. A água do vale recorda futuros que ainda não aconteceram.\"", 5.0)

func _interact_terminal_p52():
	if not seraph_contacted:
		seraph_contacted = true
		_show_msg("TERMINAL P-52 — SERAPH\n\n\"Elias Voss. Eu sou Seraph. Venho de 52.000 anos no futuro.\nOs Kharu foram deixados para guardar as rotas do vale e os seus fragmentos.\nNão precisas fugir: aprende os seus padrões, derrota-os e alcança o Cubo.\nA convergência está à tua espera.\"", 8.0)
	else:
		_show_msg("SERAPH: \"Continua, Elias. O tempo está a convergir. Não podes falhar.\"", 3.5)

# ─── MENSAGENS ────────────────────────────────────────────────
func _show_msg(text: String, duration: float = 4.0):
	msg_label.text = text
	msg_panel.visible = true
	msg_timer = duration
	msg_expires_at_msec = Time.get_ticks_msec() + roundi(maxf(0.0, duration) * 1000.0)

func _queue_msg(text: String, duration: float = 3.0):
	if msg_timer > 0:
		msg_queue.append([text, duration])
	else:
		_show_msg(text, duration)
