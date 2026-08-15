extends Node3D
## Região 12 validation-only scene: Hub Temporal orgânico.
## Reuses OrionDestinationRegion and isolates HubTemporal; earlier regions remain untouched.

const TERRAIN_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const DESTINATION_SCRIPT: Script = preload("res://levels/OrionDestinationRegion.gd")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
var camera: Camera3D
var elapsed: float = 0.0

func _ready() -> void:
	_build_environment()
	var terrain := TERRAIN_SCRIPT.new() as Node3D
	terrain.name = "TerrainPatch"
	add_child(terrain)
	var destination := DESTINATION_SCRIPT.new() as Node3D
	destination.name = "DestinosOrionEHubTemporal"
	add_child(destination)
	terrain.visible = false
	await get_tree().process_frame
	_build_final_dome_validation_proxy()
	for branch_name in ["CavernaDoOrion", "TransicaoRegiao09Para10", "CamaraDoOrionCube"]:
		var branch := destination.get_node_or_null(branch_name) as Node3D
		if branch != null:
			branch.visible = false
	var hub := destination.get_node_or_null("HubTemporal") as Node3D
	if hub != null:
		hub.visible = false
	var dome := destination.get_node_or_null("CupulaFinal") as Node3D
	if dome != null:
		dome.visible = true
	var dome_anchor := Vector3.ZERO
	camera = Camera3D.new()
	camera.name = "Region12ValidationCamera"
	camera.position = Vector3(0.0, 6.5, 11.5)
	camera.fov = 58.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 4.6, -4.0), Vector3.UP)
	camera.current = true

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#050711")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#46395a")
	environment.ambient_light_energy = 0.52
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.glow_enabled = true
	environment.glow_intensity = 0.48
	environment.glow_bloom = 0.16
	world.environment = environment
	add_child(world)
	var moon := DirectionalLight3D.new()
	moon.light_color = Color("#a9a0c6")
	moon.light_energy = 0.42
	moon.rotation_degrees = Vector3(-42.0, 28.0, 0.0)
	add_child(moon)
	var fill := DirectionalLight3D.new()
	fill.light_color = Color("#7b6aa4")
	fill.light_energy = 0.26
	fill.rotation_degrees = Vector3(-18.0, -52.0, 0.0)
	add_child(fill)

func _process(delta: float) -> void:
	if camera == null:
		return
	elapsed += delta
	camera.position = Vector3(sin(elapsed * 0.22) * 0.75, 6.5 + sin(elapsed * 0.18) * 0.18, 11.5 + cos(elapsed * 0.22) * 0.7)
	camera.look_at(Vector3(0.0, 4.6, -4.0), Vector3.UP)

func _build_final_dome_validation_proxy() -> void:
	var proxy := Node3D.new()
	proxy.name = "CupulaFinalValidationProxy"
	add_child(proxy)
	for index: int in range(8):
		var angle: float = float(index) * TAU / 8.0
		var pillar := PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarProxy_%02d" % index
		pillar.position = Vector3(cos(angle) * 6.6, 3.1 + float(index % 2) * 0.55, sin(angle) * 6.6)
		pillar.scale = Vector3(1.18, 1.55 + float(index % 3) * 0.16, 1.18)
		pillar.rotation = Vector3(0.04 * sin(angle), angle, 0.04 * cos(angle))
		proxy.add_child(pillar)
		var light := OmniLight3D.new()
		light.light_color = Color("#8879d9")
		light.light_energy = 1.5
		light.omni_range = 7.0
		light.shadow_enabled = false
		light.position = pillar.position + Vector3(0.0, 3.0, 0.0)
		proxy.add_child(light)
	for index: int in range(3):
		var crown := ROCK_LARGE.instantiate() as Node3D
		if crown == null:
			continue
		crown.name = "ArcoProxy_%02d" % index
		crown.position = Vector3(-3.6 + float(index) * 3.6, 4.0 + float(index % 2) * 0.65, -4.6)
		crown.scale = Vector3(3.2 if index != 1 else 3.8, 1.75 if index == 1 else 2.4, 2.1)
		crown.rotation = Vector3(0.0, 0.08 * float(index - 1), 0.0)
		proxy.add_child(crown)
	var base := MeshInstance3D.new()
	base.name = "BasePedraCupulaFinal"
	var base_mesh := CylinderMesh.new()
	base_mesh.top_radius = 7.2
	base_mesh.bottom_radius = 7.8
	base_mesh.height = 0.7
	base_mesh.radial_segments = 32
	base.mesh = base_mesh
	base.position = Vector3(0.0, 0.35, 0.0)
	var base_material := StandardMaterial3D.new()
	base_material.albedo_color = Color("#25233b")
	base_material.roughness = 0.92
	base.material_override = base_material
	proxy.add_child(base)
	for index: int in range(5):
		var approach_stone := ROCK_LARGE.instantiate() as Node3D
		if approach_stone == null:
			continue
		approach_stone.name = "DegrauValidacaoHubCupula_%02d" % index
		approach_stone.position = Vector3(sin(float(index) * 1.4) * 1.5, 0.78 + float(index % 2) * 0.08, 8.0 - float(index) * 2.3)
		approach_stone.scale = Vector3(0.55, 0.22, 0.42)
		approach_stone.rotation = Vector3(0.02, float(index) * 0.3, -0.03)
		var approach_material := StandardMaterial3D.new()
		approach_material.albedo_color = Color("#4a4566")
		approach_material.roughness = 0.9
		approach_stone.material_override = approach_material
		proxy.add_child(approach_stone)
		if index % 2 == 0:
			var approach_light := OmniLight3D.new()
			approach_light.light_color = Color("#8b78dc")
			approach_light.light_energy = 0.6
			approach_light.omni_range = 4.0
			approach_light.shadow_enabled = false
			approach_light.position = approach_stone.position + Vector3(0.0, 0.65, 0.0)
			proxy.add_child(approach_light)
	var core := MeshInstance3D.new()

	var sphere := SphereMesh.new()
	sphere.radius = 0.58
	sphere.height = 1.16
	core.mesh = sphere
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#6d5bd0")
	material.emission_enabled = true
	material.emission = Color("#6d5bd0")
	material.emission_energy_multiplier = 1.2
	core.material_override = material
	core.position = Vector3(0.0, 3.8, -2.2)
	proxy.add_child(core)
	var core_light := OmniLight3D.new()
	core_light.light_color = Color("#7f6bd6")
	core_light.light_energy = 2.4
	core_light.omni_range = 12.0
	core_light.shadow_enabled = false
	core_light.position = Vector3(0.0, 3.8, -2.2)
	proxy.add_child(core_light)
