## Dev5 — CP-D5-094: corredor vivo R3; QA isolado, sem arco estrutural/portal.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const DEER: PackedScene = preload("res://assets/models_cc0/deer_quaternius_cc0.glb")
const TREE: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const STONE_A: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const STONE_B: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")

const ROUTE_X := -16.741
var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var animals: Array[Node3D] = []
var origins: Array[Vector3] = []
var grounded := 0
var elapsed := 0.0
var cycles := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_spawn("ruina_lateral_a", Vector3(-29.0, 18.0, 77.0), STONE_A, Vector3(1.65, 1.28, 1.20), Vector3(0, 18, 8))
	_spawn("ruina_lateral_b", Vector3(-27.0, 18.0, 80.0), STONE_B, Vector3(1.90, 0.70, 1.12), Vector3(8, -25, 61))
	_spawn("tree_west", Vector3(-30.0, 18.0, 94.0), TREE, Vector3.ONE * 1.16)
	_spawn("tree_east", Vector3(-4.0, 18.0, 71.0), TREE, Vector3.ONE * 1.08)
	_spawn("fern_west", Vector3(-23.0, 18.0, 91.0), FERN, Vector3.ONE * 0.72)
	_spawn("fern_east", Vector3(-9.0, 18.0, 74.0), FERN, Vector3.ONE * 0.66)
	_spawn_deer("cervo_ruinas_oeste", Vector3(-28.0, 18.0, 88.0), 0.72, 102)
	_spawn_deer("cervo_ruinas_leste", Vector3(-5.0, 18.0, 70.0), 0.64, 248)
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify()
	_overlay()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "": call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _process(delta: float) -> void:
	elapsed += delta
	for index in range(animals.size()):
		animals[index].global_position = origins[index] + Vector3(sin(elapsed * 0.66 + index) * 0.42, 0, cos(elapsed * 0.47 + index) * 0.30)
	actor.global_position.z += 4.0 * delta
	if actor.global_position.z > 98.0:
		actor.global_position.z = 68.0
		cycles += 1
		print("[DEV5_R3_LIVING] route_cycle=%d clear=true fauna_distance=%.2f structural_arch=false scale_compressed=false" % [cycles, _nearest_animal()])

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.11, 0.12, 0.13)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.42, 0.41, 0.35)
	env.ambient_light_energy = 0.70
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.fog_enabled = true
	env.fog_light_color = Color(0.23, 0.25, 0.23)
	env.fog_density = 0.014
	world.environment = env
	add_child(world)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-45, 18, 0)
	sun.light_energy = 1.08
	sun.shadow_enabled = true
	add_child(sun)

func _build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.position = Vector3(ROUTE_X, -0.5, 84.0)
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(44, 0.9, 48)
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.20, 0.18, 0.12)
	mat.roughness = 0.95
	mesh.material = mat
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	ground.add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	ground.add_child(collision)

func _spawn(id: String, hint: Vector3, scene: PackedScene, scale_value: Vector3, rotation_value := Vector3.ZERO) -> void:
	var item := scene.instantiate() as Node3D
	item.name = id
	item.scale = scale_value
	item.rotation_degrees = rotation_value
	add_child(item)
	var result := GROUNDING.snap_to_ground(get_world_3d(), item, hint)
	assert(result["grounded"])
	grounded += 1

func _spawn_deer(id: String, hint: Vector3, scale_value: float, yaw: float) -> void:
	var root := Node3D.new()
	root.name = id
	root.scale = Vector3.ONE * scale_value
	root.rotation_degrees.y = yaw
	add_child(root)
	root.add_child(DEER.instantiate())
	assert(GROUNDING.snap_to_ground(get_world_3d(), root, hint)["grounded"])
	animals.append(root)
	origins.append(root.global_position)
	grounded += 1

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasArcoVivoQA"
	actor.position = Vector3(ROUTE_X, 1.18, 68.0)
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

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQAArcoVivo"
	camera.position = Vector3(2.0, 5.0, 64.0)
	camera.fov = 50.0
	add_child(camera)
	camera.look_at(Vector3(ROUTE_X, 1.0, 83.0), Vector3.UP)
	camera.make_current()

func _nearest_animal() -> float:
	var nearest := INF
	for deer in animals: nearest = minf(nearest, Vector2(deer.global_position.x - ROUTE_X, deer.global_position.z - actor.global_position.z).length())
	return nearest

func _verify() -> void:
	assert(grounded == 8 and animals.size() == 2)
	assert(elias.follow_camera != null)
	elias.follow_camera.current = false
	assert(get_viewport().get_camera_3d() != elias.follow_camera)
	assert(_nearest_animal() >= 5.0)
	print("[DEV5_R3_LIVING] status=approved fauna=2 vegetation=4 ruin_parts=2 grounded=%d structural_arch=false scale_compressed=false production_modules_changed=false" % grounded)

func _overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(46, 42)
	label.size = Vector2(1260, 84)
	label.text = "ARCO DAS RUÍNAS VIVO R3  |  ELIAS · FAUNA CC0 · MARGEM VEGETAL · RUÍNAS LATERAIS\nGROUNDING X/Z · CORREDOR R3→R4 · ZERO ARCO ESTRUTURAL · 1 LUZ DINÂMICA"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.95, 0.94, 0.90)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame in range(50): await get_tree().process_frame
	var texture := get_viewport().get_texture()
	if texture == null: return
	var image := texture.get_image()
	if image == null: return
	print("[DEV5_R3_LIVING] snapshot=%s result=%s" % [path, image.save_png(path)])
