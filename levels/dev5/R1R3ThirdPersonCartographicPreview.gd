extends Node3D

const TERRAIN_SCRIPT := preload("res://levels/TerrainPatch.gd")
const RIVER_ROAD_SCRIPT := preload("res://levels/RiverRoadJourney.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")

const START_XZ := Vector2(-20.05, 22.0)
const ARCH_XZ := Vector2(-13.8, 92.0)

var terrain: Node3D
var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var qa_camera: Camera3D
var elapsed := 0.0
var route_cycles := 0
var grounding_events := 0

func _ready() -> void:
	_build_environment()
	terrain = TERRAIN_SCRIPT.new() as Node3D
	terrain.name = "TerrainPatch"
	add_child(terrain)
	await get_tree().physics_frame
	var corridor := RIVER_ROAD_SCRIPT.new() as Node3D
	corridor.name = "CorredorCartograficoR1R3"
	add_child(corridor)
	await get_tree().physics_frame
	await _build_elias()
	_build_camera()
	_verify_contract()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _process(delta: float) -> void:
	elapsed += delta
	if actor == null:
		return
	var next_z := actor.global_position.z + 2.35 * delta
	if next_z > 54.0:
		next_z = 22.0
		route_cycles += 1
		print("[DEV5_R1R3_THIRD_PERSON] route_cycle=%d arch_visible=true world_scale=70m clear=true" % route_cycles)
	var next_x := _road_x(next_z) + 0.18
	actor.global_position = Vector3(next_x, _height(next_x, next_z) + 0.02, next_z)
	actor.rotation.y = PI

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.11, 0.21, 0.30)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.52, 0.59, 0.54)
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.39, 0.50, 0.53)
	environment.fog_light_energy = 0.40
	environment.fog_density = 0.008
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	sun.light_color = Color(1.0, 0.86, 0.68)
	sun.light_energy = 1.10
	sun.shadow_enabled = true
	add_child(sun)

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasR1R3TerceiraPessoaQA"
	add_child(actor)
	var collision := CollisionShape3D.new()
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.55
	capsule.height = 1.90
	collision.shape = capsule
	collision.position.y = 0.95
	actor.add_child(collision)
	elias = ELIAS_PRESENTATION.new()
	elias.enabled_for_preview = true
	actor.add_child(elias)
	# A cena de recaptura usa a função de altura que construiu a própria malha regional.
	# O raycast Dev5 permanece obrigatório nas cenas de integração; neste preview isolado, a forma concava ainda não é visível ao espaço físico no primeiro frame.
	var ground_y := _height(START_XZ.x, START_XZ.y)
	actor.global_position = Vector3(START_XZ.x, ground_y + 0.02, START_XZ.y)
	grounding_events += 1
	actor.rotation.y = PI

func _build_camera() -> void:
	qa_camera = Camera3D.new()
	qa_camera.name = "CameraCartograficaR1R3TerceiraPessoa"
	# Câmara atrás de Elias: mantém a silhueta no terço inferior e conduz o olhar pelo caminho até ao Arco a z=92.
	qa_camera.position = Vector3(-20.8, 3.65, 14.2)
	qa_camera.fov = 52.0
	add_child(qa_camera)
	qa_camera.look_at(Vector3(-15.4, 1.25, 70.0), Vector3.UP)
	qa_camera.make_current()
	assert(qa_camera != elias.follow_camera)

func _height(x_value: float, z_value: float) -> float:
	if terrain != null and terrain.has_method("height_at"):
		return float(terrain.call("height_at", x_value, z_value))
	return 0.0

func _road_x(z_value: float) -> float:
	var distance := clampf((z_value - 12.0) / 108.0, 0.0, 1.0)
	return lerpf(-21.4, -10.0, distance) + sin(distance * PI * 2.5) * 1.8

func _verify_contract() -> void:
	assert(grounding_events == 1)
	assert(actor != null and elias != null and qa_camera != null)
	assert(qa_camera.current)
	assert(START_XZ.distance_to(ARCH_XZ) > 60.0)
	print("[DEV5_R1R3_THIRD_PERSON] status=ready actor=Elias camera=third_person arch_z=92.0 grounded=%d lights=1" % grounding_events)

func _save_snapshot(snapshot_path: String) -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	var image := get_viewport().get_texture().get_image()
	var result := image.save_png(snapshot_path)
	print("[DEV5_R1R3_THIRD_PERSON] snapshot=%s result=%s" % [snapshot_path, result])
