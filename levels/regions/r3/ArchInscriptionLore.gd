## ArchInscriptionLore.gd
## DEV3-R3-INSCRIPTION-LORE-003
## Leitura arqueológica lateral do Arco, física e discreta, sem UI, colisão ou luz dinâmica.

class_name R3ArchInscriptionLore
extends Node3D

const LEFT_TEXT: String = "O RIO GUARDA\nO QUE A PEDRA CALA"
const RIGHT_TEXT: String = "A LUZ NÃO SABE\nO CAMINHO DE VOLTA"
const MIN_CLEARANCE_X: float = 4.20

var lore_labels: Array[Label3D] = []

static func install(arch: Node3D) -> R3ArchInscriptionLore:
	if arch == null:
		return null
	var existing: R3ArchInscriptionLore = arch.get_node_or_null("R3LeituraArqueologica") as R3ArchInscriptionLore
	if existing != null:
		return existing
	var lore: R3ArchInscriptionLore = R3ArchInscriptionLore.new()
	lore.name = "R3LeituraArqueologica"
	arch.add_child(lore)
	return lore

func _ready() -> void:
	_build_plate("PlacaArqueologicaOeste", LEFT_TEXT, Vector3(-5.20, 0.82, 3.45), -0.36, false)
	_build_plate("PlacaArqueologicaEste", RIGHT_TEXT, Vector3(5.32, 0.74, 5.18), 0.31, true)
	_build_river_memory()
	set_awakened(false)

func set_awakened(value: bool) -> void:
	var glyph_tint: Color = Color(0.40, 0.47, 0.43, 0.92)
	if value:
		glyph_tint = Color(0.49, 0.64, 0.64, 0.96)
	for label: Label3D in lore_labels:
		label.modulate = glyph_tint

func _build_plate(node_name: String, text_value: String, local_position: Vector3, yaw: float, mirrored: bool) -> void:
	var plate_root: Node3D = Node3D.new()
	plate_root.name = node_name
	plate_root.position = local_position
	plate_root.rotation = Vector3(0.10 if mirrored else -0.08, yaw, 0.13 if mirrored else -0.11)
	add_child(plate_root)

	var slab: MeshInstance3D = MeshInstance3D.new()
	slab.name = "PedraQuebrada"
	var slab_mesh: PrismMesh = PrismMesh.new()
	slab_mesh.size = Vector3(1.12, 0.84, 0.18)
	slab_mesh.left_to_right = 0.36 if mirrored else 0.64
	slab.mesh = slab_mesh
	slab.position = Vector3(0.0, 0.42, 0.0)
	slab.material_override = _make_stone_material(Color(0.18, 0.22, 0.19, 1.0))
	plate_root.add_child(slab)

	var fracture: MeshInstance3D = MeshInstance3D.new()
	fracture.name = "FragmentoDaFratura"
	var fracture_mesh: PrismMesh = PrismMesh.new()
	fracture_mesh.size = Vector3(0.40, 0.30, 0.09)
	fracture_mesh.left_to_right = 0.26 if mirrored else 0.74
	fracture.mesh = fracture_mesh
	fracture.position = Vector3(-0.31 if mirrored else 0.31, 0.91, -0.13)
	fracture.rotation.z = -0.24 if mirrored else 0.24
	fracture.material_override = _make_stone_material(Color(0.105, 0.135, 0.115, 1.0))
	plate_root.add_child(fracture)

	var label: Label3D = Label3D.new()
	label.name = "TextoDaPlaca_%s" % ("Este" if mirrored else "Oeste")
	label.text = text_value
	label.font_size = 24
	label.outline_size = 2
	label.pixel_size = 0.006
	label.position = Vector3(0.0, 0.47, -0.105)
	label.rotation = Vector3(-0.02, PI, 0.0)
	label.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	label.no_depth_test = false
	plate_root.add_child(label)
	lore_labels.append(label)

func _build_river_memory() -> void:
	# DEV3-R3-RIVER-MEMORY-006: seixos gastos pela água insinuam a memória do rio sem textualizar ou fechar a passagem.
	var memory_root: Node3D = Node3D.new()
	memory_root.name = "MemoriaMaterialDoRio"
	memory_root.set_meta("r3_road_offset", -4.72)
	add_child(memory_root)
	var wet_material: StandardMaterial3D = _make_stone_material(Color(0.115, 0.155, 0.160, 1.0))
	wet_material.roughness = 0.88
	wet_material.metallic = 0.0
	var pebble_specs: Array[Dictionary] = [
		{"position": Vector3(-5.02, 0.13, 1.82), "scale": Vector3(0.45, 0.080, 0.30), "yaw": 0.28},
		{"position": Vector3(-5.48, 0.107, 2.26), "scale": Vector3(0.34, 0.068, 0.25), "yaw": -0.46},
		{"position": Vector3(-4.74, 0.100, 2.54), "scale": Vector3(0.29, 0.060, 0.20), "yaw": 0.72}
	]
	for index: int in range(pebble_specs.size()):
		var spec: Dictionary = pebble_specs[index]
		var pebble: MeshInstance3D = MeshInstance3D.new()
		pebble.name = "SeixoLavado_%02d" % (index + 1)
		var pebble_mesh: SphereMesh = SphereMesh.new()
		pebble_mesh.radius = 1.0
		pebble_mesh.height = 2.0
		pebble_mesh.radial_segments = 20
		pebble.mesh = pebble_mesh
		var requested_position: Vector3 = spec["position"] as Vector3
		var requested_scale: Vector3 = spec["scale"] as Vector3
		pebble.position = Vector3(requested_position.x, _ground_height(requested_position.x, requested_position.z) + requested_scale.y, requested_position.z)
		pebble.scale = requested_scale
		pebble.rotation.y = spec["yaw"] as float
		pebble.material_override = wet_material
		memory_root.add_child(pebble)

func _ground_height(local_x: float, local_z: float) -> float:
	var arch: Node3D = get_parent() as Node3D
	var road: Node = arch.get_parent() if arch != null else null
	if arch != null and road != null and road.has_method("_height_at"):
		var world_x: float = arch.global_position.x + local_x
		var world_z: float = arch.global_position.z + local_z
		return float(road.call("_height_at", world_x, world_z)) - arch.global_position.y
	return 0.0

func _make_stone_material(color_value: Color) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color_value
	material.roughness = 0.94
	material.metallic = 0.0
	return material

static func validate(arch: Node3D) -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if arch == null:
		issues.append("a leitura arqueológica não recebeu o Arco R3")
		return issues
	var lore: Node3D = arch.get_node_or_null("R3LeituraArqueologica") as Node3D
	if lore == null:
		issues.append("as duas placas arqueológicas R3 estão em falta")
		return issues
	var plates: Array[Node] = lore.find_children("PlacaArqueologica*", "Node3D", false, false)
	if plates.size() != 2:
		issues.append("a leitura arqueológica R3 deve conter exatamente duas placas")
	for plate: Node in plates:
		var plate_3d: Node3D = plate as Node3D
		if plate_3d != null and absf(plate_3d.position.x) < MIN_CLEARANCE_X:
			issues.append("uma placa arqueológica invade a faixa central do Arco")
	var labels: Array[Node] = lore.find_children("TextoDaPlaca*", "Label3D", true, false)
	if labels.size() != 2:
		issues.append("as duas leituras ambientais das placas estão em falta")
	else:
		var label_texts: PackedStringArray = PackedStringArray()
		for label_node: Node in labels:
			var label: Label3D = label_node as Label3D
			if label != null:
				label_texts.append(label.text)
		if not label_texts.has(LEFT_TEXT) or not label_texts.has(RIGHT_TEXT):
			issues.append("o texto ambiental das placas perdeu a memória do rio ou o aviso da luz")
	var river_memory: Node3D = lore.get_node_or_null("MemoriaMaterialDoRio") as Node3D
	if river_memory == null:
		issues.append("a memória material do rio está em falta")
	else:
		if not river_memory.has_meta("r3_road_offset") or absf(float(river_memory.get_meta("r3_road_offset"))) < MIN_CLEARANCE_X:
			issues.append("a memória material do rio invade a faixa central do Arco")
		var pebbles: Array[Node] = river_memory.find_children("SeixoLavado*", "MeshInstance3D", false, false)
		if pebbles.size() != 3:
			issues.append("a memória material do rio deve conter três seixos baixos")
		for pebble_node: Node in pebbles:
			var pebble: MeshInstance3D = pebble_node as MeshInstance3D
			if pebble != null and pebble.scale.y > 0.08:
				issues.append("um seixo da memória do rio deixou de ser baixo")
	if not lore.find_children("*", "CollisionShape3D", true, false).is_empty() or not lore.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("as placas arqueológicas não podem introduzir colisores")
	if not lore.find_children("*", "Light3D", true, false).is_empty():
		issues.append("as placas arqueológicas não podem introduzir luz dinâmica")
	if not lore.find_children("*", "Control", true, false).is_empty() or not lore.find_children("*", "CanvasLayer", true, false).is_empty():
		issues.append("a leitura arqueológica R3 não pode abrir UI persistente")
	return issues
