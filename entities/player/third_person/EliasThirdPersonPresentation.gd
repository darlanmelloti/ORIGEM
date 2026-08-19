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
	# Silhueta provisória de Elias: camisa clara, colete aberto, cabelo escuro e espada lateral.
	var skin := _material(Color(0.32, 0.20, 0.14), 0.82)
	var shirt := _material(Color(0.62, 0.52, 0.39), 0.94)
	var vest := _material(Color(0.16, 0.085, 0.045), 0.88)
	var trousers := _material(Color(0.10, 0.075, 0.055), 0.92)
	var boots := _material(Color(0.055, 0.034, 0.022), 0.84)
	var hair := _material(Color(0.025, 0.018, 0.014), 0.95)
	var steel := _material(Color(0.27, 0.29, 0.30), 0.72)
	var brass := _material(Color(0.48, 0.31, 0.10), 0.54)

	var pelvis := _box("Cinto", Vector3(0.60, 0.14, 0.32), vest)
	pelvis.position = Vector3(0.0, 1.00, 0.0)
	add_child(pelvis)
	var buckle := _box("Fivela", Vector3(0.12, 0.09, 0.035), brass)
	buckle.position = Vector3(0.0, 1.00, 0.18)
	add_child(buckle)
	var torso := _capsule("Camisa", 0.29, 0.68, shirt)
	torso.position = Vector3(0.0, 1.43, 0.0)
	add_child(torso)
	for side: float in [-1.0, 1.0]:
		var vest_panel := _box("PainelColete%+.0f" % side, Vector3(0.17, 0.50, 0.15), vest)
		vest_panel.position = Vector3(side * 0.18, 1.46, 0.17)
		vest_panel.rotation_degrees.z = side * -5.0
		add_child(vest_panel)
	var collar := _box("GolaColete", Vector3(0.42, 0.10, 0.16), vest)
	collar.position = Vector3(0.0, 1.72, 0.15)
	add_child(collar)
	var neck := _capsule("Pescoco", 0.085, 0.17, skin)
	neck.position = Vector3(0.0, 1.82, 0.0)
	add_child(neck)
	var head := _sphere("Cabeca", 0.205, skin)
	head.position = Vector3(0.0, 2.05, 0.0)
	add_child(head)
	var hair_cap := _sphere("CabeloEscuro", 0.215, hair)
	hair_cap.scale = Vector3(1.02, 0.54, 1.02)
	hair_cap.position = Vector3(-0.015, 2.18, -0.015)
	add_child(hair_cap)
	var fringe := _box("Franja", Vector3(0.18, 0.18, 0.07), hair)
	fringe.position = Vector3(-0.08, 2.16, 0.18)
	fringe.rotation_degrees.z = -18.0
	add_child(fringe)
	for side: float in [-1.0, 1.0]:
		var arm := _capsule("Braco%+.0f" % side, 0.10, 0.52, shirt)
		arm.position = Vector3(side * 0.38, 1.47, 0.0)
		arm.rotation_degrees.z = side * -12.0
		add_child(arm)
		var hand := _sphere("Mao%+.0f" % side, 0.085, skin)
		hand.position = Vector3(side * 0.47, 1.15, 0.01)
		add_child(hand)
		var leg := _capsule("Perna%+.0f" % side, 0.125, 0.63, trousers)
		leg.position = Vector3(side * 0.17, 0.60, 0.0)
		add_child(leg)
		var boot := _box("Bota%+.0f" % side, Vector3(0.20, 0.18, 0.38), boots)
		boot.position = Vector3(side * 0.17, 0.18, 0.10)
		add_child(boot)
	var satchel := _box("BolsaLateral", Vector3(0.22, 0.32, 0.12), vest)
	satchel.position = Vector3(-0.34, 0.91, 0.10)
	add_child(satchel)
	var sword := _box("EspadaLateral", Vector3(0.06, 0.82, 0.07), steel)
	sword.position = Vector3(0.34, 0.82, 0.13)
	sword.rotation_degrees.z = -18.0
	add_child(sword)
	var hilt := _box("PunhoEspada", Vector3(0.18, 0.05, 0.08), brass)
	hilt.position = Vector3(0.22, 1.18, 0.13)
	hilt.rotation_degrees.z = -18.0
	add_child(hilt)

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
