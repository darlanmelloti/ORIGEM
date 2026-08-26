## R6ShoreHandoff.gd
## DEV6-R6-SHORE-HANDOFF-002
## Transição física contida das Ruínas Submersas para a futura Vila Elevada, sem construir conteúdo R7.

class_name R6ShoreHandoff
extends Node3D

static func install(region: Node3D, rock_scene: PackedScene, pillar_scene: PackedScene, height_at: Callable) -> R6ShoreHandoff:
	if region == null or not height_at.is_valid():
		return null
	var existing: R6ShoreHandoff = region.get_node_or_null("HandoffR6ParaVilaElevada") as R6ShoreHandoff
	if existing != null:
		return existing
	var handoff: R6ShoreHandoff = R6ShoreHandoff.new()
	handoff.name = "HandoffR6ParaVilaElevada"
	region.add_child(handoff)
	handoff._build(rock_scene, pillar_scene, height_at)
	return handoff

func _build(rock_scene: PackedScene, pillar_scene: PackedScene, height_at: Callable) -> void:
	var route_root: Node3D = Node3D.new()
	route_root.name = "ContinuacaoFisicaDaMargemR6"
	add_child(route_root)
	var slab_material: StandardMaterial3D = StandardMaterial3D.new()
	slab_material.albedo_color = Color(0.20, 0.23, 0.22, 1.0)
	slab_material.roughness = 0.92
	var points: Array[Vector2] = [
		Vector2(82.0, 288.0),
		Vector2(88.0, 296.0),
		Vector2(94.0, 304.0),
		Vector2(100.0, 311.0),
	]
	for index: int in range(points.size()):
		var point: Vector2 = points[index]
		var y: float = float(height_at.call(point.x, point.y)) + 0.11
		var slab_mesh: BoxMesh = BoxMesh.new()
		slab_mesh.size = Vector3(3.15, 0.22, 2.25)
		var slab: MeshInstance3D = MeshInstance3D.new()
		slab.name = "LajeHandoffR6_%02d" % (index + 1)
		slab.mesh = slab_mesh
		slab.material_override = slab_material
		slab.position = Vector3(point.x, y, point.y)
		slab.rotation.y = -0.64 + float(index) * 0.035
		route_root.add_child(slab)
		var body: StaticBody3D = StaticBody3D.new()
		body.name = "ColisorLajeHandoffR6_%02d" % (index + 1)
		body.position = slab.position
		body.rotation.y = slab.rotation.y
		var collision: CollisionShape3D = CollisionShape3D.new()
		var shape: BoxShape3D = BoxShape3D.new()
		shape.size = Vector3(3.10, 0.26, 2.18)
		collision.shape = shape
		body.add_child(collision)
		route_root.add_child(body)
	_build_way_marker("MarcoR6R7Ocidental", Vector2(79.0, 295.0), -0.34, 0.52, rock_scene, pillar_scene, height_at)
	_build_way_marker("MarcoR6R7Oriental", Vector2(105.0, 309.0), 0.58, 0.40, rock_scene, pillar_scene, height_at)

func _build_way_marker(marker_name: String, point: Vector2, rotation_y: float, scale_value: float, rock_scene: PackedScene, pillar_scene: PackedScene, height_at: Callable) -> void:
	var marker: Node3D = Node3D.new()
	marker.name = marker_name
	marker.position = Vector3(point.x, float(height_at.call(point.x, point.y)), point.y)
	marker.rotation.y = rotation_y
	add_child(marker)
	var pillar: Node3D = pillar_scene.instantiate() as Node3D
	if pillar != null:
		pillar.name = "FragmentoArqueologico"
		pillar.scale = Vector3(scale_value, scale_value * 1.35, scale_value)
		pillar.position = Vector3(0.0, 1.15 * scale_value, 0.0)
		pillar.rotation = Vector3(0.08, 0.18, -0.11)
		marker.add_child(pillar)
	for rock_index: int in range(2):
		var rock: Node3D = rock_scene.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "PedraDeDireccao_%02d" % (rock_index + 1)
		rock.scale = Vector3(0.18 + float(rock_index) * 0.05, 0.15 + float(rock_index) * 0.04, 0.18 + float(rock_index) * 0.05)
		rock.position = Vector3(-0.58 + float(rock_index) * 1.05, 0.07, 0.46 - float(rock_index) * 0.62)
		rock.rotation.y = float(rock_index) * 1.38
		marker.add_child(rock)
	var body: StaticBody3D = StaticBody3D.new()
	body.name = "Colisor%s" % marker_name
	body.position = marker.position + Vector3(0.0, 0.76, 0.0)
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: CylinderShape3D = CylinderShape3D.new()
	shape.radius = 0.44 * scale_value + 0.20
	shape.height = 2.15 * scale_value + 0.42
	collision.shape = shape
	body.add_child(collision)
	add_child(body)
