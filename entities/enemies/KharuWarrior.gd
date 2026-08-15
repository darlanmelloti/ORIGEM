## KharuWarrior.gd
## Inimigo comum do Vale de Kheper.
## Os Kharu são guardiões temporais de baixa casta: defendem uma área,
## atacam apenas em combate próximo e regressam ao seu território se Elias recuar.

class_name KharuWarrior
extends CharacterBody3D

enum State { IDLE, ALERT, COMBAT, RETURNING, DEAD }

@export var max_health: int = 60
@export var detection_range: float = 10.0
@export var attack_range: float = 1.75
@export var leash_range: float = 18.0
@export var patrol_radius: float = 2.2

var current_health: int
var state: State = State.IDLE
var home_position: Vector3
var attack_cooldown: float = 0.0
var patrol_time: float = 0.0
var player: Player
var health_label: Label3D
var visual: Node3D

const MOVE_SPEED: float = 2.15
const ATTACK_DAMAGE: int = 14
const ATTACK_DELAY: float = 1.15
const GRAVITY: float = 9.8

func _ready() -> void:
	add_to_group("enemy")
	current_health = max_health
	home_position = global_position
	player = get_tree().get_first_node_in_group("player") as Player
	_create_visual_if_needed()
	_update_health_label()

func _physics_process(delta: float) -> void:
	if state == State.DEAD:
		return
	if player == null:
		player = get_tree().get_first_node_in_group("player") as Player
		return

	attack_cooldown = maxf(attack_cooldown - delta, 0.0)
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0.0

	var player_distance: float = global_position.distance_to(player.global_position)
	var home_distance: float = global_position.distance_to(home_position)

	match state:
		State.IDLE:
			_patrol_near_home(delta)
			if player_distance <= detection_range:
				state = State.ALERT
				EventBus.player_message_requested.emit("Um Kharu percebeu a tua presença.", 1.8)

		State.ALERT:
			_face_target(player.global_position)
			if player_distance <= detection_range * 0.85:
				state = State.COMBAT
			elif player_distance > detection_range * 1.35:
				state = State.RETURNING

		State.COMBAT:
			if home_distance > leash_range or player_distance > leash_range:
				state = State.RETURNING
			elif player_distance > attack_range:
				_move_towards(player.global_position, MOVE_SPEED)
			else:
				_face_target(player.global_position)
				_attack_player()

		State.RETURNING:
			if global_position.distance_to(home_position) > 0.6:
				_move_towards(home_position, MOVE_SPEED * 1.15)
			else:
				state = State.IDLE

	move_and_slide()

func take_damage(amount: int, attacker_position: Vector3) -> void:
	if state == State.DEAD:
		return

	current_health = clampi(current_health - amount, 0, max_health)
	state = State.COMBAT
	_update_health_label()
	_face_target(attacker_position)

	if current_health <= 0:
		_die()
	else:
		_flash_damage()

func _attack_player() -> void:
	if attack_cooldown > 0.0 or player == null:
		return

	attack_cooldown = ATTACK_DELAY
	_animate_attack()
	player.take_damage(ATTACK_DAMAGE, global_position)

func _move_towards(target: Vector3, speed: float) -> void:
	var flat_target: Vector3 = Vector3(target.x, global_position.y, target.z)
	var direction: Vector3 = global_position.direction_to(flat_target)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	_face_target(target)

func _face_target(target: Vector3) -> void:
	var flat_target: Vector3 = Vector3(target.x, global_position.y, target.z)
	if flat_target.distance_to(global_position) > 0.05:
		look_at(flat_target, Vector3.UP)

func _patrol_near_home(delta: float) -> void:
	patrol_time += delta
	var patrol_target: Vector3 = home_position + Vector3(sin(patrol_time * 0.5) * patrol_radius, 0.0, cos(patrol_time * 0.4) * patrol_radius)
	if global_position.distance_to(patrol_target) > 0.8:
		_move_towards(patrol_target, MOVE_SPEED * 0.35)
	else:
		velocity.x = 0.0
		velocity.z = 0.0

func _die() -> void:
	state = State.DEAD
	remove_from_group("enemy")
	EventBus.player_message_requested.emit("Kharu derrotado. A energia temporal dissipa-se.", 1.8)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector3(0.05, 0.05, 0.05), 0.55)
	tween.tween_callback(queue_free)

func _create_visual_if_needed() -> void:
	visual = get_node_or_null("Visual") as Node3D
	if visual == null:
		visual = Node3D.new()
		visual.name = "Visual"
		add_child(visual)

	var skin_material: StandardMaterial3D = _material(Color(0.19, 0.13, 0.18), 0.75, false)
	var cloth_material: StandardMaterial3D = _material(Color(0.55, 0.30, 0.12), 0.9, false)
	var gold_material: StandardMaterial3D = _material(Color(0.80, 0.55, 0.14), 0.32, true)
	var eye_material: StandardMaterial3D = _material(Color(1.0, 0.58, 0.10), 0.25, false)
	eye_material.emission_enabled = true
	eye_material.emission = Color(1.0, 0.25, 0.02)
	eye_material.emission_energy_multiplier = 1.8

	_add_mesh(visual, CapsuleMesh.new(), Vector3(0.0, 1.15, 0.0), Vector3(0.72, 1.45, 0.72), skin_material, "Corpo")
	_add_mesh(visual, SphereMesh.new(), Vector3(0.0, 2.15, 0.0), Vector3(0.52, 0.52, 0.52), skin_material, "Cabeca")
	_add_mesh(visual, BoxMesh.new(), Vector3(-0.22, 2.15, -0.43), Vector3(0.15, 0.09, 0.05), eye_material, "OlhoEsquerdo")
	_add_mesh(visual, BoxMesh.new(), Vector3(0.22, 2.15, -0.43), Vector3(0.15, 0.09, 0.05), eye_material, "OlhoDireito")
	_add_mesh(visual, BoxMesh.new(), Vector3(0.0, 1.32, -0.36), Vector3(0.90, 0.95, 0.08), cloth_material, "FaixaCerimonial")
	_add_mesh(visual, CylinderMesh.new(), Vector3(0.0, 1.83, 0.0), Vector3(0.70, 0.12, 0.70), gold_material, "AroDourado")
	_add_mesh(visual, BoxMesh.new(), Vector3(0.62, 1.22, -0.1), Vector3(0.10, 0.10, 0.95), gold_material, "LaminaRitual")

	health_label = Label3D.new()
	health_label.name = "HealthLabel"
	health_label.position = Vector3(0.0, 3.05, 0.0)
	health_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	health_label.font_size = 36
	health_label.outline_size = 6
	health_label.modulate = Color(1.0, 0.72, 0.35)
	add_child(health_label)

func _add_mesh(parent: Node3D, primitive: PrimitiveMesh, position_value: Vector3, scale_value: Vector3, material: StandardMaterial3D, node_name: String) -> void:
	primitive.material = material
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.name = node_name
	mesh_instance.mesh = primitive
	mesh_instance.position = position_value
	mesh_instance.scale = scale_value
	parent.add_child(mesh_instance)

func _material(color: Color, roughness_value: float, metallic: bool) -> StandardMaterial3D:
	var result: StandardMaterial3D = StandardMaterial3D.new()
	result.albedo_color = color
	result.roughness = roughness_value
	result.metallic = 0.7 if metallic else 0.0
	return result

func _update_health_label() -> void:
	if health_label != null:
		health_label.text = "KHARU  %d / %d" % [current_health, max_health]

func _flash_damage() -> void:
	if visual == null:
		return
	var original_scale: Vector3 = visual.scale
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(visual, "scale", original_scale * 1.10, 0.08)
	tween.tween_property(visual, "scale", original_scale, 0.15)

func _animate_attack() -> void:
	if visual == null:
		return
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(visual, "rotation_degrees", Vector3(0.0, 0.0, 18.0), 0.10)
	tween.tween_property(visual, "rotation_degrees", Vector3.ZERO, 0.18)
