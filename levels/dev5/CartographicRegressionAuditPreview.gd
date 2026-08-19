extends Node3D

## CP-D5-020: auditoria de regressão dos candidatos Dev5, sem integrar produção.
const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")
const CANDIDATES: Array[Dictionary] = [
	{"name": "CasaVoss", "scene": "res://levels/dev5/VossWaystationPreview.tscn", "anchor": 1},
	{"name": "PonteMarco2", "scene": "res://levels/dev5/StoneBridgeLandmarkPreview.tscn", "anchor": 2},
	{"name": "FlorestaDensa", "scene": "res://levels/dev5/DenseForestPortalPreview.tscn", "anchor": 4},
	{"name": "Majestic", "scene": "res://levels/dev5/MajesticPavilionPreview.tscn", "anchor": 5},
	{"name": "RuinasSubmersas", "scene": "res://levels/dev5/SubmergedRuinsPierPreview.tscn", "anchor": 6},
	{"name": "VegetacaoMedia", "scene": "res://levels/dev5/MediumVegetationCompositionPreview.tscn", "anchor": 4}
]

func _ready() -> void:
	name = "CartographicRegressionAuditPreview"
	_build_environment()
	for candidate: Dictionary in CANDIDATES:
		_audit_candidate(candidate)
	print("[DEV5_REGRESSION_AUDIT] candidates=%d production_scripts=0 dynamic_lights=0" % CANDIDATES.size())

func _audit_candidate(candidate: Dictionary) -> void:
	var anchor_id: int = candidate.anchor
	var record: Dictionary = PLACEMENT.placement_record(candidate.name, anchor_id, Vector2.ZERO, 0.0)
	var packed := load(candidate.scene) as PackedScene
	var root: Node = packed.instantiate() if packed != null else Node.new()
	add_child(root)
	var metrics := _collect_metrics(root)
	print("[DEV5_REGRESSION_AUDIT] candidate=%s anchor=%d map_xz=%s world_xz=%s offset=%s collisions=%d lights=%d production_script=false" % [candidate.name, anchor_id, record.map_canvas, record.world_xz, record.local_offset_xz, metrics.collisions, metrics.lights])
	root.queue_free()

func _collect_metrics(node: Node) -> Dictionary:
	var metrics: Dictionary = {"collisions": 0, "lights": 0}
	if node is CollisionShape3D or node is StaticBody3D:
		metrics.collisions += 1
	if node is Light3D:
		metrics.lights += 1
	for child: Node in node.get_children():
		var child_metrics := _collect_metrics(child)
		metrics.collisions += child_metrics.collisions
		metrics.lights += child_metrics.lights
	return metrics

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.08, 0.11, 0.10)
	world.environment = environment
	add_child(world)
	var camera := Camera3D.new()
	camera.position = Vector3(0.0, 7.0, 18.0)
	camera.look_at_from_position(camera.position, Vector3.ZERO)
	camera.current = true
	add_child(camera)
	var light := DirectionalLight3D.new()
	light.name = "LuzQAAuditoria"
	light.rotation_degrees = Vector3(-50.0, -30.0, 0.0)
	light.light_energy = 0.9
	add_child(light)
