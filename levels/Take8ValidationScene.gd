## Take8ValidationScene.gd
## Direcção visual: Arqueologia Alpina Cinematográfica — câmara diagonal, rocha orgânica, névoa baixa e rota ascendente.
## Harness dedicado do Take 8; não substitui o mapa jogável nem toca nas Regiões 1–6.

extends Node3D

const TERRAIN_PATCH_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const HIGHLAND_REGION_SCRIPT: Script = preload("res://levels/HighlandRegion.gd")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const ROUTE_ANCHOR: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const HOUSE_ROOF: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const ROUTE_STONE: PackedScene = preload("res://assets/models_cc0/stone_smallF.glb")
const BRIDGE_ARCH: PackedScene = preload("res://assets/models_cc0/bridge_stone.glb")

var validation_camera: Camera3D
var elapsed: float = 0.0
var region9_gate_light: OmniLight3D
var route_start := Vector3(169.0, 31.2, 398.0)
var route_end := Vector3(148.0, 32.4, 438.0)
# CP108: corredor de entrada R7 em baixa perspectiva, com R9 elevado no eixo de fuga.
# CP109: recuo de segurança para impedir que o tecto da entrada ocupe o topo do frame.
# CP110: plano de entrada mais próximo, com soleira R7 dominante e horizonte R9 preservado.
# CP112: enquadramento compacto da soleira, sem overhead, com fuga R9 ainda visível.
# CP126: recuo moderado para manter a soleira R7 visível e retirar o tecto do primeiro plano.
# CP129: desvio lateral mínimo; a fachada mantém massa dominante e o corredor R9 entra no centro-direita.
var r9_camera_position := Vector3(142.2, 16.8, 342.0)

func _ready() -> void:
	_build_environment()
	var terrain := TERRAIN_PATCH_SCRIPT.new() as Node3D
	terrain.name = "TerrainPatch"
	add_child(terrain)
	var highlands := HIGHLAND_REGION_SCRIPT.new() as Node3D
	highlands.name = "Take8HighlandRegion"
	add_child(highlands)
	_prepare_real_trail_reveal(highlands, terrain)
	# CP090: as composições proxy anteriores duplicavam a Vila real e criavam leitura de marcadores/flutuação.
	# Permanecem disponíveis apenas para diagnóstico explícito, nunca no runtime normal da validação.
	if OS.get_environment("QA_SHOWCASE_PROXY") == "1":
		_build_cinematic_village_reveal()
		_build_cp079_organic_facade()
	_hide_non_diagnostic_labels(highlands)
	var start_ground: float = float(terrain.call("height_at", route_start.x, route_start.z))
	var end_ground: float = float(terrain.call("height_at", route_end.x, route_end.z))
	route_start.y = start_ground + 2.1
	route_end.y = end_ground + 2.1
	# CP088: o limiar R9 é uma âncora remota e não pode elevar a câmara da composição R7.
	# Grounding local é a autoridade desta vista de handoff; mantém perspectiva baixa e evita overhead.
	r9_camera_position.y = float(terrain.call("height_at", r9_camera_position.x, r9_camera_position.z)) + 1.9
	validation_camera = Camera3D.new()
	validation_camera.name = "Take8RouteCamera"
	validation_camera.current = true
	validation_camera.fov = 50.0
	validation_camera.position = route_start
	add_child(validation_camera)
	validation_camera.look_at(Vector3(169.0, route_start.y - 0.7, 414.0), Vector3.UP)

func _hide_non_diagnostic_labels(highlands: Node3D) -> void:
	for label in highlands.find_children("*", "Label3D", true, false):
		(label as Label3D).visible = false
	# CP094: assets de ecologia/placeholders permanecem no mundo, mas não contaminam o frame de auditoria arquitectónica.
	for node in highlands.find_children("*", "Node3D", true, false):
		var node_name := str(node.name)
		if node_name.begins_with("ArvoreVila_") or node_name.begins_with("FetoVila_") or node_name.begins_with("NPCVila_"):
			node.visible = false

func _build_cinematic_village_reveal() -> void:
	var reveal := Node3D.new()
	reveal.name = "CP090OrganicVillageReveal"
	reveal.position = Vector3(140.0, 14.25, 357.0)
	add_child(reveal)
	var house_positions: Array[Vector3] = [Vector3(-3.8, 0.0, 1.0), Vector3(3.8, 0.8, 4.5), Vector3(0.0, 1.8, 8.0)]
	for index: int in range(house_positions.size()):
		var base := ROCK_LARGE.instantiate() as Node3D
		if base != null:
			base.name = "CP090CasaBase_%02d" % index
			base.position = house_positions[index]
			base.scale = Vector3(3.5, 0.85, 2.6)
			reveal.add_child(base)
			_apply_cp090_material(base)
		for pillar_index: int in range(3):
			var pillar := PILLAR.instantiate() as Node3D
			if pillar != null:
				pillar.name = "CP090CasaPilar_%02d_%02d" % [index, pillar_index]
				pillar.position = house_positions[index] + Vector3(-1.4 + float(pillar_index) * 1.4, 1.65, 0.0)
				pillar.scale = Vector3(0.65, 2.2, 0.65)
				reveal.add_child(pillar)
				_apply_cp090_material(pillar)
		var roof := HOUSE_ROOF.instantiate() as Node3D
		if roof != null:
			roof.name = "CP090CasaCobertura_%02d" % index
			roof.position = house_positions[index] + Vector3(0.0, 2.42, 0.0)
			roof.scale = Vector3(3.1, 0.55, 2.35)
			reveal.add_child(roof)
			_apply_cp090_material(roof)
		var hearth := OmniLight3D.new()
		hearth.name = "CP090CasaLuz_%02d" % index
		hearth.position = house_positions[index] + Vector3(0.0, 2.1, 0.4)
		hearth.light_color = Color("#d9a95f")
		hearth.light_energy = 1.45
		hearth.omni_range = 8.0
		hearth.shadow_enabled = false
		add_child(hearth)
	var route_positions: Array[Vector3] = [Vector3(-4.5, 1.2, 1.0), Vector3(-2.0, 1.6, 2.8), Vector3(0.5, 2.0, 4.6), Vector3(2.5, 2.4, 6.4)]
	for route_index: int in range(route_positions.size()):
		var route_light := OmniLight3D.new()
		route_light.name = "CP090FachoRota_%02d" % route_index
		route_light.position = Vector3(140.0, 14.8, 357.0) + route_positions[route_index]
		route_light.light_color = Color("#f1c77a")
		route_light.light_energy = 0.8
		route_light.omni_range = 4.5
		route_light.shadow_enabled = false
		add_child(route_light)
		var route_stone := ROUTE_STONE.instantiate() as Node3D
		if route_stone != null:
			route_stone.name = "CP090MarcoRota_%02d" % route_index
			route_stone.position = Vector3(140.0, 14.8, 357.0) + route_positions[route_index]
			route_stone.scale = Vector3.ONE * 0.58
			reveal.add_child(route_stone)

func _build_cp079_organic_facade() -> void:
	# CP079: fachada QA-only com massa contínua; apenas assets CC0, sem blocos primitivos.
	var facade := Node3D.new()
	facade.name = "CP079FachadaOrganicaR7"
	facade.position = Vector3(140.0, 14.25, 357.0)
	add_child(facade)
	var wall_left := PILLAR.instantiate() as Node3D
	if wall_left != null:
		wall_left.name = "CP079ParedeNorte"
		wall_left.position = Vector3(-4.6, 3.4, 0.2)
		wall_left.scale = Vector3(1.65, 3.3, 1.2)
		facade.add_child(wall_left)
		_apply_cp090_material(wall_left)
	var wall_right := PILLAR.instantiate() as Node3D
	if wall_right != null:
		wall_right.name = "CP079ParedeSul"
		wall_right.position = Vector3(4.6, 3.4, 0.2)
		wall_right.scale = Vector3(1.65, 3.3, 1.2)
		facade.add_child(wall_right)
		_apply_cp090_material(wall_right)
	var lintel := ROCK_LARGE.instantiate() as Node3D
	if lintel != null:
		lintel.name = "CP079Frontao"
		lintel.position = Vector3(0.0, 6.6, 0.0)
		lintel.scale = Vector3(4.9, 1.15, 1.55)
		facade.add_child(lintel)
		_apply_cp090_material(lintel)
	var bridge := BRIDGE_ARCH.instantiate() as Node3D
	if bridge != null:
		bridge.name = "CP080ArcoEntradaVilaR7"
		bridge.position = Vector3(0.0, 2.8, -1.2)
		bridge.scale = Vector3(2.3, 2.3, 2.3)
		facade.add_child(bridge)
		_apply_cp090_material(bridge)
	var threshold := ROUTE_STONE.instantiate() as Node3D
	if threshold != null:
		threshold.name = "CP079SoleiraAterrada"
		threshold.position = Vector3(0.0, 0.28, 2.15)
		threshold.scale = Vector3(2.8, 0.45, 1.8)
		facade.add_child(threshold)
		_apply_cp090_material(threshold)

func _apply_cp090_material(node: Node3D) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#b2a083")
	material.roughness = 0.92
	material.metallic = 0.0
	material.emission_enabled = true
	material.emission = Color("#6b4f32")
	material.emission_energy_multiplier = 0.34
	for mesh in node.find_children("*", "MeshInstance3D", true, false):
		(mesh as MeshInstance3D).material_override = material

func _process(delta: float) -> void:
	if validation_camera == null:
		return
	elapsed += delta
	var trail_progress: float = smoothstep(0.0, 1.0, clampf(elapsed / 30.0, 0.0, 1.0))
	if elapsed <= 20.0:
		validation_camera.position = route_start.lerp(route_end, smoothstep(0.0, 1.0, clampf(elapsed / 20.0, 0.0, 1.0)))
		var trail_target := Vector3(169.0, lerpf(route_start.y, route_end.y, trail_progress) - 0.65, 414.0).lerp(Vector3(148.0, lerpf(route_start.y, route_end.y, trail_progress) - 0.55, 438.0), trail_progress)
		validation_camera.look_at(trail_target, Vector3.UP)
	else:
		validation_camera.fov = 52.0
		validation_camera.position = r9_camera_position
		validation_camera.look_at(Vector3(151.0, 16.2, 382.0), Vector3.UP)
		var r9_terrain := get_node_or_null("TerrainPatch") as Node3D
		if r9_terrain != null:
			r9_terrain.visible = true
		# CP092: manter apenas a rota física R9; decoradores com origins incompatíveis ficam fora do frame QA.
		var r9_route := get_node_or_null("Take8HighlandRegion/TrilhaDaMontanhaOrion") as Node3D
		if r9_route != null:
			r9_route.visible = true
		var r9_outcrops := get_node_or_null("Take8HighlandRegion/AfloramentosDaTrilha") as Node3D
		if r9_outcrops != null:
			r9_outcrops.visible = false
		for r9_decor_name in ["MarcoOrganicoEntradaTrilhaTake8", "ArcoOrganicoEntradaTake8_0", "ArcoOrganicoEntradaTake8_1", "ArcoOrganicoEntradaTake8_2", "Take8AncoraVerticalOrganica", "LimiarOrganicoRegiao09"]:
			var r9_decor := get_node_or_null("Take8HighlandRegion/" + r9_decor_name) as Node3D
			if r9_decor != null:
				r9_decor.visible = false
	if region9_gate_light != null:
		region9_gate_light.light_energy = 0.56 + sin(elapsed * 1.7) * 0.10


func _prepare_real_trail_reveal(highlands: Node3D, terrain: Node3D) -> void:
	var real_route := highlands.get_node_or_null("TrilhaDaMontanhaOrion") as Node3D
	if real_route != null:
		real_route.visible = true
		_enhance_real_trail_material(real_route)
	for node_name in [		"MarcoOrganicoEntradaTrilhaTake8", "ArcoOrganicoEntradaTake8_0", "ArcoOrganicoEntradaTake8_1", "ArcoOrganicoEntradaTake8_2", "AfloramentosDaTrilha", "LimiarOrganicoRegiao09"]:
		var landmark := highlands.get_node_or_null(node_name) as Node3D
		if landmark != null:
			landmark.visible = false if node_name != "TrilhaDaMontanhaOrion" else true
			if node_name == "LimiarOrganicoRegiao09":
				print("ORIGEM_REGION9_THRESHOLD_GLOBAL ", landmark.global_position)
				for jamb_name in ["OmbreiraRegiao09_Norte", "OmbreiraRegiao09_Sul"]:
					var jamb_debug := landmark.get_node_or_null(jamb_name) as Node3D
					if jamb_debug != null:
						print("ORIGEM_REGION9_JAMB_GLOBAL ", jamb_name, " ", jamb_debug.global_position)
			var beacon := landmark.get_node_or_null("BeaconContinuidadeRegiao09") as OmniLight3D
			if beacon != null:
				beacon.light_energy = 0.9
	var proxy := get_node_or_null("Take8WayfindingProxy") as Node3D
	if proxy != null:
		proxy.visible = false

func _enhance_real_trail_material(route: Node3D) -> void:
	var path_material := StandardMaterial3D.new()
	path_material.albedo_color = Color("#566454")
	path_material.roughness = 0.94
	path_material.emission_enabled = true
	path_material.emission = Color("#284c43")
	path_material.emission_energy_multiplier = 0.65
	for mesh in route.find_children("*", "MeshInstance3D", true, false):
		(mesh as MeshInstance3D).material_override = path_material

func _build_validation_wayfinding() -> void:
	var points: Array[Vector3] = [Vector3(188.0, 31.25, 407.0), Vector3(185.5, 31.38, 410.0), Vector3(183.0, 31.52, 413.5), Vector3(180.5, 31.66, 417.0)]
	for index: int in range(points.size()):
		var rock: Node3D = ROCK_LARGE.instantiate() as Node3D
		if rock == null:
			continue
		rock.name = "Take8WayfindingRock_%02d" % index
		var ground_y: float = points[index].y
		rock.position = Vector3(points[index].x, ground_y, points[index].z)
		rock.scale = Vector3(0.78 - float(index) * 0.05, 0.59 - float(index) * 0.035, 0.70 - float(index) * 0.04)
		rock.rotation = Vector3(0.03, -0.18 + float(index) * 0.32, -0.04)
		add_child(rock)
		var route_light := OmniLight3D.new()
		route_light.name = "Take8FachoRota_%02d" % index
		route_light.position = rock.position + Vector3(0.0, 1.4, 0.0)
		route_light.light_color = Color("#d9b26f") if index < 3 else Color("#78b9c6")
		route_light.light_energy = 0.86 if index == 0 else 0.62
		route_light.omni_range = 8.0
		route_light.shadow_enabled = false
		add_child(route_light)
	var anchor := ROUTE_ANCHOR.instantiate() as Node3D
	if anchor != null:
		anchor.name = "Take8AncoraVerticalOrganica"
		anchor.position = Vector3(181.0, 33.55, 421.2)
		anchor.scale = Vector3(0.68, 0.82, 0.62)
		anchor.rotation = Vector3(0.08, 0.42, -0.05)
		add_child(anchor)
	region9_gate_light = OmniLight3D.new()
	region9_gate_light.name = "Take8TransicaoRegiao9"
	region9_gate_light.position = route_end + Vector3(0.0, 1.8, 0.0)
	region9_gate_light.light_color = Color("#72c3cf")
	region9_gate_light.light_energy = 0.68
	region9_gate_light.omni_range = 7.5
	region9_gate_light.shadow_enabled = false
	add_child(region9_gate_light)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	world.name = "Take8WorldEnvironment"
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#839caf")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#8baab4")
	environment.ambient_light_energy = 1.32
	environment.fog_enabled = true
	environment.fog_light_color = Color("#91aeb8")
	environment.fog_light_energy = 0.48
	environment.fog_density = 0.00024
	environment.fog_height = 18.0
	environment.fog_height_density = 0.012
	environment.volumetric_fog_enabled = false
	world.environment = environment
	add_child(world)
	var sun := DirectionalLight3D.new()
	sun.name = "Take8AlpineKey"
	sun.light_color = Color("#d7e5e2")
	sun.light_energy = 1.42
	sun.shadow_enabled = false
	sun.rotation_degrees = Vector3(-50.0, -28.0, 0.0)
	add_child(sun)
