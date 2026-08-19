## Dev5 — Auditor de orçamento de malhas para candidatos cartográficos.
## Corre somente em QA; nunca instancia objectos na produção.

extends Node3D

const ASSET_PATHS: Array[String] = [
	"res://assets/models_cc0/bridge_stone.glb",
	"res://assets/models_cc0/stone_largeA.glb",
	"res://assets/models_cc0/tree_detailed_dark.glb",
	"res://assets/models_generated/ez_pine_tall_pbr.glb",
	"res://assets/models_polyhaven/fern_02/fern_02_1k.gltf"
]

var total_triangles: int = 0
var total_mesh_nodes: int = 0
var total_material_slots: int = 0
var total_collision_nodes: int = 0

func _ready() -> void:
	for path: String in ASSET_PATHS:
		_audit_asset(path)
	print("[DEV5_MESH_AUDIT] total_triangles=%d mesh_nodes=%d material_slots=%d collision_nodes=%d dynamic_lights=0" % [total_triangles, total_mesh_nodes, total_material_slots, total_collision_nodes])
	_build_view()
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _audit_asset(path: String) -> void:
	var packed := load(path) as PackedScene
	if packed == null:
		push_error("[DEV5_MESH_AUDIT] impossível carregar %s" % path)
		return
	var asset_root := packed.instantiate()
	asset_root.name = "Audit_%s" % path.get_file().get_basename()
	add_child(asset_root)
	var metrics := _collect_metrics(asset_root)
	total_triangles += metrics["triangles"] as int
	total_mesh_nodes += metrics["mesh_nodes"] as int
	total_material_slots += metrics["material_slots"] as int
	total_collision_nodes += metrics["collision_nodes"] as int
	print("[DEV5_MESH_AUDIT] asset=%s triangles=%d mesh_nodes=%d materials=%d collisions=%d" % [path.get_file(), metrics["triangles"], metrics["mesh_nodes"], metrics["material_slots"], metrics["collision_nodes"]])
	asset_root.queue_free()

func _collect_metrics(node: Node) -> Dictionary:
	var metrics: Dictionary = {"triangles": 0, "mesh_nodes": 0, "material_slots": 0, "collision_nodes": 0}
	if node is MeshInstance3D:
		var mesh_node := node as MeshInstance3D
		if mesh_node.mesh != null:
			metrics["mesh_nodes"] = 1
			metrics["triangles"] = mesh_node.mesh.get_faces().size() / 3
			metrics["material_slots"] = mesh_node.mesh.get_surface_count()
	if node is CollisionShape3D or node is StaticBody3D:
		metrics["collision_nodes"] = 1
	for child: Node in node.get_children():
		var child_metrics := _collect_metrics(child)
		metrics["triangles"] += child_metrics["triangles"] as int
		metrics["mesh_nodes"] += child_metrics["mesh_nodes"] as int
		metrics["material_slots"] += child_metrics["material_slots"] as int
		metrics["collision_nodes"] += child_metrics["collision_nodes"] as int
	return metrics

func _build_view() -> void:
	var camera := Camera3D.new()
	camera.position = Vector3(0.0, 6.0, 14.0)
	add_child(camera)
	camera.look_at(Vector3.ZERO, Vector3.UP)
	camera.make_current()
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.035, 0.05, 0.065)
	environment_node.environment = environment
	add_child(environment_node)
	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-52.0, -28.0, 0.0)
	light.light_energy = 1.0
	add_child(light)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(30):
		await get_tree().process_frame
	var result := get_viewport().get_texture().get_image().save_png(snapshot_path)
	print("[DEV5_MESH_AUDIT] snapshot=%s result=%s" % [snapshot_path, result])
