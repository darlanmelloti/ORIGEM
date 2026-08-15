## Player.gd
## Controla movimento, câmara, lanterna e interação do jogador (Elias Voss).
## Comunica com outros sistemas via EventBus.
class_name Player
extends CharacterBody3D

# ─── NÓS ──────────────────────────────────────────────────────
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interact_ray: RayCast3D = $Head/Camera3D/InteractRay
@onready var flashlight: SpotLight3D = $Head/Camera3D/Flashlight
@onready var footstep_timer: Timer = $FootstepTimer

# ─── ESTADO ───────────────────────────────────────────────────
var flashlight_on: bool = false
var is_sprinting: bool = false
var player_velocity: Vector3 = Vector3.ZERO
var bob_time: float = 0.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
const WALK_SPEED = 2.8
const SPRINT_SPEED = 5.2
const MOUSE_SENS = 0.0018
const JUMP_FORCE = 7.5

# ═══════════════════════════════════════════════════════════════
func _ready() -> void:
	add_to_group("player")
	flashlight_on = true
	flashlight.visible = true
	footstep_timer.timeout.connect(_on_footstep)

func _physics_process(delta: float) -> void:
	_handle_player(delta)
	_handle_interaction()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			return
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENS)
		head.rotate_x(-event.relative.y * MOUSE_SENS)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85), deg_to_rad(85))
		get_viewport().set_input_as_handled()

# ─── MOVIMENTO ────────────────────────────────────────────────
func _handle_player(delta: float) -> void:
	if is_on_floor():
		player_velocity.y = 0.0
	else:
		player_velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_velocity.y = JUMP_FORCE
	if Input.is_action_just_pressed("toggle_flashlight"):
		flashlight_on = !flashlight_on
		flashlight.visible = flashlight_on
		if flashlight_on:
			EventBus.player_message_requested.emit("Lanterna ligada. Cuidado — o Guardião vê a luz.", 2.5)

	is_sprinting = Input.is_action_pressed("sprint")
	var speed = SPRINT_SPEED if is_sprinting else WALK_SPEED

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		player_velocity.x = direction.x * speed
		player_velocity.z = direction.z * speed
		if is_on_floor() and footstep_timer.is_stopped():
			footstep_timer.start(0.32 if is_sprinting else 0.52)
	else:
		player_velocity.x = move_toward(player_velocity.x, 0, speed)
		player_velocity.z = move_toward(player_velocity.z, 0, speed)

	velocity = player_velocity
	move_and_slide()
	player_velocity = velocity

	if direction and is_on_floor():
		bob_time += delta * speed
		camera.transform.origin.y = sin(bob_time * 1.8) * 0.025
	else:
		camera.transform.origin.y = lerp(camera.transform.origin.y, 0.0, delta * 6.0)

func _on_footstep() -> void:
	pass

# ─── INTERAÇÃO ────────────────────────────────────────────────
func _handle_interaction() -> void:
	var hit = interact_ray.get_collider()
	if hit and hit.is_in_group("interactable"):
		EventBus.player_interact_target_changed.emit(true)
		if Input.is_action_just_pressed("interact"):
			EventBus.player_interacted.emit(hit.name)
	else:
		EventBus.player_interact_target_changed.emit(false)
