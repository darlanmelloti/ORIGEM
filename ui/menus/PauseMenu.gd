extends Control
class_name PauseMenu

@onready var btn_resume: Button = $CenterContainer/Panel/VBoxContainer/BtnResume
@onready var btn_save: Button = $CenterContainer/Panel/VBoxContainer/BtnSave
@onready var btn_main_menu: Button = $CenterContainer/Panel/VBoxContainer/BtnMainMenu
@onready var btn_quit: Button = $CenterContainer/Panel/VBoxContainer/BtnQuit
@onready var save_feedback: Label = $CenterContainer/Panel/VBoxContainer/SaveFeedback

var is_open: bool = false


func _ready() -> void:
    hide()
    for button in [btn_resume, btn_save, btn_main_menu, btn_quit]:
        if is_instance_valid(button):
            button.pressed.connect(_on_button_pressed.bind(button))


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_just_pressed("ui_cancel"):
        visible = !visible
        if visible:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
            _update_info()
        else:
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


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


func close() -> void:
    hide()
    is_open = false
    get_tree().paused = false


func _on_button_pressed(button: Button) -> void:
    match button.name:
        "BtnResume":
            close()
        "BtnSave":
            save_feedback.show()
        "BtnMainMenu":
            get_tree().change_scene_to_file("res://ui/menus/MainMenu.tscn")
        "BtnQuit":
            get_tree().quit()
