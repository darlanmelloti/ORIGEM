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
	# CP-CINE-11: volume de profundidade real; evita um painel escuro plano na entrada da caverna.
	var darkness_mesh: SphereMesh = SphereMesh.new()
	darkness_mesh.radius = 4.4
	darkness_mesh.height = 6.8
	darkness_mesh.radial_segments = 20
	darkness_mesh.rings = 12
	var darkness: MeshInstance3D = MeshInstance3D.new()
	darkness.name = "RecessoEscuroDaCaverna"
	darkness.mesh = darkness_mesh
	darkness.position = Vector3(0.0, 3.4, -7.2)
	darkness.scale = Vector3(1.0, 0.88, 0.70)
	var darkness_material: StandardMaterial3D = StandardMaterial3D.new()
	darkness_material.albedo_color = Color(0.005, 0.009, 0.013, 1.0)
	darkness_material.roughness = 1.0
	darkness.material_override = darkness_material
	cave.add_child(darkness)
	var rune_light: OmniLight3D = OmniLight3D.new()
	rune_light.name = "BrilhoChronosDaCaverna"
	rune_light.light_color = Color(0.10, 0.42, 1.0, 1.0)
	rune_light.light_energy = 2.1
	rune_light.omni_range = 18.0
	rune_light.position = Vector3(0.0, 3.5, -6.6)
	rune_light.shadow_enabled = false
	cave.add_child(rune_light)

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
	material.emission_energy_multiplier = 2.4
	return material

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
