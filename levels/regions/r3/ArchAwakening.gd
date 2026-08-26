## ArchAwakening.gd
## DEV3-R3-ARCH-AWAKENING-RECOVERY-001
## Camada modular que devolve inscrições, efeito único e persistência ao Arco físico existente.

class_name R3ArchAwakening
extends Node3D

const EVENT_ID: String = "r3_arch_awakened"

var awakened: bool = false
var effect_time: float = 0.0
var effect_root: Node3D
var inscription_left: Label3D
var inscription_right: Label3D

static func install(arch: Node3D):
	if arch == null:
		return null
	var existing = arch.get_node_or_null("R3ArchAwakening")
	if existing != null:
		return existing
	var controller = Node3D.new()
	controller.name = "R3ArchAwakening"
	arch.add_child(controller)
	return controller

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	add_to_group("Persist")
	_build_inscriptions()
	_build_trigger()
	_build_effects()
	_apply_awakened_state()

func _process(delta: float) -> void:
	if not awakened or effect_root == null:
		return
	effect_time += delta
	var pulse: float = 1.0 + sin(effect_time * 2.1) * 0.055
	effect_root.scale = Vector3(pulse, 1.0 + sin(effect_time * 1.6) * 0.025, pulse)

func save_data() -> Dictionary:
	return {"awakened": awakened}

func load_data(data: Dictionary) -> void:
	awakened = bool(data.get("awakened", false))
	_apply_awakened_state()

func _build_inscriptions() -> void:
	inscription_left = _make_inscription("R3InscricaoOeste", "A PEDRA RECORDA", Vector3(-3.95, 4.15, -0.90), 0.0)
	inscription_right = _make_inscription("R3InscricaoEste", "NÃO SIGAS A LUZ", Vector3(3.95, 4.15, -0.90), 0.0)

func _make_inscription(node_name: String, text_value: String, local_position: Vector3, yaw: float) -> Label3D:
	var label: Label3D = Label3D.new()
	label.name = node_name
	label.text = text_value
	label.font_size = 42
	label.outline_size = 4
	label.pixel_size = 0.008
	label.modulate = Color(0.46, 0.56, 0.54, 0.92)
	label.position = local_position
	label.rotation.y = yaw
	label.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	label.no_depth_test = false
	add_child(label)
	return label

func _build_trigger() -> void:
	var trigger: Area3D = Area3D.new()
	trigger.name = "R3GatilhoDeTravessia"
	trigger.monitoring = true
	trigger.monitorable = false
	trigger.position = Vector3(0.0, 2.0, 0.0)
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = Vector3(5.60, 4.20, 2.25)
	var collision: CollisionShape3D = CollisionShape3D.new()
	collision.name = "R3VolumeDeTravessia"
	collision.shape = shape
	trigger.add_child(collision)
	trigger.body_entered.connect(_on_traversal_body_entered)
	add_child(trigger)

func _build_effects() -> void:
	effect_root = Node3D.new()
	effect_root.name = "EfeitosDoDespertar"
	add_child(effect_root)
	var effect_material: StandardMaterial3D = StandardMaterial3D.new()
	effect_material.albedo_color = Color(0.10, 0.42, 0.58, 0.48)
	effect_material.emission_enabled = true
	effect_material.emission = Color(0.045, 0.21, 0.34, 1.0)
	effect_material.emission_energy_multiplier = 0.42
	effect_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	effect_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	for side: float in [-1.0, 1.0]:
		var rune: MeshInstance3D = MeshInstance3D.new()
		rune.name = "RunaDoDespertar_%s" % ("Oeste" if side < 0.0 else "Este")
		var mesh: SphereMesh = SphereMesh.new()
		mesh.radius = 0.22
		mesh.height = 0.44
		mesh.radial_segments = 12
		rune.mesh = mesh
		rune.material_override = effect_material
		rune.position = Vector3(side * 2.32, 5.05, -0.58)
		effect_root.add_child(rune)

func _on_traversal_body_entered(body: Node3D) -> void:
	if body == null or not body.is_in_group("player"):
		return
	awake_once()

func awake_once() -> bool:
	if awakened:
		return false
	awakened = true
	_apply_awakened_state()
	var event_bus: Node = get_node_or_null("/root/EventBus")
	if event_bus != null:
		event_bus.world_event_triggered.emit(EVENT_ID)
		event_bus.player_message_requested.emit("As inscrições do Arco despertam: «a pedra recorda; não sigas a luz». ", 3.2)
	return true

func _apply_awakened_state() -> void:
	if effect_root != null:
		effect_root.visible = awakened
	if inscription_left != null:
		inscription_left.modulate = Color(0.25, 0.78, 0.92, 1.0) if awakened else Color(0.46, 0.56, 0.54, 0.92)
	if inscription_right != null:
		inscription_right.modulate = Color(0.25, 0.78, 0.92, 1.0) if awakened else Color(0.46, 0.56, 0.54, 0.92)
