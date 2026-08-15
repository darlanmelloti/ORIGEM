## OrionDestinationRegion.gd
## Marcos 10–12 do mapa regional: entrada da Caverna Orion, Câmara do Cube e Hub Temporal.
## Destinos em mundo contínuo, preparados para futura missão, transição temporal e interior detalhado.

extends Node3D

const CLIFF: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var cube_material: StandardMaterial3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	stone_material = _make_stone_material()
	cube_material = _make_cube_material()
	_build_orion_cave()
	_build_region9_to_10_approach()
	if OS.get_environment("ORIGEM_VALIDATION_REGION") != "10":
		_build_cube_chamber_marker()
		_build_temporal_hub()

func _height_at(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _build_orion_cave() -> void:
	var cave: Node3D = Node3D.new()
	cave.name = "CavernaDoOrion"
	var cave_x: float = -116.0
	var cave_z: float = 548.0
	cave.position = Vector3(cave_x, _height_at(cave_x, cave_z), cave_z)
	add_child(cave)
	# Marco orgânico de legibilidade da boca: massas CC0 formam um limiar arqueológico, sem caixa/greybox.
	var mouth_positions: Array[Vector3] = [Vector3(-5.4, 4.2, -8.0), Vector3(5.4, 4.2, -8.0), Vector3(0.0, 8.6, -8.4)]
	for mouth_index: int in range(mouth_positions.size()):
		var mouth_frame: Node3D = ROCK_LARGE.instantiate() as Node3D
		if mouth_frame == null:
			continue
		mouth_frame.name = "LimiarOrganicoOrion_%02d" % mouth_index
		mouth_frame.position = mouth_positions[mouth_index]
		mouth_frame.scale = Vector3(0.66 if mouth_index < 2 else 0.82, 1.05 if mouth_index < 2 else 0.48, 0.38)
		mouth_frame.rotation = Vector3(0.0, 0.16 * float(mouth_index - 1), 0.0)
		_apply_material(mouth_frame, stone_material)
		cave.add_child(mouth_frame)
	var threshold_glow: OmniLight3D = OmniLight3D.new()
	threshold_glow.name = "BraseiroLimiarOrion"
	threshold_glow.light_color = Color("#5cc8ff")
	threshold_glow.light_energy = 3.0
	threshold_glow.omni_range = 16.0
	threshold_glow.shadow_enabled = false
	threshold_glow.position = Vector3(0.0, 3.4, -8.2)
	cave.add_child(threshold_glow)
	# Rocha disposta em ferradura: forma entrada física sem cartão plano e deixa o percurso de Orion legível à distância.
	for index: int in range(9):
		var angle: float = lerpf(-2.35, -0.78, float(index) / 8.0)
		var radius: float = 12.0 + float(index % 2) * 2.0
		var cliff: Node3D = CLIFF.instantiate() as Node3D
		if cliff == null:
			continue
		cliff.name = "RochaDaCaverna_%02d" % index
		cliff.position = Vector3(cos(angle) * radius, 2.4 + float(index % 3) * 1.8, sin(angle) * radius)
		var scale_value: float = 0.72 + float(index % 3) * 0.18
		cliff.scale = Vector3(scale_value, scale_value, scale_value)
		cliff.rotation = Vector3(0.12 * sin(angle), angle + PI * 0.5, 0.10 * cos(angle))
		_apply_material(cliff, stone_material)
		cave.add_child(cliff)
	# A boca recuada usa massas CC0 orgânicas; não há plano/caixa preta a bloquear a câmara.
	for mouth_index: int in range(3):
		var mouth_stone: Node3D = ROCK_LARGE.instantiate() as Node3D
		if mouth_stone == null:
			continue
		mouth_stone.name = "MassaOrganicaInterior_%02d" % mouth_index
		mouth_stone.position = Vector3(-3.2 + float(mouth_index) * 3.2, 2.6 + float(mouth_index % 2) * 1.2, -7.0)
		mouth_stone.scale = Vector3(0.75, 0.85 + float(mouth_index % 2) * 0.18, 0.48)
		mouth_stone.rotation = Vector3(0.08, float(mouth_index) * 0.63, -0.05)
		_apply_material(mouth_stone, stone_material)
		cave.add_child(mouth_stone)
	var cave_eye: Node3D = ROCK_LARGE.instantiate() as Node3D
	if cave_eye != null:
		cave_eye.name = "OlhoRessonanteDaEntradaOrion"
		cave_eye.position = Vector3(0.0, 3.4, -7.2)
		cave_eye.scale = Vector3(0.58, 0.38, 0.22)
		var cave_eye_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
		cave_eye_material.albedo_color = Color("#123c4b")
		cave_eye_material.emission_enabled = true
		cave_eye_material.emission = Color("#4ec9e5")
		cave_eye_material.emission_energy_multiplier = 1.15
		_apply_material(cave_eye, cave_eye_material)
		cave.add_child(cave_eye)

	var rune_light: OmniLight3D = OmniLight3D.new()
	rune_light.name = "BrilhoChronosDaCaverna"
	rune_light.light_color = Color(0.10, 0.42, 1.0, 1.0)
	rune_light.light_energy = 3.6
	rune_light.omni_range = 24.0
	rune_light.position = Vector3(0.0, 4.2, -6.6)
	rune_light.shadow_enabled = false
	cave.add_child(rune_light)
	_create_visible_brazier_core(cave, Vector3(-2.2, 3.85, -8.1), "NucleoBraseiroOrionEsquerdo")
	_create_visible_brazier_core(cave, Vector3(2.2, 3.85, -8.1), "NucleoBraseiroOrionDireito")
	var mouth_fill: OmniLight3D = OmniLight3D.new()
	mouth_fill.name = "LuzPreenchimentoBocaOrion"
	mouth_fill.light_color = Color("#7ed9e8")
	mouth_fill.light_energy = 2.2
	mouth_fill.omni_range = 18.0
	mouth_fill.shadow_enabled = false
	mouth_fill.position = Vector3(0.0, 3.0, -3.0)
	cave.add_child(mouth_fill)

func _create_visible_brazier_core(parent: Node3D, position_value: Vector3, node_name: String) -> void:
	var core := MeshInstance3D.new()
	core.name = node_name
	var sphere := SphereMesh.new()
	sphere.radius = 0.24
	sphere.height = 0.48
	core.mesh = sphere
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#5cc8ff")
	material.emission_enabled = true
	material.emission = Color("#5cc8ff")
	material.emission_energy_multiplier = 3.8
	core.material_override = material
	core.position = position_value
	parent.add_child(core)

func _build_region9_to_10_approach() -> void:
	var approach: Node3D = Node3D.new()
	approach.name = "TransicaoRegiao09Para10"
	add_child(approach)
	var route: Array[Vector2] = [Vector2(-112.0, 532.0), Vector2(-114.0, 536.5), Vector2(-116.0, 541.0), Vector2(-116.0, 545.0)]
	var route_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
	route_material.albedo_color = Color("#53665d")
	route_material.roughness = 0.92
	for index: int in range(route.size()):
		var point: Vector2 = route[index]
		var stone: Node3D = ROCK_LARGE.instantiate() as Node3D
		if stone == null:
			continue
		stone.name = "DegrauCavernaOrganico_%02d" % index
		stone.position = Vector3(point.x, _height_at(point.x, point.y) + 0.22, point.y)
		stone.scale = Vector3(0.46 + float(index % 2) * 0.10, 0.12 + float(index % 3) * 0.04, 0.34)
		stone.rotation = Vector3(0.03, -0.25 + float(index) * 0.18, -0.04)
		_apply_material(stone, route_material)
		approach.add_child(stone)
		if index == 1 or index == 3:
			var marker_light: OmniLight3D = OmniLight3D.new()
			marker_light.name = "LuzWayfindingCaverna_%02d" % index
			marker_light.light_color = Color("#4ebbd3")
			marker_light.light_energy = 1.05
			marker_light.omni_range = 7.0
			marker_light.shadow_enabled = false
			marker_light.position = Vector3(0.0, 1.15, 0.0)
			stone.add_child(marker_light)
	for root_index: int in range(5):
		var root: Node3D = ROCK_LARGE.instantiate() as Node3D
		if root == null:
			continue
		root.name = "RaizPetrea_%02d" % root_index
		var side: float = -1.0 if root_index % 2 == 0 else 1.0
		root.position = Vector3(side * (8.2 - float(root_index % 2) * 1.3), 2.8 + float(root_index) * 0.85, 539.0 + float(root_index) * 1.65)
		root.scale = Vector3(0.20 + float(root_index % 2) * 0.06, 0.95, 0.18)
		root.rotation = Vector3(0.14 * side, side * (0.52 + float(root_index) * 0.16), 0.18 * side)
		_apply_material(root, stone_material)
		approach.add_child(root)
	for fissure_index: int in range(3):
		var fissure: MeshInstance3D = MeshInstance3D.new()
		fissure.name = "FendaRessonanciaRegiao10_%02d" % fissure_index
		var ribbon: QuadMesh = QuadMesh.new()
		ribbon.size = Vector2(0.18 + float(fissure_index) * 0.06, 3.0 + float(fissure_index) * 0.7)
		ribbon.material = _make_resonance_material()
		fissure.mesh = ribbon
		var fissure_x: float = -116.2 + float(fissure_index) * 0.9
		var fissure_z: float = 538.0 + float(fissure_index) * 2.0
		fissure.position = Vector3(fissure_x, _height_at(fissure_x, fissure_z) + 0.12, fissure_z)
		fissure.rotation_degrees = Vector3(-90.0, 14.0 + float(fissure_index) * 9.0, 0.0)
		approach.add_child(fissure)
	var entrance_light: OmniLight3D = OmniLight3D.new()
	entrance_light.name = "LuzTransicaoCavernaOrion"
	entrance_light.light_color = Color("#5cc8ff")
	entrance_light.light_energy = 1.8
	entrance_light.omni_range = 14.0
	entrance_light.shadow_enabled = false
	entrance_light.position = Vector3(-116.0, 4.2, 542.0)
	approach.add_child(entrance_light)

func _make_resonance_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color("#0d2630")
	material.emission_enabled = true
	material.emission = Color("#5cc8ff")
	material.emission_energy_multiplier = 1.35
	material.roughness = 0.40
	return material

func _build_cube_chamber_marker() -> void:
	var chamber: Node3D = Node3D.new()
	chamber.name = "CamaraDoOrionCube"
	var chamber_x: float = -116.0
	var chamber_z: float = 562.0
	chamber.position = Vector3(chamber_x, _height_at(chamber_x, chamber_z) + 2.8, chamber_z)
	add_child(chamber)
	var altar_mesh: CylinderMesh = CylinderMesh.new()
	altar_mesh.top_radius = 3.2
	altar_mesh.bottom_radius = 4.2
	altar_mesh.height = 1.8
	altar_mesh.radial_segments = 12
	var altar: MeshInstance3D = MeshInstance3D.new()
	altar.mesh = altar_mesh
	altar.material_override = stone_material
	altar.position = Vector3(0.0, -1.9, 0.0)
	chamber.add_child(altar)
	var cube_mesh: BoxMesh = BoxMesh.new()
	cube_mesh.size = Vector3(1.75, 1.75, 1.75)
	var cube: MeshInstance3D = MeshInstance3D.new()
	cube.name = "CuboOrion"
	cube.mesh = cube_mesh
	cube.material_override = cube_material
	cube.position = Vector3(0.0, 0.8, 0.0)
	cube.rotation = Vector3(0.20, 0.54, 0.10)
	cube.add_to_group("interactable")
	chamber.add_child(cube)
	var cube_light: OmniLight3D = OmniLight3D.new()
	cube_light.light_color = Color(0.10, 0.48, 1.0, 1.0)
	cube_light.light_energy = 4.0
	cube_light.omni_range = 22.0
	cube_light.position = Vector3(0.0, 1.2, 0.0)
	cube_light.shadow_enabled = false
	chamber.add_child(cube_light)
	for index: int in range(4):
		var angle: float = float(index) * TAU / 4.0 + 0.22
		var support: Node3D = PILLAR.instantiate() as Node3D
		if support == null:
			continue
		support.name = "SuporteOrganicoOrionCube_%02d" % index
		support.position = Vector3(cos(angle) * 6.8, 0.8, sin(angle) * 6.8)
		support.scale = Vector3(0.62, 0.85 + float(index % 2) * 0.16, 0.62)
		support.rotation = Vector3(0.03 * sin(angle), angle, 0.04 * cos(angle))
		_apply_material(support, stone_material)
		chamber.add_child(support)
		var support_light := OmniLight3D.new()
		support_light.name = "BraseiroAnelCube_%02d" % index
		support_light.light_color = Color("#4ebbd3")
		support_light.light_energy = 1.6
		support_light.omni_range = 7.0
		support_light.shadow_enabled = false
		support_light.position = Vector3(cos(angle) * 5.4, 1.1, sin(angle) * 5.4)
		chamber.add_child(support_light)
		var ring_core := MeshInstance3D.new()
		ring_core.name = "NucleoVisivelAnelCube_%02d" % index
		var ring_sphere := SphereMesh.new()
		ring_sphere.radius = 0.22
		ring_sphere.height = 0.44
		ring_core.mesh = ring_sphere
		var ring_material := StandardMaterial3D.new()
		ring_material.albedo_color = Color("#4ebbd3")
		ring_material.emission_enabled = true
		ring_material.emission = Color("#4ebbd3")
		ring_material.emission_energy_multiplier = 2.8
		ring_core.material_override = ring_material
		ring_core.position = Vector3(cos(angle) * 5.4, 1.65, sin(angle) * 5.4)
		chamber.add_child(ring_core)

func _build_temporal_hub() -> void:
	var hub: Node3D = Node3D.new()
	hub.name = "HubTemporal"
	var hub_x: float = 164.0
	var hub_z: float = 210.0
	hub.position = Vector3(hub_x, _height_at(hub_x, hub_z), hub_z)
	add_child(hub)
	var circle_mesh: CylinderMesh = CylinderMesh.new()
	circle_mesh.top_radius = 10.5
	circle_mesh.bottom_radius = 11.2
	circle_mesh.height = 0.50
	circle_mesh.radial_segments = 32
	var circle: MeshInstance3D = MeshInstance3D.new()
	circle.name = "CirculoMegalitico"
	circle.mesh = circle_mesh
	circle.material_override = stone_material
	circle.position = Vector3(0.0, 0.25, 0.0)
	hub.add_child(circle)
	for index: int in range(8):
		var angle: float = float(index) * TAU / 8.0
		var monolith: Node3D = PILLAR.instantiate() as Node3D
		if monolith == null:
			continue
		monolith.name = "MonolitoTemporal_%02d" % index
		monolith.position = Vector3(cos(angle) * 12.5, 2.3, sin(angle) * 12.5)
		monolith.scale = Vector3(0.78, 0.78, 0.78)
		monolith.rotation = Vector3(0.04 * sin(angle), angle, 0.03 * cos(angle))
		_apply_material(monolith, stone_material)
		hub.add_child(monolith)
	var core_mesh: SphereMesh = SphereMesh.new()
	core_mesh.radius = 1.55
	core_mesh.height = 3.10
	var core: MeshInstance3D = MeshInstance3D.new()
	core.name = "NucleoTemporal"
	core.mesh = core_mesh
	core.material_override = cube_material
	core.position = Vector3(0.0, 1.9, 0.0)
	hub.add_child(core)

func _make_stone_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = MOSSY_RUIN_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_RUIN_NORMAL
	material.normal_scale = 0.30
	material.roughness = 0.95
	material.uv1_scale = Vector3(0.26, 0.26, 0.26)
	return material

func _make_cube_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.02, 0.20, 0.80, 1.0)
	material.metallic = 0.58
	material.roughness = 0.18
	material.emission_enabled = true
	material.emission = Color(0.04, 0.36, 1.0, 1.0)
	material.emission_energy_multiplier = 1.35
	return material

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
