extends Node3D

## CP-D5-019: composição QA vegetal dos marcos 4 e 5.
const TREE_PBR := "res://assets/models_generated/ez_pine_tall_pbr.glb"
const TREE_DETAILED := "res://assets/models_cc0/tree_detailed_dark.glb"
const TREE_LIGHT := "res://assets/models_cc0/tree_default_dark.glb"
const PLACEMENT := preload("res://levels/dev5/CartographicPlacementSystem.gd")

func _ready() -> void:
	name = "MediumVegetationCompositionPreview"
	_build_environment()
	_build_composition(4, Vector2(-9.0, 116.0), "FlorestaDensa")
	_build_composition(5, Vector2(-88.0, 178.0), "AcampamentoMajestic")
	print("[DEV5_VEGETATION_COMPOSITION] anchors=4,5 pbr_per_composition=1 medium_per_composition=3 distant_per_composition=4 wall_of_trees=false production_script=false")

func _build_composition(anchor_id: int, map_position: Vector2, label: String) -> void:
	var record: Dictionary = PLACEMENT.placement_record("vegetation_%s" % label, anchor_id, Vector2.ZERO, 0.0)
	assert(PLACEMENT.assert_anchor_distance(record, 36.0))
	var cluster := Node3D.new()
	cluster.name = "%sVegetationQA" % label
	cluster.position = Vector3(float(anchor_id) * 9.0 - 22.0, 0.0, float(anchor_id) * 5.0)
	add_child(cluster)
	_add_asset(cluster, TREE_PBR, Vector3(0.0, 0.0, 0.0), 0.82, "PBRFocal")
	var medium_positions: Array[Vector3] = [Vector3(-3.8, 0.0, -2.1), Vector3(2.7, 0.0, -0.8), Vector3(-1.6, 0.0, 3.4)]
	for index: int in range(medium_positions.size()):
		_add_asset(cluster, TREE_DETAILED, medium_positions[index], 0.72 + index * 0.08, "Media%02d" % index)
	var distant_positions: Array[Vector3] = [Vector3(-5.7, 0.0, 4.8), Vector3(5.2, 0.0, 2.8), Vector3(-4.9, 0.0, -5.0), Vector3(5.8, 0.0, -3.7)]
	for index: int in range(distant_positions.size()):
		_add_asset(cluster, TREE_LIGHT, distant_positions[index], 0.9 + (index % 2) * 0.12, "Distante%02d" % index)
	print("[DEV5_VEGETATION_COMPOSITION] label=%s anchor=%d map_xz=%s local_offset=(0,0) pbr=1 medium=3 distant=4" % [label, anchor_id, map_position])

func _add_asset(parent: Node3D, asset_path: String, local_position: Vector3, scale_value: float, node_name: String) -> void:
	var packed := load(asset_path) as PackedScene
	if packed == null:
		push_error("[DEV5_VEGETATION_COMPOSITION] impossible_load=%s" % asset_path)
		return
	var instance := packed.instantiate() as Node3D
	instance.name = node_name
	instance.position = local_position
	instance.rotation_degrees.y = float((node_name.hash() % 41) - 20)
	instance.scale = Vector3.ONE * scale_value
	parent.add_child(instance)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.22, 0.34, 0.24)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.54, 0.64, 0.50)
	environment.ambient_light_energy = 0.76
	world.environment = environment
	add_child(world)
	var sun := DirectionalLight3D.new()
	sun.name = "LuzQAVegetacao"
	sun.rotation_degrees = Vector3(-50.0, -30.0, 0.0)
	sun.light_energy = 1.0
	sun.shadow_enabled = true
	add_child(sun)
	var camera := Camera3D.new()
	camera.name = "CameraQAVegetacao"
	camera.position = Vector3(0.0, 9.0, 22.0)
	camera.look_at_from_position(camera.position, Vector3(0.0, 1.0, 6.0))
	camera.current = true
	add_child(camera)
