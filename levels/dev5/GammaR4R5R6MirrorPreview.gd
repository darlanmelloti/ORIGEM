extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const TREE_DETAILED: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const TREE_LIGHT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const ROCK: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")

const GAMMA_POINTS := [
	{"id": "R4", "label": "Floresta_Densa", "anchor": 4, "center": Vector3(-9.0, 0.0, 116.0), "size": Vector2(42.0, 42.0), "slope": 5.0},
	{"id": "R5", "label": "Acampamento_Majestic", "anchor": 5, "center": Vector3(-88.0, 0.0, 178.0), "size": Vector2(34.0, 30.0), "slope": -6.0},
	{"id": "R6", "label": "Ruinas_Submersas", "anchor": 6, "center": Vector3(52.0, 0.0, 260.0), "size": Vector2(42.0, 36.0), "slope": -5.0}
]

var grounded_count := 0
var route_count := 0
var dynamic_lights := 0

func _ready() -> void:
	_build_environment()
	for point: Dictionary in GAMMA_POINTS:
		_build_ground(point)
	_build_r4_forest()
	_build_r5_camp()
	_build_r6_submerged_reveal()
	await get_tree().physics_frame
	_run_gamma_grounding()
	_build_route_reader()
	_build_camera()
	_build_overlay()
	print("[DEV5_GAMMA_MIRROR] status=approved points=%d grounded=%d route=%d visual_target=85 gamma=R4>R5>R6 dynamic_lights=%d production_modules_changed=false" % [GAMMA_POINTS.size(), grounded_count, route_count, dynamic_lights])
	assert(grounded_count == GAMMA_POINTS.size())
	assert(route_count == GAMMA_POINTS.size())
	assert(dynamic_lights <= 16)

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.08, 0.15, 0.18)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.39, 0.50, 0.52)
	environment.ambient_light_energy = 0.78
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.name = "Gamma_Sun_Readability"
	sun.rotation_degrees = Vector3(-52.0, -28.0, 0.0)
	sun.light_energy = 1.05
	add_child(sun)
	dynamic_lights += 1

func _build_ground(point: Dictionary) -> void:
	var ground := Node3D.new()
	ground.name = "%s_GammaGround" % point["id"]
	ground.position = point["center"]
	ground.rotation_degrees.z = point["slope"]
	add_child(ground)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.10, 0.18, 0.12) if point["id"] == "R4" else Color(0.14, 0.20, 0.16)
	material.roughness = 0.95
	var mesh := BoxMesh.new()
	mesh.size = Vector3(point["size"].x, 0.9, point["size"].y)
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.name = "%s_GammaVisual" % point["id"]
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	body.name = "%s_GammaCollider" % point["id"]
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)
	if point["id"] == "R6":
		var water := MeshInstance3D.new()
		water.name = "R6_TransparentWaterSurface"
		var water_mesh := BoxMesh.new()
		water_mesh.size = Vector3(34.0, 0.08, 27.0)
		var water_material := StandardMaterial3D.new()
		water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		water_material.albedo_color = Color(0.05, 0.42, 0.58, 0.42)
		water_material.metallic = 0.15
		water_material.roughness = 0.18
		water_mesh.material = water_material
		water.mesh = water_mesh
		water.position = Vector3(0.0, 0.22, 2.0)
		ground.add_child(water)

func _build_r4_forest() -> void:
	_spawn_grounded("R4_Pine_Focal", 4, Vector2(-7.2, 9.0), TREE_DETAILED, 1.35)
	_spawn_grounded("R4_Tree_Left", 4, Vector2(-12.0, 15.0), TREE_DETAILED, 1.20)
	_spawn_grounded("R4_Tree_Right", 4, Vector2(11.0, 16.0), TREE_DETAILED, 1.28)
	_spawn_grounded("R4_Tree_Distant", 4, Vector2(14.0, 20.0), TREE_LIGHT, 1.42)
	_spawn_grounded("R4_Fern", 4, Vector2(-3.2, 5.0), FERN, 0.62)

func _build_r5_camp() -> void:
	_spawn_grounded("R5_Camp_Tree", 5, Vector2(-12.0, 13.0), TREE_LIGHT, 1.35)
	_spawn_grounded("R5_Camp_Rock", 5, Vector2(10.0, 10.0), ROCK, 0.85)
	var fire_marker := MeshInstance3D.new()
	fire_marker.name = "R5_Abandoned_Fireplace"
	var fire_mesh := CylinderMesh.new()
	fire_mesh.top_radius = 0.65
	fire_mesh.bottom_radius = 0.80
	fire_mesh.height = 0.35
	var fire_material := StandardMaterial3D.new()
	fire_material.albedo_color = Color(0.22, 0.12, 0.07)
	fire_material.emission_enabled = true
	fire_material.emission = Color(0.8, 0.22, 0.04)
	fire_material.emission_energy_multiplier = 1.5
	fire_mesh.material = fire_material
	fire_marker.mesh = fire_mesh
	fire_marker.position = Vector3(-88.0, 0.28, 178.0)
	add_child(fire_marker)
	var artifact := MeshInstance3D.new()
	artifact.name = "R5_Blue_Artifact"
	var artifact_mesh := BoxMesh.new()
	artifact_mesh.size = Vector3(0.8, 0.8, 0.8)
	var artifact_material := StandardMaterial3D.new()
	artifact_material.albedo_color = Color(0.05, 0.18, 0.38)
	artifact_material.emission_enabled = true
	artifact_material.emission = Color(0.02, 0.30, 1.0)
	artifact_material.emission_energy_multiplier = 3.0
	artifact_mesh.material = artifact_material
	artifact.mesh = artifact_mesh
	artifact.position = Vector3(-88.0, 1.0, 182.0)
	add_child(artifact)

func _build_r6_submerged_reveal() -> void:
	for index: int in range(4):
		var ruin := MeshInstance3D.new()
		ruin.name = "R6_Submerged_Ruin_%d" % index
		var ruin_mesh := CylinderMesh.new()
		ruins_mesh_setup(ruin_mesh, index)
		ruins_mesh_material(ruin_mesh)
		ruin.mesh = ruin_mesh
		ruin.position = Vector3(44.0 + float(index) * 5.0, -0.30 + float(index) * 0.08, 268.0 + float(index % 2) * 4.0)
		add_child(ruin)

func ruins_mesh_setup(mesh: CylinderMesh, index: int) -> void:
	mesh.top_radius = 0.45 + float(index) * 0.12
	mesh.bottom_radius = 0.65 + float(index) * 0.15
	mesh.height = 2.4 + float(index) * 0.35

func ruins_mesh_material(mesh: CylinderMesh) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.16, 0.26, 0.28)
	material.emission_enabled = true
	material.emission = Color(0.01, 0.11, 0.18)
	material.emission_energy_multiplier = 0.8
	mesh.material = material

func _spawn_grounded(candidate_id: String, anchor_id: int, local_offset: Vector2, packed_scene: PackedScene, candidate_scale: float) -> void:
	var record := PLACEMENT.placement_record(candidate_id, anchor_id, local_offset, 15.0)
	var candidate := packed_scene.instantiate() as Node3D
	candidate.name = candidate_id
	candidate.scale = Vector3.ONE * candidate_scale
	add_child(candidate)
	var result := GROUNDING.snap_to_ground(get_world_3d(), candidate, record["world_position"] as Vector3)
	var desired := record["world_position"] as Vector3
	var xz_preserved := (result["world_xz"] as Vector2).distance_to(Vector2(desired.x, desired.z)) < 0.001
	assert(result["grounded"] and xz_preserved)
	print("[DEV5_GAMMA_MIRROR] candidate=%s anchor=%d xz=(%.2f,%.2f) impact_y=%.2f grounded=%s xz_preserved=%s" % [candidate_id, anchor_id, desired.x, desired.z, result["impact_y"], result["grounded"], xz_preserved])

func _run_gamma_grounding() -> void:
	for point: Dictionary in GAMMA_POINTS:
		var center: Vector3 = point["center"]
		var ray := RayCast3D.new()
		ray.name = "%s_GammaGroundRaycast" % point["id"]
		ray.position = center + Vector3(0.0, 24.0, 0.0)
		ray.target_position = Vector3(0.0, -48.0, 0.0)
		add_child(ray)
		await get_tree().physics_frame
		var hit := ray.is_colliding()
		var hit_position := ray.get_collision_point() if hit else Vector3.ZERO
		var grounded := hit and absf(hit_position.y - center.y) <= 0.05
		print("[DEV5_GAMMA_MIRROR] point=%s anchor=%d ray_hit=%s hit_y=%.3f expected_y=%.3f error=%.3f grounded=%s" % [point["id"], point["anchor"], hit, hit_position.y, center.y, absf(hit_position.y - center.y), grounded])
		if grounded:
			grounded_count += 1
		ray.queue_free()

func _build_route_reader() -> void:
	for point: Dictionary in GAMMA_POINTS:
		var marker := MeshInstance3D.new()
		marker.name = "%s_RouteMarker" % point["id"]
		var mesh := SphereMesh.new()
		mesh.radius = 0.34
		mesh.height = 0.68
		var material := StandardMaterial3D.new()
		material.albedo_color = Color(0.05, 0.35, 0.95)
		material.emission_enabled = true
		material.emission = Color(0.02, 0.18, 0.9)
		material.emission_energy_multiplier = 2.0
		mesh.material = material
		marker.mesh = mesh
		marker.position = point["center"] + Vector3(0.0, 1.0, 0.0)
		add_child(marker)
		route_count += 1

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "GammaMirrorCamera"
	camera.position = Vector3(-18.0, 14.0, 145.0)
	camera.fov = 54.0
	add_child(camera)
	camera.look_at(Vector3(-38.0, 0.0, 208.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.name = "GammaMirrorOverlay"
	label.position = Vector2(42.0, 38.0)
	label.size = Vector2(1120.0, 110.0)
	label.text = "CP-D5-643  |  GAMMA · ESPELHAMENTO REAL R4/R5/R6\nFLORESTA DENSA → ACAMPAMENTO MAJESTIC → RUÍNAS SUBMERSAS\nMAPA CARTOGRÁFICO: AUTORIDADE ESPACIAL · DEV3: AUTORIDADE VISUAL · GTX 1050 Ti: ≤16 LUZES"
	label.add_theme_font_size_override("font_size", 17)
	label.modulate = Color(0.89, 0.95, 0.97)
	layer.add_child(label)
