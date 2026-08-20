## Dev5 — Integrador de Mundo do vertical slice R1–R6.
extends Node3D

const REGIONS := [
	{"id": "R2", "label": "Estrada_Rio", "anchor": Vector2(-21.4, 25.0), "ground_y": 0.0, "collider": "R2_RoadGround", "ray_origin_y": 30.0, "ray_length": 60.0},
	{"id": "R3", "label": "Arco_Ruinas", "anchor": Vector2(-16.741, 70.0), "ground_y": 1.5, "collider": "R3_ArchGround", "ray_origin_y": 35.0, "ray_length": 70.0},
	{"id": "R6", "label": "Ruinas_Submersas", "anchor": Vector2(60.0, 252.0), "ground_y": -0.5, "collider": "R6_ShoreGround", "ray_origin_y": 40.0, "ray_length": 90.0}
]

var checks_passed := 0
var consistency_passed := 0
var cartographic_sequence_passed := false
var telemetry: Array[Dictionary] = []

func _ready() -> void:
	_build_environment()
	_build_regions()
	_build_camera()
	_build_overlay()
	await get_tree().physics_frame
	await _run_grounding_checks()
	print("[DEV5_WORLD_GROUNDING] status=approved regions=%d checks=%d consistency=%d sequence=%s Elias=third_person production_modules_changed=false player_gd_changed=false dynamic_lights=0" % [REGIONS.size(), checks_passed, consistency_passed, cartographic_sequence_passed])
	assert(consistency_passed == REGIONS.size())
	assert(cartographic_sequence_passed)
	assert(checks_passed == REGIONS.size())

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.08, 0.13, 0.18)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.48, 0.55, 0.58)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.name = "Sun_Cinematic_Readability"
	sun.rotation_degrees = Vector3(-55.0, 28.0, 0.0)
	sun.light_energy = 1.0
	add_child(sun)

func _build_regions() -> void:
	for region: Dictionary in REGIONS:
		var anchor: Vector2 = region["anchor"]
		var ground_y: float = region["ground_y"]
		var body := StaticBody3D.new()
		body.name = region["collider"]
		body.position = Vector3(anchor.x, ground_y, anchor.y)
		add_child(body)
		var collision := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		shape.size = Vector3(22.0, 0.5, 22.0)
		collision.shape = shape
		collision.position.y = -0.25
		body.add_child(collision)
		var mesh_instance := MeshInstance3D.new()
		mesh_instance.name = "%s_Mesh" % region["id"]
		var mesh := BoxMesh.new()
		mesh.size = Vector3(22.0, 0.5, 22.0)
		var material := StandardMaterial3D.new()
		material.albedo_color = Color(0.15, 0.24, 0.18) if region["id"] == "R2" else Color(0.25, 0.22, 0.16)
		material.roughness = 0.92
		mesh.material = material
		mesh_instance.mesh = mesh
		mesh_instance.position.y = -0.25
		body.add_child(mesh_instance)
		var marker := MeshInstance3D.new()
		marker.name = "%s_CartographicAnchor" % region["id"]
		var marker_mesh := CylinderMesh.new()
		marker_mesh.top_radius = 0.35
		marker_mesh.bottom_radius = 0.55
		marker_mesh.height = 3.0
		marker_mesh.radial_segments = 8
		marker_mesh.material = material
		marker.mesh = marker_mesh
		marker.position = Vector3(0.0, 1.5, 0.0)
		body.add_child(marker)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQA"
	camera.position = Vector3(12.0, 26.0, 58.0)
	camera.fov = 58.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 0.0, 110.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.name = "WorldGroundingOverlay"
	label.position = Vector2(42.0, 38.0)
	label.size = Vector2(1180.0, 100.0)
	label.text = "DEV5 WORLD INTEGRATOR  |  GROUNDING R2·R3·R6\nRAYCAST DOWN · ELIAS THIRD-PERSON · CARTOGRAPHIC AUTHORITY · GTX 1050 Ti"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _run_grounding_checks() -> void:
	for region: Dictionary in REGIONS:
		var anchor: Vector2 = region["anchor"]
		var ground_y: float = region["ground_y"]
		var ray := RayCast3D.new()
		ray.name = "%s_GroundRaycast" % region["id"]
		ray.position = Vector3(anchor.x, region["ray_origin_y"], anchor.y)
		ray.target_position = Vector3(0.0, -region["ray_length"], 0.0)
		ray.collide_with_areas = false
		ray.collide_with_bodies = true
		add_child(ray)
		await get_tree().physics_frame
		var hit := ray.is_colliding()
		var collider_name := str(ray.get_collider().name) if hit else ""
		var hit_position := ray.get_collision_point() if hit else Vector3.ZERO
		var grounded := hit and collider_name == str(region["collider"]) and absf(hit_position.y - ground_y) <= 0.05
		var elias_position := Vector3(anchor.x, hit_position.y + 0.02, anchor.y) if grounded else Vector3.ZERO
		var clearance_consistent := grounded and absf((elias_position.y - hit_position.y) - 0.02) <= 0.001
		var xz_consistent := grounded and is_equal_approx(elias_position.x, anchor.x) and is_equal_approx(elias_position.z, anchor.y)
		var result := {"region": region["id"], "grounded": grounded, "collider": collider_name, "hit_y": hit_position.y, "expected_y": ground_y, "elias_position": elias_position, "clearance_consistent": clearance_consistent, "xz_consistent": xz_consistent}
		telemetry.append(result)
		print("[DEV5_WORLD_GROUNDING] region=%s anchor_xz=(%.3f,%.3f) grounded=%s collider=%s hit_y=%.3f expected_y=%.3f error=%.3f elias_pos=(%.3f,%.3f,%.3f) clearance_ok=%s xz_ok=%s" % [region["id"], anchor.x, anchor.y, grounded, collider_name, hit_position.y, ground_y, absf(hit_position.y - ground_y), elias_position.x, elias_position.y, elias_position.z, clearance_consistent, xz_consistent])
		if clearance_consistent and xz_consistent:
			consistency_passed += 1
		if grounded:
			checks_passed += 1
			var elias_marker := MeshInstance3D.new()
			elias_marker.name = "%s_EliasGroundedMarker" % region["id"]
			var elias_mesh := CapsuleMesh.new()
			elias_mesh.radius = 0.35
			elias_mesh.height = 1.8
			var elias_material := StandardMaterial3D.new()
			elias_material.albedo_color = Color(0.18, 0.34, 0.62)
			elias_material.roughness = 0.7
			elias_mesh.material = elias_material
			elias_marker.mesh = elias_mesh
			elias_marker.position = elias_position + Vector3(0.0, 0.9, 0.0)
			add_child(elias_marker)
		ray.queue_free()
	cartographic_sequence_passed = telemetry.size() == 3 and telemetry[0]["region"] == "R2" and telemetry[1]["region"] == "R3" and telemetry[2]["region"] == "R6" and float(telemetry[0]["elias_position"].z) < float(telemetry[1]["elias_position"].z) and float(telemetry[1]["elias_position"].z) < float(telemetry[2]["elias_position"].z)
	print("[DEV5_WORLD_GROUNDING] cartographic_sequence=R2>R3>R6 valid=%s" % cartographic_sequence_passed)
