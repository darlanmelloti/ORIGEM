## Dev5 — Biblioteca isolada de objectos tridimensionais para espelhar marcos do mapa oficial.
## Não é instanciada por TempleLevel até uma integração validada pelo proprietário R1–R6.

class_name CartographicLandmarkObjects
extends Node3D

const MAX_TRIANGLES_PER_OBJECT: int = 2500
const MAX_MATERIALS_PER_OBJECT: int = 3
const DYNAMIC_LIGHTS_PER_OBJECT: int = 0

var stone_material: StandardMaterial3D
var weathered_stone_material: StandardMaterial3D
var moss_material: StandardMaterial3D

func _ready() -> void:
	name = "Dev5CartographicObjects"
	add_to_group("dev5_cartographic_objects")
	_build_material_library()

func _build_material_library() -> void:
	stone_material = _material(Color(0.25, 0.27, 0.25), 0.92)
	weathered_stone_material = _material(Color(0.34, 0.31, 0.26), 0.88)
	moss_material = _material(Color(0.075, 0.17, 0.08), 0.98)

func create_stone_bridge_landmark() -> Node3D:
	# CP-D5-002: ponte modular do marco 2. O chamador decide a âncora e a orientação;
	# esta função não toca na Estrada do Rio nem instala colisores fora da própria ponte.
	var bridge := Node3D.new()
	bridge.name = "PonteDePedraMarco2"
	bridge.add_to_group("dev5_landmark_bridge")
	for index: int in range(7):
		var slab := _box("LajePonte%02d" % index, Vector3(1.8, 0.22, 1.45), weathered_stone_material)
		slab.position = Vector3(0.0, 0.18 + absf(float(index) - 3.0) * 0.035, (float(index) - 3.0) * 1.28)
		bridge.add_child(slab)
		_add_static_collider(slab, Vector3(1.8, 0.22, 1.45))
	for side: float in [-1.0, 1.0]:
		for index: int in [0, 3, 6]:
			var pier := _cylinder("Pilar%+.0f_%02d" % [side, index], 0.22, 1.8, stone_material)
			pier.position = Vector3(side * 0.75, -0.65, (float(index) - 3.0) * 1.28)
			bridge.add_child(pier)
	return bridge

func _box(node_name: String, size: Vector3, material: Material) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh.material = material
	var instance := MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = mesh
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	return instance

func _cylinder(node_name: String, radius: float, height: float, material: Material) -> MeshInstance3D:
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius * 0.92
	mesh.bottom_radius = radius
	mesh.height = height
	mesh.radial_segments = 8
	mesh.rings = 2
	mesh.material = material
	var instance := MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = mesh
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	return instance

func _add_static_collider(mesh_node: MeshInstance3D, size: Vector3) -> void:
	var body := StaticBody3D.new()
	body.name = "Colisor_" + mesh_node.name
	var shape := BoxShape3D.new()
	shape.size = size
	var collision := CollisionShape3D.new()
	collision.shape = shape
	body.add_child(collision)
	mesh_node.add_child(body)

func _material(color: Color, roughness_value: float) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness_value
	material.metallic = 0.0
	return material
