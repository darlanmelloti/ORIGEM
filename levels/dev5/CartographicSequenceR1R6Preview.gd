## Dev5 — CP-D5-062: auditoria executável do rumo cartográfico R1–R6.
extends Node3D

const ANCHORS := preload("res://levels/CartographicAnchors.gd")

var checks_passed := 0

func _ready() -> void:
	_build_environment()
	_build_anchor_markers()
	_run_sequence_checks()
	_build_camera()
	_build_overlay()
	assert(checks_passed == 8)
	print("[DEV5_SEQUENCE_R1R6] status=approved checks=%d no_anchor_skip=true majestic_lateral=true ruins_arrival=true" % checks_passed)
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_environment() -> void:
	var environment_node := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.11, 0.19, 0.25)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.46, 0.56, 0.56)
	environment.ambient_light_energy = 0.84
	environment_node.environment = environment
	add_child(environment_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-55.0, 28.0, 0.0)
	sun.light_energy = 1.03
	add_child(sun)
	var ground := MeshInstance3D.new()
	var ground_mesh := PlaneMesh.new()
	ground_mesh.size = Vector2(250.0, 320.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.12, 0.22, 0.14)
	material.roughness = 1.0
	ground_mesh.material = material
	ground.mesh = ground_mesh
	ground.position = Vector3(-15.0, 0.0, 130.0)
	add_child(ground)

func _build_anchor_markers() -> void:
	var anchors: Array[Vector2] = [
		ANCHORS.CASA_VOSS, ANCHORS.ESTRADA_RIO_INICIO, ANCHORS.ARCO_RUINAS,
		ANCHORS.FLORESTA_DENSA_ENTRADA, ANCHORS.ACAMPAMENTO_MAJESTIC, ANCHORS.RUINAS_SUBMERSAS
	]
	for index: int in range(anchors.size()):
		var marker := MeshInstance3D.new()
		marker.name = "MarcoR%d" % (index + 1)
		var mesh := CylinderMesh.new()
		mesh.top_radius = 0.56
		mesh.bottom_radius = 0.78
		mesh.height = 5.0 + float(index) * 0.25
		mesh.radial_segments = 8
		var material := StandardMaterial3D.new()
		material.albedo_color = Color(0.30 + float(index) * 0.05, 0.34, 0.22 + float(index) * 0.04)
		material.roughness = 0.85
		mesh.material = material
		marker.mesh = mesh
		marker.position = Vector3(anchors[index].x, mesh.height * 0.5, anchors[index].y)
		add_child(marker)

func _run_sequence_checks() -> void:
	var tests: Array[Dictionary] = [
		{"id":"r1_voss", "world":Vector2(-22.0, 8.0), "expected":2},
		{"id":"r2_road_exit", "world":Vector2(-21.4, 25.0), "expected":3},
		{"id":"r3_arch", "world":Vector2(-16.741, 70.0), "expected":4},
		{"id":"r4_forest", "world":Vector2(-9.0, 140.0), "expected":5},
		{"id":"r5_east_approach", "world":Vector2(0.0, 178.0), "expected":5},
		{"id":"r5_majestic_west", "world":Vector2(-88.0, 178.0), "expected":6},
		{"id":"r6_approach", "world":Vector2(60.0, 230.0), "expected":6},
		{"id":"r6_arrival", "world":Vector2(60.0, 252.0), "expected":7}
	]
	for test: Dictionary in tests:
		var world := test["world"] as Vector2
		var result := ANCHORS.next_dev1_destination(world)
		var expected := test["expected"] as int
		assert((result["anchor_id"] as int) == expected)
		checks_passed += 1
		print("[DEV5_SEQUENCE_R1R6] id=%s xz=(%.3f,%.3f) next=%d label=%s" % [test["id"], world.x, world.y, result["anchor_id"], result["label"]])

func _build_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "CameraQASequenceR1R6"
	camera.position = Vector3(-15.0, 160.0, 265.0)
	camera.fov = 58.0
	add_child(camera)
	camera.look_at(Vector3(-15.0, 0.0, 130.0), Vector3.UP)
	camera.make_current()

func _build_overlay() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.position = Vector2(52.0, 46.0)
	label.size = Vector2(1120.0, 92.0)
	label.text = "CP-D5-062  |  SEQUÊNCIA CARTOGRÁFICA R1→R6\nR1→R2→R3→R4→MAJESTIC→RUÍNAS · 8 TESTES · SEM SALTOS DE MARCO"
	label.add_theme_font_size_override("font_size", 18)
	label.modulate = Color(0.90, 0.95, 0.96)
	layer.add_child(label)

func _save_snapshot(path: String) -> void:
	for frame: int in range(40):
		await get_tree().process_frame
	var viewport_texture := get_viewport().get_texture()
	if viewport_texture == null:
		print("[DEV5_SEQUENCE_R1R6] snapshot_unavailable=headless_renderer path=%s" % path)
		return
	var image := viewport_texture.get_image()
	if image == null:
		print("[DEV5_SEQUENCE_R1R6] snapshot_unavailable=headless_image path=%s" % path)
		return
	var result := image.save_png(path)
	print("[DEV5_SEQUENCE_R1R6] snapshot=%s result=%s" % [path, result])
