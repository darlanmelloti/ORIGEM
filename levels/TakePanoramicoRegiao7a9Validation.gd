extends Node3D
## CP-D2-006 — tomada panorâmica Dev2 Região 7→9.
## Autoridade: mapaorigem.webp / matriz de espelho. Apenas Regiões 7–12.
## A composição revela Vila Elevada, Observatório e Trilha como volumes CC0 já existentes.

const TERRAIN_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const HIGHLAND_SCRIPT: Script = preload("res://levels/HighlandRegion.gd")
const REGION7_VALIDATION_SCRIPT: Script = preload("res://levels/Region7ValidationScene.gd")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const TREE_CC0: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const CLIFF_SLOPE: PackedScene = preload("res://assets/models_cc0/cliff_blockSlope_rock.glb")
const BRIDGE_STONE: PackedScene = preload("res://assets/models_cc0/bridge_stone.glb")

var validation_camera: Camera3D
var elapsed: float = 0.0
var camera_start := Vector3(140.0, 24.0, 348.0)
var camera_end := Vector3(151.0, 25.0, 366.0)
var camera_target := Vector3(159.0, 18.0, 377.0)

func _ready() -> void:
	var region7 := REGION7_VALIDATION_SCRIPT.new() as Node3D
	region7.name = "Region7ApprovedCompositionCPD2006"
	add_child(region7)
	await get_tree().process_frame
	for environment_node in region7.find_children("*", "WorldEnvironment", true, false):
		var local_environment := (environment_node as WorldEnvironment).environment
		if local_environment != null:
			local_environment.fog_enabled = false
			local_environment.ambient_light_energy = 1.72
			local_environment.tonemap_exposure = 1.12
	for camera_node in region7.find_children("*", "Camera3D", true, false):
		(camera_node as Camera3D).current = false
	for label_node in region7.find_children("*", "Label3D", true, false):
		(label_node as Label3D).visible = false
	_build_observatory_extension()
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraTakePanoramicoRegiao7a9"
	validation_camera.fov = 50.0
	validation_camera.position = camera_start
	validation_camera.current = true
	add_child(validation_camera)
	validation_camera.look_at(camera_target, Vector3.UP)
	print("CPD2006_REGION7_COMPOSITION ", region7.name)
	print("CPD2006_CAMERA_HANDOFF_READY ", validation_camera.name)

func _build_observatory_extension() -> void:
	var observatory := Node3D.new()
	observatory.name = "Marco08_ObservatorioCPD2006"
	observatory.position = Vector3(158.0, 24.0, 377.0)
	add_child(observatory)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#8b8171")
	material.roughness = 0.9
	for index: int in range(8):
		var shell := ROCK_LARGE.instantiate() as Node3D
		if shell == null:
			continue
		var angle := float(index) * TAU / 8.0
		shell.name = "CascaObservatorioCPD2006_%02d" % index
		shell.position = Vector3(cos(angle) * 8.0, 1.8 + float(index % 2) * 0.5, sin(angle) * 7.0)
		shell.scale = Vector3(1.25, 0.6, 1.0)
		_apply_proxy_material(shell, material)
		observatory.add_child(shell)
	for index: int in range(4):
		var pillar := PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarObservatorioCPD2006_%02d" % index
		pillar.position = Vector3(-5.0 + float(index) * 3.3, 2.8, 0.0)
		pillar.scale = Vector3(0.6, 1.5, 0.6)
		_apply_proxy_material(pillar, material)
		observatory.add_child(pillar)
	var beacon := OmniLight3D.new()
	beacon.name = "LuzObservatorioCPD2006"
	beacon.position = Vector3(0.0, 9.0, 0.0)
	beacon.light_color = Color("#78c6d0")
	beacon.light_energy = 2.0
	beacon.omni_range = 16.0
	beacon.shadow_enabled = false
	observatory.add_child(beacon)

func _build_panorama_proxy() -> void:
	var proxy := Node3D.new()
	proxy.name = "CPD2006OrganicPanoramaProxy"
	proxy.scale = Vector3.ONE * 1.65
	add_child(proxy)
	var stone_material := StandardMaterial3D.new()
	stone_material.albedo_color = Color("#7e7666")
	stone_material.roughness = 0.94
	for ground_index: int in range(4):
		var ground := CLIFF_SLOPE.instantiate() as Node3D
		if ground == null:
			continue
		ground.name = "MassaSoloOrganicaCPD2006_%02d" % ground_index
		ground.position = Vector3(-1.0 + float(ground_index % 2) * 5.0, -1.48, -9.0 + float(ground_index) * 5.4)
		ground.scale = Vector3(7.0, 0.55, 4.8)
		_apply_proxy_material(ground, stone_material)
		proxy.add_child(ground)
	var mountain_back := ROCK_LARGE.instantiate() as Node3D
	if mountain_back != null:
		mountain_back.name = "ContraforteOrionDistanteCPD2006"
		mountain_back.position = Vector3(5.6, 6.0, -15.8)
		mountain_back.scale = Vector3(6.8, 4.8, 2.8)
		_apply_proxy_material(mountain_back, stone_material)
		proxy.add_child(mountain_back)
	var village := Node3D.new()
	village.name = "Marco07_VilaElevada_Panorama"
	village.position = Vector3(-6.8, -1.15, -3.2)
	proxy.add_child(village)
	for index: int in range(3):
		var terrace := ROCK_LARGE.instantiate() as Node3D
		if terrace == null:
			continue
		terrace.name = "TerracoVila07_%02d" % index
		terrace.position = Vector3(float(index) * 1.8, 0.8 + float(index) * 1.2, float(index) * -2.6)
		terrace.scale = Vector3(2.6, 0.42, 1.5)
		terrace.rotation = Vector3(0.02, 0.18 * float(index), -0.03)
		_apply_proxy_material(terrace, stone_material)
		village.add_child(terrace)
		var pillar := PILLAR.instantiate() as Node3D
		if pillar != null:
			pillar.name = "CasaOrganicaVila07_%02d" % index
			pillar.position = terrace.position + Vector3(0.0, 2.0, -0.4)
			pillar.scale = Vector3(0.5, 1.2, 0.5)
			_apply_proxy_material(pillar, stone_material)
			village.add_child(pillar)
	var bridge := BRIDGE_STONE.instantiate() as Node3D
	if bridge != null:
		bridge.name = "PassagemPedraEntre07e08"
		bridge.position = Vector3(-0.6, -0.8, -6.0)
		bridge.scale = Vector3(1.6, 0.8, 1.15)
		_apply_proxy_material(bridge, stone_material)
		proxy.add_child(bridge)
	var observatory := Node3D.new()
	observatory.name = "Marco08_Observatorio_Panorama"
	observatory.position = Vector3(7.6, -1.0, -11.8)
	proxy.add_child(observatory)
	for index: int in range(6):
		var angle := float(index) * TAU / 6.0
		var shell := ROCK_LARGE.instantiate() as Node3D
		if shell == null:
			continue
		shell.name = "CascaObservatorio08_%02d" % index
		shell.position = Vector3(cos(angle) * 3.6, 1.9 + float(index % 2) * 0.55, sin(angle) * 2.8)
		shell.scale = Vector3(0.9, 0.55, 0.7)
		_apply_proxy_material(shell, stone_material)
		observatory.add_child(shell)
	var trail := Node3D.new()
	trail.name = "Marco09_TrilhaDaMontanha_Panorama"
	trail.position.y = -1.15
	proxy.add_child(trail)
	for index: int in range(8):
		var route_stone := ROCK_LARGE.instantiate() as Node3D
		if route_stone == null:
			continue
		route_stone.name = "AfloramentoTrilha09_%02d" % index
		var t := float(index) / 7.0
		route_stone.position = Vector3(-1.0 + sin(t * PI * 1.25) * 4.4, 0.32 + t * 2.6, 1.6 - t * 11.8)
		route_stone.scale = Vector3(0.58, 0.22, 0.48)
		_apply_proxy_material(route_stone, stone_material)
		trail.add_child(route_stone)
	if TREE_CC0 != null:
		for index: int in range(4):
			var tree := TREE_CC0.instantiate() as Node3D
			if tree == null:
				continue
			tree.name = "MataLateralCPD2006_%02d" % index
			tree.position = Vector3(-12.0 + float(index) * 7.5, 0.0, 3.0 + float(index % 2) * 2.0)
			tree.scale = Vector3.ONE * (0.8 + float(index % 2) * 0.14)
			proxy.add_child(tree)
	for position_value: Vector3 in [Vector3(-6.5, 4.0, -1.0), Vector3(5.2, 4.0, -7.8), Vector3(1.0, 2.2, 2.8), Vector3(-3.5, 3.0, -1.0)]:
		var beacon := OmniLight3D.new()
		beacon.name = "LuzWayfindingCPD2006"
		beacon.position = position_value
		beacon.light_color = Color("#d9a86c") if position_value.x < 0.0 else Color("#78c6d0")
		beacon.light_energy = 1.2
		beacon.omni_range = 8.0
		beacon.shadow_enabled = false
		proxy.add_child(beacon)

func _apply_proxy_material(root: Node3D, material: StandardMaterial3D) -> void:
	for mesh_node in root.find_children("*", "MeshInstance3D", true, false):
		(mesh_node as MeshInstance3D).material_override = material

func _process(delta: float) -> void:
	if validation_camera == null:
		return
	elapsed += delta
	var progress := clampf(elapsed / 30.0, 0.0, 1.0)
	var eased := smoothstep(0.0, 1.0, progress)
	validation_camera.position = camera_start.lerp(camera_end, eased)
	validation_camera.look_at(camera_target, Vector3.UP)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	world.name = "CPD2006PanoramaEnvironment"
	var environment := Environment.new()
	environment.background_mode = Environment.BG_SKY
	var sky := Sky.new()
	var sky_material := ProceduralSkyMaterial.new()
	sky_material.sky_top_color = Color("#293f56")
	sky_material.sky_horizon_color = Color("#d49d70")
	sky_material.ground_bottom_color = Color("#111923")
	sky_material.ground_horizon_color = Color("#536b70")
	sky.sky_material = sky_material
	environment.sky = sky
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#9caeaa")
	environment.ambient_light_energy = 1.18
	environment.fog_enabled = false
	environment.fog_light_color = Color("#91a7a6")
	environment.fog_light_energy = 0.44
	environment.fog_density = 0.000015
	environment.fog_height = 24.0
	environment.fog_height_density = 0.012
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	world.environment = environment
	add_child(world)
	var key := DirectionalLight3D.new()
	key.name = "CPD2006WarmHorizonKey"
	key.light_color = Color("#f0c58f")
	key.light_energy = 2.15
	key.shadow_enabled = false
	key.rotation_degrees = Vector3(-35.0, -42.0, 0.0)
	add_child(key)
	var cool_fill := DirectionalLight3D.new()
	cool_fill.name = "CPD2006CoolMountainFill"
	cool_fill.light_color = Color("#8caec2")
	cool_fill.light_energy = 0.48
	cool_fill.shadow_enabled = false
	cool_fill.rotation_degrees = Vector3(-18.0, 128.0, 0.0)
	add_child(cool_fill)
