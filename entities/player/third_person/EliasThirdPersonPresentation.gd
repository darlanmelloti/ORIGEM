## Dev5 — Apresentação 3D de Elias em terceira pessoa.
## A referência de Elias define o vestuário e a silhueta; este módulo não substitui Player.gd no primeiro ciclo.

class_name EliasThirdPersonPresentation
extends Node3D

@export var camera_distance: float = 3.8
@export var camera_height: float = 1.55
@export var enabled_for_preview: bool = true

var follow_pivot: Node3D
var spring_arm: SpringArm3D
var follow_camera: Camera3D

func _ready() -> void:
	name = "EliasThirdPersonPresentation"
	add_to_group("dev5_elias_third_person")
	_build_reference_body()
	_build_camera_rig()
	visible = enabled_for_preview

func attach_to_actor(actor: Node3D) -> void:
	# A integração futura chama este método apenas após preservar o controlador de primeira pessoa.
	global_transform = actor.global_transform

func set_third_person_active(value: bool) -> void:
	visible = value
	if follow_camera != null:
		follow_camera.current = value

func _build_reference_body() -> void:
	# Silhueta: cabelo escuro, camisa clara, colete castanho, calças escuras, botas e espada lateral.
	var skin := _material(Color(0.32, 0.20, 0.14), 0.82)
	var shirt := _material(Color(0.62, 0.52, 0.39), 0.94)
	var vest := _material(Color(0.16, 0.085, 0.045), 0.88)
	var trousers := _material(Color(0.10, 0.075, 0.055), 0.92)
	var boots := _material(Color(0.055, 0.034, 0.022), 0.84)
	var hair := _material(Color(0.025, 0.018, 0.014), 0.95)
	var steel := _material(Color(0.27, 0.29, 0.30), 0.72)

	var pelvis := _box("Cinto", Vector3(0.58, 0.16, 0.30), vest)
	pelvis.position = Vector3(0.0, 1.02, 0.0)
	add_child(pelvis)
	var torso := _capsule("Camisa", 0.28, 0.62, shirt)
	torso.position = Vector3(0.0, 1.43, 0.0)
	add_child(torso)
	var waistcoat := _box("Colete", Vector3(0.59, 0.55, 0.16), vest)
	waistcoat.position = Vector3(0.0, 1.48, 0.15)
	add_child(waistcoat)
	var head := _sphere("Cabeca", 0.20, skin)
	head.position = Vector3(0.0, 2.04, 0.0)
	add_child(head)
	var hair_cap := _sphere("CabeloEscuro", 0.215, hair)
	hair_cap.scale = Vector3(1.0, 0.55, 1.0)
	hair_cap.position = Vector3(0.0, 2.17, 0.0)
	add_child(hair_cap)
	for side: float in [-1.0, 1.0]:
		var arm := _capsule("Braco%+.0f" % side, 0.095, 0.45, shirt)
		arm.position = Vector3(side * 0.36, 1.52, 0.0)
		arm.rotation_degrees.z = side * -8.0
		add_child(arm)
		var hand := _sphere("Mao%+.0f" % side, 0.09, skin)
		hand.position = Vector3(side * 0.42, 1.19, 0.0)
		add_child(hand)
		var leg := _capsule("Perna%+.0f" % side, 0.115, 0.55, trousers)
		leg.position = Vector3(side * 0.16, 0.62, 0.0)
		add_child(leg)
		var boot := _box("Bota%+.0f" % side, Vector3(0.18, 0.18, 0.36), boots)
		boot.position = Vector3(side * 0.16, 0.20, 0.08)
		add_child(boot)
	var sword := _box("EspadaLateral", Vector3(0.05, 0.78, 0.06), steel)
	sword.position = Vector3(0.33, 0.83, 0.13)
	sword.rotation_degrees.z = -18.0
	add_child(sword)

func _build_camera_rig() -> void:
	follow_pivot = Node3D.new()
	follow_pivot.name = "PivotCameraElias"
	follow_pivot.position = Vector3(0.0, camera_height, 0.0)
	add_child(follow_pivot)
	spring_arm = SpringArm3D.new()
	spring_arm.name = "BracoCameraElias"
	spring_arm.spring_length = camera_distance
	follow_pivot.add_child(spring_arm)
	follow_camera = Camera3D.new()
	follow_camera.name = "CameraTerceiraPessoaElias"
	follow_camera.fov = 62.0
	follow_camera.position = Vector3(0.0, 0.25, 0.0)
	follow_camera.current = false
	spring_arm.add_child(follow_camera)

func _material(color: Color, roughness_value: float) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness_value
	return material

func _box(node_name: String, size: Vector3, material: Material) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh.material = material
	var node := MeshInstance3D.new()
	node.name = node_name
	node.mesh = mesh
	node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	return node

func _sphere(node_name: String, radius: float, material: Material) -> MeshInstance3D:
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 2.0
	mesh.radial_segments = 16
	mesh.rings = 8
	mesh.material = material
	var node := MeshInstance3D.new()
	node.name = node_name
	node.mesh = mesh
	node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	return node

func _capsule(node_name: String, radius: float, height: float, material: Material) -> MeshInstance3D:
	var mesh := CapsuleMesh.new()
	mesh.radius = radius
	mesh.height = height
	mesh.radial_segments = 12
	mesh.rings = 6
	mesh.material = material
	var node := MeshInstance3D.new()
	node.name = node_name
	node.mesh = mesh
	node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	return node
