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
	# QA-only: nunca activa no jogo normal; permite capturas headless determinísticas.
	if OS.get_environment("ORIGEM_AUTO_START") == "1":
		call_deferred("_on_new_game_pressed")

func _on_new_game_pressed() -> void:
	var path := "res://scenes/main.tscn"
	if not ResourceLoader.exists(path):
		push_error("[MainMenu] Cena não encontrada: " + path)
		print("[MainMenu] Cenas disponíveis:")
		for f in DirAccess.get_files_at("res://scenes/"):
			print("  res://scenes/" + f)
		return

	var err := get_tree().change_scene_to_file(path)
	if err != OK:
		push_error("[MainMenu] Falha ao carregar cena: %s (%d)" % [path, err])

func _on_continue_pressed() -> void:
	var path := "res://scenes/main.tscn"
	var err := get_tree().change_scene_to_file(path)
	if err != OK:
		push_error("[MainMenu] Falha ao continuar: %s (%d)" % [path, err])
