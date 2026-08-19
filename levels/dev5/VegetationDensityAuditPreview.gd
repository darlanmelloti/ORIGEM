## Dev5 — CP-D5-018: auditoria de densidade vegetal com activos reais.
## Apenas QA; não carrega ForestLakeRegion.gd nem altera produção.

extends Node3D

const PINE_SCENE: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const DARK_TREE_SCENE: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const DEFAULT_TREE_SCENE: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const FERN_SCENE: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")

var sample_triangles: int = 0

func _ready() -> void:
	_build_environment()
	_build_ground()
	_place_assets()
	_build_camera()
	print("[DEV5_VEGETATION_AUDIT] composition=pine_focal:1 dark_tree_medium:3 tree_light:1 fern_foreground:2 total_triangles=%d dynamic_lights=0 wall_density=false" % sample_triangles)
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.19, 0.29, 0.23)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.52, 0.64, 0.55)
	environment.ambient_light_energy = 0.74
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.05
	sun.rotation_degrees = Vector3(-48.0, -26.0, 0.0)
	add_child(sun)

func _build_ground() -> void:
	var ground := MeshInstance3D.new()
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(24.0, 24.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.09, 0.17, 0.095)
	material.roughness = 0.96
	mesh.material = material
	ground.mesh = mesh
	add_child(ground)

func _place_assets() -> void:
	_add_asset(PINE_SCENE, Vector3(-1.8, 0.0, -2.6), Vector3(0.55, 0.55, 0.55), "PineFocal")
	_add_asset(DARK_TREE_SCENE, Vector3(-5.0, 0.0, 1.2), Vector3(1.45, 1.45, 1.45), "TreeMediumA")
	_add_asset(DARK_TREE_SCENE, Vector3(3.8, 0.0, 1.6), Vector3(1.25, 1.25, 1.25), "TreeMediumB")
	_add_asset(DARK_TREE_SCENE, Vector3(5.6, 0.0, -3.0), Vector3(1.0, 1.0, 1.0), "TreeMediumC")
	_add_asset(DEFAULT_TREE_SCENE, Vector3(-6.4, 0.0, -2.4), Vector3(1.35, 1.35, 1.35), "TreeLightAlternative")
	_add_asset(FERN_SCENE, Vector3(-1.8, 0.0, 2.5), Vector3(1.15, 1.15, 1.15), "FernForegroundA")
	_add_asset(FERN_SCENE, Vector3(1.4, 0.0, 3.2), Vector3(0.95, 0.95, 0.95), "FernForegroundB")

func _add_asset(scene: PackedScene, position_3d: Vector3, scale_3d: Vector3, asset_name: String) -> void:
	var instance := scene.instantiate()
	instance.name = asset_name
	instance.position = position_3d
	instance.scale = scale_3d
	add_child(instance)
	sample_triangles += _count_triangles(instance)

func _count_triangles(node: Node) -> int:
	var total := 0
	if node is MeshInstance3D:
		var mesh_node := node as MeshInstance3D
		if mesh_node.mesh != null:
			total += mesh_node.mesh.get_faces().size() / 3
	for child: Node in node.get_children():
		total += _count_triangles(child)
	return total

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(10.5, 6.2, 12.0)
	camera.fov = 55.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 1.8, 0.0), Vector3.UP)
	camera.make_current()

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var result := get_viewport().get_texture().get_image().save_png(snapshot_path)
	print("[DEV5_VEGETATION_AUDIT] snapshot=%s result=%s" % [snapshot_path, result])
