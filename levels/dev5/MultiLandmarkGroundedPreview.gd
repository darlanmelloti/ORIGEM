extends Node3D

## CP-D5-024: composição Casa Voss → Estrada sobre terreno físico irregular.
const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")
const LANDMARKS := preload("res://levels/dev5/CartographicLandmarkObjects.gd")

func _ready() -> void:
	name = "MultiLandmarkGroundedPreview"
	_build_environment()
	_build_irregular_ground()
	var library := LANDMARKS.new()
	add_child(library)
	var house := library.create_voss_waystation_landmark()
	var bridge := library.create_stone_bridge_landmark()
	add_child(house)
	add_child(bridge)
	var house_record: Dictionary = PLACEMENT.placement_record("CasaVossGrounded", 1, Vector2.ZERO, 15.0)
	var bridge_record: Dictionary = PLACEMENT.placement_record("PonteMarco2Grounded", 2, Vector2.ZERO, 18.0)
	await get_tree().physics_frame
	var house_ground := _ground_candidate(house, house_record.world_position)
	var bridge_ground := _ground_candidate(bridge, bridge_record.world_position)
	print("[DEV5_GROUND_COMPOSITION] candidate=CasaVoss anchor=1 map=%s desired_y=%.2f impact_y=%.2f grounded=%s world_xz=%s" % [house_record.map_canvas, house_ground.desired_y, house_ground.impact_y, house_ground.grounded, house_ground.world_xz])
	print("[DEV5_GROUND_COMPOSITION] candidate=PonteMarco2 anchor=2 map=%s desired_y=%.2f impact_y=%.2f grounded=%s world_xz=%s" % [bridge_record.map_canvas, bridge_ground.desired_y, bridge_ground.impact_y, bridge_ground.grounded, bridge_ground.world_xz])
	print("[DEV5_GROUND_COMPOSITION] anchors=1,2 irregular_ground=true production_script=false dynamic_lights=0")

func _ground_candidate(candidate: Node3D, desired: Vector3) -> Dictionary:
	_set_candidate_collision(candidate, false)
	var result: Dictionary = GROUNDING.snap_to_ground(get_world_3d(), candidate, desired)
	_set_candidate_collision(candidate, true)
	return result

func _set_candidate_collision(candidate: Node3D, enabled: bool) -> void:
	for node: Node in candidate.find_children("*", "StaticBody3D", true, false):
		(node as StaticBody3D).collision_layer = 1 if enabled else 0

func _build_irregular_ground() -> void:
	_add_ground("TerrenoCasaVoss", Vector3(-22.0, -2.78, 8.0), Vector3(8.0, 0.45, 7.0), -4.0)
	_add_ground("TerrenoPonte", Vector3(-21.4, -2.71, 12.0), Vector3(5.8, 0.38, 11.0), 3.0)
	_add_ground("LigacaoInclinada", Vector3(-21.7, -2.60, 10.0), Vector3(2.8, 0.30, 3.5), -9.0)

func _add_ground(node_name: String, position: Vector3, size: Vector3, slope_degrees: float) -> void:
	var body := StaticBody3D.new()
	body.name = node_name
	body.position = position
	var mesh := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = size
	mesh.mesh = box
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.22, 0.25, 0.19)
	material.roughness = 1.0
	box.material = material
	mesh.rotation_degrees.z = slope_degrees
	body.add_child(mesh)
	var shape := CollisionShape3D.new()
	var box_shape := BoxShape3D.new()
	box_shape.size = size
	shape.shape = box_shape
	body.add_child(shape)
	add_child(body)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.20, 0.28, 0.22)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.58, 0.64, 0.52)
	environment.ambient_light_energy = 0.78
	world.environment = environment
	add_child(world)
	var camera := Camera3D.new()
	camera.position = Vector3(-14.0, 7.5, 27.0)
	camera.look_at_from_position(camera.position, Vector3(-21.5, 0.0, 10.0))
	camera.current = true
	add_child(camera)
	var sun := DirectionalLight3D.new()
	sun.name = "LuzQAGrounding"
	sun.rotation_degrees = Vector3(-52.0, -30.0, 0.0)
	sun.light_energy = 1.0
	sun.shadow_enabled = true
	add_child(sun)
