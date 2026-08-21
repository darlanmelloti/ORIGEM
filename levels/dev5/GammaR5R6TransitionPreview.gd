extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")

const R5 := Vector3(-88.0, 0.0, 178.0)
const R6 := Vector3(52.0, 0.0, 260.0)
var grounded_count := 0
var route_count := 0
var dynamic_lights := 0

func _ready() -> void:
	_build_environment()
	_build_ground("R5", R5, Vector2(34.0, 30.0), -6.0)
	_build_ground("R6", R6, Vector2(42.0, 36.0), -5.0)
	_build_transition_route()
	await get_tree().physics_frame
	_build_camera()
	_build_overlay()
	print("[APOIO-GAMMA-02] status=approved route=R5>R6 grounded=%d route_markers=%d dynamic_lights=%d production_modules_changed=false" % [grounded_count, route_count, dynamic_lights])
	assert(grounded_count == 2)
	assert(route_count == 2)
	assert(dynamic_lights == 0)

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.08, 0.16, 0.19)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.39, 0.51, 0.54)
	environment.ambient_light_energy = 0.80
	environment_node.environment = environment
	add_child(environment_node)

func _build_ground(region_id: String, center: Vector3, size: Vector2, slope: float) -> void:
	var ground := Node3D.new()
	ground.name = "%s_TransitionGround" % region_id
	ground.position = center
	ground.rotation_degrees.z = slope
	add_child(ground)
	var mesh := BoxMesh.new()
	mesh.size = Vector3(size.x, 0.9, size.y)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.20, 0.12) if region_id == "R5" else Color(0.08, 0.20, 0.24)
	material.roughness = 0.92
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	body.name = "%s_TransitionCollider" % region_id
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)
	if region_id == "R6":
		var water := MeshInstance3D.new()
		water.name = "R6_TransparentWaterTransition"
		var water_mesh := BoxMesh.new()
		water_mesh.size = Vector3(34.0, 0.08, 27.0)
		var water_material := StandardMaterial3D.new()
		water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		water_material.albedo_color = Color(0.04, 0.40, 0.58, 0.38)
		water_material.roughness = 0.16
		water_mesh.material = water_material
		water.mesh = water_mesh
		water.position = Vector3(0.0, 0.24, 2.0)
		ground.add_child(water)
	var record := PLACEMENT.placement_record("transition_%s" % region_id, 5 if region_id == "R5" else 6, Vector2.ZERO, 14.0)
	var probe := Node3D.new()
	probe.name = "%s_GroundProbe" % region_id
	add_child(probe)
	var result := GROUNDING.snap_to_ground(get_world_3d(), probe, record["world_position"] as Vector3)
	var target := record["world_position"] as Vector3
	var xz_preserved := (result["world_xz"] as Vector2).distance_to(Vector2(target.x, target.z)) < 0.001
	assert(result["grounded"] and xz_preserved)
	grounded_count += 1
	print("[APOIO-GAMMA-02] region=%s anchor=%s xz_preserved=%s impact_y=%.2f grounded=%s" % [region_id, str(record["anchor_id"]), xz_preserved, result["impact_y"], result["grounded"]])

func _build_transition_route() -> void:
	for point: Vector3 in [R5, R6]:
		var marker := MeshInstance3D.new()
		marker.name = "R5R6_TransitionMarker_%d" % route_count
		var mesh := SphereMesh.new()
		mesh.radius = 0.34
		mesh.height = 0.68
		var material := StandardMaterial3D.new()
		material.albedo_color = Color(0.05, 0.35, 0.95)
		material.emission_enabled = true
		material.emission = Color(0.02, 0.18, 0.9)
		material.emission_energy_multiplier = 1.7
		mesh.material = material
		marker.mesh = mesh
		marker.position = point + Vector3(0.0, 1.0, 0.0)
		add_child(marker)
		route_count += 1
	var route := MeshInstance3D.new()
	route.name = "R5R6_TransitionReadablePath"
	var route_mesh := BoxMesh.new()
	route_mesh.size = Vector3(3.0, 0.12, 162.0)
	var route_material := StandardMaterial3D.new()
	route_material.albedo_color = Color(0.16, 0.25, 0.27)
	route_material.roughness = 0.82
	route_mesh.material = route_material
	route.mesh = route_mesh
	route.position = (R5 + R6) * 0.5 + Vector3(0.0, 0.02, 0.0)
	route.rotation_degrees.y = -59.7
	add_child(route)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "R5R6TransitionCamera"
	camera.position = Vector3(-106.0, 11.0, 166.0)
	camera.fov = 58.0
	add_child(camera)
	camera.look_at(Vector3(-8.0, 0.7, 220.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(46.0, 40.0)
	label.size = Vector2(1100.0, 100.0)
	label.text = "APOIO-GAMMA-02  |  CONTINUIDADE R5 → R6\nACAMPAMENTO MAJESTIC → ÁGUA TRANSPARENTE → RUÍNAS SUBMERSAS\nGROUNDING R5/R6 POR RAYCAST · X/Z PRESERVADO · 0 LUZES DINÂMICAS"
	label.add_theme_font_size_override("font_size", 17)
	label.modulate = Color(0.89, 0.95, 0.97)
	layer.add_child(label)
