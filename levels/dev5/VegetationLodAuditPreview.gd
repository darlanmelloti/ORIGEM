extends Node3D

## CP-D5-018: auditoria QA de LOD vegetal; não instancia produção.
const ASSET_PATHS: Array[String] = [
	"res://assets/models_generated/ez_pine_tall_pbr.glb",
	"res://assets/models_cc0/tree_detailed_dark.glb",
	"res://assets/models_polyhaven/fern_02/fern_02_1k.gltf",
	"res://assets/models_cc0/tree_default_dark.glb"
]

func _ready() -> void:
	for path: String in ASSET_PATHS:
		_audit_asset(path)
	_build_view()
	print("[DEV5_LOD_AUDIT] focal_limit=1_pbr_tree medium_limit=3_detailed_trees distant_limit=8_light_foliage dynamic_lights=0")

func _audit_asset(path: String) -> void:
	var packed := load(path) as PackedScene
	if packed == null:
		push_error("[DEV5_LOD_AUDIT] impossible_load=%s" % path)
		return
	var asset_root := packed.instantiate()
	add_child(asset_root)
	var metrics := _collect_metrics(asset_root)
	var file_path := ProjectSettings.globalize_path(path)
	var file_handle := FileAccess.open(file_path, FileAccess.READ)
	var file_size := file_handle.get_length() if file_handle != null else -1
	if file_handle != null:
		file_handle.close()
	print("[DEV5_LOD_AUDIT] asset=%s triangles=%d meshes=%d materials=%d collisions=%d bytes=%d" % [path.get_file(), metrics.triangles, metrics.meshes, metrics.materials, metrics.collisions, file_size])
	asset_root.queue_free()

func _collect_metrics(node: Node) -> Dictionary:
	var metrics: Dictionary = {"triangles": 0, "meshes": 0, "materials": 0, "collisions": 0}
	if node is MeshInstance3D:
		var mesh_node := node as MeshInstance3D
		if mesh_node.mesh != null:
			metrics.meshes = 1
			metrics.triangles = mesh_node.mesh.get_faces().size() / 3
			metrics.materials = mesh_node.mesh.get_surface_count()
	if node is CollisionShape3D or node is StaticBody3D:
		metrics.collisions = 1
	for child: Node in node.get_children():
		var child_metrics := _collect_metrics(child)
		for key: String in metrics.keys():
			metrics[key] += child_metrics[key]
	return metrics

func _build_view() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(0.0, 5.0, 13.0)
	camera.look_at_from_position(camera.position, Vector3.ZERO)
	camera.current = true
	add_child(camera)
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.06, 0.10, 0.08)
	world.environment = environment
	add_child(world)
	var light := DirectionalLight3D.new()
	light.name = "LuzQALodVegetal"
	light.rotation_degrees = Vector3(-52.0, -28.0, 0.0)
	light.light_energy = 1.0
	add_child(light)
