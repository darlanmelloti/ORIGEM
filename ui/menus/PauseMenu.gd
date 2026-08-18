extends Control
class_name PauseMenu

@onready var btn_resume: Button = $CenterContainer/Panel/VBoxContainer/BtnResume
@onready var btn_save: Button = $CenterContainer/Panel/VBoxContainer/BtnSave
@onready var btn_main_menu: Button = $CenterContainer/Panel/VBoxContainer/BtnMainMenu
@onready var btn_quit: Button = $CenterContainer/Panel/VBoxContainer/BtnQuit
@onready var save_feedback: Label = $CenterContainer/Panel/VBoxContainer/SaveFeedback

var is_open: bool = false

func _ready() -> void:
	# O menu precisa continuar a receber Esc mesmo depois de pausar o mundo.
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	for button: Button in [btn_resume, btn_save, btn_main_menu, btn_quit]:
		if is_instance_valid(button):
			button.pressed.connect(_on_button_pressed.bind(button))

func _update_info() -> void:
	if is_instance_valid(save_feedback):
		save_feedback.hide()

func toggle() -> void:
	if is_open:
		close()
	else:
		open()

func open() -> void:
	show()
	is_open = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_update_info()
	if is_instance_valid(btn_resume):
		btn_resume.grab_focus()

func close() -> void:
	hide()
	is_open = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_button_pressed(button: Button) -> void:
	match button.name:
		"BtnResume":
			close()
		"BtnSave":
			save_feedback.show()
		"BtnMainMenu":
			get_tree().paused = false
			get_tree().change_scene_to_file("res://ui/menus/MainMenu.tscn")
		"BtnQuit":
			get_tree().quit()
