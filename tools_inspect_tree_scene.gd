extends SceneTree

const TREE_SCENE: PackedScene = preload("res://assets/models_polyhaven/island_tree_01/island_tree_01_1k.gltf")

func _init() -> void:
	var root: Node3D = TREE_SCENE.instantiate() as Node3D
	if root == null:
		push_error("Não foi possível instanciar island_tree_01_1k.gltf")
		quit(1)
		return
	_print_node(root, "", Transform3D.IDENTITY)
	quit()

func _print_node(node: Node, indent: String, parent_transform: Transform3D) -> void:
	var local_transform: Transform3D = Transform3D.IDENTITY
	if node is Node3D:
		local_transform = (node as Node3D).transform
	var accumulated_transform: Transform3D = parent_transform * local_transform
	if node is MeshInstance3D:
		var mesh_node: MeshInstance3D = node as MeshInstance3D
		var mesh: Mesh = mesh_node.mesh
		var surfaces: int = mesh.get_surface_count() if mesh != null else 0
		print("MESH|%s|surfaces=%d|local_origin=%s|accumulated_origin=%s" % [node.name, surfaces, local_transform.origin, accumulated_transform.origin])
	else:
		print("NODE|%s|type=%s" % [node.name, node.get_class()])
	for child: Node in node.get_children():
		_print_node(child, indent + "  ", accumulated_transform)
