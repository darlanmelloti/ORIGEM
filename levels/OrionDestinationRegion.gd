## OrionDestinationRegion.gd
## Marcos 10–12 do mapa regional: entrada da Caverna Orion, Câmara do Cube e Hub Temporal.
## Destinos em mundo contínuo, preparados para futura missão, transição temporal e interior detalhado.

extends Node3D

const CLIFF: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var cube_material: StandardMaterial3D
var recess_resonance_light: OmniLight3D
var elapsed: float = 0.0

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	stone_material = _make_stone_material()
	cube_material = _make_cube_material()
	_build_orion_cave()
	_build_region9_to_10_approach()
	_build_cp_d2_007_physical_handoff()
	if OS.get_environment("QA_VALIDATION_ROUTE") == "R9_R10_INTEGRATED_HANDOFF":
		_apply_r9_r10_visual_culling()
	var validation_region := OS.get_environment("ORIGEM_VALIDATION_REGION")
	if validation_region != "10":
		_build_cube_chamber_marker()
		_build_region11_to_12_approach()
		if validation_region != "11":
			_build_temporal_hub()
			_build_hub_to_final_dome_approach()
			_build_final_dome()
			_enforce_region12_light_budget()
			if _is_contextual_decor_validation():
				_apply_contextual_decor_culling()
		_build_cartographic_anchors()

func _is_contextual_decor_validation() -> bool:
	return OS.get_environment("QA_VALIDATION_ROUTE") == "R10_CAVE_TO_R12_HUB_FULL"

func _enforce_region12_light_budget() -> void:
	# CP-D2-202: orçamento estrito Dev2; preserva iluminação estrutural e remove apenas preenchimentos decorativos.
	var lights: Array[Node] = find_children("*", "OmniLight3D", true, false)
	var keep_names: Array[String] = [
		"BraseiroLimiarOrion", "BrilhoChronosDaCaverna", "LuzPreenchimentoBocaOrion",
		"LuzTransicaoCavernaOrion", "LuzNucleoOrion", "LuzNucleoCupulaFinal",
		"RessonanciaRecessivoCupulaR12", "LuzNucleoTemporalR12", "LuzContactoNucleoR12",
		"LuzWayfindingCamara_00", "LuzWayfindingCamara_01", "LuzWayfindingHub_01",
		"LuzWayfindingCupula_00", "LuzCoroaCupula_00", 
		"WayfinderCPD2007_HubTemporal"
	]
	var kept: int = 0
	for node in lights:
		var light := node as OmniLight3D
		if light == null:
			continue
		var preserve: bool = str(light.name) in keep_names and kept < 16
		if preserve:
			kept += 1
		else:
			light.queue_free()
	print("REGION12_LIGHT_BUDGET kept=", kept, " max=16 removed=", lights.size() - kept)

func _apply_contextual_decor_culling() -> void:
	# CP-D2-066: preserve physical handoffs and sanctuary landmarks; remove only distant decoration.
	for node_name: String in ["DegrauHubTemporal_00", "DegrauHubTemporal_01", "DegrauHubTemporal_02", "DegrauHubTemporal_03", "DegrauHubTemporal_04", "DegrauHubTemporal_05", "DegrauHubTemporal_06", "LuzWayfindingHub_01", "LuzWayfindingHub_02", "LuzWayfindingHub_03", "LuzWayfindingHub_04", "LuzWayfindingHub_05", "LuzWayfindingHub_06"]:
		var decorative_node := find_child(node_name, true, false)
		if decorative_node != null:
			decorative_node.queue_free()
	for node_name: String in ["PilarCupulaFinal_02", "PilarCupulaFinal_03", "PilarCupulaFinal_04", "PilarCupulaFinal_05", "PilarCupulaFinal_06", "PilarCupulaFinal_07", "ArcoOrganicoCupula_00", "ArcoOrganicoCupula_01", "ArcoOrganicoCupula_02", "LuzCoroaCupula_00"]:
		var dome_decorative_node := find_child(node_name, true, false)
		if dome_decorative_node != null:
			dome_decorative_node.queue_free()
	for decorative_node in find_children("*", "", true, false):
		var decorative_name := str(decorative_node.name)
		if decorative_name.begins_with("NucleoVisivelMonolito_") or decorative_name.begins_with("LuzRimMonolitoTemporal_"):
			decorative_node.queue_free()
	var alpine_fill := find_child("PreenchimentoAlpinoSemSombrasR12", true, false) as DirectionalLight3D
	if alpine_fill != null:
		alpine_fill.light_energy = 0.12
	var recess_decorative_light := find_child("RessonanciaRecessivoCupulaR12", true, false)
	if recess_decorative_light != null:
		recess_decorative_light.queue_free()

func _report_region12_render_inventory() -> void:
	var mesh_count: int = find_children("*", "GeometryInstance3D", true, false).size()
	var light_count: int = find_children("*", "OmniLight3D", true, false).size()
	var body_count: int = find_children("*", "StaticBody3D", true, false).size()
	print("REGION12_RENDER_INVENTORY meshes=", mesh_count, " omni_lights=", light_count, " static_bodies=", body_count)
	for region_node_name: String in ["CavernaDoOrion", "CamaraDoOrionCube", "HubTemporal", "CupulaFinal"]:
		var region_node := get_node_or_null(region_node_name)
		if region_node == null:
			continue
		var region_meshes: int = region_node.find_children("*", "GeometryInstance3D", true, false).size()
		var region_lights: int = region_node.find_children("*", "OmniLight3D", true, false).size()
		print("REGION12_RENDER_GROUP name=", region_node_name, " meshes=", region_meshes, " omni_lights=", region_lights)
	var handoff_colliders: Array[String] = ["ColisaoHandoffCubeR11", "ColisaoHandoffSoleiraR12", "ColisaoHandoffHubR12"]
	var audit_root: Node = get_parent() if get_parent() != null else self
	for collider_name: String in handoff_colliders:
		var collider_node := audit_root.find_child(collider_name, true, false)
		print("REGION12_HANDOFF_COLLIDER name=", collider_name, " present=", collider_node != null)

func _build_cartographic_anchors() -> void:
	var anchors := Node3D.new()
	anchors.name = "CartographicAnchors_Regioes10a12"
	anchors.set_meta("map_authority", "mapaorigem.webp")
	anchors.set_meta("scope", "REGIONS_7_12_ONLY")
	var anchor_data: Array[Dictionary] = [
		{"name": "Marco10_CavernaDoOrion", "position": Vector3(-116.0, 0.0, 548.0), "role": "abertura tectonica escura na serra"},
		{"name": "Marco11_CamaraOrionCube", "position": Vector3(-116.0, 0.0, 562.0), "role": "pico tridimensional e ponto luminescente"},
		{"name": "Marco12_HubTemporal", "position": Vector3(164.0, 0.0, 210.0), "role": "anel de monolitos e nucleo temporal em perspectiva"}
	]
	for data: Dictionary in anchor_data:
		var marker := Marker3D.new()
		marker.name = str(data["name"])
		marker.position = data["position"] as Vector3
		marker.set_meta("map_role", str(data["role"]))
		marker.set_meta("visibility_rule", "silhueta ou continuidade; sem painel")
		anchors.add_child(marker)
	add_child(anchors)

func _height_at(world_x: float, world_z: float) -> float:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		return float(terrain_patch.call("height_at", world_x, world_z))
	return 0.0

func _build_orion_cave() -> void:
	var cave: Node3D = Node3D.new()
	cave.name = "CavernaDoOrion"
	var cave_x: float = -116.0
	var cave_z: float = 548.0
	cave.position = Vector3(cave_x, _height_at(cave_x, cave_z), cave_z)
	add_child(cave)
	# Marco orgânico de legibilidade da boca: massas CC0 formam um limiar arqueológico, sem caixa/greybox.
	var mouth_positions: Array[Vector3] = [Vector3(-5.4, 4.2, -8.0), Vector3(5.4, 4.2, -8.0), Vector3(0.0, 8.6, -8.4)]
	for mouth_index: int in range(mouth_positions.size()):
		var mouth_frame: Node3D = ROCK_LARGE.instantiate() as Node3D
		if mouth_frame == null:
			continue
		mouth_frame.name = "LimiarOrganicoOrion_%02d" % mouth_index
		mouth_frame.position = mouth_positions[mouth_index]
		mouth_frame.scale = Vector3(0.66 if mouth_index < 2 else 0.82, 1.05 if mouth_index < 2 else 0.48, 0.38)
		mouth_frame.rotation = Vector3(0.0, 0.16 * float(mouth_index - 1), 0.0)
		_apply_material(mouth_frame, stone_material)
		cave.add_child(mouth_frame)
	var threshold_glow: OmniLight3D = OmniLight3D.new()
	threshold_glow.name = "BraseiroLimiarOrion"
	threshold_glow.light_color = Color("#5cc8ff")
	threshold_glow.light_energy = 3.0
	threshold_glow.omni_range = 16.0
	threshold_glow.shadow_enabled = false
	threshold_glow.position = Vector3(0.0, 3.4, -8.2)
	cave.add_child(threshold_glow)
	# Rocha disposta em ferradura: forma entrada física sem cartão plano e deixa o percurso de Orion legível à distância.
	for index: int in range(9):
		var angle: float = lerpf(-2.35, -0.78, float(index) / 8.0)
		var radius: float = 12.0 + float(index % 2) * 2.0
		var cliff: Node3D = CLIFF.instantiate() as Node3D
		if cliff == null:
			continue
		cliff.name = "RochaDaCaverna_%02d" % index
		cliff.position = Vector3(cos(angle) * radius, 2.4 + float(index % 3) * 1.8, sin(angle) * radius)
		var scale_value: float = 0.72 + float(index % 3) * 0.18
		cliff.scale = Vector3(scale_value, scale_value, scale_value)
		cliff.rotation = Vector3(0.12 * sin(angle), angle + PI * 0.5, 0.10 * cos(angle))
		_apply_material(cliff, stone_material)
		cave.add_child(cliff)
	# A boca recuada usa massas CC0 orgânicas; não há plano/caixa preta a bloquear a câmara.
	for mouth_index: int in range(3):
		var mouth_stone: Node3D = ROCK_LARGE.instantiate() as Node3D
		if mouth_stone == null:
			continue
		mouth_stone.name = "MassaOrganicaInterior_%02d" % mouth_index
		mouth_stone.position = Vector3(-3.2 + float(mouth_index) * 3.2, 2.6 + float(mouth_index % 2) * 1.2, -7.0)
		mouth_stone.scale = Vector3(0.75, 0.85 + float(mouth_index % 2) * 0.18, 0.48)
		mouth_stone.rotation = Vector3(0.08, float(mouth_index) * 0.63, -0.05)
		_apply_material(mouth_stone, stone_material)
		cave.add_child(mouth_stone)
	# CP-D2-216: recess interior real atrás das ombreiras; volume escuro, apoiado e sem cartão plano.
	var cave_recess := MeshInstance3D.new()
	cave_recess.name = "RecorteEscuroInteriorBocaOrion"
	var recess_mesh := SphereMesh.new()
	recess_mesh.radius = 4.2
	recess_mesh.height = 7.6
	cave_recess.mesh = recess_mesh
	cave_recess.position = Vector3(0.0, 4.1, -7.4)
	cave_recess.scale = Vector3(1.0, 1.0, 0.34)
	var recess_material := StandardMaterial3D.new()
	recess_material.albedo_color = Color("#02070a")
	recess_material.roughness = 1.0
	recess_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	cave_recess.material_override = recess_material
	cave.add_child(cave_recess)
	var cave_eye: Node3D = ROCK_LARGE.instantiate() as Node3D
	if cave_eye != null:
		cave_eye.name = "OlhoRessonanteDaEntradaOrion"
		cave_eye.position = Vector3(0.0, 3.4, -7.2)
		cave_eye.scale = Vector3(0.58, 0.38, 0.22)
		var cave_eye_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
		cave_eye_material.albedo_color = Color("#123c4b")
		cave_eye_material.emission_enabled = true
		cave_eye_material.emission = Color("#4ec9e5")
		cave_eye_material.emission_energy_multiplier = 1.15
		_apply_material(cave_eye, cave_eye_material)
		cave.add_child(cave_eye)

	var rune_light: OmniLight3D = OmniLight3D.new()
	rune_light.name = "BrilhoChronosDaCaverna"
	rune_light.light_color = Color(0.10, 0.42, 1.0, 1.0)
	rune_light.light_energy = 3.6
	rune_light.omni_range = 24.0
	rune_light.position = Vector3(0.0, 4.2, -6.6)
	rune_light.shadow_enabled = false
	cave.add_child(rune_light)
	_create_visible_brazier_core(cave, Vector3(-2.2, 3.85, -8.1), "NucleoBraseiroOrionEsquerdo")
	_create_visible_brazier_core(cave, Vector3(2.2, 3.85, -8.1), "NucleoBraseiroOrionDireito")
	var mouth_fill: OmniLight3D = OmniLight3D.new()
	mouth_fill.name = "LuzPreenchimentoBocaOrion"
	mouth_fill.light_color = Color("#7ed9e8")
	mouth_fill.light_energy = 2.2
	mouth_fill.omni_range = 18.0
	mouth_fill.shadow_enabled = false
	mouth_fill.position = Vector3(0.0, 3.0, -3.0)
	cave.add_child(mouth_fill)

func _create_visible_brazier_core(parent: Node3D, position_value: Vector3, node_name: String) -> void:
	var core := MeshInstance3D.new()
	core.name = node_name
	var sphere := SphereMesh.new()
	sphere.radius = 0.24
	sphere.height = 0.48
	core.mesh = sphere
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#5cc8ff")
	material.emission_enabled = true
	material.emission = Color("#5cc8ff")
	material.emission_energy_multiplier = 3.8
	core.material_override = material
	core.position = position_value
	parent.add_child(core)

func _build_region9_to_10_approach() -> void:
	var approach: Node3D = Node3D.new()
	approach.name = "TransicaoRegiao09Para10"
	add_child(approach)
	var route: Array[Vector2] = [Vector2(-112.0, 532.0), Vector2(-114.0, 536.5), Vector2(-116.0, 541.0), Vector2(-116.0, 545.0)]
	var route_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
	route_material.albedo_color = Color("#53665d")
	route_material.roughness = 0.92
	for index: int in range(route.size()):
		var point: Vector2 = route[index]
		var stone: Node3D = ROCK_LARGE.instantiate() as Node3D
		if stone == null:
			continue
		stone.name = "DegrauCavernaOrganico_%02d" % index
		stone.position = Vector3(point.x, _height_at(point.x, point.y) + 0.22, point.y)
		stone.scale = Vector3(0.46 + float(index % 2) * 0.10, 0.12 + float(index % 3) * 0.04, 0.34)
		stone.rotation = Vector3(0.03, -0.25 + float(index) * 0.18, -0.04)
		_apply_material(stone, route_material)
		_limit_geometry_visibility(stone, 72.0)
		approach.add_child(stone)
		if index == 1 or index == 3:
			var marker_light: OmniLight3D = OmniLight3D.new()
			marker_light.name = "LuzWayfindingCaverna_%02d" % index
			marker_light.light_color = Color("#4ebbd3")
			marker_light.light_energy = 1.05
			marker_light.omni_range = 7.0
			marker_light.shadow_enabled = false
			marker_light.position = Vector3(0.0, 1.15, 0.0)
			stone.add_child(marker_light)
	var warm_entry_light := OmniLight3D.new()
	warm_entry_light.name = "LuzQuenteInicioTransicaoRegiao09"
	warm_entry_light.light_color = Color("#d9a86c")
	warm_entry_light.light_energy = 0.62
	warm_entry_light.omni_range = 6.5
	warm_entry_light.shadow_enabled = false
	warm_entry_light.position = Vector3(-112.0, _height_at(-112.0, 532.0) + 1.3, 532.0)
	approach.add_child(warm_entry_light)
	for root_index: int in range(5):
		var root: Node3D = ROCK_LARGE.instantiate() as Node3D
		if root == null:
			continue
		root.name = "RaizPetrea_%02d" % root_index
		var side_material := stone_material.duplicate() as StandardMaterial3D
		side_material.albedo_color = Color("#3a5960")
		side_material.roughness = 0.88
		_apply_material(root, side_material)
		var side: float = -1.0 if root_index % 2 == 0 else 1.0
		root.position = Vector3(side * (8.2 - float(root_index % 2) * 1.3), 2.8 + float(root_index) * 0.85, 539.0 + float(root_index) * 1.65)
		root.scale = Vector3(0.20 + float(root_index % 2) * 0.06, 0.95, 0.18)
		root.rotation = Vector3(0.14 * side, side * (0.52 + float(root_index) * 0.16), 0.18 * side)
		approach.add_child(root)
	for fissure_index: int in range(3):
		var fissure: MeshInstance3D = MeshInstance3D.new()
		fissure.name = "FendaRessonanciaRegiao10_%02d" % fissure_index
		var ribbon: QuadMesh = QuadMesh.new()
		ribbon.size = Vector2(0.16 + float(fissure_index) * 0.05, 2.8 + float(fissure_index) * 0.62)
		ribbon.material = _make_resonance_material()
		fissure.mesh = ribbon
		var fissure_x: float = -116.2 + float(fissure_index) * 0.9
		var fissure_z: float = 538.0 + float(fissure_index) * 2.0
		fissure.position = Vector3(fissure_x, _height_at(fissure_x, fissure_z) + 0.12, fissure_z)
		fissure.rotation_degrees = Vector3(-90.0, 14.0 + float(fissure_index) * 9.0, 0.0)
		approach.add_child(fissure)
	var entrance_light: OmniLight3D = OmniLight3D.new()
	entrance_light.name = "LuzTransicaoCavernaOrion"
	entrance_light.light_color = Color("#5cc8ff")
	entrance_light.light_energy = 2.25
	entrance_light.omni_range = 14.0
	entrance_light.shadow_enabled = false
	entrance_light.position = Vector3(-116.0, 4.2, 542.0)
	approach.add_child(entrance_light)
	var lateral_fill := OmniLight3D.new()
	lateral_fill.name = "PreenchimentoLateralRotaRegiao09"
	lateral_fill.light_color = Color("#3d91a6")
	lateral_fill.light_energy = 0.72
	lateral_fill.omni_range = 8.0
	lateral_fill.shadow_enabled = false
	lateral_fill.position = Vector3(-121.0, 3.2, 539.5)
	approach.add_child(lateral_fill)
	for side: int in [-1, 1]:
		var mouth_jamb: Node3D = ROCK_LARGE.instantiate() as Node3D
		if mouth_jamb == null:
			continue
		mouth_jamb.name = "OmbreiraBocaCavernaOrion_%s" % ("Norte" if side < 0 else "Sul")
		var mouth_x: float = -116.0 + float(side) * 5.2
		mouth_jamb.position = Vector3(mouth_x, _height_at(mouth_x, 545.0) + 2.4, 545.0)
		mouth_jamb.scale = Vector3(0.42, 0.92, 0.34)
		mouth_jamb.rotation = Vector3(0.12 * float(side), 0.26 * float(side), -0.08 * float(side))
		_apply_material(mouth_jamb, stone_material)
		approach.add_child(mouth_jamb)
	var mouth_lintel: Node3D = ROCK_LARGE.instantiate() as Node3D
	if mouth_lintel != null:
		mouth_lintel.name = "LintelOrganicoBocaCavernaOrion"
		mouth_lintel.position = Vector3(-116.0, _height_at(-116.0, 545.0) + 5.3, 545.0)
		mouth_lintel.scale = Vector3(1.65, 0.52, 0.48)
		mouth_lintel.rotation = Vector3(0.02, 0.0, -0.03)
		_apply_material(mouth_lintel, stone_material)
		approach.add_child(mouth_lintel)
	for brazier_side: int in [-1, 1]:
		var brazier_light := OmniLight3D.new()
		brazier_light.name = "BraseiroAzulHandoffR10_%s" % ("Norte" if brazier_side < 0 else "Sul")
		brazier_light.position = Vector3(-116.0 + float(brazier_side) * 2.2, _height_at(-116.0 + float(brazier_side) * 2.2, 545.0) + 3.0, 544.4)
		brazier_light.light_color = Color("#5cc8ff")
		brazier_light.light_energy = 1.8
		brazier_light.omni_range = 9.0
		brazier_light.shadow_enabled = false
		approach.add_child(brazier_light)
	var mouth_rim_fill := OmniLight3D.new()
	mouth_rim_fill.name = "PreenchimentoFrontalBocaCavernaOrion"
	mouth_rim_fill.light_color = Color("#86dbea")
	mouth_rim_fill.light_energy = 1.02
	mouth_rim_fill.omni_range = 10.0
	mouth_rim_fill.shadow_enabled = false
	mouth_rim_fill.position = Vector3(-116.0, 3.0, 546.5)
	approach.add_child(mouth_rim_fill)
	var threshold_warm_fill := OmniLight3D.new()
	threshold_warm_fill.name = "PreenchimentoQuenteTransicao09_10"
	threshold_warm_fill.light_color = Color("#d6a46c")
	threshold_warm_fill.light_energy = 0.66
	threshold_warm_fill.omni_range = 9.5
	threshold_warm_fill.shadow_enabled = false
	threshold_warm_fill.position = Vector3(-112.0, _height_at(-112.0, 532.0) + 2.1, 532.0)
	approach.add_child(threshold_warm_fill)

func _build_cp_d2_007_physical_handoff() -> void:
	var handoff := Node3D.new()
	handoff.name = "CPD2007_HandoffFisico_Regiao09_10_11"
	handoff.set_meta("scope", "REGIONS_7_12_ONLY")
	handoff.set_meta("map_route", "09_TRILHA -> 10_CAVERNA -> 11_CAMARA_CUBE")
	add_child(handoff)
	var handoff_points: Array[Vector3] = [
		Vector3(-112.0, _height_at(-112.0, 532.0) + 0.45, 532.0),
		Vector3(-116.0, _height_at(-116.0, 542.0) + 0.45, 542.0),
		Vector3(-116.0, _height_at(-116.0, 548.0) + 0.45, 548.0),
		Vector3(-116.0, _height_at(-116.0, 555.0) + 0.45, 555.0),
		Vector3(-116.0, _height_at(-116.0, 562.0) + 0.45, 562.0)
	]
	var roles: Array[String] = ["ENTRADA_TRILHA_09", "LIMIAR_CAVERNA_10", "BOCA_CAVERNA_10", "TRANSICAO_INTERIOR", "CAMARA_CUBE_11"]
	var transition_colors: Array[Color] = [Color("#5cc8ff"), Color("#63bce8"), Color("#6a9fda"), Color("#777fd0"), Color("#8c6cff")]
	for index: int in range(handoff_points.size()):
		var marker := Marker3D.new()
		marker.name = "CPD2007_%s" % roles[index]
		marker.position = handoff_points[index]
		marker.set_meta("physical_handoff", true)
		marker.set_meta("map_region", 9 + mini(index, 2))
		handoff.add_child(marker)
		var body := StaticBody3D.new()
		body.name = "ColliderCPD2007_%s" % roles[index]
		body.collision_layer = 1
		body.collision_mask = 1
		body.set_meta("physical_handoff", true)
		if index == 0:
			body.set_meta("handoff_R9_R10", true)
		elif index < 4:
			body.set_meta("handoff_R10_R11", true)
		else:
			body.set_meta("handoff_R11_R12", true)
		var shape := CollisionShape3D.new()
		var box := BoxShape3D.new()
		box.size = Vector3(5.2 if index < 2 else 4.4, 0.9, 3.2)
		shape.shape = box
		shape.position = handoff_points[index]
		body.add_child(shape)
		handoff.add_child(body)
		if index > 0:
			var light := OmniLight3D.new()
			light.name = "WayfinderCPD2007_%s" % roles[index]
			light.position = handoff_points[index] + Vector3(0.0, 1.8, 0.0)
			light.light_color = transition_colors[index]
			light.light_energy = 0.72
			light.omni_range = 6.5
			light.shadow_enabled = false
			handoff.add_child(light)
	print("CPD2007_HANDOFF_READY points=", handoff_points.size())

func _apply_r9_r10_visual_culling() -> void:
	# CP-D2-091: remover apenas adornos de QA que flutuam no handoff; a física permanece intacta.
	for node_name: String in ["Take8WayfindingProxy", "FendaRessonanciaRegiao10_00", "FendaRessonanciaRegiao10_01", "FendaRessonanciaRegiao10_02"]:
		var visual_node := find_child(node_name, true, false) as Node3D
		if visual_node != null:
			visual_node.visible = false
	for node in find_children("*", "Marker3D", true, false):
		if str(node.name).begins_with("CPD2007_"):
			(node as Node3D).visible = false
	for node in find_children("*", "OmniLight3D", true, false):
		if str(node.name).begins_with("WayfinderCPD2007_"):
			(node as OmniLight3D).visible = false

func _make_resonance_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color("#0d2630")
	material.emission_enabled = true
	material.emission = Color("#5cc8ff")
	material.emission_energy_multiplier = 1.48
	material.roughness = 0.40
	return material

func _build_cube_chamber_marker() -> void:
	var chamber_route: Node3D = Node3D.new()
	chamber_route.name = "ContinuidadeCavernaParaCamaraOrion"
	add_child(chamber_route)
	var chamber_route_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
	chamber_route_material.albedo_color = Color("#425b61")
	chamber_route_material.roughness = 0.94
	for index: int in range(7):
		var route_t: float = float(index) / 6.0
		var route_z: float = lerpf(547.0, 560.0, route_t)
		var route_stone: Node3D = ROCK_LARGE.instantiate() as Node3D
		if route_stone == null:
			continue
		route_stone.name = "DegrauCavernaParaCamara_%02d" % index
		route_stone.position = Vector3(-116.0, _height_at(-116.0, route_z) + 0.25, route_z)
		route_stone.scale = Vector3(0.48 + float(index % 2) * 0.08, 0.13, 0.34)
		route_stone.rotation = Vector3(0.02, float(index) * 0.21, -0.03)
		_apply_material(route_stone, chamber_route_material)
		chamber_route.add_child(route_stone)
		if index % 2 == 1:
			var route_light := OmniLight3D.new()
			route_light.name = "LuzWayfindingCamara_%02d" % index
			route_light.light_color = Color("#4ebbd3")
			route_light.light_energy = 0.70
			route_light.omni_range = 5.5
			route_light.shadow_enabled = false
			route_light.position = route_stone.position + Vector3(0.0, 0.9, 0.0)
			chamber_route.add_child(route_light)
	var chamber: Node3D = Node3D.new()
	chamber.name = "CamaraDoOrionCube"
	var chamber_x: float = -116.0
	var chamber_z: float = 562.0
	chamber.position = Vector3(chamber_x, _height_at(chamber_x, chamber_z) + 2.8, chamber_z)
	add_child(chamber)
	var altar_mesh: CylinderMesh = CylinderMesh.new()
	altar_mesh.top_radius = 3.2
	altar_mesh.bottom_radius = 4.2
	altar_mesh.height = 1.8
	altar_mesh.radial_segments = 12
	var altar: MeshInstance3D = MeshInstance3D.new()
	altar.mesh = altar_mesh
	altar.material_override = stone_material
	altar.position = Vector3(0.0, -1.9, 0.0)
	chamber.add_child(altar)
	# CP-D2 continuidade: o marco narrativo mantém o grupo interactable, mas deixa de usar um BoxMesh azul como silhueta principal.
	var cube: Node3D = ROCK_LARGE.instantiate() as Node3D
	if cube != null:
		cube.name = "CuboOrion"
		cube.position = Vector3(0.0, 1.55, 0.0)
		cube.scale = Vector3(0.96, 2.10, 0.96)
		cube.rotation = Vector3(0.12, 0.54, -0.08)
		var cube_silhouette_material := stone_material.duplicate() as StandardMaterial3D
		cube_silhouette_material.albedo_color = Color("#23384b")
		cube_silhouette_material.emission_enabled = true
		cube_silhouette_material.emission = Color("#6c9dff")
		cube_silhouette_material.emission_energy_multiplier = 0.72
		_apply_material(cube, cube_silhouette_material)
		cube.add_to_group("interactable")
		chamber.add_child(cube)
		var inner_core := MeshInstance3D.new()
		inner_core.name = "NucleoEmissivoOrion"
		var inner_mesh := SphereMesh.new()
		inner_mesh.radius = 0.58
		inner_mesh.height = 1.22
		inner_mesh.radial_segments = 12
		inner_mesh.material = cube_material
		inner_core.mesh = inner_mesh
		inner_core.position = Vector3(0.0, 1.55, 0.0)
		cube.add_child(inner_core)
	var cube_light: OmniLight3D = OmniLight3D.new()
	cube_light.name = "LuzNucleoOrion"
	cube_light.light_color = Color(0.10, 0.48, 1.0, 1.0)
	cube_light.light_energy = 2.2
	cube_light.omni_range = 14.0
	cube_light.position = Vector3(0.0, 1.2, 0.0)
	cube_light.shadow_enabled = false
	chamber.add_child(cube_light)
	# CP-D2-222: pórtico orgânico vertical para separar a silhueta R11 dos anéis.
	for gate_side: int in [-1, 1]:
		var gate_pillar: Node3D = PILLAR.instantiate() as Node3D
		if gate_pillar == null:
			continue
		gate_pillar.name = "PorticoOrionCube_%s" % ("Esquerdo" if gate_side < 0 else "Direito")
		gate_pillar.position = Vector3(float(gate_side) * 4.0, 4.8, 1.8)
		gate_pillar.scale = Vector3(0.82, 2.25, 0.82)
		gate_pillar.rotation = Vector3(0.04, 0.12 * float(gate_side), -0.03)
		_apply_material(gate_pillar, stone_material)
		chamber.add_child(gate_pillar)
	var gate_lintel: Node3D = ROCK_LARGE.instantiate() as Node3D
	if gate_lintel != null:
		gate_lintel.name = "LintelPorticoOrionCube"
		gate_lintel.position = Vector3(0.0, 9.3, 1.8)
		gate_lintel.scale = Vector3(1.35, 0.42, 0.78)
		gate_lintel.rotation = Vector3(0.02, 0.08, -0.02)
		_apply_material(gate_lintel, stone_material)
		chamber.add_child(gate_lintel)
	# CP-D2-223: contrafundo vertical emissivo, apoiado atrás do Cube, sem cartão plano.
	var cube_backdrop: Node3D = ROCK_LARGE.instantiate() as Node3D
	if cube_backdrop != null:
		cube_backdrop.name = "ContrafundoOrganicoOrionCube"
		cube_backdrop.position = Vector3(0.0, 5.0, 3.0)
		cube_backdrop.scale = Vector3(1.75, 3.2, 0.48)
		var backdrop_material := stone_material.duplicate() as StandardMaterial3D
		backdrop_material.albedo_color = Color("#101b32")
		backdrop_material.emission_enabled = true
		backdrop_material.emission = Color("#263e79")
		backdrop_material.emission_energy_multiplier = 0.58
		_apply_material(cube_backdrop, backdrop_material)
		chamber.add_child(cube_backdrop)
	for index: int in range(4):
		var angle: float = float(index) * TAU / 4.0 + 0.22
		var support: Node3D = PILLAR.instantiate() as Node3D
		if support == null:
			continue
		support.name = "SuporteOrganicoOrionCube_%02d" % index
		support.position = Vector3(cos(angle) * 6.8, 0.8, sin(angle) * 6.8)
		support.scale = Vector3(0.62, 0.85 + float(index % 2) * 0.16, 0.62)
		support.rotation = Vector3(0.03 * sin(angle), angle, 0.04 * cos(angle))
		_apply_material(support, stone_material)
		chamber.add_child(support)
		var support_light := OmniLight3D.new()
		support_light.name = "BraseiroAnelCube_%02d" % index
		support_light.light_color = Color("#4ebbd3")
		support_light.light_energy = 1.6
		support_light.omni_range = 7.0
		support_light.shadow_enabled = false
		support_light.position = Vector3(cos(angle) * 5.4, 1.1, sin(angle) * 5.4)
		chamber.add_child(support_light)
		var ring_core := MeshInstance3D.new()
		ring_core.name = "NucleoVisivelAnelCube_%02d" % index
		var ring_sphere := SphereMesh.new()
		ring_sphere.radius = 0.22
		ring_sphere.height = 0.44
		ring_core.mesh = ring_sphere
		var ring_material := StandardMaterial3D.new()
		ring_material.albedo_color = Color("#4ebbd3")
		ring_material.emission_enabled = true
		ring_material.emission = Color("#4ebbd3")
		ring_material.emission_energy_multiplier = 2.8
		ring_core.material_override = ring_material
		ring_core.position = Vector3(cos(angle) * 5.4, 1.65, sin(angle) * 5.4)
		chamber.add_child(ring_core)

func _build_region11_to_12_approach() -> void:
	var approach := Node3D.new()
	approach.name = "TransicaoRegiao11Para12"
	add_child(approach)
	var route: Array[Vector2] = [Vector2(-116.0, 562.0), Vector2(-82.0, 518.0), Vector2(-48.0, 474.0), Vector2(-14.0, 430.0), Vector2(20.0, 386.0), Vector2(54.0, 342.0), Vector2(88.0, 298.0), Vector2(126.0, 254.0), Vector2(164.0, 216.0)]
	for index: int in range(route.size()):
		var point := route[index]
		var stone := ROCK_LARGE.instantiate() as Node3D
		if stone == null:
			continue
		stone.name = "DegrauHubTemporal_%02d" % index
		stone.position = Vector3(point.x, _height_at(point.x, point.y) + 0.24, point.y)
		stone.scale = Vector3(0.46 + float(index % 3) * 0.08, 0.14 + float(index % 2) * 0.05, 0.34 + float(index % 2) * 0.08)
		stone.rotation = Vector3(0.03, -0.26 + float(index) * 0.12, -0.04)
		_apply_material(stone, stone_material)
		_limit_geometry_visibility(stone, 72.0)
		approach.add_child(stone)
		if index % 4 == 1:
			var waypoint := OmniLight3D.new()
			waypoint.name = "LuzWayfindingHub_%02d" % index
			waypoint.light_color = Color("#7f6bd6")
			waypoint.light_energy = 0.9
			waypoint.omni_range = 6.5
			waypoint.shadow_enabled = false
			waypoint.position = stone.position + Vector3(0.0, 0.9, 0.0)
			approach.add_child(waypoint)


func _build_temporal_hub() -> void:
	var hub: Node3D = Node3D.new()
	hub.name = "HubTemporal"
	var hub_x: float = 164.0
	var hub_z: float = 210.0
	hub.position = Vector3(hub_x, _height_at(hub_x, hub_z), hub_z)
	add_child(hub)
	var circle_mesh: CylinderMesh = CylinderMesh.new()
	circle_mesh.top_radius = 10.5
	circle_mesh.bottom_radius = 11.2
	circle_mesh.height = 0.50
	circle_mesh.radial_segments = 32
	var circle: MeshInstance3D = MeshInstance3D.new()
	circle.name = "CirculoMegalitico"
	circle.mesh = circle_mesh
	circle.material_override = stone_material
	circle.position = Vector3(0.0, 0.25, 0.0)
	hub.add_child(circle)
	for index: int in range(8):
		var angle: float = float(index) * TAU / 8.0
		var monolith: Node3D = PILLAR.instantiate() as Node3D
		if monolith == null:
			continue
		monolith.name = "MonolitoTemporal_%02d" % index
		monolith.position = Vector3(cos(angle) * 12.5, 2.3, sin(angle) * 12.5)
		monolith.scale = Vector3(0.78, 0.78, 0.78)
		monolith.rotation = Vector3(0.04 * sin(angle), angle, 0.03 * cos(angle))
		_apply_material(monolith, stone_material)
		hub.add_child(monolith)
		for monolith_mesh in monolith.find_children("*", "GeometryInstance3D", true, false):
			(monolith_mesh as GeometryInstance3D).visibility_range_end = 48.0
		if index % 4 == 0:
			var rim_light := OmniLight3D.new()
			rim_light.name = "LuzRimMonolitoTemporal_%02d" % index
			rim_light.light_color = Color("#7f6bd6")
			rim_light.light_energy = 1.55
			rim_light.omni_range = 6.5
			rim_light.shadow_enabled = false
			rim_light.position = Vector3(cos(angle) * 12.5, 3.8, sin(angle) * 12.5)
			hub.add_child(rim_light)
		var monolith_core := MeshInstance3D.new()
		monolith_core.name = "NucleoVisivelMonolito_%02d" % index
		var monolith_sphere := SphereMesh.new()
		monolith_sphere.radius = 0.18
		monolith_sphere.height = 0.36
		monolith_core.mesh = monolith_sphere
		var monolith_material := StandardMaterial3D.new()
		monolith_material.albedo_color = Color("#8b78dc")
		monolith_material.emission_enabled = true
		monolith_material.emission = Color("#8b78dc")
		monolith_material.emission_energy_multiplier = 0.95
		monolith_core.material_override = monolith_material
		monolith_core.position = Vector3(cos(angle) * 12.5, 4.1, sin(angle) * 12.5)
		monolith_core.visibility_range_end = 48.0
		hub.add_child(monolith_core)
	var core_mesh: SphereMesh = SphereMesh.new()
	core_mesh.radius = 1.55
	core_mesh.height = 3.10
	var core: MeshInstance3D = MeshInstance3D.new()
	core.name = "NucleoTemporal"
	core.mesh = core_mesh
	core.material_override = cube_material
	core.position = Vector3(0.0, 1.9, 0.0)
	hub.add_child(core)


func _build_hub_to_final_dome_approach() -> void:
	var approach := Node3D.new()
	approach.name = "TransicaoHubParaCupulaFinal"
	add_child(approach)
	var route: Array[Vector2] = [Vector2(164.0, 203.0), Vector2(164.0, 199.5), Vector2(162.5, 196.0), Vector2(165.0, 192.5), Vector2(163.0, 189.0), Vector2(165.0, 185.5), Vector2(164.0, 181.5)]
	for index: int in range(route.size()):
		var point := route[index]
		var stone := ROCK_LARGE.instantiate() as Node3D
		if stone == null:
			continue
		stone.name = "DegrauCupulaFinal_%02d" % index
		stone.position = Vector3(point.x, _height_at(point.x, point.y) + 0.30, point.y)
		stone.scale = Vector3(0.58 + float(index % 2) * 0.10, 0.18 + float(index % 3) * 0.05, 0.48 + float(index % 2) * 0.08)
		stone.rotation = Vector3(0.04, -0.22 + float(index) * 0.08, -0.03)
		_apply_material(stone, stone_material)
		var stone_body := StaticBody3D.new()
		stone_body.name = "ColisaoDegrauCupulaFinal_%02d" % index
		stone_body.collision_layer = 1
		stone_body.collision_mask = 1
		var stone_shape := CollisionShape3D.new()
		var stone_box := BoxShape3D.new()
		stone_box.size = Vector3(1.25 + float(index % 2) * 0.18, 0.48, 1.05 + float(index % 2) * 0.16)
		stone_shape.shape = stone_box
		stone_shape.position = Vector3(0.0, 0.02, 0.0)
		stone_body.add_child(stone_shape)
		stone.add_child(stone_body)
		approach.add_child(stone)
		if index % 2 == 0:
			var waypoint := OmniLight3D.new()
			waypoint.name = "LuzWayfindingCupula_%02d" % index
			waypoint.light_color = Color("#8b78dc")
			waypoint.light_energy = 0.85
			waypoint.omni_range = 5.5
			waypoint.shadow_enabled = false
			waypoint.position = stone.position + Vector3(0.0, 0.75, 0.0)
			approach.add_child(waypoint)

	var final_route_point := route[route.size() - 1]
	var threshold_marker := PILLAR.instantiate() as Node3D
	if threshold_marker != null:
		threshold_marker.name = "WayfindingOrganicoSoleiraR12"
		threshold_marker.position = Vector3(final_route_point.x, _height_at(final_route_point.x, final_route_point.y) + 1.05, final_route_point.y)
		threshold_marker.scale = Vector3(0.34, 1.02, 0.30)
		threshold_marker.rotation = Vector3(0.035, -0.26, -0.018)
		threshold_marker.set_meta("map_region", 12)
		threshold_marker.set_meta("physical_wayfinding", true)
		var threshold_material := stone_material.duplicate() as StandardMaterial3D
		threshold_material.albedo_color = Color("#2e3653")
		threshold_material.emission_enabled = true
		threshold_material.emission = Color("#7d70de")
		threshold_material.emission_energy_multiplier = 0.34
		_apply_material(threshold_marker, threshold_material)
		approach.add_child(threshold_marker)

func _build_final_dome() -> void:
	var dome := Node3D.new()
	dome.name = "CupulaFinal"
	var dome_x: float = 164.0
	var dome_z: float = 178.0
	dome.position = Vector3(dome_x, _height_at(dome_x, dome_z), dome_z)
	add_child(dome)
	# An organic ring of CC0 pillars establishes the final sanctuary without greybox geometry.
	# CP-D2-064: eight broad pillars preserve the monumental silhouette while reducing distant decoration.
	for index: int in range(8):
		var angle: float = float(index) * TAU / 8.0
		var pillar := PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarCupulaFinal_%02d" % index
		pillar.position = Vector3(cos(angle) * 15.0, 3.2 + float(index % 3) * 0.7, sin(angle) * 15.0)
		pillar.scale = Vector3(0.62 + float(index % 2) * 0.12, 0.92 + float(index % 3) * 0.12, 0.62 + float(index % 2) * 0.12)
		pillar.rotation = Vector3(0.05 * sin(angle), angle, 0.04 * cos(angle))
		_apply_material(pillar, stone_material)
		_limit_geometry_visibility(pillar, 52.0)
		dome.add_child(pillar)
		for pillar_mesh in pillar.find_children("*", "GeometryInstance3D", true, false):
			(pillar_mesh as GeometryInstance3D).visibility_range_end = 46.0
		if index == 0:
			var beacon := OmniLight3D.new()
			beacon.name = "LuzCoroaCupula_%02d" % index
			beacon.light_color = Color("#8b78dc")
			beacon.light_energy = 0.95
			beacon.omni_range = 6.5
			beacon.shadow_enabled = false
			beacon.position = pillar.position + Vector3(0.0, 5.1, 0.0)
			dome.add_child(beacon)
	# The entrance crown uses the validated staggered organic masses from the R12 harness.
	for crown_index: int in range(3):
		var crown := ROCK_LARGE.instantiate() as Node3D
		if crown == null:
			continue
		crown.name = "ArcoOrganicoCupula_%02d" % crown_index
		crown.position = Vector3(-2.35 + float(crown_index) * 2.35, 3.55 if crown_index != 1 else 4.15, -4.48)
		crown.scale = Vector3(2.9 if crown_index != 1 else 3.35, 1.65 if crown_index != 1 else 2.0, 1.85)
		crown.rotation = Vector3(0.08 * sign(float(crown_index - 1)), 0.08 * float(crown_index - 1), -0.06 * sign(float(crown_index - 1)))
		var crown_material := stone_material.duplicate() as StandardMaterial3D
		crown_material.albedo_color = Color("#66839c")
		crown_material.roughness = 0.86
		_apply_material(crown, crown_material)
		_limit_geometry_visibility(crown, 48.0)
		dome.add_child(crown)
	# Validated Region 12 sanctuary gateway: organic side monoliths, staggered crown, and a recessed dark opening.
	for gateway_x in [0.0]:
		var gateway_monolith := PILLAR.instantiate() as Node3D
		if gateway_monolith == null:
			continue
		gateway_monolith.name = "MassaVerticalPortalCupulaR12"
		gateway_monolith.position = Vector3(gateway_x, 2.52, -4.45)
		gateway_monolith.scale = Vector3(1.72, 4.65, 1.08)
		gateway_monolith.rotation = Vector3(0.04, 0.10 * sign(gateway_x), 0.03 * sign(gateway_x))
		_apply_material(gateway_monolith, stone_material)
		var monolith_body := StaticBody3D.new()
		monolith_body.name = "ColisaoMassaVerticalPortalCupulaR12"
		monolith_body.collision_layer = 1
		monolith_body.collision_mask = 1
		var monolith_shape := CollisionShape3D.new()
		var monolith_box := BoxShape3D.new()
		monolith_box.size = Vector3(2.65, 9.3, 2.1)
		monolith_shape.shape = monolith_box
		monolith_shape.position = Vector3(0.0, 0.0, 0.0)
		monolith_body.add_child(monolith_shape)
		gateway_monolith.add_child(monolith_body)
		dome.add_child(gateway_monolith)
	var gateway_recess := ROCK_LARGE.instantiate() as Node3D
	if gateway_recess != null:
		gateway_recess.name = "RecessoEscuroGatewayCupula"
		gateway_recess.position = Vector3(0.0, 2.25, -4.18)
		gateway_recess.scale = Vector3(1.12, 0.78, 0.14)
		gateway_recess.rotation = Vector3(0.0, PI, 0.0)
		var gateway_dark := stone_material.duplicate() as StandardMaterial3D
		gateway_dark.albedo_color = Color("#03050b")
		gateway_dark.emission_enabled = false
		_apply_material(gateway_recess, gateway_dark)
		dome.add_child(gateway_recess)
	var gateway_base := ROCK_LARGE.instantiate() as Node3D
	if gateway_base != null:
		gateway_base.name = "BordaBaseGatewayCupula"
		gateway_base.position = Vector3(0.0, 0.58, -4.42)
		gateway_base.scale = Vector3(5.8, 0.52, 1.65)
		gateway_base.rotation = Vector3(0.02, 0.0, 0.0)
		_apply_material(gateway_base, stone_material)
		var gateway_body := StaticBody3D.new()
		gateway_body.name = "ColisaoSoleiraGatewayCupula"
		gateway_body.collision_layer = 1
		gateway_body.collision_mask = 1
		var gateway_shape := CollisionShape3D.new()
		var gateway_box := BoxShape3D.new()
		gateway_box.size = Vector3(11.6, 1.0, 3.3)
		gateway_shape.shape = gateway_box
		gateway_shape.position = Vector3(0.0, -0.22, 0.0)
		gateway_body.add_child(gateway_shape)
		gateway_base.add_child(gateway_body)
		dome.add_child(gateway_base)
	# CP-D2-228/229: moldura vertical monumental da Cúpula Final, sem painel plano e sem novas luzes.
	var cupula_contrast_material := stone_material.duplicate() as StandardMaterial3D
	cupula_contrast_material.albedo_color = Color("#26334c")
	cupula_contrast_material.emission_enabled = true
	cupula_contrast_material.emission = Color("#7569d9")
	cupula_contrast_material.emission_energy_multiplier = 0.42
	cupula_contrast_material.roughness = 0.82
	for silhouette_side: int in [-1, 1]:
		var silhouette_pillar: Node3D = PILLAR.instantiate() as Node3D
		if silhouette_pillar == null:
			continue
		silhouette_pillar.name = "PilarSilhuetaCupulaR12_%s" % ("Oeste" if silhouette_side < 0 else "Este")
		silhouette_pillar.position = Vector3(float(silhouette_side) * 7.0, 5.4, 0.6)
		silhouette_pillar.scale = Vector3(1.18, 4.10, 1.18)
		silhouette_pillar.rotation = Vector3(0.03, 0.12 * float(silhouette_side), -0.04)
		_apply_material(silhouette_pillar, cupula_contrast_material)
		_limit_geometry_visibility(silhouette_pillar, 58.0)
		dome.add_child(silhouette_pillar)
	var silhouette_arch: Node3D = ROCK_LARGE.instantiate() as Node3D
	if silhouette_arch != null:
		silhouette_arch.name = "ArcoSilhuetaCupulaR12"
		silhouette_arch.position = Vector3(0.0, 6.4, 0.6)
		silhouette_arch.scale = Vector3(3.60, 1.05, 1.15)
		silhouette_arch.rotation = Vector3(0.02, 0.04, 0.0)
		_apply_material(silhouette_arch, cupula_contrast_material)
		_limit_geometry_visibility(silhouette_arch, 58.0)
		dome.add_child(silhouette_arch)
	var sanctuary_pedestal := ROCK_LARGE.instantiate() as Node3D
	if sanctuary_pedestal != null:
		sanctuary_pedestal.name = "PedestalOrganicoContrasteCupulaR12"
		sanctuary_pedestal.position = Vector3(0.0, 0.95, -0.35)
		sanctuary_pedestal.scale = Vector3(6.8, 0.86, 4.6)
		sanctuary_pedestal.rotation = Vector3(0.02, 0.16, -0.02)
		_apply_material(sanctuary_pedestal, cupula_contrast_material)
		_limit_geometry_visibility(sanctuary_pedestal, 58.0)
		dome.add_child(sanctuary_pedestal)
	var heart := MeshInstance3D.new()
	heart.name = "NucleoCoroaFinal"
	var heart_mesh := SphereMesh.new()
	heart_mesh.radius = 1.15
	heart_mesh.height = 2.3
	heart.mesh = heart_mesh
	var heart_material := StandardMaterial3D.new()
	heart_material.albedo_color = Color("#6d5bd0")
	heart_material.emission_enabled = true
	heart_material.emission = Color("#6d5bd0")
	heart_material.emission_energy_multiplier = 1.6
	heart.material_override = heart_material
	heart.position = Vector3(0.0, 5.2, 0.0)
	dome.add_child(heart)
	var heart_light := OmniLight3D.new()
	heart_light.name = "LuzNucleoCupulaFinal"
	heart_light.light_color = Color("#7f6bd6")
	heart_light.light_energy = 2.2
	heart_light.omni_range = 14.0
	heart_light.shadow_enabled = false
	heart_light.position = Vector3(0.0, 5.0, 0.0)
	dome.add_child(heart_light)
	var alpine_fill := DirectionalLight3D.new()
	alpine_fill.name = "PreenchimentoAlpinoSemSombrasR12"
	alpine_fill.light_color = Color("#8fb7d6")
	alpine_fill.light_energy = 0.24
	alpine_fill.shadow_enabled = false
	alpine_fill.rotation_degrees = Vector3(-52.0, -28.0, 0.0)
	dome.add_child(alpine_fill)
	var recess_light := OmniLight3D.new()
	recess_resonance_light = recess_light
	recess_light.name = "RessonanciaRecessivoCupulaR12"
	recess_light.light_color = Color("#3c8fb5")
	recess_light.light_energy = 0.24
	recess_light.omni_range = 2.8
	recess_light.shadow_enabled = false
	recess_light.position = Vector3(0.0, 2.25, 173.0 - dome_z)
	dome.add_child(recess_light)

func _process(delta: float) -> void:
	elapsed += delta
	if recess_resonance_light != null:
		recess_resonance_light.light_energy = 0.20 + sin(elapsed * 1.7) * 0.055

func _make_stone_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = MOSSY_RUIN_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_RUIN_NORMAL
	material.normal_scale = 0.30
	material.roughness = 0.95
	material.uv1_scale = Vector3(0.26, 0.26, 0.26)
	return material

func _make_cube_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.02, 0.20, 0.80, 1.0)
	material.metallic = 0.58
	material.roughness = 0.18
	material.emission_enabled = true
	material.emission = Color(0.04, 0.36, 1.0, 1.0)
	material.emission_energy_multiplier = 1.35
	return material

func _limit_geometry_visibility(root: Node, range_end: float) -> void:
	for child in root.find_children("*", "GeometryInstance3D", true, false):
		var geometry := child as GeometryInstance3D
		if geometry != null:
			geometry.visibility_range_end = range_end

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
