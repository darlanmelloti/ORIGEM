## OrionDestinationRegion.gd
## Marcos 10–12 do mapa regional: entrada da Caverna Orion, Câmara do Cube e Hub Temporal.
## Destinos em mundo contínuo, preparados para futura missão, transição temporal e interior detalhado.

extends Node3D

const CLIFF: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var cube_material: StandardMaterial3D
var cube_chamber: Node3D
var interior_handoff_ready: bool = false
const CUBE_CHAMBER_REVEAL_RADIUS: float = 10.5

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	stone_material = _make_stone_material()
	cube_material = _make_cube_material()
	_build_orion_cave()
	_build_cube_chamber_marker()
	_build_temporal_hub()

func _process(_delta: float) -> void:
	# O artefacto só integra a narrativa depois da travessia: não pode contaminar a vista da montanha ou da boca Orion.
	if cube_chamber == null:
		return
	var player: Node3D = get_tree().get_first_node_in_group("player") as Node3D
	if player == null and get_tree().current_scene != null:
		player = get_tree().current_scene.find_child("Player", true, false) as Node3D
	var qa_interior_reveal: bool = OS.get_environment("ORIGEM_QA_ORION_REVEAL") == "1"
	# Enquanto não existir um corredor interior físico, a proximidade em terreno aberto não pode revelar o artefacto na superfície.
	# A futura câmara subterrânea substituirá este bloqueio por uma condição de entrada real.
	cube_chamber.visible = qa_interior_reveal

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
	# CP-CINE-24: a boca é agora um colo de terreno contínuo. Nenhum activo isolado é usado enquanto o kit de caverna definitivo não estiver validado.
	# Isto remove os poucos pivôs de rocha ainda visíveis como objectos suspensos na crista.
	var rune_light: OmniLight3D = OmniLight3D.new()
	rune_light.name = "BrilhoChronosDaCaverna"
	rune_light.light_color = Color(0.10, 0.42, 1.0, 1.0)
	rune_light.light_energy = 2.1
	rune_light.omni_range = 18.0
	rune_light.position = Vector3(0.0, 3.5, -6.6)
	rune_light.shadow_enabled = false
	cave.add_child(rune_light)
	# CP-CINE-28: volume físico invisível; não teletransporta nem altera a câmara, apenas confirma a entrada no futuro módulo.
	var handoff: Area3D = Area3D.new()
	handoff.name = "GatilhoFisicoInteriorOrion"
	handoff.collision_layer = 0
	handoff.collision_mask = 1
	handoff.position = Vector3(0.0, 1.7, 5.4)
	var handoff_shape: CollisionShape3D = CollisionShape3D.new()
	var handoff_box: BoxShape3D = BoxShape3D.new()
	handoff_box.size = Vector3(4.2, 3.4, 1.4)
	handoff_shape.shape = handoff_box
	handoff.add_child(handoff_shape)
	handoff.body_entered.connect(_on_orion_handoff_body_entered)
	cave.add_child(handoff)

func _on_orion_handoff_body_entered(body: Node3D) -> void:
	if not body.is_in_group("player") and body.name != "Player":
		return
	if interior_handoff_ready:
		return
	interior_handoff_ready = true
	print("[CP-CINE-28] ORION_HANDOFF_READY player=%s" % body.name)

func _build_cube_chamber_marker() -> void:
	var chamber: Node3D = Node3D.new()
	chamber.name = "CamaraDoOrionCube"
	var chamber_x: float = -116.0
	var chamber_z: float = 562.0
	chamber.position = Vector3(chamber_x, _height_at(chamber_x, chamber_z) + 2.8, chamber_z)
	cube_chamber = chamber
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
