## EliteKharu.gd
## Sentinela Temporal do Cubo: encontro de elite para o pátio do Santuário da Nascente.

class_name EliteKharu
extends CharacterBody3D

enum State { DORMANT, ENGAGE, COMBAT, STAGGERED, RETURNING, DEAD }
enum AttackType { SLASH, REVERSE_SLASH, THRUST }

@export var max_health: int = 250
@export var max_posture: float = 100.0
@export var detection_range: float = 14.0
@export var attack_range: float = 3.35
@export var leash_range: float = 24.0

const MOVE_SPEED: float = 2.55
const STRAFE_SPEED: float = 1.35
const GRAVITY: float = 9.8
const STAGGER_DURATION: float = 1.50
const AURA_RANGE: float = 4.4
const AURA_TICK: float = 1.10

var current_health: int
var current_posture: float
var state: State = State.DORMANT
var home_position: Vector3
var player: Player
var visual: Node3D
var health_label: Label3D
var posture_label: Label3D
var attack_windup: float = 0.0
var attack_recovery: float = 0.0
var attack_cooldown: float = 0.0
var stagger_timer: float = 0.0
var aura_timer: float = 0.0
var combo_index: int = 0
var pending_attack: AttackType = AttackType.SLASH
var strafe_direction: float = 1.0
var announced: bool = false

func _ready() -> void:
	add_to_group("enemy")
	add_to_group("elite_kharu")
	current_health = max_health
	current_posture = max_posture
	home_position = global_position
	player = get_tree().get_first_node_in_group("player") as Player
	_create_visual()
	_update_labels()

func _physics_process(delta: float) -> void:
	if state == State.DEAD:
		return
	if player == null:
		player = get_tree().get_first_node_in_group("player") as Player
		return
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0.0

	attack_cooldown = maxf(attack_cooldown - delta, 0.0)
	aura_timer = maxf(aura_timer - delta, 0.0)
	var player_distance: float = global_position.distance_to(player.global_position)
	var home_distance: float = global_position.distance_to(home_position)

	match state:
		State.DORMANT:
			velocity.x = 0.0
			velocity.z = 0.0
			if player_distance <= detection_range:
				state = State.ENGAGE
				if not announced:
					announced = true
					EventBus.player_message_requested.emit("SENTINELA TEMPORAL: O Capitão Kharu ergue a lâmina bifacetada.", 2.2)
		State.ENGAGE:
			_face_target(player.global_position)
			if player_distance <= detection_range * 0.86:
				state = State.COMBAT
			elif player_distance > detection_range * 1.35:
				state = State.DORMANT
		State.COMBAT:
			if home_distance > leash_range or player_distance > leash_range:
				state = State.RETURNING
			else:
				_combat_loop(delta, player_distance)
		State.STAGGERED:
			stagger_timer = maxf(stagger_timer - delta, 0.0)
			velocity.x = 0.0
			velocity.z = 0.0
			if stagger_timer <= 0.0:
				current_posture = max_posture * 0.55
				state = State.COMBAT
		State.RETURNING:
			if global_position.distance_to(home_position) > 0.7:
				_move_towards(home_position, MOVE_SPEED * 1.20)
			else:
				state = State.DORMANT
				current_posture = minf(max_posture, current_posture + 35.0)
				_update_labels()

	move_and_slide()

func _combat_loop(delta: float, player_distance: float) -> void:
	_face_target(player.global_position)
	if player_distance <= AURA_RANGE and aura_timer <= 0.0:
		aura_timer = AURA_TICK
		player.apply_temporal_slow(0.65)
		EventBus.player_message_requested.emit("A aura temporal pesa sobre Elias.", 0.55)

	if attack_windup > 0.0:
		attack_windup = maxf(attack_windup - delta, 0.0)
		velocity.x = 0.0
		velocity.z = 0.0
		if attack_windup <= 0.0:
			_resolve_attack()
		return
	if attack_recovery > 0.0:
		attack_recovery = maxf(attack_recovery - delta, 0.0)
		velocity.x = 0.0
		velocity.z = 0.0
		return

	if player_distance > attack_range:
		_move_towards(player.global_position, MOVE_SPEED)
		return

	if attack_cooldown <= 0.0:
		_choose_attack()
		return

	# Desvio lateral curto entre golpes: obriga a reposicionamento em vez de troca frontal estática.
	var to_player: Vector3 = global_position.direction_to(player.global_position)
	var side: Vector3 = Vector3(-to_player.z, 0.0, to_player.x) * strafe_direction
	velocity.x = side.x * STRAFE_SPEED
	velocity.z = side.z * STRAFE_SPEED

func _choose_attack() -> void:
	combo_index = (combo_index + 1) % 3
	if combo_index == 2 and player.current_stamina < 42.0:
		pending_attack = AttackType.THRUST
		attack_windup = 0.52
		attack_recovery = 0.78
		attack_cooldown = 1.45
		_animate_thrust_windup()
		EventBus.player_message_requested.emit("O Sentinela prepara uma estocada temporal.", 0.75)
	else:
		pending_attack = AttackType.SLASH if combo_index == 0 else AttackType.REVERSE_SLASH
		attack_windup = 0.25
		attack_recovery = 0.44
		attack_cooldown = 0.82
		_animate_combo_windup(combo_index)

func _resolve_attack() -> void:
	if player == null:
		return
	var distance: float = global_position.distance_to(player.global_position)
	var damage: int = 22
	var reach: float = attack_range
	if pending_attack == AttackType.THRUST:
		damage = 38
		reach = attack_range + 1.15
		_straight_lunge()
	if distance <= reach:
		player.take_damage(damage, global_position)
	if pending_attack == AttackType.THRUST:
		strafe_direction *= -1.0
	_animate_attack_release()

func take_damage(amount: int, attacker_position: Vector3 = Vector3.ZERO) -> void:
	if state == State.DEAD:
		return
	current_health = clampi(current_health - amount, 0, max_health)
	current_posture = maxf(0.0, current_posture - float(amount) * 1.30)
	state = State.COMBAT
	_face_target(attacker_position)
	_flash_damage()
	if current_posture <= 0.0 and current_health > 0:
		state = State.STAGGERED
		stagger_timer = STAGGER_DURATION
		EventBus.player_message_requested.emit("A postura do Sentinela quebrou. Ataca enquanto ele vacila.", 1.6)
	if current_health <= 0:
		_die()
	_update_labels()

func _die() -> void:
	state = State.DEAD
	remove_from_group("enemy")
	remove_from_group("elite_kharu")
	EventBus.world_event_triggered.emit("captain_kharu_defeated")
	EventBus.player_message_requested.emit("O Capitão Kharu desaba e o selo da masmorra perde a força.", 2.4)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector3(0.03, 0.03, 0.03), 0.85)
	tween.tween_callback(queue_free)

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

func _straight_lunge() -> void:
	if player == null:
		return
	var direction: Vector3 = global_position.direction_to(player.global_position)
	velocity.x = direction.x * 7.5
	velocity.z = direction.z * 7.5

func _create_visual() -> void:
	visual = Node3D.new()
	visual.name = "SentinelVisual"
	add_child(visual)
	var armor: StandardMaterial3D = _material(Color(0.08, 0.10, 0.12), 0.28, true)
	var armor_light: StandardMaterial3D = _material(Color(0.16, 0.18, 0.19), 0.42, true)
	var cloth: StandardMaterial3D = _material(Color(0.18, 0.10, 0.06), 0.92, false)
	var gold: StandardMaterial3D = _material(Color(0.43, 0.28, 0.08), 0.34, true)
	var amber: StandardMaterial3D = _material(Color(0.66, 0.25, 0.04), 0.22, false)
	amber.emission_enabled = true
	amber.emission = Color(0.46, 0.08, 0.01)
	amber.emission_energy_multiplier = 1.1
	_add_mesh(visual, CapsuleMesh.new(), Vector3(0.0, 1.42, 0.0), Vector3(0.96, 1.75, 0.96), armor, "ArmaduraMonolitica")
	_add_mesh(visual, SphereMesh.new(), Vector3(0.0, 2.70, 0.0), Vector3(0.60, 0.60, 0.60), armor_light, "Elmo")
	_add_mesh(visual, BoxMesh.new(), Vector3(-0.24, 2.70, -0.50), Vector3(0.17, 0.11, 0.05), amber, "OlhoEsquerdo")
	_add_mesh(visual, BoxMesh.new(), Vector3(0.24, 2.70, -0.50), Vector3(0.17, 0.11, 0.05), amber, "OlhoDireito")
	for segment: int in range(4):
		_add_mesh(visual, BoxMesh.new(), Vector3(0.0, 1.10 + float(segment) * 0.36, -0.50), Vector3(1.00 - float(segment) * 0.08, 0.18, 0.12), gold, "InscricaoDourada")
	_add_mesh(visual, BoxMesh.new(), Vector3(0.0, 0.95, -0.56), Vector3(1.10, 1.25, 0.10), cloth, "MantoCerimonial")
	# Lança bifacetada: haste, lâminas e energia âmbar instável.
	_add_mesh(visual, CylinderMesh.new(), Vector3(0.92, 1.65, -0.12), Vector3(0.10, 2.85, 0.10), armor_light, "HasteTemporal")
	_add_mesh(visual, BoxMesh.new(), Vector3(0.92, 3.18, -0.12), Vector3(0.28, 0.80, 0.12), gold, "LaminaSuperior")
	_add_mesh(visual, BoxMesh.new(), Vector3(0.92, 0.24, -0.12), Vector3(0.24, 0.62, 0.10), gold, "LaminaInferior")

	health_label = Label3D.new()
	health_label.name = "HealthLabel"
	health_label.position = Vector3(0.0, 3.78, 0.0)
	health_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	health_label.font_size = 38
	health_label.outline_size = 7
	health_label.modulate = Color(0.92, 0.54, 0.20)
	add_child(health_label)
	posture_label = Label3D.new()
	posture_label.name = "PostureLabel"
	posture_label.position = Vector3(0.0, 3.48, 0.0)
	posture_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	posture_label.font_size = 23
	posture_label.outline_size = 5
	posture_label.modulate = Color(0.55, 0.71, 0.86)
	add_child(posture_label)

func _add_mesh(parent: Node3D, primitive: PrimitiveMesh, position_value: Vector3, scale_value: Vector3, material: StandardMaterial3D, node_name: String) -> void:
	primitive.material = material
	var instance: MeshInstance3D = MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = primitive
	instance.position = position_value
	instance.scale = scale_value
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(instance)

func _material(color: Color, roughness_value: float, metallic_value: bool) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness_value
	material.metallic = 0.76 if metallic_value else 0.0
	return material

func _update_labels() -> void:
	if health_label != null:
		health_label.text = "SENTINELA KHARU  %d / %d" % [current_health, max_health]
	if posture_label != null:
		posture_label.text = "POSTURA  %d / %d" % [roundi(current_posture), roundi(max_posture)]

func _flash_damage() -> void:
	if visual == null:
		return
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(visual, "scale", Vector3(1.10, 0.95, 1.10), 0.08)
	tween.tween_property(visual, "scale", Vector3.ONE, 0.16)

func _animate_combo_windup(index: int) -> void:
	if visual == null:
		return
	var sign_value: float = 1.0 if index == 0 else -1.0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(visual, "rotation_degrees", Vector3(0.0, 0.0, 22.0 * sign_value), 0.12)
	tween.tween_property(visual, "rotation_degrees", Vector3.ZERO, 0.28)

func _animate_thrust_windup() -> void:
	if visual == null:
		return
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(visual, "rotation_degrees", Vector3(-12.0, 0.0, 0.0), 0.22)
	tween.tween_property(visual, "rotation_degrees", Vector3.ZERO, 0.40)

func _animate_attack_release() -> void:
	if visual == null:
		return
	visual.rotation_degrees = Vector3.ZERO
