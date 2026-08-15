## SanctuaryInterior.gd
## Primeiro bloco jogável do interior: pedra ciclópica, água estagnada, perigos temporais e Câmara do Cubo.

extends Node3D

var player: Player
var entrance_seal: StaticBody3D
var resonance_bridge: Node3D
var bridge_active: bool = false
var captain_defeated: bool = false
var pulse_time: float = 0.0
var cube_core: MeshInstance3D
var pbr_normal_map: ImageTexture

var stone: StandardMaterial3D
var stone_dark: StandardMaterial3D
var stone_wet: StandardMaterial3D
var metal: StandardMaterial3D
var blue_fire: StandardMaterial3D
var water: StandardMaterial3D
var hazard: StandardMaterial3D
var resonance_particle_material: StandardMaterial3D

func _ready() -> void:
	add_to_group("sanctuary_interior")
	player = get_tree().get_first_node_in_group("player") as Player
	_create_materials()
	_build_entrance()
	_build_corridor()
	call_deferred("_open_entrance_for_exploration")
	_build_well_hall()
	_build_resonance_crossing()
	_build_cube_chamber()
	EventBus.world_event_triggered.connect(_on_world_event)

func _process(delta: float) -> void:
	pulse_time += delta
	if cube_core != null:
		cube_core.rotation.y += delta * 0.42
		cube_core.position.y = 3.10 + sin(pulse_time * 1.35) * 0.14

func _on_world_event(event_id: String) -> void:
	if event_id == "captain_kharu_defeated":
		captain_defeated = true
		TimelineManager.trigger_event("captain_kharu_defeated")
		_unlock_entrance()

func _create_materials() -> void:
	_create_pbr_normal_map()
	stone = _material(Color(0.28, 0.30, 0.28), 0.90, 0.0)
	stone_dark = _material(Color(0.15, 0.18, 0.18), 0.94, 0.0)
	stone_wet = _material(Color(0.16, 0.23, 0.23), 0.68, 0.05)
	metal = _material(Color(0.18, 0.24, 0.28), 0.36, 0.80)
	blue_fire = _material(Color(0.17, 0.42, 0.70), 0.26, 0.25)
	blue_fire.emission_enabled = true
	blue_fire.emission = Color(0.015, 0.12, 0.50)
	blue_fire.emission_energy_multiplier = 0.82
	# Água escura opaca: permite SSR e probes refletirem o interior; a ondulação vem da luz e das partículas.
	water = _material(Color(0.018, 0.050, 0.075), 0.14, 0.42)
	hazard = _material(Color(0.18, 0.08, 0.28), 0.30, 0.20)
	hazard.emission_enabled = true
	hazard.emission = Color(0.22, 0.02, 0.42)
	hazard.emission_energy_multiplier = 0.65
	resonance_particle_material = StandardMaterial3D.new()
	resonance_particle_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	resonance_particle_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	resonance_particle_material.albedo_color = Color(0.22, 0.56, 1.0, 0.72)
	resonance_particle_material.emission_enabled = true
	resonance_particle_material.emission = Color(0.03, 0.20, 0.85)
	resonance_particle_material.emission_energy_multiplier = 1.25
	resonance_particle_material.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED

func _build_entrance() -> void:
	var entrance: Node3D = Node3D.new()
	entrance.name = "EntradaSubmersa"
	add_child(entrance)
	_add_solid_box(entrance, Vector3(0.0, 0.20, -10.5), Vector3(8.0, 0.40, 7.0), stone_wet, "PisoDaEntrada")
	_add_mesh_box(entrance, Vector3(-4.2, 2.4, -10.5), Vector3(0.6, 4.8, 7.0), stone_dark, "ParedeEsquerda")
	_add_mesh_box(entrance, Vector3(4.2, 2.4, -10.5), Vector3(0.6, 4.8, 7.0), stone_dark, "ParedeDireita")
	_add_mesh_box(entrance, Vector3(0.0, 4.8, -10.5), Vector3(8.8, 0.50, 7.0), stone_dark, "TectoDaEntrada")

	entrance_seal = StaticBody3D.new()
	entrance_seal.name = "InteriorGate"
	entrance_seal.add_to_group("interactable")
	entrance_seal.collision_layer = 4
	entrance_seal.position = Vector3(0.0, 0.30, -7.95)
	add_child(entrance_seal)
	var door_mesh: BoxMesh = BoxMesh.new()
	door_mesh.size = Vector3(3.4, 3.8, 0.45)
	door_mesh.material = metal
	var door: MeshInstance3D = MeshInstance3D.new()
	door.name = "SeloDaMasmorra"
	door.mesh = door_mesh
	door.position.y = 1.9
	entrance_seal.add_child(door)
	var rune_mesh: BoxMesh = _box_mesh(Vector3(1.3, 1.8, 0.04), blue_fire)
	var rune: MeshInstance3D = MeshInstance3D.new()
	rune.name = "RunaDoSelo"
	rune.mesh = rune_mesh
	rune.position = Vector3(0.0, 1.9, -0.25)
	entrance_seal.add_child(rune)
	var shape: CollisionShape3D = CollisionShape3D.new()
	var box: BoxShape3D = BoxShape3D.new()
	box.size = Vector3(3.4, 3.8, 0.50)
	shape.shape = box
	shape.position.y = 1.9
	entrance_seal.add_child(shape)

func _open_entrance_for_exploration() -> void:
	# O início deve ser solitário: o selo já está quebrado quando Elias chega ao vale.
	if entrance_seal != null and is_instance_valid(entrance_seal):
		entrance_seal.queue_free()
		entrance_seal = null

func _unlock_entrance() -> void:
	EventBus.player_message_requested.emit("A morte do Sentinela reverbera pela câmara. O Cubo de Orion fica exposto.", 2.6)

func try_enter_interior() -> void:
	EventBus.player_message_requested.emit("A câmara respira ar frio. O Sentinela aguarda junto ao altar do Cubo.", 1.8)

func _build_corridor() -> void:
	var corridor: Node3D = Node3D.new()
	corridor.name = "CorredorCiclope"
	add_child(corridor)
	_add_solid_box(corridor, Vector3(0.0, 0.15, -19.5), Vector3(8.0, 0.30, 12.5), stone_wet, "PisoDoCorredor")
	_add_mesh_box(corridor, Vector3(-4.2, 2.65, -19.5), Vector3(0.55, 5.3, 12.5), stone_dark, "ParedeOeste")
	_add_mesh_box(corridor, Vector3(4.2, 2.65, -19.5), Vector3(0.55, 5.3, 12.5), stone_dark, "ParedeEste")
	_add_mesh_box(corridor, Vector3(0.0, 5.35, -19.5), Vector3(8.8, 0.46, 12.5), stone_dark, "TectoDoCorredor")
	for z_value: float in [-15.0, -21.5]:
		_add_pillar(corridor, Vector3(-3.2, 0.30, z_value), 4.4)
		_add_pillar(corridor, Vector3(3.2, 0.30, z_value), 4.4)
		_add_brazier(corridor, Vector3(-2.8, 1.4, z_value + 0.8))

func _build_well_hall() -> void:
	var hall: Node3D = Node3D.new()
	hall.name = "SalaDosPocos"
	add_child(hall)
	_add_solid_box(hall, Vector3(0.0, 0.10, -31.5), Vector3(17.0, 0.30, 12.0), stone, "PisoDaSalaDosPocos")
	for x_value: float in [-8.7, 8.7]:
		_add_mesh_box(hall, Vector3(x_value, 3.0, -31.5), Vector3(0.55, 6.0, 12.0), stone_dark, "ParedeDaSala")
	_add_mesh_box(hall, Vector3(0.0, 6.05, -31.5), Vector3(18.0, 0.50, 12.0), stone_dark, "TectoDaSala")
	# Água estagnada lateral, delimitada por lajes seguras no centro.
	for x_value: float in [-4.9, 4.9]:
		var pool: MeshInstance3D = MeshInstance3D.new()
		var plane: PlaneMesh = PlaneMesh.new()
		plane.size = Vector2(4.2, 8.8)
		plane.material = water
		pool.mesh = plane
		pool.position = Vector3(x_value, 0.30, -31.5)
		hall.add_child(pool)
		_add_temporal_well(hall, Vector3(x_value, 0.50, -31.5), "PocoTemporal")
	_add_reflection_probe(hall, Vector3(0.0, 2.4, -31.5), Vector3(15.0, 5.5, 11.0))
	for z_value: float in [-27.4, -31.5, -35.6]:
		_add_solid_box(hall, Vector3(0.0, 0.35, z_value), Vector3(4.0, 0.45, 2.4), stone_wet, "IlhaSegura")
		_add_brazier(hall, Vector3(-2.4, 1.35, z_value))
		_add_brazier(hall, Vector3(2.4, 1.35, z_value))

func _build_resonance_crossing() -> void:
	var crossing: Node3D = Node3D.new()
	crossing.name = "TravessiaDaRessonancia"
	add_child(crossing)
	_add_solid_box(crossing, Vector3(0.0, 0.15, -39.5), Vector3(8.0, 0.30, 5.8), stone_dark, "AbismoDaRessonancia")
	var switch_body: StaticBody3D = StaticBody3D.new()
	switch_body.name = "InteriorResonanceSwitch"
	switch_body.add_to_group("interactable")
	switch_body.collision_layer = 4
	switch_body.position = Vector3(-2.6, 0.5, -36.0)
	crossing.add_child(switch_body)
	var switch_mesh: CylinderMesh = CylinderMesh.new()
	switch_mesh.top_radius = 0.55
	switch_mesh.bottom_radius = 0.85
	switch_mesh.height = 1.0
	switch_mesh.material = blue_fire
	var switch_visual: MeshInstance3D = MeshInstance3D.new()
	switch_visual.mesh = switch_mesh
	switch_visual.position.y = 0.5
	switch_body.add_child(switch_visual)
	var switch_shape: CollisionShape3D = CollisionShape3D.new()
	var capsule: CapsuleShape3D = CapsuleShape3D.new()
	capsule.radius = 0.90
	capsule.height = 2.4
	switch_shape.shape = capsule
	switch_shape.position.y = 0.9
	switch_body.add_child(switch_shape)

	resonance_bridge = Node3D.new()
	resonance_bridge.name = "PonteDeRessonancia"
	resonance_bridge.visible = false
	crossing.add_child(resonance_bridge)
	for index: int in range(5):
		_add_solid_box(resonance_bridge, Vector3(0.0, 0.34, -37.3 - float(index) * 1.35), Vector3(3.2, 0.35, 1.55), stone_wet, "PlataformaMovel")
	_add_resonance_particles(crossing, Vector3(0.0, 1.35, -39.4), Vector3(2.0, 1.4, 3.8), 36, "ParticulasDaPonte")

func activate_resonance_bridge() -> void:
	if bridge_active:
		EventBus.player_message_requested.emit("A ponte de ressonância já vibra sobre o vazio.", 1.6)
		return
	bridge_active = true
	resonance_bridge.visible = true
	EventBus.player_message_requested.emit("A ressonância estabiliza as plataformas. O caminho para o Cubo abriu-se.", 2.8)

func _build_cube_chamber() -> void:
	var chamber: Node3D = Node3D.new()
	chamber.name = "CamaraDoCubo"
	add_child(chamber)
	_add_solid_box(chamber, Vector3(0.0, 0.12, -49.5), Vector3(15.0, 0.32, 13.0), stone, "PisoDaCamara")
	for x_value: float in [-7.7, 7.7]:
		_add_mesh_box(chamber, Vector3(x_value, 4.0, -49.5), Vector3(0.65, 8.0, 13.0), stone_dark, "ParedeDaCamara")
	_add_mesh_box(chamber, Vector3(0.0, 8.15, -49.5), Vector3(16.0, 0.50, 13.0), stone_dark, "TectoDaCamara")
	for position_value: Vector3 in [Vector3(-5.1, 0.30, -45.3), Vector3(5.1, 0.30, -45.3), Vector3(-5.1, 0.30, -53.7), Vector3(5.1, 0.30, -53.7)]:
		_add_pillar(chamber, position_value, 6.4)
		_add_brazier(chamber, position_value + Vector3(0.0, 1.35, 0.45))
	_add_reflection_probe(chamber, Vector3(0.0, 3.0, -49.5), Vector3(13.5, 7.0, 11.5))
	_add_solid_box(chamber, Vector3(0.0, 0.88, -49.5), Vector3(3.2, 1.50, 3.2), metal, "PedestalDoCubo")
	var cube_mesh: BoxMesh = BoxMesh.new()
	cube_mesh.size = Vector3(1.35, 1.35, 1.35)
	cube_mesh.material = blue_fire
	cube_core = MeshInstance3D.new()
	cube_core.name = "CuboDeOrionInterior"
	cube_core.mesh = cube_mesh
	cube_core.position = Vector3(0.0, 3.10, -49.5)
	chamber.add_child(cube_core)
	_add_resonance_particles(chamber, Vector3(0.0, 3.2, -49.5), Vector3(4.4, 2.4, 4.4), 68, "ParticulasDoCubo")
	var lore: StaticBody3D = StaticBody3D.new()
	lore.name = "InnerOrionSeal"
	lore.add_to_group("interactable")
	lore.collision_layer = 4
	lore.position = Vector3(0.0, 1.60, -49.5)
	chamber.add_child(lore)
	var lore_shape: CollisionShape3D = CollisionShape3D.new()
	var lore_box: BoxShape3D = BoxShape3D.new()
	lore_box.size = Vector3(2.6, 2.8, 2.6)
	lore_shape.shape = lore_box
	lore_shape.position.y = 1.4
	lore.add_child(lore_shape)
	_build_chronos_console(chamber)

func _build_chronos_console(parent: Node3D) -> void:
	var console: StaticBody3D = StaticBody3D.new()
	console.name = "ChronosPrototypeConsole"
	console.add_to_group("interactable")
	console.collision_layer = 4
	console.position = Vector3(3.45, 0.30, -49.5)
	parent.add_child(console)
	var base_mesh: CylinderMesh = CylinderMesh.new()
	base_mesh.top_radius = 0.42
	base_mesh.bottom_radius = 0.70
	base_mesh.height = 1.15
	base_mesh.material = metal
	var base: MeshInstance3D = MeshInstance3D.new()
	base.mesh = base_mesh
	base.position.y = 0.58
	console.add_child(base)
	var core_mesh: SphereMesh = SphereMesh.new()
	core_mesh.radius = 0.26
	core_mesh.height = 0.52
	core_mesh.material = blue_fire
	var core: MeshInstance3D = MeshInstance3D.new()
	core.mesh = core_mesh
	core.position.y = 1.30
	console.add_child(core)
	var shape: CollisionShape3D = CollisionShape3D.new()
	var capsule: CapsuleShape3D = CapsuleShape3D.new()
	capsule.radius = 0.86
	capsule.height = 2.5
	shape.shape = capsule
	shape.position.y = 1.00
	console.add_child(shape)

func _add_resonance_particles(parent: Node3D, position_value: Vector3, extents: Vector3, amount_value: int, node_name: String) -> void:
	var particles: GPUParticles3D = GPUParticles3D.new()
	particles.name = node_name
	particles.position = position_value
	particles.amount = amount_value
	particles.lifetime = 4.5
	particles.visibility_aabb = AABB(-extents, extents * 2.0)
	var process: ParticleProcessMaterial = ParticleProcessMaterial.new()
	process.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	process.emission_box_extents = extents
	process.direction = Vector3(0.0, 1.0, 0.0)
	process.spread = 38.0
	process.gravity = Vector3(0.0, 0.18, 0.0)
	process.initial_velocity_min = 0.08
	process.initial_velocity_max = 0.34
	process.scale_min = 0.05
	process.scale_max = 0.15
	process.color = Color(0.30, 0.68, 1.0, 0.78)
	particles.process_material = process
	var quad: QuadMesh = QuadMesh.new()
	quad.size = Vector2(0.18, 0.18)
	quad.material = resonance_particle_material
	particles.draw_pass_1 = quad
	parent.add_child(particles)

func _add_reflection_probe(parent: Node3D, position_value: Vector3, size_value: Vector3) -> void:
	var probe: ReflectionProbe = ReflectionProbe.new()
	probe.position = position_value
	probe.size = size_value
	probe.intensity = 0.72
	probe.max_distance = 20.0
	probe.update_mode = ReflectionProbe.UPDATE_ONCE
	probe.enable_shadows = false
	parent.add_child(probe)

func _add_temporal_well(parent: Node3D, position_value: Vector3, node_name: String) -> void:
	var area: Area3D = Area3D.new()
	area.name = node_name
	area.collision_layer = 0
	area.collision_mask = 1
	area.monitoring = true
	area.position = position_value
	parent.add_child(area)
	var hazard_mesh: CylinderMesh = CylinderMesh.new()
	hazard_mesh.top_radius = 1.55
	hazard_mesh.bottom_radius = 1.85
	hazard_mesh.height = 0.18
	hazard_mesh.radial_segments = 16
	hazard_mesh.material = hazard
	var visual: MeshInstance3D = MeshInstance3D.new()
	visual.mesh = hazard_mesh
	area.add_child(visual)
	var shape: CollisionShape3D = CollisionShape3D.new()
	var cylinder: CylinderShape3D = CylinderShape3D.new()
	cylinder.radius = 1.70
	cylinder.height = 1.60
	shape.shape = cylinder
	shape.position.y = 0.60
	area.add_child(shape)
	area.body_entered.connect(_on_hazard_body_entered.bind(node_name))

func _on_hazard_body_entered(body: Node3D, _well_id: String) -> void:
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(16, global_position)
		EventBus.player_message_requested.emit("O poço temporal corrói a memória de Elias.", 1.2)

func _add_pillar(parent: Node3D, position_value: Vector3, height: float) -> void:
	var root: Node3D = Node3D.new()
	root.position = position_value
	parent.add_child(root)
	_add_mesh_box(root, Vector3(0.0, 0.22, 0.0), Vector3(1.15, 0.44, 1.15), stone_wet, "BaseDoPilar")
	var shaft_mesh: CylinderMesh = CylinderMesh.new()
	shaft_mesh.top_radius = 0.38
	shaft_mesh.bottom_radius = 0.50
	shaft_mesh.height = height - 0.8
	shaft_mesh.radial_segments = 12
	shaft_mesh.material = stone
	var shaft: MeshInstance3D = MeshInstance3D.new()
	shaft.mesh = shaft_mesh
	shaft.position.y = height * 0.50
	root.add_child(shaft)
	_add_mesh_box(root, Vector3(0.0, height - 0.28, 0.0), Vector3(1.4, 0.55, 1.4), stone_wet, "CapitelDoPilar")

func _add_brazier(parent: Node3D, position_value: Vector3) -> void:
	var brazier: Node3D = Node3D.new()
	brazier.position = position_value
	parent.add_child(brazier)
	var bowl_mesh: CylinderMesh = CylinderMesh.new()
	bowl_mesh.top_radius = 0.48
	bowl_mesh.bottom_radius = 0.35
	bowl_mesh.height = 0.28
	bowl_mesh.material = metal
	var bowl: MeshInstance3D = MeshInstance3D.new()
	bowl.mesh = bowl_mesh
	brazier.add_child(bowl)
	var flame_mesh: SphereMesh = SphereMesh.new()
	flame_mesh.radius = 0.28
	flame_mesh.height = 0.70
	flame_mesh.material = blue_fire
	var flame: MeshInstance3D = MeshInstance3D.new()
	flame.mesh = flame_mesh
	flame.position.y = 0.45
	brazier.add_child(flame)
	var light: OmniLight3D = OmniLight3D.new()
	light.light_color = Color(0.16, 0.35, 0.68)
	light.light_energy = 0.42
	light.omni_range = 6.5
	light.shadow_enabled = false
	light.position.y = 0.75
	brazier.add_child(light)

func _add_solid_box(parent: Node3D, position_value: Vector3, size_value: Vector3, material: StandardMaterial3D, node_name: String) -> void:
	var body: StaticBody3D = StaticBody3D.new()
	body.name = node_name
	body.position = position_value
	parent.add_child(body)
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.mesh = _box_mesh(size_value, material)
	body.add_child(mesh_instance)
	var shape: CollisionShape3D = CollisionShape3D.new()
	var box: BoxShape3D = BoxShape3D.new()
	box.size = size_value
	shape.shape = box
	body.add_child(shape)

func _add_mesh_box(parent: Node3D, position_value: Vector3, size_value: Vector3, material: StandardMaterial3D, node_name: String) -> void:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.name = node_name
	mesh_instance.mesh = _box_mesh(size_value, material)
	mesh_instance.position = position_value
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(mesh_instance)

func _box_mesh(size_value: Vector3, material: StandardMaterial3D) -> BoxMesh:
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = size_value
	mesh.material = material
	return mesh

func _create_pbr_normal_map() -> void:
	var size_value: int = 64
	var image: Image = Image.create(size_value, size_value, false, Image.FORMAT_RGBA8)
	for y: int in range(size_value):
		for x: int in range(size_value):
			var fx: float = float(x) / float(size_value)
			var fy: float = float(y) / float(size_value)
			var dx: float = cos(fx * TAU * 5.0) * 0.38 + sin(fy * TAU * 9.0) * 0.20
			var dy: float = sin(fy * TAU * 6.0) * 0.38 + cos(fx * TAU * 8.0) * 0.20
			var normal: Vector3 = Vector3(-dx, 1.0, -dy).normalized()
			image.set_pixel(x, y, Color(normal.x * 0.5 + 0.5, normal.y * 0.5 + 0.5, normal.z * 0.5 + 0.5, 1.0))
	pbr_normal_map = ImageTexture.create_from_image(image)

func _material(color: Color, roughness_value: float, metallic_value: float) -> StandardMaterial3D:
	var result: StandardMaterial3D = StandardMaterial3D.new()
	result.albedo_color = color
	result.roughness = roughness_value
	result.metallic = metallic_value
	result.normal_texture = pbr_normal_map
	result.normal_scale = 0.34 if metallic_value < 0.20 else 0.18
	return result
