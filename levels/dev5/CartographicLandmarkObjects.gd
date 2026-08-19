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
var plaster_material: StandardMaterial3D
var timber_material: StandardMaterial3D
var roof_material: StandardMaterial3D
var canvas_material: StandardMaterial3D

func _ready() -> void:
	name = "Dev5CartographicObjects"
	add_to_group("dev5_cartographic_objects")
	_build_material_library()

func _build_material_library() -> void:
	stone_material = _material(Color(0.25, 0.27, 0.25), 0.92)
	weathered_stone_material = _material(Color(0.34, 0.31, 0.26), 0.88)
	moss_material = _material(Color(0.075, 0.17, 0.08), 0.98)
	plaster_material = _material(Color(0.50, 0.42, 0.31), 0.96)
	timber_material = _material(Color(0.18, 0.09, 0.045), 0.90)
	roof_material = _material(Color(0.095, 0.075, 0.055), 0.97)
	canvas_material = _material(Color(0.42, 0.31, 0.17), 0.99)

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

func create_voss_waystation_landmark() -> Node3D:
	# CP-D5-006: anexo de pedra e madeira do marco Casa Voss, isolado da casa jogável.
	# Três materiais: reboco, madeira e telhado. Não contém luzes nem painéis.
	var house := Node3D.new()
	house.name = "AnexoCasaVossMarco1"
	house.add_to_group("dev5_landmark_voss")
	var foundation := _box("FundacaoPedra", Vector3(3.55, 0.32, 2.72), plaster_material)
	foundation.position = Vector3(0.0, 0.0, 0.0)
	house.add_child(foundation)
	_add_static_collider(foundation, Vector3(3.55, 0.32, 2.72))
	# Paredes grossas e uma abertura frontal real, nunca uma fachada plana.
	for side: float in [-1.0, 1.0]:
		var wall := _box("ParedeLateral%+.0f" % side, Vector3(0.24, 1.75, 2.45), plaster_material)
		wall.position = Vector3(side * 1.63, 1.01, 0.0)
		house.add_child(wall)
		_add_static_collider(wall, Vector3(0.24, 1.75, 2.45))
	var back_wall := _box("ParedePosterior", Vector3(3.18, 1.75, 0.24), plaster_material)
	back_wall.position = Vector3(0.0, 1.01, -1.10)
	house.add_child(back_wall)
	_add_static_collider(back_wall, Vector3(3.18, 1.75, 0.24))
	for door_side: float in [-1.0, 1.0]:
		var front_wall := _box("ParedeFrontal%+.0f" % door_side, Vector3(0.95, 1.75, 0.24), plaster_material)
		front_wall.position = Vector3(door_side * 1.10, 1.01, 1.10)
		house.add_child(front_wall)
		_add_static_collider(front_wall, Vector3(0.95, 1.75, 0.24))
	# Estrutura de madeira e lintel enfatizam a casa como marco histórico do mapa.
	for corner_x: float in [-1.48, 1.48]:
		for corner_z: float in [-1.02, 1.02]:
			var beam := _box("VigaCanto_%+.0f_%+.0f" % [corner_x, corner_z], Vector3(0.16, 2.05, 0.16), timber_material)
			beam.position = Vector3(corner_x, 1.20, corner_z)
			house.add_child(beam)
	var lintel := _box("LintelEntrada", Vector3(1.40, 0.18, 0.24), timber_material)
	lintel.position = Vector3(0.0, 1.78, 1.12)
	house.add_child(lintel)
	var threshold := _box("SoleiraEntrada", Vector3(1.28, 0.10, 0.60), timber_material)
	threshold.position = Vector3(0.0, 0.22, 1.34)
	house.add_child(threshold)
	# Telhado de duas águas com planos físicos inclinados, não um painel de fundo.
	for roof_side: float in [-1.0, 1.0]:
		var roof := _box("Telhado%+.0f" % roof_side, Vector3(1.95, 0.16, 2.72), roof_material)
		roof.position = Vector3(roof_side * 0.76, 2.03, 0.0)
		roof.rotation_degrees.z = roof_side * -31.0
		house.add_child(roof)
	var chimney := _box("Chamine", Vector3(0.34, 0.95, 0.34), plaster_material)
	chimney.position = Vector3(-0.78, 2.30, -0.34)
	house.add_child(chimney)
	return house

func create_majestic_pavilion_landmark() -> Node3D:
	# CP-D5-008: pavilhão do Acampamento Majestic, em volume real e sem luzes.
	var pavilion := Node3D.new()
	pavilion.name = "PavilhaoAcampamentoMajesticMarco5"
	pavilion.add_to_group("dev5_landmark_majestic")
	var deck := _box("EstradoDeMadeira", Vector3(4.60, 0.18, 3.30), timber_material)
	deck.position = Vector3(0.0, 0.09, 0.0)
	pavilion.add_child(deck)
	_add_static_collider(deck, Vector3(4.60, 0.18, 3.30))
	# Quatro postes ancoram uma tenda real, em vez de um painel ou silhueta plana.
	for post_x: float in [-1.92, 1.92]:
		for post_z: float in [-1.30, 1.30]:
			var post := _cylinder("Poste_%+.0f_%+.0f" % [post_x, post_z], 0.105, 2.55, timber_material)
			post.position = Vector3(post_x, 1.36, post_z)
			pavilion.add_child(post)
	# Cobertura dupla inclinada e beirais: forma reconhecível no marco 5 do mapa.
	for side: float in [-1.0, 1.0]:
		var canopy := _box("Lona%+.0f" % side, Vector3(2.44, 0.10, 3.72), canvas_material)
		canopy.position = Vector3(side * 0.98, 2.48, 0.0)
		canopy.rotation_degrees.z = side * -27.5
		pavilion.add_child(canopy)
	var ridge := _box("Cumeeira", Vector3(0.16, 0.16, 3.48), timber_material)
	ridge.position = Vector3(0.0, 2.63, 0.0)
	pavilion.add_child(ridge)
	# Painéis de lona curtos mantêm a entrada aberta e dão profundidade lateral.
	for side: float in [-1.0, 1.0]:
		var curtain := _box("LonaLateral%+.0f" % side, Vector3(0.08, 1.12, 2.85), canvas_material)
		curtain.position = Vector3(side * 2.02, 1.22, 0.0)
		pavilion.add_child(curtain)
	var bench := _box("BancoDeCampanha", Vector3(2.05, 0.32, 0.48), timber_material)
	bench.position = Vector3(0.0, 0.44, -0.86)
	pavilion.add_child(bench)
	_add_static_collider(bench, Vector3(2.05, 0.32, 0.48))
	return pavilion

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
