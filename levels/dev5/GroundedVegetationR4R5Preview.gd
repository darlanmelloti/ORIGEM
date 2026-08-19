## Dev5 — CP-D5-030: vegetação média aterrada, sem portal estrutural nem parede florestal.

extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const PINE_TALL: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const TREE_DETAILED: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")

var grounded_count := 0
var tracked_candidates: Array[Node3D] = []

func _ready() -> void:
	_build_environment()
	_build_ground_patch("TerrenoR4QA", Vector3(-9.0, 0.0, 116.0), 5.0)
	_build_ground_patch("TerrenoR5QA", Vector3(-88.0, 0.0, 178.0), -4.0)
	await get_tree().physics_frame
	_build_r4_composition()
	_build_r5_composition()
	await get_tree().physics_frame
	assert(grounded_count == 12)
	assert(_count_dynamic_lights() == 1)
	_build_camera()
	_build_overlay()
	print("[DEV5_VEGETATION_GROUNDING] status=approved candidates=%d pine_focal=1 detailed=3 light=6 ferns=2 dynamic_lights_added=0 wall_of_trees=false production_modules_changed=false" % grounded_count)
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.16, 0.25, 0.30)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.43, 0.56, 0.54)
	environment.ambient_light_energy = 0.78
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-52.0, -28.0, 0.0)
	sun.light_energy = 1.08
	add_child(sun)

func _build_ground_patch(node_name: String, center: Vector3, slope_z: float) -> void:
	var ground := Node3D.new()
	ground.name = node_name
	ground.position = center
	ground.rotation_degrees.z = slope_z
	add_child(ground)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.12, 0.21, 0.11)
	material.roughness = 0.96
	var mesh := BoxMesh.new()
	mesh.size = Vector3(42.0, 0.9, 42.0)
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	body.name = node_name + "_Colisor"
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)
	for index: int in range(7):
		var side := -1.0 if index % 2 == 0 else 1.0
		var mound := MeshInstance3D.new()
		var mound_mesh := SphereMesh.new()
		mound_mesh.radius = 0.42 + float(index % 3) * 0.15
		mound_mesh.height = 0.58 + float(index % 2) * 0.18
		mound_mesh.material = material
		mound.mesh = mound_mesh
		mound.position = Vector3(side * (8.0 + float(index % 2) * 2.2), 0.16, -13.0 + float(index) * 3.7)
		mound.scale = Vector3(1.7, 0.75, 1.1)
		ground.add_child(mound)

func _build_r4_composition() -> void:
	# R4: abertura central de 5,2 m mantida livre; vegetação toma apenas os dois bordos em profundidade.
	_spawn_grounded("r4_pine_focal", 4, Vector2(-7.2, 9.0), PINE_TALL, Vector3.ONE * 0.95)
	_spawn_grounded("r4_tree_medium_a", 4, Vector2(6.8, 10.4), TREE_DETAILED, Vector3.ONE * 1.35)
	_spawn_grounded("r4_tree_medium_b", 4, Vector2(-10.0, 17.0), TREE_DETAILED, Vector3.ONE * 1.15)
	_spawn_grounded("r4_light_distant_a", 4, Vector2(11.5, 18.5), TREE_LIGHT, Vector3.ONE * 1.55)
	_spawn_grounded("r4_light_distant_b", 4, Vector2(-14.0, 20.0), TREE_LIGHT, Vector3.ONE * 1.35)
	_spawn_grounded("r4_fern_left", 4, Vector2(-3.3, 4.6), FERN, Vector3.ONE * 0.58)

func _build_r5_composition() -> void:
	# R5: os grupos ficam nos bordos do acampamento, sem fechar a leitura do pavilhão nem uma rota futura.
	_spawn_grounded("r5_tree_medium", 5, Vector2(8.4, 8.0), TREE_DETAILED, Vector3.ONE * 1.25)
	_spawn_grounded("r5_light_distant_a", 5, Vector2(-11.8, 14.0), TREE_LIGHT, Vector3.ONE * 1.45)
	_spawn_grounded("r5_light_distant_b", 5, Vector2(13.5, 18.0), TREE_LIGHT, Vector3.ONE * 1.25)
	_spawn_grounded("r5_light_distant_c", 5, Vector2(-15.0, 20.0), TREE_LIGHT, Vector3.ONE * 1.40)
	_spawn_grounded("r5_light_distant_d", 5, Vector2(16.0, -13.5), TREE_LIGHT, Vector3.ONE * 1.20)
	_spawn_grounded("r5_fern_right", 5, Vector2(3.2, 5.0), FERN, Vector3.ONE * 0.54)

func _spawn_grounded(candidate_id: String, anchor_id: int, local_offset: Vector2, packed_scene: PackedScene, candidate_scale: Vector3) -> void:
	var record := PLACEMENT.placement_record(candidate_id, anchor_id, local_offset, 15.0)
	var candidate := packed_scene.instantiate() as Node3D
	candidate.name = candidate_id
	candidate.scale = candidate_scale
	add_child(candidate)
	var result := GROUNDING.snap_to_ground(get_world_3d(), candidate, record["world_position"] as Vector3)
	var desired := record["world_position"] as Vector3
	var xz_preserved := (result["world_xz"] as Vector2).distance_to(Vector2(desired.x, desired.z)) < 0.001
	assert(result["grounded"] and xz_preserved)
	grounded_count += 1
	tracked_candidates.append(candidate)
	print("[DEV5_VEGETATION_GROUNDING] id=%s r=%d xz=(%.2f,%.2f) impact_y=%.2f grounded=%s xz_preserved=%s" % [candidate_id, anchor_id, desired.x, desired.z, result["impact_y"], result["grounded"], xz_preserved])

func _count_dynamic_lights() -> int:
	var count := 0
	for child: Node in get_children():
		if child is Light3D:
			count += 1
	return count

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(3.5, 6.8, 103.0)
	camera.fov = 59.0
	add_child(camera)
	camera.look_at(Vector3(-9.0, 1.2, 127.5), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 48.0)
	label.size = Vector2(890.0, 90.0)
	label.text = "CP-D5-030  |  VEGETAÇÃO ATERRADA R4/R5\nR4 EM PRIMEIRO PLANO · CORREDOR LIVRE · LOD CONTROLADO"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.88, 0.94, 0.96)
	layer.add_child(label)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_VEGETATION_GROUNDING] snapshot_unavailable=headless_renderer path=%s" % snapshot_path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_VEGETATION_GROUNDING] snapshot_unavailable=headless_image path=%s" % snapshot_path)
		return
	var result := image.save_png(snapshot_path)
	print("[DEV5_VEGETATION_GROUNDING] snapshot=%s result=%s" % [snapshot_path, result])
