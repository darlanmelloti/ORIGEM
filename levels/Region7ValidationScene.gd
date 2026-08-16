## Region7ValidationScene.gd
## Direcção visual: Vila Elevada — handoff CP 201–202, aterramento orgânico, crepúsculo litúrgico e estela CC0.
extends Node3D

const TERRAIN_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const HIGHLAND_SCRIPT: Script = preload("res://levels/HighlandRegion.gd")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")

var validation_camera: Camera3D
var elapsed: float = 0.0
var camera_start := Vector3.ZERO
var camera_end := Vector3.ZERO
var camera_target := Vector3.ZERO

func _ready() -> void:
	_build_environment()
	var terrain := TERRAIN_SCRIPT.new() as Node3D
	terrain.name = "TerrainPatch"
	add_child(terrain)
	var highland := HIGHLAND_SCRIPT.new() as Node3D
	highland.name = "Region7HighlandRegion"
	add_child(highland)
	var village_node := highland.get_node_or_null("VilaElevada") as Node3D
	if village_node != null:
		print("ORIGEM_REGION7_VILLAGE_GLOBAL ", village_node.global_position)
		var stela_node := village_node.get_node_or_null("EstelaChegadaRegiao7") as Node3D
		if stela_node != null:
			print("ORIGEM_REGION7_STELA_GLOBAL ", stela_node.global_position)
		for child in village_node.get_children():
			if child is Node3D and (String(child.name).begins_with("CasaDePedra") or String(child.name).begins_with("Afloramento")):
				print("ORIGEM_REGION7_CHILD_GLOBAL ", child.name, " ", (child as Node3D).global_position)
				for mesh_node in (child as Node3D).find_children("*", "MeshInstance3D", true, false):
					var mesh_instance := mesh_node as MeshInstance3D
					print("ORIGEM_REGION7_MESH ", mesh_instance.name, " visible=", mesh_instance.visible, " global=", mesh_instance.global_position, " aabb=", mesh_instance.get_aabb())
		_build_region7_cinematic_house_reveal()
	var village_y: float = float(terrain.call("height_at", 140.0, 352.0)) + 5.0
	for terrain_probe in [Vector2(130.0, 354.0), Vector2(140.0, 358.0), Vector2(150.0, 362.0)]:
		print("ORIGEM_REGION7_TERRAIN_PROBE ", terrain_probe, " ", terrain.call("height_at", terrain_probe.x, terrain_probe.y))
	camera_start = Vector3(140.0, 24.0, 348.0)
	camera_end = Vector3(140.0, 22.0, 353.0)
	camera_target = Vector3(140.0, 18.5, 363.0)
	validation_camera = Camera3D.new()
	validation_camera.name = "Region7VillageCamera"
	validation_camera.current = true
	validation_camera.fov = 48.0
	validation_camera.position = camera_start
	add_child(validation_camera)
	validation_camera.look_at(camera_target, Vector3.UP)

func _build_region7_cinematic_house_reveal() -> void:
	var reveal := Node3D.new()
	reveal.name = "Region7OrganicHouseReveal"
	reveal.position = Vector3(140.0, 14.8, 357.0)
	add_child(reveal)
	var reveal_material := StandardMaterial3D.new()
	reveal_material.albedo_color = Color("#b89d76")
	reveal_material.roughness = 0.88
	reveal_material.emission_enabled = true
	reveal_material.emission = Color("#7a542f")
	reveal_material.emission_energy_multiplier = 0.75
	var house_positions: Array[Vector3] = [Vector3(-3.8, 0.0, 1.0), Vector3(3.8, 0.8, 4.5), Vector3(0.0, 1.8, 8.0)]
	for index: int in range(house_positions.size()):
		var base := ROCK_LARGE.instantiate() as Node3D
		if base == null:
			continue
		base.name = "CasaRevealBase_%02d" % index
		base.position = house_positions[index]
		base.scale = Vector3(2.2, 0.48, 1.65)
		base.rotation = Vector3(0.02, 0.22 * float(index), -0.03)
		_apply_region7_reveal_material(base, reveal_material)
		reveal.add_child(base)
		for pillar_index: int in range(3):
			var pillar := PILLAR.instantiate() as Node3D
			if pillar == null:
				continue
			pillar.name = "CasaRevealPilar_%02d_%02d" % [index, pillar_index]
			pillar.position = house_positions[index] + Vector3(-1.4 + float(pillar_index) * 1.4, 2.1, 0.0)
			pillar.scale = Vector3(0.42, 1.25 + 0.12 * float(pillar_index % 2), 0.42)
			pillar.rotation = Vector3(0.02, 0.16 * float(index), -0.02)
			_apply_region7_reveal_material(pillar, reveal_material)
			reveal.add_child(pillar)
		var roof := ROCK_LARGE.instantiate() as Node3D
		if roof != null:
			roof.name = "CasaRevealCobertura_%02d" % index
			roof.position = house_positions[index] + Vector3(0.0, 3.55, 0.0)
			roof.scale = Vector3(2.35, 0.34, 1.75)
			roof.rotation = Vector3(0.12, 0.28 * float(index), -0.08)
			_apply_region7_reveal_material(roof, reveal_material)
			reveal.add_child(roof)
		var hearth := OmniLight3D.new()
		hearth.name = "CasaRevealLuz_%02d" % index
		hearth.position = house_positions[index] + Vector3(0.0, 2.1, 0.4)
		hearth.light_color = Color("#d9a95f")
		hearth.light_energy = 1.8
		hearth.omni_range = 8.0
		hearth.shadow_enabled = false
		reveal.add_child(hearth)

func _apply_region7_reveal_material(root: Node3D, material: StandardMaterial3D) -> void:
	for mesh_node in root.find_children("*", "MeshInstance3D", true, false):
		(mesh_node as MeshInstance3D).set_surface_override_material(0, material)

func _process(delta: float) -> void:
	if validation_camera == null:
		return
	elapsed += delta
	var progress: float = clampf(elapsed / 30.0, 0.0, 1.0)
	var eased: float = smoothstep(0.0, 1.0, progress)
	validation_camera.position = camera_start.lerp(camera_end, eased)
	validation_camera.look_at(camera_target, Vector3.UP)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	world.name = "Region7ValidationEnvironment"
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#839caf")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#8baab4")
	environment.ambient_light_energy = 1.12
	environment.fog_enabled = true
	environment.fog_light_color = Color("#91aeb8")
	environment.fog_light_energy = 0.56
	environment.fog_density = 0.00025
	environment.fog_height = 18.0
	environment.fog_height_density = 0.012
	environment.volumetric_fog_enabled = false
	world.environment = environment
	add_child(world)
	var key := DirectionalLight3D.new()
	key.name = "Region7TwilightKey"
	key.light_color = Color("#d7e5e2")
	key.light_energy = 1.55
	key.shadow_enabled = false
	key.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	add_child(key)
	var warm_fill := DirectionalLight3D.new()
	warm_fill.name = "Region7VillageWarmFill"
	warm_fill.light_color = Color("#e0a477")
	warm_fill.light_energy = 0.18
	warm_fill.shadow_enabled = false
	warm_fill.rotation_degrees = Vector3(-22.0, 142.0, 8.0)
	add_child(warm_fill)
