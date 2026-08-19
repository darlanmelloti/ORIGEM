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
	# Tabuleiro em lajes irregulares: superfície física contínua e leitura de travessia antiga.
	for index: int in range(7):
		var material: Material = weathered_stone_material if index % 2 == 0 else stone_material
		var slab := _box("LajePonte%02d" % index, Vector3(1.82, 0.24, 1.42), material)
		var arch_rise := 0.15 * (1.0 - pow((float(index) - 3.0) / 3.0, 2.0))
		slab.position = Vector3(0.0, 0.20 + arch_rise, (float(index) - 3.0) * 1.28)
		slab.rotation_degrees.y = 2.0 if index % 2 == 0 else -2.0
		bridge.add_child(slab)
		_add_static_collider(slab, Vector3(1.82, 0.24, 1.42))
	# Encontros nas duas margens: massa de pedra real que ancora a ponte no terreno.
	for end_z: float in [-4.35, 4.35]:
		var abutment := _box("Encontro_%+.0f" % end_z, Vector3(2.55, 0.95, 1.10), stone_material)
		abutment.position = Vector3(0.0, -0.25, end_z)
		bridge.add_child(abutment)
		var moss_cap := _box("MusgoEncontro_%+.0f" % end_z, Vector3(1.88, 0.055, 0.68), moss_material)
		moss_cap.position = Vector3(0.0, 0.25, end_z)
		bridge.add_child(moss_cap)
	# Dois arcos baixos, descritos por aduelas visíveis dos dois lados e apoios de margem.
	for side: float in [-1.0, 1.0]:
		for pier_z: float in [-3.15, 3.15]:
			var pier := _box("Apoio%+.0f_%+.0f" % [side, pier_z], Vector3(0.30, 1.42, 0.44), stone_material)
			pier.position = Vector3(side * 0.72, -0.42, pier_z)
			bridge.add_child(pier)
		for arch_index: int in range(9):
			var z := (float(arch_index) - 4.0) * 0.72
			var rise := 0.34 * (1.0 - pow(z / 3.0, 2.0))
			var voussoir := _box("Aduela%+.0f_%02d" % [side, arch_index], Vector3(0.18, 0.34, 0.46), weathered_stone_material)
			voussoir.position = Vector3(side * 0.82, -0.06 + rise, z)
			voussoir.rotation_degrees.x = -side * z * 5.2
			bridge.add_child(voussoir)
		# Parapeito descontínuo: silhueta arqueológica sem bloquear a travessia.
		for rail_index: int in [0, 1, 3, 5, 6]:
			var rail_z := (float(rail_index) - 3.0) * 1.28
			var rail := _box("Parapeito%+.0f_%02d" % [side, rail_index], Vector3(0.16, 0.28, 0.50), moss_material if rail_index == 1 else stone_material)
			rail.position = Vector3(side * 0.84, 0.53, rail_z)
			bridge.add_child(rail)
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
