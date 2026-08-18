extends Node3D

# ═══════════════════════════════════════════════════════════════
# ORIGEM — Script Principal
# Baseado na lore: P-0 (Humanidade), P-47 (Greys), P-52 (Nórdicos)
# Herói: ELIAS VOSS — arqueólogo e físico de plasma, P-0
# Aliada: SERAPH — entidade P-52 que guia o jogador
# Ameaça ativa: os guerreiros Kharu guardam os fragmentos e as ruínas do Vale de Kheper.
# ═══════════════════════════════════════════════════════════════

# ─── UI ───────────────────────────────────────────────────────
@onready var interact_label: Label = $UI/HUD/InteractLabel
@onready var msg_panel: PanelContainer = $UI/HUD/MsgPanel
@onready var msg_label: Label = $UI/HUD/MsgPanel/MsgLabel
@onready var hud_status: Label = $UI/HUD/StatusLabel
@onready var stamina_label: Label = $UI/HUD/StaminaLabel
@onready var crosshair: Label = $UI/HUD/Crosshair

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
var msg_queue: Array = []

# ─── SERAPH (ALIADA P-52) ─────────────────────────────────────
var seraph_pulse_time: float = 0.0
var seraph_active: bool = true

# ═══════════════════════════════════════════════════════════════
func _ready():
	add_to_group("main_scene")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	RenderingServer.set_default_clear_color(Color(0.05, 0.05, 0.08))
	interact_label.visible = false
	EventBus.player_interacted.connect(_on_player_interacted)
	EventBus.player_interact_target_changed.connect(_on_player_interact_target_changed)
	EventBus.player_message_requested.connect(_on_player_message_requested)
	EventBus.player_health_changed.connect(_on_player_health_changed)
	EventBus.player_stamina_changed.connect(_on_player_stamina_changed)
	hud_status.text = "ELIAS  100 / 100"
	stamina_label.text = "STAMINA  100 / 100"
	_start_narrative()

func _start_narrative():
	if _take57_validation_mode():
		await get_tree().create_timer(2.0).timeout
		var voss_house := get_tree().get_first_node_in_group("voss_house_controller") as Node
		if voss_house != null and voss_house.has_method("_finish_opening_camera"):
			voss_house.call("_finish_opening_camera")
		await get_tree().process_frame
		var validation_player := get_tree().get_first_node_in_group("player") as Node3D
		var validation_take: String = OS.get_environment("ORIGEM_VALIDATION_TAKE")
		var validation_region: String = OS.get_environment("ORIGEM_VALIDATION_REGION")
		if validation_player != null:
			if OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R6_R7_BOUNDARY":
				validation_player.global_position = Vector3(60.0, 8.0, 252.0)
				validation_player.rotation.y = -0.72
			elif OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R7_R8_BOUNDARY":
				validation_player.global_position = Vector3(128.0, 14.0, 332.0)
				validation_player.rotation.y = -2.38
			elif validation_take == "6":
				validation_player.global_position = Vector3(0.0, 1.8, -73.0)
			elif validation_take == "7":
				validation_player.global_position = Vector3(0.0, 1.8, -104.0)
			elif validation_take == "8":
				validation_player.global_position = Vector3(174.0, 34.0, 410.0)
			elif validation_region == "7":
				validation_player.global_position = Vector3(128.0, 14.0, 332.0)
			elif validation_region == "8":
				validation_player.global_position = Vector3(176.0, 20.0, 382.0)
			elif validation_region == "10":
				validation_player.global_position = Vector3(-116.0, 43.0, 532.0)
			else:
				validation_player.global_position = Vector3(0.0, 1.4, -28.0)
			if validation_take != "8" and OS.get_environment("QA_VALIDATION_ROUTE") not in ["MAP_MIRROR_VALIDATION_R6_R7_BOUNDARY", "MAP_MIRROR_VALIDATION_R7_R8_BOUNDARY"]:
				validation_player.rotation.y = PI
		mission_phase = 1
		if OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R7_R8_BOUNDARY" and validation_player != null:
			var validation_camera := validation_player.get_node_or_null("Head/Camera3D") as Camera3D
			if validation_camera != null:
				validation_camera.look_at(Vector3(194.0, 24.0, 404.0), Vector3.UP)
		if OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R6_R7_BOUNDARY":
			_show_msg("HANDOFF R6 → R7 — Ruínas Submersas para Vila Elevada.", 4.0)
		elif OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R7_R8_BOUNDARY":
			_show_msg("HANDOFF R7 → R8 — Vila Elevada para Observatório.", 4.0)
		elif validation_region == "8":
			_show_msg("REGIÃO 8 — Observatório da Orion e leitura do céu alpino.", 4.0)
		elif validation_region == "7":
			_show_msg("REGIÃO 7 — Vila Elevada e rota para o Observatório.", 4.0)
		elif validation_region == "10":
			_show_msg("REGIÃO 10 — Limiar da Caverna do Orion.", 4.0)
		elif validation_take == "6":
			_show_msg("TAKE 6 — Desfiladeiro profundo e fendas tectónicas.", 4.0)
		elif validation_take == "7":
			_show_msg("TAKE 7 — Praça ciclópica e Cubo de Orion.", 4.0)
		elif validation_take == "8":
			_show_msg("TAKE 8 — Trilha da Montanha: ascensão arqueológica.", 4.0)
		else:
			_show_msg("TAKE 5–7 — Rota de validação iniciada no limiar da caverna.", 4.0)
		return
	await get_tree().create_timer(0.5).timeout
	_show_msg("ORIGEM — VALE DE KHEPER\n\n2026. Elias Voss desperta diante de ruínas que não existem em nenhum mapa. A memória do futuro chama-o pelo nome...", 6.0)
	await get_tree().create_timer(6.5).timeout
	_show_msg("SERAPH: \"P-0... os Kharu protegem este vale para os P-47. Encontra os fragmentos e alcança o Cubo de Orion.\"", 6.0)
	await get_tree().create_timer(6.5).timeout
	_show_msg("CONTROLOS: WASD Mover | Rato Olhar | Botão Esquerdo Atacar | Botão Direito Defender | Shift Correr | E Interagir\n\nCOMBATE: atacar, defender e correr consomem STAMINA. Depois de um golpe, Elias recupera o fôlego antes de voltar a atacar.\n\nObjectivo: Explora o Vale de Kheper, derrota os Kharu e encontra as 3 Tábuas de Tradução.", 8.5)

# ═══════════════════════════════════════════════════════════════
func _take57_validation_mode() -> bool:
	if OS.get_environment("ORIGEM_TAKE57") == "1" or OS.get_environment("ORIGEM_VALIDATION_TAKE") in ["6", "7", "8"] or OS.get_environment("ORIGEM_VALIDATION_REGION") in ["7", "8"] or OS.get_environment("ORIGEM_VALIDATION_REGION") == "10" or OS.get_environment("QA_VALIDATION_ROUTE") in ["MAP_MIRROR_VALIDATION_R6_R7_BOUNDARY", "MAP_MIRROR_VALIDATION_R7_R8_BOUNDARY"]:
		return true
	for argument: String in OS.get_cmdline_args():
		if argument == "--take57":
			return true
	return false

func _process(delta: float):
	_process_messages(delta)
	_process_seraph(delta)
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process_messages(delta: float):
	if msg_timer > 0:
		msg_timer -= delta
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
func _on_player_interact_target_changed(has_target: bool) -> void:
	interact_label.visible = has_target

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
			_show_msg("RUNAS: A água recorda aquilo que o tempo tentou apagar.", 3.0)
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
		"VossFrontDoor":
			_open_voss_front_door()

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

func _queue_msg(text: String, duration: float = 3.0):
	if msg_timer > 0:
		msg_queue.append([text, duration])
	else:
		_show_msg(text, duration)
