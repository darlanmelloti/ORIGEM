## SanctuarySlice.gd
## Vertical slice do Santuário da Nascente: rota, ruínas modulares, natureza local e recompensa temporal.

extends Node3D

var terrain_provider: Node3D
var reward_core: MeshInstance3D
var reward_light: OmniLight3D
var shortcut_barrier: StaticBody3D
var pulse_time: float = 0.0

var stone: StandardMaterial3D
var stone_dark: StandardMaterial3D
var stone_warm: StandardMaterial3D
var moss: StandardMaterial3D
var gold: StandardMaterial3D
var bark: StandardMaterial3D
var leaf: StandardMaterial3D

func _ready() -> void:
	add_to_group("sanctuary_slice")
	_create_materials()
	_build_causeway()
	_build_sanctuary_foundation()
	_build_colonnade()
	_build_ruin_walls()
	_build_nature_overgrowth()
	_build_shortcut_gate()
	_build_environmental_runes()
	_build_reward_fragment()
	_build_local_lights()

func _process(delta: float) -> void:
	pulse_time += delta
	if reward_core != null:
		reward_core.rotation.y += delta * 0.75
		reward_core.position.y = 2.5 + sin(pulse_time * 1.8) * 0.12
	if reward_light != null:
		reward_light.light_energy = 0.85 + sin(pulse_time * 2.0) * 0.22

func _create_materials() -> void:
	stone = _make_material(Color(0.31, 0.33, 0.30), 0.88)
	stone_dark = _make_material(Color(0.18, 0.21, 0.20), 0.92)
	stone_warm = _make_material(Color(0.42, 0.34, 0.22), 0.86)
	moss = _make_material(Color(0.10, 0.25, 0.09), 0.95)
	gold = StandardMaterial3D.new()
	gold.albedo_color = Color(0.28, 0.43, 0.56)
	gold.metallic = 0.72
	gold.roughness = 0.31
	gold.emission_enabled = true
	gold.emission = Color(0.025, 0.10, 0.32)
	gold.emission_energy_multiplier = 0.65
	bark = _make_material(Color(0.095, 0.06, 0.04), 1.0)
	leaf = _make_material(Color(0.06, 0.22, 0.09), 0.92)
	leaf.cull_mode = BaseMaterial3D.CULL_DISABLED

func _build_causeway() -> void:
	var bridge: Node3D = Node3D.new()
	bridge.name = "PassagemDaNascente"
	add_child(bridge)
	# Liga o final do caminho central (a leste) à escadaria frontal do santuário.
	var start: Vector3 = Vector3(25.0, 0.0, -6.0)
	var finish: Vector3 = Vector3(0.0, 0.0, 7.0)
	for index: int in range(13):
		var t: float = float(index) / 12.0
		var point: Vector3 = start.lerp(finish, t)
		point.z += sin(float(index) * 0.75) * 0.28
		point.y = 0.24 + float(index % 3) * 0.04
		_add_box(bridge, point, Vector3(2.45, 0.30, 3.25), stone_warm, "LajeDaPassagem")
		if index % 3 == 1:
			_add_box(bridge, point + Vector3(0.62, 0.20, 0.60), Vector3(0.45, 0.10, 0.55), moss, "MusgoDaPassagem")

func _build_sanctuary_foundation() -> void:
	# Plataforma circular irregular: elimina o grande bloco negro que denunciava o greybox.
	var plinth_mesh: CylinderMesh = CylinderMesh.new()
	plinth_mesh.top_radius = 8.2
	plinth_mesh.bottom_radius = 9.5
	plinth_mesh.height = 0.68
	plinth_mesh.radial_segments = 32
	plinth_mesh.material = stone_dark
	var plinth: MeshInstance3D = MeshInstance3D.new()
	plinth.name = "PlataformaDoSantuario"
	plinth.mesh = plinth_mesh
	plinth.position = Vector3(0.0, 0.34, 0.0)
	add_child(plinth)
	for step: int in range(5):
		var width: float = 11.8 - float(step) * 0.45
		var depth: float = 3.4 - float(step) * 0.22
		_add_box(self, Vector3(0.0, 0.25 + float(step) * 0.23, 8.8 - float(step) * 0.60), Vector3(width, 0.46 + float(step) * 0.12, depth), stone_warm, "DegrauDoSantuario")

func _build_colonnade() -> void:
	var column_positions: Array[Vector3] = [
		Vector3(-6.0, 0.85, 3.4), Vector3(-6.0, 0.85, -2.6), Vector3(-6.0, 0.85, -7.4),
		Vector3(6.0, 0.85, 3.4), Vector3(6.0, 0.85, -2.6), Vector3(6.0, 0.85, -7.4)
	]
	for index: int in range(column_positions.size()):
		var height: float = 6.8 if index != 2 and index != 5 else 4.2
		_add_fluted_column(self, column_positions[index], height, index)

	_add_box(self, Vector3(0.0, 7.25, 3.4), Vector3(13.2, 0.72, 1.10), stone_dark, "LintelFrontalPartido")
	_add_box(self, Vector3(0.0, 7.66, 3.4), Vector3(8.2, 0.12, 1.22), moss, "MusgoDoLintel")

func _build_ruin_walls() -> void:
	# Fragmentos baixos e afastados deixam o céu e a silhueta das colunas respirarem.
	var wall_pieces: Array[Dictionary] = [
		{"p": Vector3(-7.5, 1.2, -4.8), "s": Vector3(0.9, 2.4, 4.0), "r": -0.12},
		{"p": Vector3(7.2, 1.0, -5.5), "s": Vector3(0.9, 2.0, 3.2), "r": 0.13},
		{"p": Vector3(-3.0, 1.1, -8.0), "s": Vector3(2.6, 2.1, 0.7), "r": 0.04},
		{"p": Vector3(3.0, 0.8, -7.6), "s": Vector3(2.2, 1.5, 0.7), "r": -0.08}
	]
	for piece: Dictionary in wall_pieces:
		var block: MeshInstance3D = _add_box(self, piece["p"] as Vector3, piece["s"] as Vector3, stone, "MuroPartido")
		block.rotation.z = float(piece["r"])

func _build_nature_overgrowth() -> void:
	# Troncos, raízes e hera ancoram as ruínas no vale, com variação local.
	for position_value: Vector3 in [Vector3(-7.6, 0.9, -0.4), Vector3(7.1, 0.9, -5.2), Vector3(-4.8, 0.9, -7.1)]:
		_add_root_cluster(position_value)
	for position_value: Vector3 in [Vector3(-7.4, 3.2, 2.8), Vector3(7.1, 2.8, -2.2), Vector3(-2.8, 3.0, -7.55)]:
		_add_ivy_cluster(position_value)

func _build_shortcut_gate() -> void:
	# O Portão da Margem conduz a uma rota curta de regresso ao lago, mas só abre pelo lado do santuário.
	var route: Node3D = Node3D.new()
	route.name = "AtalhoDaMargem"
	add_child(route)
	for index: int in range(7):
		var point: Vector3 = Vector3(-10.0 - float(index) * 2.0, 0.26, 3.0 - float(index) * 1.65)
		_add_box(route, point, Vector3(2.3, 0.26, 2.5), stone_warm, "LajeDoAtalho")

	var arch_root: Node3D = Node3D.new()
	arch_root.name = "PortaoDaMargem"
	arch_root.position = Vector3(-9.2, 0.88, 3.0)
	add_child(arch_root)
	_add_box(arch_root, Vector3(-1.4, 2.2, 0.0), Vector3(0.72, 4.4, 0.92), stone_dark, "PilarEsquerdo")
	_add_box(arch_root, Vector3(1.4, 2.2, 0.0), Vector3(0.72, 4.4, 0.92), stone_dark, "PilarDireito")
	_add_box(arch_root, Vector3(0.0, 4.35, 0.0), Vector3(3.75, 0.74, 0.92), stone_warm, "LintelDoPortao")

	shortcut_barrier = StaticBody3D.new()
	shortcut_barrier.name = "ShortcutGate"
	shortcut_barrier.add_to_group("interactable")
	shortcut_barrier.collision_layer = 4
	shortcut_barrier.position = Vector3(-9.2, 0.88, 3.0)
	add_child(shortcut_barrier)
	var barrier_mesh: BoxMesh = BoxMesh.new()
	barrier_mesh.size = Vector3(2.45, 3.35, 0.28)
	barrier_mesh.material = stone_dark
	var barrier: MeshInstance3D = MeshInstance3D.new()
	barrier.name = "SeloDoAtalho"
	barrier.mesh = barrier_mesh
	barrier.position.y = 1.65
	shortcut_barrier.add_child(barrier)
	var barrier_shape: CollisionShape3D = CollisionShape3D.new()
	var box: BoxShape3D = BoxShape3D.new()
	box.size = Vector3(2.45, 3.35, 0.34)
	barrier_shape.shape = box
	barrier_shape.position.y = 1.65
	shortcut_barrier.add_child(barrier_shape)

func unlock_shortcut() -> bool:
	if shortcut_barrier == null or not is_instance_valid(shortcut_barrier):
		return false
	shortcut_barrier.queue_free()
	EventBus.player_message_requested.emit("O selo temporal cedeu. O atalho da margem está aberto.", 2.4)
	return true

func _build_environmental_runes() -> void:
	_create_rune(Vector3(-4.0, 1.22, -7.35), "RuneP0_01", "RUNAS: A água recorda aquilo que o tempo tentou apagar.")
	_create_rune(Vector3(5.0, 1.16, -5.7), "RuneP0_02", "RUNAS: Os Kharu vigiam a nascente, mas não compreendem a memória que guardam.")
	_create_rune(Vector3(-8.0, 1.10, 1.7), "RuneP0_03", "RUNAS: O portão abre-se a quem alcança a ruína pelo lado da verdade.")

func _create_rune(position_value: Vector3, rune_name: String, _text: String) -> void:
	var rune: StaticBody3D = StaticBody3D.new()
	rune.name = rune_name
	rune.add_to_group("interactable")
	rune.collision_layer = 4
	rune.position = position_value
	add_child(rune)
	var slab_mesh: BoxMesh = BoxMesh.new()
	slab_mesh.size = Vector3(0.78, 1.50, 0.20)
	slab_mesh.material = stone_dark
	var slab: MeshInstance3D = MeshInstance3D.new()
	slab.mesh = slab_mesh
	slab.position.y = 0.75
	rune.add_child(slab)
	var glow_mesh: BoxMesh = BoxMesh.new()
	glow_mesh.size = Vector3(0.30, 0.74, 0.025)
	glow_mesh.material = gold
	var glyph: MeshInstance3D = MeshInstance3D.new()
	glyph.mesh = glow_mesh
	glyph.position = Vector3(0.0, 0.80, -0.115)
	rune.add_child(glyph)
	var shape: CollisionShape3D = CollisionShape3D.new()
	var box: BoxShape3D = BoxShape3D.new()
	box.size = Vector3(1.20, 1.70, 0.70)
	shape.shape = box
	shape.position.y = 0.82
	rune.add_child(shape)

func _build_reward_fragment() -> void:
	var pedestal: StaticBody3D = StaticBody3D.new()
	pedestal.name = "SpringFragment"
	pedestal.add_to_group("interactable")
	pedestal.add_to_group("spring_reward")
	pedestal.collision_layer = 4
	pedestal.position = Vector3(0.0, 1.0, -2.0)
	add_child(pedestal)

	var base_mesh: CylinderMesh = CylinderMesh.new()
	base_mesh.top_radius = 0.75
	base_mesh.bottom_radius = 1.15
	base_mesh.height = 1.35
	base_mesh.radial_segments = 10
	base_mesh.material = stone_warm
	var base: MeshInstance3D = MeshInstance3D.new()
	base.mesh = base_mesh
	base.position.y = 0.67
	pedestal.add_child(base)

	var rune_mesh: TorusMesh = TorusMesh.new()
	rune_mesh.inner_radius = 0.47
	rune_mesh.outer_radius = 0.58
	rune_mesh.rings = 10
	rune_mesh.ring_segments = 8
	rune_mesh.material = gold
	var rune: MeshInstance3D = MeshInstance3D.new()
	rune.mesh = rune_mesh
	rune.position.y = 1.36
	pedestal.add_child(rune)

	var core_mesh: SphereMesh = SphereMesh.new()
	core_mesh.radius = 0.30
	core_mesh.height = 0.62
	core_mesh.radial_segments = 12
	core_mesh.rings = 6
	core_mesh.material = gold
	reward_core = MeshInstance3D.new()
	reward_core.name = "FragmentoTemporal"
	reward_core.mesh = core_mesh
	reward_core.position.y = 2.5
	pedestal.add_child(reward_core)

	var shape: CollisionShape3D = CollisionShape3D.new()
	var capsule: CapsuleShape3D = CapsuleShape3D.new()
	capsule.radius = 0.90
	capsule.height = 3.20
	shape.shape = capsule
	shape.position.y = 1.45
	pedestal.add_child(shape)

	reward_light = OmniLight3D.new()
	reward_light.light_color = Color(0.28, 0.68, 1.0)
	reward_light.light_energy = 0.90
	reward_light.omni_range = 8.0
	reward_light.shadow_enabled = false
	reward_light.position.y = 2.3
	pedestal.add_child(reward_light)

func _build_local_lights() -> void:
	for position_value: Vector3 in [Vector3(-5.6, 2.4, 2.8), Vector3(5.6, 2.4, 2.8), Vector3(0.0, 2.4, -6.6)]:
		var light: OmniLight3D = OmniLight3D.new()
		light.light_color = Color(0.18, 0.44, 0.62)
		light.light_energy = 0.36
		light.omni_range = 7.0
		light.shadow_enabled = false
		light.position = position_value
		add_child(light)

func _add_fluted_column(parent: Node3D, position_value: Vector3, height: float, index: int) -> void:
	var root: Node3D = Node3D.new()
	root.name = "ColunaModular_%02d" % index
	root.position = position_value
	parent.add_child(root)
	_add_box(root, Vector3(0.0, 0.24, 0.0), Vector3(1.35, 0.48, 1.35), stone_warm, "Base")
	var shaft_mesh: CylinderMesh = CylinderMesh.new()
	shaft_mesh.top_radius = 0.34
	shaft_mesh.bottom_radius = 0.46
	shaft_mesh.height = height - 1.0
	shaft_mesh.radial_segments = 12
	shaft_mesh.material = stone
	var shaft: MeshInstance3D = MeshInstance3D.new()
	shaft.mesh = shaft_mesh
	shaft.position.y = height * 0.50
	root.add_child(shaft)
	for flute: int in range(6):
		var angle: float = TAU * float(flute) / 6.0
		var groove: MeshInstance3D = _add_box(root, Vector3(cos(angle) * 0.40, height * 0.50, sin(angle) * 0.40), Vector3(0.07, height - 1.15, 0.07), stone_dark, "Friso")
		groove.rotation.y = angle
	_add_box(root, Vector3(0.0, height - 0.25, 0.0), Vector3(1.55, 0.50, 1.55), stone_warm, "Capitel")

func _add_root_cluster(position_value: Vector3) -> void:
	for index: int in range(4):
		var angle: float = float(index) * 1.55 + 0.25
		var start: Vector3 = position_value + Vector3(0.0, 0.15, 0.0)
		var end: Vector3 = start + Vector3(cos(angle) * (1.0 + float(index) * 0.16), 0.12, sin(angle) * (1.0 + float(index) * 0.16))
		_add_branch(start, end, 0.16, 0.05, bark)

func _add_ivy_cluster(position_value: Vector3) -> void:
	for index: int in range(7):
		var leaf_mesh: SphereMesh = SphereMesh.new()
		leaf_mesh.radius = 0.20
		leaf_mesh.height = 0.08
		leaf_mesh.radial_segments = 6
		leaf_mesh.rings = 2
		leaf_mesh.material = leaf
		var ivy: MeshInstance3D = MeshInstance3D.new()
		ivy.mesh = leaf_mesh
		ivy.position = position_value + Vector3(sin(float(index) * 1.7) * 0.33, -float(index) * 0.24, cos(float(index) * 0.9) * 0.20)
		add_child(ivy)

func _add_branch(start: Vector3, end: Vector3, bottom_radius: float, top_radius: float, material: StandardMaterial3D) -> void:
	var direction: Vector3 = end - start
	var length: float = direction.length()
	if length <= 0.001:
		return
	var mesh: CylinderMesh = CylinderMesh.new()
	mesh.bottom_radius = bottom_radius
	mesh.top_radius = top_radius
	mesh.height = length
	mesh.radial_segments = 7
	mesh.material = material
	var branch: MeshInstance3D = MeshInstance3D.new()
	branch.mesh = mesh
	branch.position = (start + end) * 0.5
	branch.basis = Basis(Quaternion(Vector3.UP, direction.normalized()))
	add_child(branch)

func _add_box(parent: Node3D, position_value: Vector3, size_value: Vector3, material: StandardMaterial3D, node_name: String) -> MeshInstance3D:
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = size_value
	mesh.material = material
	var instance: MeshInstance3D = MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = mesh
	instance.position = position_value
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(instance)
	return instance

func _make_material(color: Color, roughness_value: float) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness_value
	return material
