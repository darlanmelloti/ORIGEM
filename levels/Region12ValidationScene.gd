extends Node3D
## Região 12 validation-only scene: Hub Temporal orgânico.
## Reuses OrionDestinationRegion and isolates HubTemporal; earlier regions remain untouched.

const TERRAIN_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const DESTINATION_SCRIPT: Script = preload("res://levels/OrionDestinationRegion.gd")
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
	await get_tree().process_frame
	for branch_name in ["CavernaDoOrion", "TransicaoRegiao09Para10", "CamaraDoOrionCube"]:
		var branch := destination.get_node_or_null(branch_name) as Node3D
		if branch != null:
			branch.visible = false
	var hub := destination.get_node_or_null("HubTemporal") as Node3D
	if hub != null:
		hub.visible = true
	camera = Camera3D.new()
	camera.name = "Region12ValidationCamera"
	camera.position = Vector3(183.0, 25.0, 230.0)
	camera.fov = 56.0
	add_child(camera)
	camera.look_at(Vector3(164.0, 5.0, 210.0), Vector3.UP)
	camera.current = true

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#100d1e")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#46395a")
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.glow_enabled = true
	environment.glow_intensity = 0.48
	environment.glow_bloom = 0.16
	world.environment = environment
	add_child(world)
	var moon := DirectionalLight3D.new()
	moon.light_color = Color("#a9a0c6")
	moon.light_energy = 0.52
	moon.rotation_degrees = Vector3(-42.0, 28.0, 0.0)
	add_child(moon)
	var fill := DirectionalLight3D.new()
	fill.light_color = Color("#7b6aa4")
	fill.light_energy = 0.34
	fill.rotation_degrees = Vector3(-18.0, -52.0, 0.0)
	add_child(fill)

func _process(delta: float) -> void:
	if camera == null:
		return
	elapsed += delta
	camera.position = Vector3(183.0 + sin(elapsed * 0.22) * 2.5, 25.0 + sin(elapsed * 0.18) * 0.35, 230.0 + cos(elapsed * 0.22) * 2.2)
	camera.look_at(Vector3(164.0, 5.0, 210.0), Vector3.UP)
