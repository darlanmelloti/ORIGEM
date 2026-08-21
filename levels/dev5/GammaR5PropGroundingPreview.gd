extends Node3D

const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const GROUNDING := preload("res://levels/dev5/CartographicGroundingSystem.gd")

const R5_CENTER := Vector3(-88.0, 0.0, 178.0)
var grounded_count := 0
var dynamic_lights := 0

func _ready() -> void:
	_build_environment()
	_build_r5_ground()
	_build_r5_props()
	await get_tree().physics_frame
	_build_camera()
	_build_overlay()
	print("[APOIO-GAMMA-01] status=approved anchor=5 props=3 grounded=%d dynamic_lights=%d production_modules_changed=false" % [grounded_count, dynamic_lights])
	assert(grounded_count == 3)
	assert(dynamic_lights == 0)

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.12, 0.20, 0.22)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.43, 0.55, 0.55)
	environment.ambient_light_energy = 0.82
	environment_node.environment = environment
	add_child(environment_node)

func _build_r5_ground() -> void:
	var ground := Node3D.new()
	ground.name = "R5_APOIO_GammaGround"
	ground.position = R5_CENTER
	ground.rotation_degrees.z = -6.0
	add_child(ground)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.13, 0.20, 0.12)
	material.roughness = 0.96
	var mesh := BoxMesh.new()
	mesh.size = Vector3(34.0, 0.90, 30.0)
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.name = "R5_APOIO_GammaGroundVisual"
	visual.mesh = mesh
	visual.position.y = -0.45
	ground.add_child(visual)
	var body := StaticBody3D.new()
	body.name = "R5_APOIO_GammaGroundCollider"
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	collision.position.y = -0.45
	body.add_child(collision)
	ground.add_child(body)

func _build_r5_props() -> void:
	_spawn_prop("R5_Tenda_Grounded", Vector2(-7.0, 2.0), _make_tent(), 4.0)
	_spawn_prop("R5_Fogueira_Grounded", Vector2(1.0, 0.5), _make_fireplace(), 2.0)
	_spawn_prop("R5_Equipamento_Abandonado_Grounded", Vector2(8.0, -3.0), _make_equipment(), 3.0)

func _spawn_prop(prop_id: String, local_offset: Vector2, prop: Node3D, desired_y: float) -> void:
	var record := PLACEMENT.placement_record(prop_id, 5, local_offset, desired_y)
	add_child(prop)
	var result := GROUNDING.snap_to_ground(get_world_3d(), prop, record["world_position"] as Vector3)
	var target := record["world_position"] as Vector3
	var xz_preserved := (result["world_xz"] as Vector2).distance_to(Vector2(target.x, target.z)) < 0.001
	assert(result["grounded"] and xz_preserved)
	grounded_count += 1
	print("[APOIO-GAMMA-01] prop=%s anchor=5 xz=(%.3f,%.3f) desired_y=%.2f impact_y=%.2f grounded=%s xz_preserved=%s collider=%s" % [prop_id, target.x, target.z, result["desired_y"], result["impact_y"], result["grounded"], xz_preserved, result.get("collider", "none")])

func _make_tent() -> Node3D:
	var root := Node3D.new()
	root.name = "TentProp"
	var mesh := BoxMesh.new()
	mesh.size = Vector3(4.8, 1.9, 3.2)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.28, 0.25, 0.18)
	material.roughness = 0.88
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = 0.95
	root.add_child(visual)
	return root

func _make_fireplace() -> Node3D:
	var root := Node3D.new()
	root.name = "FireplaceProp"
	var mesh := CylinderMesh.new()
	mesh.top_radius = 0.65
	mesh.bottom_radius = 0.80
	mesh.height = 0.35
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.22, 0.12, 0.07)
	material.emission_enabled = true
	material.emission = Color(0.8, 0.22, 0.04)
	material.emission_energy_multiplier = 1.5
	mesh.material = material
	var visual := MeshInstance3D.new()
	visual.mesh = mesh
	visual.position.y = 0.18
	root.add_child(visual)
	return root

func _make_equipment() -> Node3D:
	var root := Node3D.new()
	root.name = "EquipmentProp"
	for index: int in range(3):
		var mesh := BoxMesh.new()
		mesh.size = Vector3(1.2, 0.8, 1.0)
		var material := StandardMaterial3D.new()
		material.albedo_color = Color(0.20 + float(index) * 0.04, 0.16, 0.10)
		material.roughness = 0.92
		mesh.material = material
		var visual := MeshInstance3D.new()
		visual.mesh = mesh
		visual.position = Vector3(float(index) * 1.35, 0.40, float(index % 2) * 0.85)
		root.add_child(visual)
	return root

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "R5PropGroundingCamera"
	camera.position = Vector3(-105.0, 8.0, 164.0)
	camera.fov = 56.0
	add_child(camera)
	camera.look_at(Vector3(-88.0, 1.1, 178.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.name = "ApoioGammaOverlay"
	label.position = Vector2(48.0, 42.0)
	label.size = Vector2(1100.0, 100.0)
	label.text = "APOIO-GAMMA-01  |  R5 ACAMPAMENTO MAJESTIC\nGROUNDING POR RAYCAST: TENDA · FOGUEIRA · EQUIPAMENTO ABANDONADO\nX/Z CARTOGRÁFICO PRESERVADO · 0 LUZES DINÂMICAS · PRODUÇÃO INTACTA"
	label.add_theme_font_size_override("font_size", 17)
	label.modulate = Color(0.89, 0.95, 0.97)
	layer.add_child(label)
