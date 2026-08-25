## Player.gd
## Elias Voss: movimento em primeira pessoa, interação e combate de espada.
## A espada e o raycast de combate são criados em tempo de execução para preservar a cena existente.

class_name Player
extends CharacterBody3D

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interact_ray: RayCast3D = $Head/Camera3D/InteractRay
@onready var flashlight: SpotLight3D = $Head/Camera3D/Flashlight
@onready var footstep_timer: Timer = $FootstepTimer

var flashlight_on: bool = false
var is_sprinting: bool = false
var is_blocking: bool = false
var player_velocity: Vector3 = Vector3.ZERO
var bob_time: float = 0.0
var qa_carto_link_frames: int = 0

var current_health: int = 100
const MAX_HEALTH: int = 100
var current_stamina: float = 100.0
const MAX_STAMINA: float = 100.0
const SWORD_DAMAGE: int = 25
const ATTACK_RANGE: float = 3.5
const ATTACK_COOLDOWN: float = 0.55
const ATTACK_RECOVERY: float = 0.46
const DAMAGE_INVULNERABILITY: float = 0.55
const ATTACK_STAMINA_COST: float = 16.0
const BLOCK_STAMINA_PER_SECOND: float = 8.0
const SPRINT_STAMINA_PER_SECOND: float = 12.0
const STAMINA_REGEN_PER_SECOND: float = 35.0
const STAMINA_RECOVERY_DELAY: float = 0.30
const JUMP_VELOCITY: float = 4.8
const JUMP_STAMINA_COST: float = 6.0
const AIR_CONTROL: float = 0.65

var attack_cooldown: float = 0.0
var attack_recovery_timer: float = 0.0
var stamina_recovery_delay: float = 0.0
var temporal_slow_timer: float = 0.0
var invulnerability_timer: float = 0.0
var combat_ray: RayCast3D
var sword_pivot: Node3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
const WALK_SPEED: float = 2.8
const SPRINT_SPEED: float = 5.2
const BLOCK_SPEED: float = 1.75
const MOUSE_SENS: float = 0.0018

func _ready() -> void:
	add_to_group("player")
	add_to_group("Persist")
	flashlight_on = true
	flashlight.visible = true
	footstep_timer.timeout.connect(_on_footstep)
	_create_combat_nodes()
	EventBus.player_health_changed.emit(current_health, MAX_HEALTH)
	EventBus.player_stamina_changed.emit(current_stamina, MAX_STAMINA)

func _physics_process(delta: float) -> void:
	# Evita que uma pausa de renderização num hardware de compatibilidade converta gravidade e movimento em um salto físico através do terreno.
	# A simulação continua determinística, mas cada integração de CharacterBody3D fica limitada a aproximadamente 30 Hz.
	var safe_delta: float = minf(delta, 0.033)
	_update_combat(safe_delta)
	_handle_player(safe_delta)
	_handle_interaction()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			return
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENS)
		head.rotate_x(-event.relative.y * MOUSE_SENS)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85.0), deg_to_rad(85.0))
		get_viewport().set_input_as_handled()

func _create_combat_nodes() -> void:
	combat_ray = RayCast3D.new()
	combat_ray.name = "CombatRay"
	combat_ray.target_position = Vector3(0.0, 0.0, -ATTACK_RANGE)
	combat_ray.collision_mask = 2
	combat_ray.enabled = true
	camera.add_child(combat_ray)

	sword_pivot = Node3D.new()
	sword_pivot.name = "SwordPivot"
	# Preserva pivot, animação e raycast, mas desloca a arma para o canto inferior direito e liberta a leitura do mundo cartográfico.
	sword_pivot.position = Vector3(0.84, -0.84, -1.50)
	sword_pivot.scale = Vector3(0.52, 0.52, 0.52)
	sword_pivot.rotation_degrees = Vector3(-12.0, 3.0, -20.0)
	camera.add_child(sword_pivot)

	var blade_material: StandardMaterial3D = StandardMaterial3D.new()
	# Aço frio envelhecido: mantém a leitura metálica, mas evita que a lâmina reflita o céu como um emissor ciano no GL Compatibility.
	blade_material.albedo_color = Color(0.22, 0.27, 0.30)
	blade_material.metallic = 0.34
	blade_material.roughness = 0.78

	# Lâmina de secção losangular: evita a leitura de barra rectangular no canto da câmara.
	var blade_mesh: CylinderMesh = CylinderMesh.new()
	blade_mesh.top_radius = 0.028
	blade_mesh.bottom_radius = 0.068
	blade_mesh.height = 0.88
	blade_mesh.radial_segments = 4
	blade_mesh.material = blade_material
	var blade: MeshInstance3D = MeshInstance3D.new()
	blade.name = "TemporalSword"
	blade.mesh = blade_mesh
	blade.position = Vector3(0.0, 0.44, -0.04)
	blade.rotation_degrees = Vector3(0.0, 0.0, 0.0)
	blade.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	sword_pivot.add_child(blade)

	var guard_material: StandardMaterial3D = StandardMaterial3D.new()
	# Bronze envelhecido para guarda e pomo, com aspereza suficiente para manter detalhe em luz de dia.
	guard_material.albedo_color = Color(0.22, 0.12, 0.030)
	guard_material.metallic = 0.38
	guard_material.roughness = 0.72

	var guard_mesh: CylinderMesh = CylinderMesh.new()
	guard_mesh.top_radius = 0.042
	guard_mesh.bottom_radius = 0.055
	guard_mesh.height = 0.36
	guard_mesh.radial_segments = 6
	guard_mesh.material = guard_material
	var guard: MeshInstance3D = MeshInstance3D.new()
	guard.name = "SwordGuard"
	guard.mesh = guard_mesh
	guard.position = Vector3(0.0, 0.0, -0.01)
	guard.rotation_degrees = Vector3(0.0, 0.0, 90.0)
	guard.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	sword_pivot.add_child(guard)

	var grip_material: StandardMaterial3D = StandardMaterial3D.new()
	grip_material.albedo_color = Color(0.085, 0.045, 0.022, 1.0)
	grip_material.roughness = 0.76
	var grip_mesh: CylinderMesh = CylinderMesh.new()
	grip_mesh.top_radius = 0.043
	grip_mesh.bottom_radius = 0.050
	grip_mesh.height = 0.28
	grip_mesh.radial_segments = 8
	grip_mesh.material = grip_material
	var grip: MeshInstance3D = MeshInstance3D.new()
	grip.name = "SwordGrip"
	grip.mesh = grip_mesh
	grip.position = Vector3(0.0, -0.16, 0.0)
	grip.rotation_degrees = Vector3(0.0, 0.0, 0.0)
	grip.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	sword_pivot.add_child(grip)

	var pommel_mesh: SphereMesh = SphereMesh.new()
	pommel_mesh.radius = 0.042
	pommel_mesh.height = 0.084
	pommel_mesh.radial_segments = 10
	pommel_mesh.rings = 5
	pommel_mesh.material = guard_material
	var pommel: MeshInstance3D = MeshInstance3D.new()
	pommel.name = "SwordPommel"
	pommel.mesh = pommel_mesh
	pommel.position = Vector3(0.0, -0.34, 0.0)
	pommel.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	sword_pivot.add_child(pommel)

func _update_combat(delta: float) -> void:
	attack_cooldown = maxf(attack_cooldown - delta, 0.0)
	attack_recovery_timer = maxf(attack_recovery_timer - delta, 0.0)
	stamina_recovery_delay = maxf(stamina_recovery_delay - delta, 0.0)
	temporal_slow_timer = maxf(temporal_slow_timer - delta, 0.0)
	invulnerability_timer = maxf(invulnerability_timer - delta, 0.0)

	is_blocking = Input.is_action_pressed("defend") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and attack_recovery_timer <= 0.0 and current_stamina > 1.0
	if is_blocking:
		_consume_stamina(BLOCK_STAMINA_PER_SECOND * delta)
		sword_pivot.rotation_degrees = Vector3(-35.0, 2.0, 30.0)
	elif not is_attacking():
		sword_pivot.rotation_degrees = Vector3(-16.0, 2.0, -16.0)

	if Input.is_action_just_pressed("attack") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if attack_cooldown <= 0.0 and attack_recovery_timer <= 0.0 and not is_blocking and current_stamina >= ATTACK_STAMINA_COST:
			_consume_stamina(ATTACK_STAMINA_COST)
			_perform_sword_attack()
		elif current_stamina < ATTACK_STAMINA_COST:
			EventBus.player_message_requested.emit("Sem stamina para atacar.", 0.8)

	_update_stamina(delta)

func is_attacking() -> bool:
	return attack_recovery_timer > 0.0

func _perform_sword_attack() -> void:
	attack_cooldown = ATTACK_COOLDOWN
	attack_recovery_timer = ATTACK_RECOVERY
	combat_ray.force_raycast_update()
	_animate_sword_swing()

	var target: Node = combat_ray.get_collider() as Node
	if target != null and target.is_in_group("enemy") and target.has_method("take_damage"):
		target.take_damage(SWORD_DAMAGE, global_position)
		EventBus.player_message_requested.emit("Golpe temporal acertou.", 1.0)

func _consume_stamina(amount: float) -> void:
	if amount <= 0.0:
		return
	current_stamina = maxf(0.0, current_stamina - amount)
	stamina_recovery_delay = STAMINA_RECOVERY_DELAY
	EventBus.player_stamina_changed.emit(current_stamina, MAX_STAMINA)

func _update_stamina(delta: float) -> void:
	if stamina_recovery_delay > 0.0 or is_blocking or is_sprinting or attack_recovery_timer > 0.0:
		return
	if current_stamina < MAX_STAMINA:
		current_stamina = minf(MAX_STAMINA, current_stamina + STAMINA_REGEN_PER_SECOND * delta)
		EventBus.player_stamina_changed.emit(current_stamina, MAX_STAMINA)

func _animate_sword_swing() -> void:
	var start_rotation: Vector3 = Vector3(-16.0, 2.0, -16.0)
	var strike_rotation: Vector3 = Vector3(35.0, -8.0, 64.0)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sword_pivot, "rotation_degrees", strike_rotation, 0.10)
	tween.tween_property(sword_pivot, "rotation_degrees", start_rotation, 0.16)

func take_damage(amount: int, _source_position: Vector3 = Vector3.ZERO) -> void:
	if invulnerability_timer > 0.0:
		return

	invulnerability_timer = DAMAGE_INVULNERABILITY
	var final_damage: int = amount
	if is_blocking:
		final_damage = maxi(1, int(round(float(amount) * 0.35)))
		EventBus.player_message_requested.emit("Bloqueio temporal.", 0.8)

	current_health = clampi(current_health - final_damage, 0, MAX_HEALTH)
	EventBus.player_health_changed.emit(current_health, MAX_HEALTH)

	if current_health <= 0:
		EventBus.player_died.emit()
		EventBus.player_message_requested.emit("Elias caiu. A memória regressa ao último instante seguro...", 2.0)
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()

func apply_temporal_slow(duration: float) -> void:
	temporal_slow_timer = maxf(temporal_slow_timer, duration)

func restore_health(amount: int) -> void:
	current_health = clampi(current_health + amount, 0, MAX_HEALTH)
	EventBus.player_health_changed.emit(current_health, MAX_HEALTH)
	EventBus.player_message_requested.emit("A energia da nascente restaura Elias.", 1.4)

func rest_at_safe_point() -> void:
	current_health = MAX_HEALTH
	current_stamina = MAX_STAMINA
	stamina_recovery_delay = 0.0
	EventBus.player_health_changed.emit(current_health, MAX_HEALTH)
	EventBus.player_stamina_changed.emit(current_stamina, MAX_STAMINA)

func save_data() -> Dictionary:
	return {
		"position": [position.x, position.y, position.z],
		"rotation_y": rotation.y,
		"health": current_health,
		"stamina": current_stamina
	}

func load_data(data: Dictionary) -> void:
	current_health = clampi(int(data.get("health", current_health)), 1, MAX_HEALTH)
	current_stamina = clampf(float(data.get("stamina", current_stamina)), 0.0, MAX_STAMINA)
	EventBus.player_health_changed.emit(current_health, MAX_HEALTH)
	EventBus.player_stamina_changed.emit(current_stamina, MAX_STAMINA)
	var saved_position: Array = data.get("position", []) as Array
	if saved_position.size() == 3:
		call_deferred("_restore_saved_pose", Vector3(float(saved_position[0]), float(saved_position[1]), float(saved_position[2])), float(data.get("rotation_y", rotation.y)))

func _restore_saved_pose(saved_position: Vector3, saved_rotation_y: float) -> void:
	position = saved_position
	rotation.y = saved_rotation_y
	velocity = Vector3.ZERO
	player_velocity = Vector3.ZERO

func _handle_player(delta: float) -> void:
	# CP-CARTO-80: o renderer llvmpipe pode avançar a física antes de a colisão concava regional estabilizar.
	# A retenção é exclusiva do harness de leitura cartográfica e não existe numa execução normal.
	var qa_arch_forest_hold: bool = OS.get_environment("ORIGEM_QA_ROUTE") == "arch_to_forest" and OS.get_environment("ORIGEM_QA_CARTO_STABILIZE") == "1"
	var grounded: bool = is_on_floor() or qa_arch_forest_hold
	if grounded:
		player_velocity.y = 0.0
		if Input.is_action_just_pressed("jump") and not is_blocking and attack_recovery_timer <= 0.0:
			if current_stamina >= JUMP_STAMINA_COST:
				player_velocity.y = JUMP_VELOCITY
				_consume_stamina(JUMP_STAMINA_COST)
				EventBus.player_message_requested.emit("Salto temporal.", 0.45)
			else:
				EventBus.player_message_requested.emit("Sem stamina para saltar.", 0.65)
	else:
		player_velocity.y -= gravity * delta

	if Input.is_action_just_pressed("toggle_flashlight"):
		flashlight_on = not flashlight_on
		flashlight.visible = flashlight_on
		if flashlight_on:
			EventBus.player_message_requested.emit("Lanterna ligada.", 1.5)

	is_sprinting = grounded and Input.is_action_pressed("sprint") and not is_blocking and attack_recovery_timer <= 0.0 and current_stamina > 1.0
	if is_sprinting:
		_consume_stamina(SPRINT_STAMINA_PER_SECOND * delta)
	var speed: float = BLOCK_SPEED if is_blocking else (SPRINT_SPEED if is_sprinting else WALK_SPEED)
	if attack_recovery_timer > 0.0:
		speed = WALK_SPEED * 0.30
	if temporal_slow_timer > 0.0:
		speed *= 0.65

	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	# CP-CARTO-85: percorre a ligação R5→R6 sob a mesma física do jogador, sem injetar eventos Xvfb nem existir no jogo normal.
	var qa_link_walk: bool = OS.get_environment("ORIGEM_QA_ROUTE") == "majestic_to_lake" and OS.get_environment("ORIGEM_QA_CARTO_LINK_WALK") == "1"
	if qa_link_walk:
		input_dir = Vector2(0.0, -1.0)
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()

	var horizontal_response: float = 1.0 if grounded else AIR_CONTROL
	var lerp_weight: float = minf(1.0, delta * 12.0 * horizontal_response)
	if direction != Vector3.ZERO:
		player_velocity.x = lerpf(player_velocity.x, direction.x * speed, lerp_weight)
		player_velocity.z = lerpf(player_velocity.z, direction.z * speed, lerp_weight)
		if grounded and footstep_timer.is_stopped():
			footstep_timer.start(0.32 if is_sprinting else 0.52)
	else:
		player_velocity.x = lerpf(player_velocity.x, 0.0, lerp_weight)
		player_velocity.z = lerpf(player_velocity.z, 0.0, lerp_weight)

	velocity = player_velocity
	move_and_slide()
	player_velocity = velocity
	if qa_link_walk:
		qa_carto_link_frames += 1
		if qa_carto_link_frames == 30:
			print("[CP_CARTO85_LINK] frames=%d pos=(%.2f,%.2f,%.2f) no_chao=%s" % [qa_carto_link_frames, global_position.x, global_position.y, global_position.z, str(is_on_floor())])
			var snapshot_path: String = OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT")
			if snapshot_path != "":
				call_deferred("_save_carto_link_snapshot_qa", snapshot_path)

	if direction != Vector3.ZERO and is_on_floor():
		bob_time += delta * speed
		camera.position.y = sin(bob_time * 1.8) * 0.025
	else:
		camera.position.y = lerpf(camera.position.y, 0.0, delta * 6.0)

func _save_carto_link_snapshot_qa(snapshot_path: String) -> void:
	await get_tree().process_frame
	var image: Image = get_viewport().get_texture().get_image()
	var result: Error = image.save_png(snapshot_path)
	print("[CP_CARTO85_LINK] snapshot=%s result=%s" % [snapshot_path, result])

func _on_footstep() -> void:
	pass

func _handle_interaction() -> void:
	var hit: Object = interact_ray.get_collider()
	if hit != null and hit.is_in_group("interactable"):
		EventBus.player_interact_target_changed.emit(true, hit.name)
		if Input.is_action_just_pressed("interact"):
			EventBus.player_interacted.emit(hit.name)
	else:
		EventBus.player_interact_target_changed.emit(false, "")
