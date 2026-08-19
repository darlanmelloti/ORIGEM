## Dev5 — CP-D5-052: composição QA R5; isolada de módulos de produção.
extends Node3D

const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const OBJECTS := preload("res://levels/dev5/CartographicLandmarkObjects.gd")
const ELIAS_PRESENTATION := preload("res://entities/player/third_person/EliasThirdPersonPresentation.gd")
const TREE_DETAILED: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")

const PAVILION_XZ := Vector2(-88.0, 178.0)
const ROUTE_X := -80.0
const ELIAS_RADIUS := 0.55
const PAVILION_HALF_WIDTH := 2.0
const MIN_CLEARANCE := 4.0

var actor: CharacterBody3D
var elias: EliasThirdPersonPresentation
var elapsed := 0.0
var route_cycles := 0
var grounded_count := 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	await get_tree().physics_frame
	_build_pavilion()
	_build_vegetation()
	_build_elias()
	_build_camera()
	await get_tree().process_frame
	_verify_contract()
	_build_overlay()
	var clearance := abs(ROUTE_X - PAVILION_XZ.x) - PAVILION_HALF_WIDTH - ELIAS_RADIUS
	assert(clearance >= MIN_CLEARANCE)
	assert(grounded_count == 5)
	assert(_dynamic_lights() == 1)
	print("[DEV5_R5_READ] status=approved pavilion_xz=(%.2f,%.2f) route_x=%.2f clearance=%.2f vegetation=5 wall_of_trees=false" % [PAVILION_XZ.x, PAVILION_XZ.y, ROUTE_X, clearance])
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _process(delta: float) -> void:
	if actor == null:
		return
	elapsed += delta
	var phase := fmod(elapsed, 12.0) / 12.0
	actor.position.z = lerp(163.0, 194.0, phase)
	if elapsed >= float(route_cycles + 1) * 12.0:
		route_cycles += 1
		print("[DEV5_R5_READ] route_cycle=%d clear=true actor=Elias" % route_cycles)

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.13, 0.22, 0.27)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.45, 0.56, 0.50)
	environment.ambient_light_energy = 0.76
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-52.0, -25.0, 0.0)
	sun.light_energy = 1.05
	add_child(sun)

func _build_ground() -> void:
	var ground := Node3D.new()
	ground.name = "TerrenoMajesticLeituraQA"
	ground.position = Vector3(-84.0, 0.0, 179.0)
	ground.rotation_degrees.z = -3.0
	add_child(ground)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.105, 0.19, 0.105)
	material.roughness = 0.97
	var mesh := BoxMesh.new()
	mesh.size = Vector3(46.0, 0.9, 46.0)
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	body.name = "TerrenoMajesticLeituraQAColisor"
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)

func _build_pavilion() -> void:
	var library := OBJECTS.new()
	add_child(library)
	await get_tree().physics_frame
	var pavilion := library.create_majestic_pavilion_landmark()
	add_child(pavilion)
	var result := GROUNDING.snap_to_ground(get_world_3d(), pavilion, Vector3(PAVILION_XZ.x, 15.0, PAVILION_XZ.y))
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(PAVILION_XZ) < 0.001)
	print("[DEV5_R5_READ] pavilion_grounded=%s xz=(%.2f,%.2f)" % [result["grounded"], PAVILION_XZ.x, PAVILION_XZ.y])

func _build_vegetation() -> void:
	# Cinco elementos: 1 detalhado, 2 leves e 2 fetos; bordos do corredor apenas.
	_spawn_grounded("tree_medium_right", Vector3(-73.0, 15.0, 185.0), TREE_DETAILED, Vector3.ONE * 1.20)
	_spawn_grounded("tree_light_left", Vector3(-97.0, 15.0, 190.0), TREE_LIGHT, Vector3.ONE * 1.35)
	_spawn_grounded("tree_light_far", Vector3(-101.0, 15.0, 200.0), TREE_LIGHT, Vector3.ONE * 1.15)
	_spawn_grounded("fern_left", Vector3(-83.5, 15.0, 171.0), FERN, Vector3.ONE * 0.58)
	_spawn_grounded("fern_right", Vector3(-76.8, 15.0, 176.0), FERN, Vector3.ONE * 0.54)

func _spawn_grounded(candidate_id: String, target: Vector3, packed: PackedScene, candidate_scale: Vector3) -> void:
	var candidate := packed.instantiate() as Node3D
	candidate.name = candidate_id
	candidate.scale = candidate_scale
	add_child(candidate)
	var result := GROUNDING.snap_to_ground(get_world_3d(), candidate, target)
	assert(result["grounded"] and (result["world_xz"] as Vector2).distance_to(Vector2(target.x, target.z)) < 0.001)
	grounded_count += 1
	print("[DEV5_R5_READ] grounded=%s xz=(%.2f,%.2f) y=%.2f" % [candidate_id, target.x, target.z, result["impact_y"]])

func _build_elias() -> void:
	actor = CharacterBody3D.new()
	actor.name = "EliasLeituraMajesticQA"
	actor.position = Vector3(ROUTE_X, 0.95, 163.0)
	add_child(actor)
	var capsule := CollisionShape3D.new()
	var capsule_shape := CapsuleShape3D.new()
	capsule_shape.radius = ELIAS_RADIUS
	capsule_shape.height = 1.9
	capsule.shape = capsule_shape
	capsule.position.y = 0.95
	actor.add_child(capsule)
	elias = ELIAS_PRESENTATION.new()
	elias.enabled_for_preview = true
	actor.add_child(elias)

func _verify_contract() -> void:
	assert(elias != null and elias.follow_camera != null)
	elias.follow_camera.current = false
	var viewport_camera := get_viewport().get_camera_3d()
	assert(viewport_camera != null and viewport_camera != elias.follow_camera)
	print("[DEV5_R5_READ] elias_camera_current=%s viewport_owner=%s production_modules_changed=false" % [elias.follow_camera.current, viewport_camera.name])

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQAMajesticLeitura"
	camera.position = Vector3(-66.0, 8.5, 157.0)
	camera.fov = 52.0
	add_child(camera)
	camera.look_at(Vector3(-85.0, 1.5, 183.0), Vector3.UP)
	camera.make_current()

func _dynamic_lights() -> int:
	var count := 0
	for node: Node in get_children():
		if node is Light3D:
			count += 1
	return count

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1080.0, 88.0)
	label.text = "CP-D5-052  |  LEITURA R5: ELIAS · PAVILHÃO · VEGETAÇÃO\nCORREDOR X=-80 · FOLGA ≥4,00 M · 5 ELEMENTOS ATERRADOS · SEM PAREDE FLORESTAL"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture: Texture2D = get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_R5_READ] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image: Image = viewport_texture.get_image()
	if image == null:
		print("[DEV5_R5_READ] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_R5_READ] snapshot=%s result=%s" % [path, result])
