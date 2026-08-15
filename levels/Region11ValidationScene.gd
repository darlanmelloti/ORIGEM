extends Node3D
## Região 11 validation-only scene: Câmara orgânica do Orion Cube.
## Reuses the normal OrionDestinationRegion builder and does not alter Regions 1–6.

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
	var cave := destination.get_node_or_null("CavernaDoOrion") as Node3D
	if cave != null:
		cave.visible = false
	var approach := destination.get_node_or_null("TransicaoRegiao09Para10") as Node3D
	if approach != null:
		approach.visible = false
	var hub := destination.get_node_or_null("HubTemporal") as Node3D
	if hub != null:
		hub.visible = false
	var chamber := destination.get_node_or_null("CamaraDoOrionCube") as Node3D
	if chamber != null:
		chamber.visible = true
	camera = Camera3D.new()
	camera.name = "Region11ValidationCamera"
	camera.position = Vector3(-101.0, 54.0, 576.0)
	camera.fov = 54.0
	add_child(camera)
	camera.look_at(Vector3(-116.0, 46.0, 562.0), Vector3.UP)
	camera.current = true

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#07111b")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#2e3e52")
	environment.ambient_light_energy = 0.58
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.glow_enabled = true
	environment.glow_intensity = 0.42
	environment.glow_bloom = 0.14
	world.environment = environment
	add_child(world)
	var moon := DirectionalLight3D.new()
	moon.light_color = Color("#8da7c1")
	moon.light_energy = 0.42
	moon.rotation_degrees = Vector3(-42.0, 22.0, 0.0)
	add_child(moon)

func _process(delta: float) -> void:
	if camera == null:
		return
	elapsed += delta
	camera.position = Vector3(-101.0 + sin(elapsed * 0.24) * 1.6, 54.0 + sin(elapsed * 0.19) * 0.3, 576.0 + cos(elapsed * 0.24) * 1.5)
	camera.look_at(Vector3(-116.0, 46.0, 562.0), Vector3.UP)
