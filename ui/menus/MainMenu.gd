extends Control

@onready var btn_new_game: Button = $CenterContainer/VBoxContainer/Buttons/BtnNewGame
@onready var btn_continue: Button = $CenterContainer/VBoxContainer/Buttons/BtnContinue
@onready var btn_settings: Button = $CenterContainer/VBoxContainer/Buttons/BtnSettings
@onready var btn_quit: Button = $CenterContainer/VBoxContainer/Buttons/BtnQuit

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	btn_new_game.pressed.connect(_on_new_game_pressed)
	btn_continue.pressed.connect(_on_continue_pressed)
	btn_settings.pressed.connect(func(): print("Definições - em breve"))
	btn_quit.pressed.connect(func(): get_tree().quit())
	btn_new_game.grab_focus()
	# Exclusivo de QA automatizado: evita que limitações de entrada do Xvfb invalidem a prova de Novo Jogo.
	# Não altera o menu em qualquer execução sem a variável de ambiente explícita.
	if OS.get_environment("ORIGEM_QA_AUTOSTART_NEW_GAME") == "1":
		call_deferred("_on_new_game_pressed")

func _on_new_game_pressed() -> void:
	const path: String = "res://scenes/main.tscn"
	# CP-ERR-03: resolve a PackedScene explicitamente antes da troca de cena;
	# isto transforma UID/ext_resource inválido numa mensagem diagnosticável.
	var packed_scene: PackedScene = ResourceLoader.load(path, "PackedScene", ResourceLoader.CACHE_MODE_IGNORE) as PackedScene
	if packed_scene == null:
		push_error("[MainMenu] Não foi possível resolver PackedScene: " + path)
		return
	var err: Error = get_tree().change_scene_to_packed(packed_scene)
	if err != OK:
		push_error("[MainMenu] Falha ao carregar cena: %s (%d)" % [path, err])

func _on_continue_pressed() -> void:
	_on_new_game_pressed()
