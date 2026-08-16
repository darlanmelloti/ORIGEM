## Region7ValidationScene.gd
## Direcção visual: Vila Elevada — handoff CP 201–202, aterramento orgânico, crepúsculo litúrgico e estela CC0.
extends Node3D

const TERRAIN_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const HIGHLAND_SCRIPT: Script = preload("res://levels/HighlandRegion.gd")

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
	var village_y: float = float(terrain.call("height_at", 140.0, 352.0)) + 5.0
	for terrain_probe in [Vector2(130.0, 354.0), Vector2(140.0, 358.0), Vector2(150.0, 362.0)]:
		print("ORIGEM_REGION7_TERRAIN_PROBE ", terrain_probe, " ", terrain.call("height_at", terrain_probe.x, terrain_probe.y))
	camera_start = Vector3(132.0, 23.0, 346.0)
	camera_end = Vector3(136.0, 19.0, 350.0)
	camera_target = Vector3(140.0, 16.5, 357.5)
	validation_camera = Camera3D.new()
	validation_camera.name = "Region7VillageCamera"
	validation_camera.current = true
	validation_camera.fov = 52.0
	validation_camera.position = camera_start
	add_child(validation_camera)
	validation_camera.look_at(camera_target, Vector3.UP)

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
	key.light_energy = 1.35
	key.shadow_enabled = false
	key.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	add_child(key)
