class_name DenseForestPortalPreview
extends Node3D

## CP-D5-011: cena QA autónoma do marco 4; não toca ForestLakeRegion.gd.
const MAP_ANCHOR := Vector2(-9.0, 116.0)
const CENTRAL_PASSAGE_WIDTH := 2.4

func _ready() -> void:
	name = "DenseForestPortalPreview"
	_build_environment()
	var landmarks := CartographicLandmarkObjects.new()
	add_child(landmarks)
	var portal := landmarks.create_dense_forest_portal_landmark()
	portal.name = "PortalFlorestalMarco4QA"
	add_child(portal)
	print("[DEV5_FOREST_QA] anchor=%s passage_width=%.1f isolated=true region_script=false" % [MAP_ANCHOR, CENTRAL_PASSAGE_WIDTH])

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.27, 0.39, 0.31)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.54, 0.64, 0.52)
	environment.ambient_light_energy = 0.76
	world.environment = environment
	add_child(world)

	var sun := DirectionalLight3D.new()
	sun.name = "LuzQAForesta"
	sun.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	sun.light_energy = 1.08
	sun.shadow_enabled = true
	add_child(sun)

	var camera := Camera3D.new()
	camera.name = "CameraQAFlorestaMarco4"
	camera.position = Vector3(7.6, 4.8, 8.8)
	camera.fov = 55.0
	camera.look_at_from_position(camera.position, Vector3(0.0, 1.0, 0.0))
	camera.current = true
	add_child(camera)
