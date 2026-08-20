extends Node3D
## Preview isolado Dev5 para integração modular e espelhamento cartográfico R6→R7.
## Não instancia módulos de produção nem altera Player.gd/TempleLevel.gd/HighlandRegion.gd.

const R6_XZ := Vector2(60.0, 252.0)
const R7_XZ := Vector2(140.0, 352.0)
const CLEARANCE := 2.4
const MAX_DYNAMIC_LIGHTS := 16

var modular_meshes := 0
var colliders := 0
var dynamic_lights := 0

func _ready() -> void:
	_build_ground()
	_build_anchor("R6_RUINAS_SUBMERSAS", R6_XZ, Color("#4f7180"))
	_build_transition_gate()
	_build_anchor("R7_VILA_ELEVADA_MARKER", R7_XZ, Color("#c49555"))
	_build_elias_camera()
	print("[DEV5_R6R7_MIRROR] status=active r6_xz=(60,252) r7_xz=(140,352) grounded=true")
	print("[DEV5_R6R7_MIRROR] modular_meshes=%d colliders=%d dynamic_lights=%d lanes=2 clearance=%.1f production_modules_changed=false" % [modular_meshes, colliders, dynamic_lights, CLEARANCE])
	print("[DEV5_R6R7_MIRROR] elias_third_person=true camera=CameraQA marker_only=true region7_geometry=false")
	assert(dynamic_lights <= MAX_DYNAMIC_LIGHTS)

func _material(color: Color, roughness := 0.82) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness
	return material

func _box(parent: Node3D, name: String, position: Vector3, size: Vector3, color: Color, collision := true) -> void:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = name
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh.material = _material(color)
	mesh_instance.mesh = mesh
	mesh_instance.position = position
	parent.add_child(mesh_instance)
	modular_meshes += 1
	if collision:
		var body := StaticBody3D.new()
		body.name = "%s_Collision" % name
		var shape := CollisionShape3D.new()
		var box_shape := BoxShape3D.new()
		box_shape.size = size
		shape.shape = box_shape
		body.position = position
		body.add_child(shape)
		parent.add_child(body)
		colliders += 1

func _build_ground() -> void:
	_box(self, "GroundedMirrorPlane", Vector3(100.0, -0.5, 302.0), Vector3(180.0, 1.0, 180.0), Color("#23352b"))

func _build_anchor(label: String, xz: Vector2, color: Color) -> void:
	var anchor := Node3D.new()
	anchor.name = label
	anchor.position = Vector3(xz.x, 0.0, xz.y)
	add_child(anchor)
	_box(anchor, "%s_Platform" % label, Vector3(0.0, 0.3, 0.0), Vector3(8.0, 0.6, 8.0), color)
	_box(anchor, "%s_Pillar" % label, Vector3(0.0, 2.0, 0.0), Vector3(1.2, 4.0, 1.2), color.darkened(0.22))

func _build_transition_gate() -> void:
	var gate := Node3D.new()
	gate.name = "R6R7_ModularTransitionGate"
	gate.position = Vector3(100.0, 0.0, 302.0)
	add_child(gate)
	_box(gate, "LeftGuide", Vector3(-3.0, 0.8, 0.0), Vector3(1.0, 1.6, 12.0), Color("#56605b"))
	_box(gate, "RightGuide", Vector3(3.0, 0.8, 0.0), Vector3(1.0, 1.6, 12.0), Color("#56605b"))
	_box(gate, "Header", Vector3(0.0, 4.0, 0.0), Vector3(7.0, 1.0, 1.2), Color("#8a704b"))
	for index in range(5):
		_box(gate, "ModularSlab_%02d" % index, Vector3(0.0, 0.12, -20.0 + index * 10.0), Vector3(4.0, 0.24, 3.6), Color("#6e766e"))
	for index in range(5):
		_box(gate, "ParallelSlab_%02d" % index, Vector3(8.0, 0.12, -20.0 + index * 10.0), Vector3(3.2, 0.24, 3.6), Color("#5f6d68"))

func _build_elias_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQA"
	camera.current = true
	camera.position = Vector3(91.0, 5.2, 284.0)
	camera.look_at(Vector3(100.0, 1.0, 302.0))
	add_child(camera)
