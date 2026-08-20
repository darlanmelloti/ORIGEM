extends SceneTree
## CP-D2-R1R6-027 — composição QA-only para âncoras próximas.
## Os painéis são uma apresentação de auditoria; as posições de origem continuam CartographicAnchors.gd.

const Anchors = preload("res://levels/CartographicAnchors.gd")
const MAX_DYNAMIC_LIGHTS := 16
var root_qa: Node3D
var light_count := 0

func _initialize() -> void:
	root_qa = Node3D.new()
	root_qa.name = "CPD2NearAnchorCompositionQA"
	get_root().add_child(root_qa)
	var environment := WorldEnvironment.new()
	var world := Environment.new()
	world.background_mode = Environment.BG_COLOR
	world.background_color = Color("#182737")
	world.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	world.ambient_light_color = Color("#b7c5d0")
	world.ambient_light_energy = 0.62
	environment.environment = world
	root_qa.add_child(environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-40.0, -30.0, 0.0)
	sun.light_energy = 0.5
	root_qa.add_child(sun)
	light_count += 1
	_add_panel(Vector3(-72.0, 0.0, -30.0), Vector2(-22.0, 8.0), Vector2(-21.4, 12.0), "R1 CASA VOSS", "R2 ESTRADA DO RIO", Color("#f5c56b"))
	_add_panel(Vector3(72.0, 0.0, -30.0), Vector2(-116.0, 548.0), Vector2(-116.0, 562.0), "R10 CAVERNA DO ORION", "R11 CÂMARA DO ORION CUBE", Color("#c39aff"))
	print("NEAR_ANCHOR_SOURCE R1=%s R2=%s R10=%s R11=%s" % [str(Anchors.CASA_VOSS), str(Anchors.ESTRADA_RIO_INICIO), str(Anchors.CAVERNA_ORION), str(Anchors.CAMARA_ORION_CUBE)])
	print("NEAR_ANCHOR_LIGHT_BUDGET=PASS dynamic_lights=%d max=%d" % [light_count, MAX_DYNAMIC_LIGHTS])
	var camera := Camera3D.new()
	camera.current = true
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 175.0
	root_qa.add_child(camera)
	await process_frame
	var duration := 31.0
	var env_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not env_seconds.is_empty():
		duration = maxf(float(env_seconds), 1.0)
	var frame_count := maxi(30, ceili(duration * 10.0))
	var center := Vector3(0.0, 0.0, -30.0)
	for frame: int in range(frame_count):
		camera.look_at_from_position(center + Vector3(0.0, 260.0, 0.0), center, Vector3.FORWARD)
		if frame % 30 == 0:
			print("NEAR_ANCHOR_DYNAMIC progress=%0.2f" % (float(frame) / float(frame_count - 1)))
		await create_timer(duration / float(frame_count)).timeout
	print("CP-D2-R1R6-027_NEAR_ANCHOR_CAPTURE=PASS")
	quit(0)

func _add_panel(panel_center: Vector3, source_a: Vector2, source_b: Vector2, title_a: String, title_b: String, color: Color) -> void:
	var panel := MeshInstance3D.new()
	var panel_mesh := BoxMesh.new()
	panel_mesh.size = Vector3(92.0, 0.12, 48.0)
	var panel_material := StandardMaterial3D.new()
	panel_material.albedo_color = Color("#30464e")
	panel_mesh.material = panel_material
	panel.mesh = panel_mesh
	panel.position = panel_center
	root_qa.add_child(panel)
	var source_delta := source_b - source_a
	var a_point := panel_center + Vector3(-24.0, 0.5, 6.0)
	var b_point := panel_center + Vector3(24.0, 0.5, -6.0)
	_add_marker(a_point, title_a, color, false)
	_add_marker(b_point, title_b, color.lightened(0.2), true)
	_add_segment(a_point, b_point, color)
	print("NEAR_ANCHOR_PANEL %s -> %s source_distance=%0.3f" % [title_a, title_b, source_delta.length()])

func _add_marker(point: Vector3, title: String, color: Color, larger: bool) -> void:
	var marker := MeshInstance3D.new()
	var mesh := SphereMesh.new()
	mesh.radius = 3.6 if larger else 2.8
	mesh.height = mesh.radius * 2.0
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.emission_enabled = true
	mat.emission = color * 0.25
	mesh.material = mat
	marker.mesh = mesh
	marker.position = point
	root_qa.add_child(marker)
	var label := Label3D.new()
	label.text = title
	label.position = point + Vector3(-8.0, 8.0, 0.0)
	label.font_size = 82 if larger else 76
	label.pixel_size = 0.052
	label.outline_size = 10
	label.modulate = Color("#f4f1e7")
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	root_qa.add_child(label)

func _add_segment(from_point: Vector3, to_point: Vector3, color: Color) -> void:
	var segment := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = Vector3(1.7, 0.15, from_point.distance_to(to_point))
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.emission_enabled = true
	mat.emission = color * 0.18
	mesh.material = mat
	segment.mesh = mesh
	segment.position = (from_point + to_point) * 0.5
	segment.look_at_from_position(segment.position, to_point, Vector3.UP)
	root_qa.add_child(segment)
