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
		var cube := chamber.get_node_or_null("CuboOrion") as Node3D
		if cube != null:
			var cube_reveal := StandardMaterial3D.new()
			cube_reveal.albedo_color = Color("#496e78")
			cube_reveal.roughness = 0.72
			cube_reveal.emission_enabled = true
			cube_reveal.emission = Color("#8c6cff")
			cube_reveal.emission_energy_multiplier = 0.72
			cube.scale = Vector3(0.95, 1.25, 0.95)
			if destination.has_method("_apply_material"):
				destination.call("_apply_material", cube, cube_reveal)
		for chamber_child in chamber.get_children():
			if chamber_child is OmniLight3D and chamber_child.name.begins_with("BraseiroAnelCube"):
				chamber_child.light_energy = 0.62
			elif chamber_child is Node3D and chamber_child.name.begins_with("SuporteOrganicoOrionCube"):
				var support_reveal := StandardMaterial3D.new()
				support_reveal.albedo_color = Color("#3f626b")
				support_reveal.roughness = 0.78
				support_reveal.emission_enabled = true
				support_reveal.emission = Color("#356a9a")
				support_reveal.emission_energy_multiplier = 0.36
				chamber_child.scale *= 1.18
				if destination.has_method("_apply_material"):
					destination.call("_apply_material", chamber_child, support_reveal)
	camera = Camera3D.new()
	camera.name = "Region11ValidationCamera"
	camera.position = Vector3(-100.0, 56.0, 580.0)
	camera.fov = 54.0
	add_child(camera)
	camera.look_at(Vector3(-116.0, 45.5, 562.0), Vector3.UP)
	camera.current = true

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#07111b")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#2e3e52")
	environment.ambient_light_energy = 1.55
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 1.35
	environment.glow_enabled = true
	environment.glow_intensity = 0.30
	environment.glow_bloom = 0.10
	world.environment = environment
	add_child(world)
	var moon := DirectionalLight3D.new()
	moon.light_color = Color("#8da7c1")
	moon.light_energy = 1.12
	moon.rotation_degrees = Vector3(-42.0, 22.0, 0.0)
	add_child(moon)
	var fill := DirectionalLight3D.new()
	fill.name = "RecorteSuaveCamaraCube"
	fill.light_color = Color("#5d9bb5")
	fill.light_energy = 0.82
	fill.rotation_degrees = Vector3(-22.0, -58.0, 0.0)
	add_child(fill)
	var base_fill := OmniLight3D.new()
	base_fill.name = "PreenchimentoQuenteBaseCamaraCube"
	base_fill.light_color = Color("#c68b62")
	base_fill.light_energy = 1.10
	base_fill.omni_range = 8.0
	base_fill.shadow_enabled = false
	base_fill.position = Vector3(-116.0, 43.0, 562.0)
	add_child(base_fill)

func _process(delta: float) -> void:
	if camera == null:
		return
	elapsed += delta
	camera.position = Vector3(-101.0 + sin(elapsed * 0.24) * 1.6, 54.0 + sin(elapsed * 0.19) * 0.3, 576.0 + cos(elapsed * 0.24) * 1.5)
	camera.look_at(Vector3(-116.0, 45.5, 562.0), Vector3.UP)
