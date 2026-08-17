## Primeiro bloco subterrâneo Orion: soleira neutra, sem altar, Cube ou emissões Chronos.
extends Node3D

var stone_material: Material
var active: bool = false

func configure(material: Material) -> void:
	stone_material = material

func _ready() -> void:
	name = "SoleiraSubterraneaOrion"
	_build_threshold()
	set_active(false)

func set_active(value: bool) -> void:
	active = value
	visible = value
	process_mode = Node.PROCESS_MODE_INHERIT if value else Node.PROCESS_MODE_DISABLED

func _build_threshold() -> void:
	# O piso visual e o colisor usam exactamente as mesmas dimensões e origem local.
	var floor_mesh: BoxMesh = BoxMesh.new()
	floor_mesh.size = Vector3(4.2, 0.32, 7.0)
	var floor_visual: MeshInstance3D = MeshInstance3D.new()
	floor_visual.name = "PisoFisicoDaSoleira"
	floor_visual.mesh = floor_mesh
	floor_visual.material_override = stone_material
	floor_visual.position = Vector3(0.0, -0.16, 0.0)
	add_child(floor_visual)
	var floor_body: StaticBody3D = StaticBody3D.new()
	floor_body.name = "ColisaoDoPisoDaSoleira"
	var floor_shape: CollisionShape3D = CollisionShape3D.new()
	var floor_box: BoxShape3D = BoxShape3D.new()
	floor_box.size = floor_mesh.size
	floor_shape.shape = floor_box
	floor_shape.position = floor_visual.position
	floor_body.add_child(floor_shape)
	add_child(floor_body)
	# CP-CINE-30: continuação adjacente a partir de z=3,5; sem sobreposição de piso ou de colisão.
	var continuation_mesh: BoxMesh = BoxMesh.new()
	continuation_mesh.size = Vector3(4.2, 0.32, 5.5)
	var continuation_visual: MeshInstance3D = MeshInstance3D.new()
	continuation_visual.name = "PisoFisicoSecao01"
	continuation_visual.mesh = continuation_mesh
	continuation_visual.material_override = stone_material
	continuation_visual.position = Vector3(0.0, -0.16, 6.25)
	add_child(continuation_visual)
	var continuation_body: StaticBody3D = StaticBody3D.new()
	continuation_body.name = "ColisaoDoPisoSecao01"
	var continuation_shape: CollisionShape3D = CollisionShape3D.new()
	var continuation_box: BoxShape3D = BoxShape3D.new()
	continuation_box.size = continuation_mesh.size
	continuation_shape.shape = continuation_box
	continuation_shape.position = continuation_visual.position
	continuation_body.add_child(continuation_shape)
	add_child(continuation_body)
	# Apenas duas paredes curtas e convergentes; o teto e o santuário pertencem a blocos posteriores.
	for side: float in [-1.0, 1.0]:
		var wall_mesh: BoxMesh = BoxMesh.new()
		wall_mesh.size = Vector3(0.42, 3.2, 5.8)
		var wall: MeshInstance3D = MeshInstance3D.new()
		wall.name = "ParedeDeRocha_%s" % ("Oeste" if side < 0.0 else "Este")
		wall.mesh = wall_mesh
		wall.material_override = stone_material
		wall.position = Vector3(side * 2.3, 1.42, 3.1)
		wall.rotation.y = side * 0.12
		add_child(wall)
		var wall_body: StaticBody3D = StaticBody3D.new()
		wall_body.name = "Colisao_%s" % wall.name
		var wall_shape: CollisionShape3D = CollisionShape3D.new()
		var wall_box: BoxShape3D = BoxShape3D.new()
		wall_box.size = wall_mesh.size
		wall_shape.shape = wall_box
		wall_shape.position = wall.position
		wall_shape.rotation = wall.rotation
		wall_body.add_child(wall_shape)
		add_child(wall_body)
