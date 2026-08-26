## ArchAwakening.gd
## DEV3-R3-ARCH-AWAKENING-RECOVERY-001
## Camada modular que devolve inscrições, efeito único e persistência ao Arco físico existente.

class_name R3ArchAwakening
extends Node3D

const EVENT_ID: String = "r3_arch_awakened"
const INSCRIPTION_LORE_SCRIPT: Script = preload("res://levels/regions/r3/ArchInscriptionLore.gd")
const ARCH_PATINA_SCRIPT: Script = preload("res://levels/regions/r3/ArchPatina.gd")
const ARCH_SILHOUETTE_SCRIPT: Script = preload("res://levels/regions/r3/ArchSilhouette.gd")
const ARCH_ARRIVAL_CUE_SCRIPT: Script = preload("res://levels/regions/r3/ArchArrivalCue.gd")
const ARCH_GROUND_RHYTHM_SCRIPT: Script = preload("res://levels/regions/r3/ArchGroundRhythm.gd")
const ARCH_EXIT_ECHO_SCRIPT: Script = preload("res://levels/regions/r3/ArchExitEcho.gd")
const SILENT_CADENCE_DURATION: float = 1.35
const SILENT_CADENCE_BEATS: int = 3
const SILENT_CADENCE_SCALE_DELTA: float = 0.12

var awakened: bool = false
var effect_time: float = 0.0
var silent_cadence_elapsed: float = 0.0
var silent_cadence_active: bool = false
var effect_root: Node3D
var inscription_left: Label3D
var inscription_right: Label3D
var inscription_lore: Node3D

static func install(arch: Node3D) -> R3ArchAwakening:
	if arch == null:
		return null
	var existing: R3ArchAwakening = arch.get_node_or_null("R3ArchAwakening") as R3ArchAwakening
	if existing != null:
		return existing
	var controller: R3ArchAwakening = R3ArchAwakening.new()
	controller.name = "R3ArchAwakening"
	arch.add_child(controller)
	return controller

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	add_to_group("Persist")
	_build_inscriptions()
	inscription_lore = INSCRIPTION_LORE_SCRIPT.call("install", get_parent() as Node3D) as Node3D
	ARCH_PATINA_SCRIPT.call("install", get_parent() as Node3D)
	ARCH_SILHOUETTE_SCRIPT.call("install", get_parent() as Node3D)
	ARCH_ARRIVAL_CUE_SCRIPT.call("install", get_parent() as Node3D)
	ARCH_GROUND_RHYTHM_SCRIPT.call("install", get_parent() as Node3D)
	ARCH_EXIT_ECHO_SCRIPT.call("install", get_parent() as Node3D)
	_build_trigger()
	_build_effects()
	_apply_awakened_state()

func _process(delta: float) -> void:
	if not awakened or effect_root == null:
		return
	effect_time += delta
	if silent_cadence_active:
		silent_cadence_elapsed += delta
		var progression: float = clampf(silent_cadence_elapsed / SILENT_CADENCE_DURATION, 0.0, 1.0)
		var beat: float = pow(sin(progression * PI * float(SILENT_CADENCE_BEATS)), 2.0) * (1.0 - progression * 0.18)
		var cadence_scale: float = 1.0 + beat * SILENT_CADENCE_SCALE_DELTA
		effect_root.scale = Vector3(cadence_scale, 1.0 + beat * 0.055, cadence_scale)
		if progression >= 1.0:
			silent_cadence_active = false
		return
	var pulse: float = 1.0 + sin(effect_time * 2.1) * 0.030
	effect_root.scale = Vector3(pulse, 1.0 + sin(effect_time * 1.6) * 0.014, pulse)

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
	effect_time = 0.0
	silent_cadence_elapsed = 0.0
	silent_cadence_active = true
	_apply_awakened_state()
	EventBus.world_event_triggered.emit(EVENT_ID)
	EventBus.player_message_requested.emit("As inscrições do Arco despertam: «a pedra recorda; não sigas a luz». ", 3.2)
	return true

func get_silent_cadence_contract() -> Dictionary:
	return {
		"duration_seconds": SILENT_CADENCE_DURATION,
		"beats": SILENT_CADENCE_BEATS,
		"scale_delta": SILENT_CADENCE_SCALE_DELTA,
		"adds_lights": false,
		"adds_emitters": false,
		"adds_audio": false
	}

func _apply_awakened_state() -> void:
	if effect_root != null:
		effect_root.visible = awakened
		if not awakened:
			effect_root.scale = Vector3.ONE
			silent_cadence_elapsed = 0.0
			silent_cadence_active = false
	if inscription_left != null:
		inscription_left.modulate = Color(0.25, 0.78, 0.92, 1.0) if awakened else Color(0.46, 0.56, 0.54, 0.92)
	if inscription_right != null:
		inscription_right.modulate = Color(0.25, 0.78, 0.92, 1.0) if awakened else Color(0.46, 0.56, 0.54, 0.92)
	if inscription_lore != null and inscription_lore.has_method("set_awakened"):
		inscription_lore.call("set_awakened", awakened)
