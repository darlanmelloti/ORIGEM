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
	if not lore.find_children("*", "CollisionShape3D", true, false).is_empty() or not lore.find_children("*", "StaticBody3D", true, false).is_empty():
		issues.append("as placas arqueológicas não podem introduzir colisores")
	if not lore.find_children("*", "Light3D", true, false).is_empty():
		issues.append("as placas arqueológicas não podem introduzir luz dinâmica")
	if not lore.find_children("*", "Control", true, false).is_empty() or not lore.find_children("*", "CanvasLayer", true, false).is_empty():
		issues.append("a leitura arqueológica R3 não pode abrir UI persistente")
	return issues
