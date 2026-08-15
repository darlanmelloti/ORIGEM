extends Node3D

# ═══════════════════════════════════════════════════════════════
# ORIGEM — Script Principal
# Baseado na lore: P-0 (Humanidade), P-47 (Greys), P-52 (Nórdicos)
# Herói: ELIAS VOSS — arqueólogo e físico de plasma, P-0
# Aliada: SERAPH — entidade P-52 que guia o jogador
# Vilão Principal: O GUARDIÃO — ser P-47 que protege o Orion Cube
# ═══════════════════════════════════════════════════════════════

# ─── UI ───────────────────────────────────────────────────────
@onready var interact_label: Label = $UI/HUD/InteractLabel
@onready var msg_panel: PanelContainer = $UI/HUD/MsgPanel
@onready var msg_label: Label = $UI/HUD/MsgPanel/MsgLabel
@onready var hud_status: Label = $UI/HUD/StatusLabel
@onready var crosshair: Label = $UI/HUD/Crosshair

# ─── NÓS DO JOGO ──────────────────────────────────────────────

# Jogador
@onready var player: CharacterBody3D = $Player

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
	EventBus.guardian_player_caught.connect(_on_guardian_player_caught)
	EventBus.guardian_alert.connect(_on_guardian_alert)
	_start_narrative()

func _start_narrative():
	await get_tree().create_timer(0.5).timeout
	_show_msg("ORIGEM\n\n2026. Museu Arqueológico de Lisboa.\nElias Voss desperta com uma memória que não é sua...", 6.0)
	await get_tree().create_timer(6.5).timeout
	_show_msg("Uma voz estranha ecoa: \"P-0... encontra os fragmentos. O Cubo de Orion deve ser ativado antes que eles cheguem.\"", 6.0)
	await get_tree().create_timer(6.5).timeout
	_show_msg("CONTROLOS: WASD Mover | Rato Olhar | F Lanterna | E Interagir | Shift Correr\n\nObjectivo: Encontra as 3 Tábuas de Tradução e ativa o Cubo de Orion.", 7.0)

# ═══════════════════════════════════════════════════════════════
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
		_queue_msg("SERAPH: \"O último fragmento está no corredor sul. Cuidado com o Guardião.\"", 4.0)

# ─── EVENTBUS — JOGADOR ───────────────────────────────────────
func _on_player_interact_target_changed(has_target: bool) -> void:
	interact_label.visible = has_target

func _on_player_message_requested(text: String, duration: float) -> void:
	_queue_msg(text, duration)

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
		"TempleExitDoorCollider":
			_exit_temple_to_world()

# ─── INTERAÇÃO (via EventBus) ─────────────────────────────────
func _exit_temple_to_world() -> void:
	if player:
		player.position = Vector3(8.0, 2.0, 15.0)
		_show_msg("Saíste do templo.\n\nO mundo aberto aguarda sua exploração. Em algum lugar destas terras, o Guardião protege o Cubo de Orionte.", 4.0)

# ─── EVENTBUS — GUARDIÃO ──────────────────────────────────────
func _on_guardian_alert(text: String, duration: float) -> void:
	_queue_msg(text, duration)

func _on_guardian_player_caught() -> void:
	seraph_active = false
	_show_msg("O Guardião capturou-te.\n\nA memória de Elias foi apagada.\nO P-47 levou as amostras genéticas...", 4.0)
	await get_tree().create_timer(4.0).timeout
	get_tree().reload_current_scene()

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
		_show_msg("SERAPH: \"Elias! Tens os três fragmentos. O Cubo de Orion está no centro do templo. Ativa-o antes que o Guardião regresse!\"", 5.0)
		mission_phase = 2

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

	EventBus.guardian_chase_forced.emit()
	await get_tree().create_timer(7.5).timeout
	_show_msg("SERAPH: \"Atravessa a porta! O Guardião vai tentar impedir-te. Eu vou segurá-lo... vai, Elias!\"", 5.0)

func _interact_terminal_p52():
	if not seraph_contacted:
		seraph_contacted = true
		_show_msg("TERMINAL P-52 — SERAPH\n\n\"Elias Voss. Eu sou Seraph. Venho de 52.000 anos no futuro.\nOs P-47 querem o teu ADN para curar a sua degeneração.\nNão podes deixar que o Guardião te apanhe.\nEncontra os fragmentos. Ativa o Cubo. É a única forma de fechar a janela temporal.\"", 8.0)
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
