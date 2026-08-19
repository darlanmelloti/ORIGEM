extends Node3D

const FLOOR := preload("res://assets/models_dev7/majestic_cc0_selected/Floor_UnevenBrick.gltf")
const FRAME := preload("res://assets/models_dev7/majestic_cc0_selected/DoorFrame_Round_Brick.gltf")
const ROOF := preload("res://assets/models_dev7/majestic_cc0_selected/Roof_RoundTiles_4x4.gltf")
const SUPPORTS := preload("res://assets/models_dev7/majestic_cc0_selected/Roof_FrontSupports.gltf")

var elapsed := 0.0

func _ready() -> void:
	_build_ground()
	_build_shelter()
	_build_camera()
	print("DEV7_MAJESTIC_CC0_READY corridor=5.20 dynamic_lights=1 procedural_pavilion=false")

func _process(delta: float) -> void:
	elapsed += delta
	if elapsed >= 36.0:
		print("DEV7_MAJESTIC_CC0_36S_PASS corridor=5.20")
		set_process(false)

func _build_ground() -> void:
	var ground := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(36.0, 44.0)
	ground.mesh = mesh
	ground.position = Vector3(-88.0, 0.0, 178.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("31412f")
	material.roughness = 0.95
	ground.material_override = material
	add_child(ground)

func _build_shelter() -> void:
	var shelter := Node3D.new()
	shelter.name = "AbrigoMajesticCC0"
	shelter.position = Vector3(-96.0, 0.0, 184.0) # lateral; corredor central x=-88 fica livre
	add_child(shelter)
	_add_piece(shelter, FLOOR, Vector3(0, 0.03, 0), Vector3(1.4, 1.0, 1.4), 0.0)
	_add_piece(shelter, FRAME, Vector3(0, 0.05, -1.8), Vector3(1.4, 1.4, 1.4), 0.0)
	_add_piece(shelter, SUPPORTS, Vector3(0, 0.05, 0.8), Vector3(1.4, 1.4, 1.4), 0.0)
	_add_piece(shelter, ROOF, Vector3(0.7, 2.25, 0.2), Vector3(1.35, 1.35, 1.35), -0.32)
	_add_piece(shelter, ROOF, Vector3(-1.55, 0.55, 1.65), Vector3(0.8, 0.8, 0.8), 1.05) # colapso lateral

func _add_piece(parent: Node3D, scene: PackedScene, offset: Vector3, scale_value: Vector3, yaw: float) -> void:
	var piece := scene.instantiate() as Node3D
	piece.position = offset
	piece.scale = scale_value
	piece.rotation.y = yaw
	parent.add_child(piece)

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(-75.0, 8.0, 163.0)
	camera.look_at(Vector3(-91.0, 1.3, 181.0), Vector3.UP)
	camera.make_current()
	add_child(camera)
	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-52.0, -34.0, 0.0)
	light.light_energy = 1.25
	add_child(light)
