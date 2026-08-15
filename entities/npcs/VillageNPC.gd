extends CharacterBody3D

@export var npc_name: String = "Village NPC"
@export var move_speed: float = 2.0
@export var interaction_radius: float = 2.0

@onready var nav_agent: NavigationAgent3D = $NavAgent
@onready var interaction_area: Area3D = $InteractionArea
@onready var name_label: Label3D = $NameLabel

var target_position: Vector3 = Vector3.ZERO
var is_moving: bool = false


func _ready() -> void:
    name_label.text = npc_name
    interaction_area.monitoring = true
    interaction_area.monitorable = false
    nav_agent.target_desired_distance = 0.5
    nav_agent.path_desired_distance = 0.5


func _physics_process(delta: float) -> void:
    if nav_agent.is_navigation_finished():
        velocity = Vector3.ZERO
        return

    var next_path_position: Vector3 = nav_agent.get_next_path_position()
    var direction: Vector3 = (next_path_position - global_transform.origin).normalized()
    velocity = direction * move_speed
    move_and_slide()


func set_target(target: Vector3) -> void:
    target_position = target
    nav_agent.target_position = target
    is_moving = true


func stop_moving() -> void:
    is_moving = false
    nav_agent.target_position = global_transform.origin
    velocity = Vector3.ZERO
