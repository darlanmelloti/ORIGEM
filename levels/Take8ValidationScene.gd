## Take8ValidationScene.gd
## Direcção visual: Arqueologia Alpina Cinematográfica — câmara diagonal, rocha orgânica, névoa baixa e rota ascendente.
## Harness dedicado do Take 8; não substitui o mapa jogável nem toca nas Regiões 1–6.

extends Node3D

const TERRAIN_PATCH_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const HIGHLAND_REGION_SCRIPT: Script = preload("res://levels/HighlandRegion.gd")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")

var validation_camera: Camera3D
var elapsed: float = 0.0
var route_start := Vector3(198.0, 40.0, 408.0)
var route_end := Vector3(76.0, 43.0, 443.0)

func _ready() -> void:
	_build_environment()
	var terrain := TERRAIN_PATCH_SCRIPT.new() as Node3D
	terrain.name = "TerrainPatch"
	add_child(terrain)
	var highlands := HIGHLAND_REGION_SCRIPT.new() as Node3D
	highlands.name = "Take8HighlandRegion"
	add_child(highlands)
	_build_validation_wayfinding()
	validation_camera = Camera3D.new()
	validation_camera.name = "Take8RouteCamera"
	validation_camera.current = true
	validation_camera.fov = 45.0
	validation_camera.position = route_start
	add_child(validation_camera)
	validation_camera.look_at(route_start + Vector3(-20.0, -5.0, 28.0), Vector3.UP)

func _process(delta: float) -> void:
	if validation_camera == null:
		return
	elapsed += delta
	var progress: float = clampf(elapsed / 30.0, 0.0, 1.0)
	var eased: float = smoothstep(0.0, 1.0, progress)
	validation_camera.position = route_start.lerp(route_end, eased)
	var look_target: Vector3 = validation_camera.position + Vector3(-20.0, -5.0, 28.0)
	validation_camera.look_at(look_target, Vector3.UP)

func _build_validation_wayfinding() -> void:
	var points: Array[Vector3] = [Vector3(170.0, 44.0, 432.0), Vector3(160.0, 43.0, 440.0), Vector3(150.0, 42.0, 448.0), Vector3(140.0, 41.0, 456.0)]
	for index: int in range(points.size()):
		var rock: Node3D = ROCK_LARGE.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "Take8WayfindingRock_%02d" % index
		var ground_y: float = float(get_node("TerrainPatch").call("height_at", points[index].x, points[index].z))
		rock.position = Vector3(points[index].x, ground_y + 0.7, points[index].z)
		rock.scale = Vector3(1.8 - float(index) * 0.16, 2.2 - float(index) * 0.16, 1.55 - float(index) * 0.12)
		rock.rotation = Vector3(0.03, -0.18 + float(index) * 0.32, -0.04)
		add_child(rock)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	world.name = "Take8WorldEnvironment"
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#839caf")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#8baab4")
	environment.ambient_light_energy = 0.78
	environment.fog_enabled = true
	environment.fog_light_color = Color("#91aeb8")
	environment.fog_light_energy = 0.72
	environment.fog_density = 0.0008
	environment.fog_height = 18.0
	environment.fog_height_density = 0.012
	environment.volumetric_fog_enabled = false
	world.environment = environment
	add_child(world)
	var sun := DirectionalLight3D.new()
	sun.name = "Take8AlpineKey"
	sun.light_color = Color("#d7e5e2")
	sun.light_energy = 1.15
	sun.shadow_enabled = false
	sun.rotation_degrees = Vector3(-50.0, -28.0, 0.0)
	add_child(sun)
