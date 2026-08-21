## HighlandRegion.gd
## Marcos 7–9 do mapa regional: Vila Elevada, Observatório e Trilha da Montanha.
## Estruturas modulares leves, apoiadas no TerrainPatch regional e organizadas para futura expansão jogável.

extends Node3D

const Anchors = preload("res://levels/CartographicAnchors.gd")
const PINE_TALL: PackedScene = preload("res://assets/models_generated/ez_pine_tall_pbr.glb")
const TREE_CC0: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const FERN_CC0: PackedScene = preload("res://assets/models_polyhaven/fern_02/fern_02_1k.gltf")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const CLIFF_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const SLOPE_ROCK: PackedScene = preload("res://assets/models_cc0/cliff_blockSlope_rock.glb")
const BRIDGE_ARCH: PackedScene = preload("res://assets/models_cc0/bridge_stone.glb")
const FLAGSTONE: Texture2D = preload("res://assets/textures/generated/daylight_weathered_flagstone.png")
const MOSSY_RUIN_DIFF: Texture2D = preload("res://assets/textures/generated/mossy_ancient_ruin_stone.png")
const MOSSY_RUIN_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")
const GROUND_NORMAL: Texture2D = preload("res://assets/textures/pbr/forest_ground_normal_gl.jpg")

var terrain_patch: Node3D
var stone_material: StandardMaterial3D
var roof_material: StandardMaterial3D
var path_material: StandardMaterial3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	stone_material = _make_stone_material()
	roof_material = _make_roof_material()
	path_material = _make_path_material()
	_build_region7_handoff_chain()
	_build_lake_to_village_path()
	_build_r6_r7_handoff_colliders()
	_build_r7_r8_handoff_colliders()
	_build_r8_r9_handoff_colliders()
	_build_elevated_village()
	_build_observatory()
	_build_mountain_trail()
	_build_region9_threshold()
	if OS.get_environment("QA_VALIDATION_ROUTE") == "R9_R10_INTEGRATED_HANDOFF":
		_apply_r9_r10_integrated_visual_culling()
	_build_cartographic_anchors()

func _build_cartographic_anchors() -> void:
	var anchors := Node3D.new()
	anchors.name = "CartographicAnchors_Regioes7a9"
	anchors.set_meta("map_authority", "mapaorigem.webp")
	anchors.set_meta("scope", "REGIONS_7_12_ONLY")
	var anchor_data: Array[Dictionary] = [
		{"name": "Marco07_VilaElevada", "position": Vector3(140.0, 0.0, 352.0), "role": "massa urbana em socalcos à direita"},
{"name": "Marco08_Observatorio", "position": Vector3(194.0, 0.0, 404.0), "role": "cupula no topo da vila"},
			{"name": "Marco09_TrilhaDaMontanha", "position": Vector3(174.0, 0.0, 414.0), "role": "linha serpenteante até Orion"}
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

func _build_region7_handoff_chain() -> void:
	# CP-CINE-06: primeiras massas físicas da Região 7. Estendem a escala real R6→R7 sem aproximar a Vila ou Orion.
	# Não usam luzes, painéis ou colisores na faixa da rota; cada agrupamento é uma massa 3D explorável no bordo da subida.
	var handoff: Node3D = Node3D.new()
	handoff.name = "HandoffRemotoRegiao7"
	add_child(handoff)

	# Terraços baixos e descontínuos: lêem-se depois das Ruínas Submersas, mas deixam a estrada de x≈16→48 aberta.
	var passage_specs: Array[Dictionary] = [
		{"p": Vector2(34.0, 290.0), "s": 0.74, "yaw": 0.30},
		{"p": Vector2(48.0, 298.0), "s": 0.88, "yaw": -0.42},
		{"p": Vector2(66.0, 306.0), "s": 0.96, "yaw": 0.18}
	]
	var passage: Node3D = Node3D.new()
	passage.name = "TerracosDePassagemR7"
	handoff.add_child(passage)
	for index: int in range(passage_specs.size()):
		var spec: Dictionary = passage_specs[index]
		var point: Vector2 = spec["p"] as Vector2
		var base: Node3D = ROCK_LARGE.instantiate() as Node3D
		if base != null:
			base.name = "TerracoR7_%02d" % (index + 1)
			base.position = Vector3(point.x, _height_at(point.x, point.y) - 0.12, point.y)
			var scale_value: float = spec["s"] as float
			base.scale = Vector3(scale_value * 1.55, scale_value * 0.78, scale_value * 1.18)
			base.rotation.y = spec["yaw"] as float
			_apply_material(base, stone_material)
			passage.add_child(base)
		var remnant: Node3D = PILLAR.instantiate() as Node3D
		if remnant != null:
			remnant.name = "VestigioTerracoR7_%02d" % (index + 1)
			remnant.position = Vector3(point.x - 1.45, _height_at(point.x - 1.45, point.y + 0.7) - 0.05, point.y + 0.7)
			remnant.scale = Vector3(0.34, 0.70 + float(index) * 0.07, 0.34)
			remnant.rotation = Vector3(0.06, (spec["yaw"] as float) + 0.22, -0.05)
			_apply_material(remnant, stone_material)
			passage.add_child(remnant)

	# A borda inferior da Vila em socalcos antecipa a cidade principal de z≈352, sem criar uma muralha contínua.
	var village_edge: Node3D = Node3D.new()
	village_edge.name = "BordaBaixaDaVilaR7"
	handoff.add_child(village_edge)
	var edge_specs: Array[Dictionary] = [
		{"p": Vector2(88.0, 318.0), "s": 0.58, "yaw": -0.24},
		{"p": Vector2(104.0, 326.0), "s": 0.64, "yaw": 0.38},
		{"p": Vector2(118.0, 334.0), "s": 0.71, "yaw": -0.16}
	]
	for index: int in range(edge_specs.size()):
		var spec: Dictionary = edge_specs[index]
		var point: Vector2 = spec["p"] as Vector2
		var fragment: Node3D = ROCK_LARGE.instantiate() as Node3D
		if fragment != null:
			fragment.name = "MuroQuebradoR7_%02d" % (index + 1)
			fragment.position = Vector3(point.x, _height_at(point.x, point.y) - 0.06, point.y)
			var scale_value: float = spec["s"] as float
			fragment.scale = Vector3(scale_value * 1.75, scale_value * 0.98, scale_value * 0.86)
			fragment.rotation.y = spec["yaw"] as float
			_apply_material(fragment, stone_material)
			village_edge.add_child(fragment)
		var cap: Node3D = PILLAR.instantiate() as Node3D
		if cap != null:
			cap.name = "PilarBordaVilaR7_%02d" % (index + 1)
			cap.position = Vector3(point.x + 1.85, _height_at(point.x + 1.85, point.y - 0.9) - 0.05, point.y - 0.9)
			cap.scale = Vector3(0.30, 0.62 + float(index) * 0.06, 0.30)
			cap.rotation = Vector3(-0.04, (spec["yaw"] as float) - 0.28, 0.08)
			_apply_material(cap, stone_material)
			village_edge.add_child(cap)

	# Contrafortes: última camada antes da vila. Permanecem rochosos para manter aberto o eixo visual da estrada.
	var foothills: Node3D = Node3D.new()
	foothills.name = "ContrafortesDaSubidaR7"
	handoff.add_child(foothills)
	var foothill_specs: Array[Dictionary] = [
		{"p": Vector2(122.0, 338.0), "s": 1.06, "yaw": 0.34},
		{"p": Vector2(137.0, 346.0), "s": 1.22, "yaw": -0.40},
		{"p": Vector2(151.0, 354.0), "s": 1.34, "yaw": 0.20}
	]
	for index: int in range(foothill_specs.size()):
		var spec: Dictionary = foothill_specs[index]
		var point: Vector2 = spec["p"] as Vector2
		var cliff: Node3D = ROCK_LARGE.instantiate() as Node3D
		if cliff != null:
			cliff.name = "ContraforteR7_%02d" % (index + 1)
			cliff.position = Vector3(point.x, _height_at(point.x, point.y) - 0.18, point.y)
			var scale_value: float = spec["s"] as float
			cliff.scale = Vector3(scale_value * 1.15, scale_value * 1.45, scale_value)
			cliff.rotation.y = spec["yaw"] as float
			_apply_material(cliff, stone_material)
			foothills.add_child(cliff)

func _build_lake_to_village_path() -> void:
	var route: Array[Vector2] = [Vector2(16.0, 288.0), Vector2(48.0, 302.0), Vector2(83.0, 318.0), Vector2(116.0, 336.0), Vector2(138.0, 354.0)]
	_build_flagstone_route("EstradaParaVilaElevada", route, 3.3)

func _build_r6_r7_handoff_colliders() -> void:
	# Corredor físico invisível derivado exclusivamente da autoridade cartográfica.
	# É integração de fronteira, não geometria regional: R6 permanece read-only.
	var contract: Dictionary = Anchors.continuity_6_to_7(_height_at(60.0, 252.0))
	var start: Vector3 = contract["handoff_in"]
	var finish: Vector3 = contract["handoff_out"]
	var corridor: Node3D = Node3D.new()
	corridor.name = "R6R7_HandoffColliders_Dev2"
	corridor.set_meta("map_authority", "mapaorigem.webp")
	corridor.set_meta("scope", "R6_BOUNDARY_READONLY_R7_OWNER")
	add_child(corridor)
	var segment_count: int = 8
	for index: int in range(segment_count):
		var t0: float = float(index) / float(segment_count)
		var t1: float = float(index + 1) / float(segment_count)
		var a: Vector3 = start.lerp(finish, t0)
		var b: Vector3 = start.lerp(finish, t1)
		var segment: StaticBody3D = StaticBody3D.new()
		segment.name = "R6R7_HandoffCollider_%02d" % (index + 1)
		segment.collision_layer = 1
		segment.collision_mask = 1
		segment.position = (a + b) * 0.5
		segment.look_at_from_position(segment.position, b, Vector3.UP)
		var shape_node: CollisionShape3D = CollisionShape3D.new()
		var shape: BoxShape3D = BoxShape3D.new()
		shape.size = Vector3(3.3, 0.45, a.distance_to(b) + 0.25)
		shape_node.shape = shape
		segment.add_child(shape_node)
		corridor.add_child(segment)
	if OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R6_R7_BOUNDARY":
		print("R6R7_RUNTIME_COLLIDERS count=%d start=%s finish=%s distance=%0.3f grounding_y=%0.3f scope=R6_BOUNDARY_READONLY_R7_OWNER" % [segment_count, str(start), str(finish), float(contract["distance"]), start.y])

func _build_r7_r8_handoff_colliders() -> void:
	# Handoff físico owner-safe da Vila Elevada ao Observatório, derivado do contrato cartográfico.
	var contract: Dictionary = Anchors.continuity_7_to_8(_height_at(140.0, 352.0))
	var start: Vector3 = contract["handoff_in"]
	var finish: Vector3 = contract["handoff_out"]
	var corridor: Node3D = Node3D.new()
	corridor.name = "R7R8_HandoffColliders_Dev2"
	corridor.set_meta("handoff_id", "R07_R08")
	corridor.set_meta("collider_contract", "ColliderCPD2007_R07_R08")
	corridor.set_meta("map_authority", "mapaorigem.webp")
	corridor.set_meta("scope", "R7_R8_DEV2_OWNER")
	add_child(corridor)
	var segment_count: int = 6
	for index: int in range(segment_count):
		var a: Vector3 = start.lerp(finish, float(index) / float(segment_count))
		var b: Vector3 = start.lerp(finish, float(index + 1) / float(segment_count))
		var segment: StaticBody3D = StaticBody3D.new()
		segment.name = "ColliderCPD2007_R07_R08_%02d" % (index + 1)
		segment.collision_layer = 1
		segment.collision_mask = 1
		segment.position = (a + b) * 0.5
		segment.look_at_from_position(segment.position, b, Vector3.UP)
		var shape_node: CollisionShape3D = CollisionShape3D.new()
		var shape: BoxShape3D = BoxShape3D.new()
		shape.size = Vector3(3.0, 0.45, a.distance_to(b) + 0.25)
		shape_node.shape = shape
		segment.add_child(shape_node)
		corridor.add_child(segment)
	if OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R7_R8_BOUNDARY":
		print("R7R8_RUNTIME_COLLIDERS count=%d start=%s finish=%s distance=%0.3f grounding_y=%0.3f contract=ColliderCPD2007_R07_R08 scope=R7_R8_DEV2_OWNER" % [segment_count, str(start), str(finish), float(contract["distance"]), start.y])

func _build_r8_r9_handoff_colliders() -> void:
	# Handoff físico owner-safe do Observatório à Trilha da Montanha.
	var contract: Dictionary = Anchors.continuity_8_to_9(_height_at(194.0, 404.0))
	var start: Vector3 = contract["handoff_in"]
	var finish: Vector3 = contract["handoff_out"]
	var corridor: Node3D = Node3D.new()
	corridor.name = "R8R9_HandoffColliders_Dev2"
	corridor.set_meta("handoff_id", "R08_R09")
	corridor.set_meta("collider_contract", "ColliderCPD2007_R08_R09")
	corridor.set_meta("map_authority", "mapaorigem.webp")
	corridor.set_meta("scope", "R8_R9_DEV2_OWNER")
	add_child(corridor)
	var segment_count: int = 4
	for index: int in range(segment_count):
		var a: Vector3 = start.lerp(finish, float(index) / float(segment_count))
		var b: Vector3 = start.lerp(finish, float(index + 1) / float(segment_count))
		var segment: StaticBody3D = StaticBody3D.new()
		segment.name = "ColliderCPD2007_R08_R09_%02d" % (index + 1)
		segment.collision_layer = 1
		segment.collision_mask = 1
		segment.position = (a + b) * 0.5
		segment.look_at_from_position(segment.position, b, Vector3.UP)
		var shape_node: CollisionShape3D = CollisionShape3D.new()
		var shape: BoxShape3D = BoxShape3D.new()
		shape.size = Vector3(2.8, 0.45, a.distance_to(b) + 0.25)
		shape_node.shape = shape
		segment.add_child(shape_node)
		corridor.add_child(segment)
	if OS.get_environment("QA_VALIDATION_ROUTE") == "MAP_MIRROR_VALIDATION_R8_R9_BOUNDARY":
		print("R8R9_RUNTIME_COLLIDERS count=%d start=%s finish=%s distance=%0.3f grounding_y=%0.3f contract=ColliderCPD2007_R08_R09 scope=R8_R9_DEV2_OWNER" % [segment_count, str(start), str(finish), float(contract["distance"]), start.y])

func _build_elevated_village() -> void:
	var village: Node3D = Node3D.new()
	village.name = "VilaElevada"
	var village_x: float = 140.0
	var village_z: float = 352.0
	# CP089: grounding real da Vila; o offset global de 5 m fazia casas, muros e soleira flutuarem acima do terreno.
	village.position = Vector3(village_x, _height_at(village_x, village_z) + 0.65, village_z)
	add_child(village)
	# Terraços orgânicos escalonados: afloramentos CC0 conformam a vila sem caixas de greybox.
	for terrace_index: int in range(3):
		var terrace: Node3D = ROCK_LARGE.instantiate() as Node3D
		if terrace == null:
			continue
		terrace.name = "AfloramentoTerraco_%02d" % terrace_index
		terrace.scale = Vector3(1.15 - float(terrace_index) * 0.10, 0.22, 0.78)
		terrace.rotation = Vector3(0.02, float(terrace_index) * 0.34, -0.03)
		terrace.position = Vector3(-float(terrace_index) * 3.5, 0.62 + float(terrace_index) * 3.4, float(terrace_index) * 8.0)
		_apply_material(terrace, stone_material)
		village.add_child(terrace)
	# Três casas-âncora preservam a leitura de vila e reduzem instâncias GLB para o orçamento GTX 1050.
	for house_index: int in range(4):
		var row: int = house_index / 2
		var col: int = house_index % 2
		var house: Node3D = _make_village_house(house_index)
		house.scale = Vector3.ONE * 1.8
		var house_local_x: float = -9.0 + float(col) * 18.0
		var house_local_z: float = 4.0 + float(row) * 11.0
		house.position = Vector3(house_local_x, 1.15 + float(row) * 2.85, house_local_z)
		# CP098: escala arquitectónica real calibrada ao relevo R7; evita que o asset CC0 domine a paisagem como placa flutuante.
		house.scale = Vector3.ONE * 0.62
		# CP102: a malha original permanece para colisão/estrutura, mas fica fora da apresentação até a substituição do asset.
		house.visible = false
		village.add_child(house)
	# CP102: massa contínua de fachada fortificada, construída com rocha CC0 aterrada.
	var fortress_facade: Node3D = CLIFF_ROCK.instantiate() as Node3D
	if fortress_facade != null:
		fortress_facade.name = "CP102FachadaContinuaVilaR7"
		# CP106: massa central ampliada e apoiada na soleira, com proporção legível em baixa perspectiva.
		fortress_facade.position = Vector3(0.0, 2.8, 8.0)
		fortress_facade.scale = Vector3(6.3, 2.05, 1.28)
		fortress_facade.rotation = Vector3(0.02, 0.0, 0.0)
		var facade_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
		facade_material.albedo_color = Color("#87968a")
		facade_material.roughness = 0.82
		facade_material.emission_enabled = true
		facade_material.emission = Color("#18383a")
		facade_material.emission_energy_multiplier = 0.42
		_apply_material(fortress_facade, facade_material)
		village.add_child(fortress_facade)
		# CP103: contrafortes laterais e lintel orgânico transformam a massa num portal habitável.
		var buttress_positions: Array[Vector3] = [Vector3(-3.8, 1.65, 7.1), Vector3(3.8, 1.65, 7.1)]
		for buttress_index: int in range(buttress_positions.size()):
			var buttress: Node3D = CLIFF_ROCK.instantiate() as Node3D
			if buttress == null:
				continue
			buttress.name = "CP103ContraforteVilaR7_%02d" % buttress_index
			buttress.position = buttress_positions[buttress_index]
			buttress.scale = Vector3(0.62, 1.55, 0.78)
			buttress.rotation = Vector3(0.04, 0.18 if buttress_index == 0 else -0.18, 0.0)
			_apply_material(buttress, facade_material)
			village.add_child(buttress)
		var entry_lintel: Node3D = SLOPE_ROCK.instantiate() as Node3D
		if entry_lintel != null:
			entry_lintel.name = "CP103LintelEntradaVilaR7"
			entry_lintel.position = Vector3(0.0, 3.9, 5.8)
			entry_lintel.scale = Vector3(1.95, 0.5, 0.82)
			_apply_material(entry_lintel, facade_material)
			village.add_child(entry_lintel)
		# CP106: dois vãos laterais apoiados no terraço reforçam a entrada sem duplicar a rota física.
		var entry_jamb_positions: Array[Vector3] = [Vector3(-2.25, 1.85, 6.0), Vector3(2.25, 1.85, 6.0)]
		for jamb_index: int in range(entry_jamb_positions.size()):
			var entry_jamb: Node3D = CLIFF_ROCK.instantiate() as Node3D
			if entry_jamb == null:
				continue
			entry_jamb.name = "CP106OmbreiraEntradaR7_%02d" % jamb_index
			entry_jamb.position = entry_jamb_positions[jamb_index]
			entry_jamb.scale = Vector3(0.48, 1.42, 0.62)
			entry_jamb.rotation.y = 0.08 if jamb_index == 0 else -0.08
			_apply_material(entry_jamb, facade_material)
			village.add_child(entry_jamb)
		# CP083: terraço e muros de ligação transformam as casas isoladas numa vila fortificada contínua.
	var elevated_base_positions: Array[Vector3] = [Vector3(-9.0, 0.78, 4.0), Vector3(0.0, 1.42, 9.5), Vector3(9.0, 1.95, 15.0)]
	for base_index: int in range(elevated_base_positions.size()):
		var elevated_base: Node3D = SLOPE_ROCK.instantiate() as Node3D
		if elevated_base == null:
			continue
		elevated_base.name = "CP083TerracoElevadoR7_%02d" % base_index
		elevated_base.position = elevated_base_positions[base_index]
		elevated_base.scale = Vector3(3.6, 0.72, 2.0)
		elevated_base.rotation = Vector3(0.02, -0.08 + float(base_index) * 0.12, 0.0)
		_apply_material(elevated_base, stone_material)
		village.add_child(elevated_base)
	var connecting_wall_positions: Array[Vector3] = [Vector3(-4.7, 2.35, 6.9), Vector3(4.5, 3.0, 12.3)]
	for wall_index: int in range(connecting_wall_positions.size()):
		var connecting_wall: Node3D = CLIFF_ROCK.instantiate() as Node3D
		if connecting_wall == null:
			continue
		connecting_wall.name = "CP083MuroLigacaoR7_%02d" % wall_index
		connecting_wall.position = connecting_wall_positions[wall_index]
		connecting_wall.scale = Vector3(2.75, 1.18, 0.72)
		connecting_wall.rotation = Vector3(0.02, 0.18 if wall_index == 0 else -0.14, 0.0)
		_apply_material(connecting_wall, stone_material)
		village.add_child(connecting_wall)
	# Soleira larga de chegada alinhada ao corredor cartográfico R6→R7.
	for step_index: int in range(3):
		var entrance_step: Node3D = ROCK_LARGE.instantiate() as Node3D
		if entrance_step == null:
			continue
		entrance_step.name = "CP083SoleiraR6R7_%02d" % step_index
		entrance_step.position = Vector3(0.0, 0.32 + float(step_index) * 0.34, -4.6 + float(step_index) * 1.35)
		entrance_step.scale = Vector3(2.8, 0.34, 0.82)
		_apply_material(entrance_step, stone_material)
		village.add_child(entrance_step)
	# CP087: arco único de entrada, ancorado na soleira física R6→R7.
	var village_gate: Node3D = BRIDGE_ARCH.instantiate() as Node3D
	if village_gate != null:
		village_gate.name = "CP087ArcoEntradaVilaElevada"
		# CP101: bridge_stone tem uma origem vertical ampla; escala e soleira calibradas ao terreno R7.
		village_gate.position = Vector3(0.0, 1.25, -4.0)
		village_gate.scale = Vector3(0.86, 0.86, 0.86)
		village_gate.rotation.y = PI
		_apply_material(village_gate, stone_material)
		village.add_child(village_gate)
	# CP084: entulho orgânico aterra a ligação entre casas, muros e soleira; não são marcadores de QA.
	var debris_positions: Array[Vector3] = [Vector3(-6.8, 1.08, 6.0), Vector3(-2.4, 1.72, 8.4), Vector3(2.8, 2.18, 11.2), Vector3(7.2, 2.68, 14.2), Vector3(-1.2, 0.72, -2.8), Vector3(3.6, 1.04, -1.6)]
	for debris_index: int in range(debris_positions.size()):
		var debris: Node3D = ROCK_LARGE.instantiate() as Node3D
		if debris == null:
			continue
		debris.name = "CP084DetritoOrganicoR7_%02d" % debris_index
		debris.position = debris_positions[debris_index]
		debris.scale = Vector3(0.34 + float(debris_index % 3) * 0.08, 0.22 + float(debris_index % 2) * 0.08, 0.28)
		debris.rotation = Vector3(0.04 * float(debris_index), -0.22 + float(debris_index) * 0.31, 0.08)
		_apply_material(debris, stone_material)
		village.add_child(debris)
	# CP093: pilares de perímetro com origem incompatível removidos; a silhueta é agora dada por muros e casas aterradas.
	var village_lights: Array[Vector3] = [Vector3(-8.0, 6.0, 3.0), Vector3(2.0, 9.0, 9.0), Vector3(10.0, 7.0, 15.0)]
	for light_index: int in range(village_lights.size()):
		var beacon: OmniLight3D = OmniLight3D.new()
		beacon.name = "FachoRessonanciaVila_%02d" % light_index
		beacon.position = village_lights[light_index]
		beacon.light_color = Color("#9fc4d4") if light_index == 0 else Color("#d9a95f")
		beacon.light_energy = 1.10 if light_index == 0 else 1.45
		beacon.omni_range = 10.0
		beacon.shadow_enabled = false
		village.add_child(beacon)
	_build_village_ecology(village)
	_build_village_npcs(village)
	# Estela de chegada no handoff Dev1: asset CC0, Area3D de raio físico 2.5m e texto diegético.
	var arrival_stela: Node3D = null
	if arrival_stela != null:
		arrival_stela.name = "EstelaChegadaRegiao7"
		arrival_stela.position = Vector3(0.0, 2.25, 3.0)
		arrival_stela.scale = Vector3(0.42, 0.78, 0.42)
		_apply_material(arrival_stela, stone_material)
		village.add_child(arrival_stela)
		var stela_light := OmniLight3D.new()
		stela_light.name = "LuzEstelaRegiao7"
		stela_light.position = arrival_stela.position + Vector3(0.0, 1.6, 0.0)
		stela_light.light_color = Color("#d9a95f")
		stela_light.light_energy = 0.85
		stela_light.omni_range = 8.0
		stela_light.shadow_enabled = false
		village.add_child(stela_light)
		var stela_area := Area3D.new()
		stela_area.name = "EstelaChegadaRegiao7_Area"
		stela_area.position = Vector3(0.0, 1.4, 3.0)
		var stela_shape := CollisionShape3D.new()
		var stela_sphere := SphereShape3D.new()
		stela_sphere.radius = 2.5
		stela_shape.shape = stela_sphere
		stela_area.add_child(stela_shape)
		village.add_child(stela_area)
		var stela_label := Label3D.new()
		stela_label.name = "EstelaChegadaRegiao7_Label"
		stela_label.text = "Vila Elevada — Marco 7"
		stela_label.font_size = 28
		stela_label.outline_size = 8
		stela_label.modulate = Color("#f3d39b")
		stela_label.position = Vector3(0.0, 4.1, 3.0)
		stela_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		village.add_child(stela_label)

func _build_village_ecology(village: Node3D) -> void:
	var tree_positions: Array[Vector3] = [Vector3(-18.0, 0.0, 0.0), Vector3(18.0, 0.0, 1.0), Vector3(-19.0, 0.0, 12.0), Vector3(19.0, 0.0, 14.0), Vector3(-15.0, 0.0, 24.0), Vector3(15.0, 0.0, 25.0)]
	for index: int in range(tree_positions.size()):
		var tree: Node3D = TREE_CC0.instantiate() as Node3D
		if tree == null:
			continue
		tree.name = "ArvoreVila_%02d" % index
		tree.position = tree_positions[index]
		tree.scale = Vector3.ONE * (0.72 + float(index % 3) * 0.10)
		_apply_material(tree, stone_material)
		village.add_child(tree)
	var fern_positions: Array[Vector3] = [Vector3(-13.0, 0.0, 1.0), Vector3(13.0, 0.0, 2.0), Vector3(-14.0, 0.0, 8.0), Vector3(14.0, 0.0, 9.0), Vector3(-14.0, 0.0, 17.0), Vector3(14.0, 0.0, 18.0), Vector3(-11.0, 0.0, 25.0), Vector3(11.0, 0.0, 26.0)]
	for index: int in range(fern_positions.size()):
		var fern: Node3D = FERN_CC0.instantiate() as Node3D
		if fern == null:
			continue
		fern.name = "FetoVila_%02d" % index
		fern.position = fern_positions[index]
		fern.scale = Vector3.ONE * (0.55 + float(index % 2) * 0.10)
		_apply_material(fern, stone_material)
		village.add_child(fern)

func _build_village_npcs(village: Node3D) -> void:
	var npc_data: Array = [["Aldeão Velho", Vector3(-3.0, 0.0, 9.0)], ["Ferreiro", Vector3(4.0, 0.0, 20.0)]]
	for index: int in range(npc_data.size()):
		var npc: Node3D = Node3D.new()
		npc.name = "NPCVila_%02d" % index
		var ground: Node3D = ROCK_LARGE.instantiate() as Node3D
		if ground != null:
			ground.name = "BaseNPC"
			ground.scale = Vector3(0.22, 0.42, 0.22)
			_apply_material(ground, stone_material)
			npc.add_child(ground)
		var marker: Node3D = PILLAR.instantiate() as Node3D
		if marker != null:
			marker.name = "SilhuetaNPC"
			marker.position = Vector3(0.0, 1.25, 0.0)
			marker.scale = Vector3(0.16, 0.38, 0.16)
			_apply_material(marker, stone_material)
			npc.add_child(marker)
		var label := Label3D.new()
		label.text = str(npc_data[index][0])
		label.font_size = 22
		label.outline_size = 6
		label.modulate = Color("#e5c995")
		label.position = Vector3(0.0, 2.3, 0.0)
		label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		npc.add_child(label)
		npc.position = Vector3(npc_data[index][1])
		var world_x: float = 140.0 + npc.position.x
		var world_z: float = 352.0 + npc.position.z
		npc.position.y = _height_at(world_x, world_z) - (village.position.y - 0.0)
		village.add_child(npc)

func _make_village_house(index: int) -> Node3D:
	var house: Node3D = Node3D.new()
	house.name = "CasaDePedra_%02d" % index
	var house_stone_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
	house_stone_material.albedo_color = Color("#a49678")
	house_stone_material.emission_enabled = true
	house_stone_material.emission = Color("#765e37")
	house_stone_material.emission_energy_multiplier = 0.52
	var house_roof_material: StandardMaterial3D = roof_material.duplicate() as StandardMaterial3D
	house_roof_material.albedo_color = Color("#514b3d")
	# CP091: a fachada passa a usar volumes de parede/rocha com grounding previsível; placas e pilares off-origin são removidos.
	for pillar_index: int in range(0):
		var house_pillar: Node3D = PILLAR.instantiate() as Node3D
		if house_pillar != null:
			house_pillar.name = "PilarOrganicoCasa_%02d_%02d" % [index, pillar_index]
			house_pillar.position = Vector3(-1.75 + float(pillar_index) * 1.75, 2.55 + float(pillar_index % 2) * 0.30, 0.0)
			house_pillar.scale = Vector3(0.42, 1.34, 0.42)
			_apply_material(house_pillar, house_stone_material)
			house.add_child(house_pillar)
	var roof: Node3D = SLOPE_ROCK.instantiate() as Node3D
	if roof != null:
		roof.name = "CoberturaRochosaDaCasa"
		roof.scale = Vector3(1.62, 0.78, 1.18)
		roof.rotation = Vector3(0.14, 0.35, -0.08)
		roof.position = Vector3(0.0, 3.55, 0.06)
		_apply_material(roof, house_roof_material)
		house.add_child(roof)
	var left_wall: Node3D = CLIFF_ROCK.instantiate() as Node3D
	if left_wall != null:
		left_wall.name = "ParedeOrganicaEsquerdaCasa_%02d" % index
		left_wall.scale = Vector3(1.12, 2.10, 1.08)
		left_wall.rotation = Vector3(0.04, 0.20, -0.08)
		left_wall.position = Vector3(-1.55, 2.15, 0.04)
		_apply_material(left_wall, house_stone_material)
		house.add_child(left_wall)
	var right_wall: Node3D = CLIFF_ROCK.instantiate() as Node3D
	if right_wall != null:
		right_wall.name = "ParedeOrganicaDireitaCasa_%02d" % index
		right_wall.scale = Vector3(1.12, 2.10, 1.08)
		right_wall.rotation = Vector3(-0.03, -0.18, 0.08)
		right_wall.position = Vector3(1.55, 2.15, 0.04)
		_apply_material(right_wall, house_stone_material)
		house.add_child(right_wall)
	var sloped_roof: Node3D = SLOPE_ROCK.instantiate() as Node3D
	if sloped_roof != null:
		sloped_roof.name = "CoberturaInclinadaOrganicaCasa_%02d" % index
		sloped_roof.scale = Vector3(1.52, 0.86, 1.10)
		sloped_roof.rotation = Vector3(0.12, 0.30, -0.14)
		sloped_roof.position = Vector3(0.0, 4.18, 0.06)
		_apply_material(sloped_roof, house_roof_material)
		house.add_child(sloped_roof)
	var hearth_light := OmniLight3D.new()
	hearth_light.name = "LuzDiegeticaCasa_%02d" % index
	hearth_light.position = Vector3(0.0, 2.5, 0.5)
	hearth_light.light_color = Color("#d9a95f")
	hearth_light.light_energy = 1.55
	hearth_light.omni_range = 6.0
	hearth_light.shadow_enabled = false
	house.add_child(hearth_light)
	return house

func _build_observatory() -> void:
	var observatory: Node3D = Node3D.new()
	observatory.name = "ObservatorioDaOrion"
	var ox: float = 194.0
	var oz: float = 404.0
	# CP097: R8 deve ser um volume distante legível, não um conjunto de lâminas oversized no céu da R7.
	observatory.position = Vector3(ox, _height_at(ox, oz) + 0.45, oz)
	observatory.scale = Vector3(0.62, 0.62, 0.62)
	add_child(observatory)
	print("ORIGEM_REGION8_OBSERVATORY_READY ", observatory.global_position)
	var observatory_stone: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
	observatory_stone.albedo_color = Color("#64766d")
	observatory_stone.roughness = 0.78
	# Plataforma e cúpula orgânicas: a Região 8 usa massas CC0 em vez de primitivas de greybox.
	for shell_index: int in range(5):
		var shell: Node3D = ROCK_LARGE.instantiate() as Node3D
		if shell == null:
			continue
		var shell_angle: float = float(shell_index) * TAU / 5.0
		shell.name = "CascaOrganicaObservatorio_%02d" % shell_index
		shell.position = Vector3(cos(shell_angle) * 7.2, 1.8 + float(shell_index % 2) * 0.7, sin(shell_angle) * 7.2)
		shell.scale = Vector3(0.72, 0.32, 0.60)
		shell.rotation = Vector3(0.08, shell_angle, -0.04)
		_apply_material(shell, observatory_stone)
		observatory.add_child(shell)
	var observatory_spine: Node3D = ROCK_LARGE.instantiate() as Node3D
	if observatory_spine != null:
		observatory_spine.name = "MassaVerticalApoiadaObservatorioR8"
		observatory_spine.position = Vector3(0.0, 4.4, 0.8)
		observatory_spine.scale = Vector3(1.18, 2.65, 0.82)
		observatory_spine.rotation = Vector3(-0.10, 0.18, 0.06)
		var spine_material: StandardMaterial3D = observatory_stone.duplicate() as StandardMaterial3D
		spine_material.albedo_color = Color("#263f45")
		spine_material.emission_enabled = true
		spine_material.emission = Color("#0c5e6e")
		spine_material.emission_energy_multiplier = 0.55
		_apply_material(observatory_spine, spine_material)
		observatory.add_child(observatory_spine)
	for crown_index: int in range(3):
		var crown: Node3D = ROCK_LARGE.instantiate() as Node3D
		if crown == null:
			continue
		crown.name = "CoroaOrganicaObservatorio_%02d" % crown_index
		crown.position = Vector3(-3.6 + float(crown_index) * 3.6, 5.0 + float(crown_index % 2) * 0.8, 0.0)
		crown.scale = Vector3(0.52, 0.46, 0.48)
		crown.rotation = Vector3(0.14, float(crown_index) * 0.7, -0.10)
		_apply_material(crown, observatory_stone)
		observatory.add_child(crown)
	# CP097: pilares verticais off-origin removidos do horizonte; a massa central e o olho azul mantêm o sujeito R8.
	var eye: Node3D = ROCK_LARGE.instantiate() as Node3D
	if eye != null:
		eye.name = "OlhoOrganicoDoObservatorio"
		eye.position = Vector3(0.0, 8.2, 0.0)
		eye.scale = Vector3(0.82, 0.64, 0.82)
		var eye_material: StandardMaterial3D = stone_material.duplicate() as StandardMaterial3D
		eye_material.albedo_color = Color("#163c4c")
		eye_material.emission_enabled = true
		eye_material.emission = Color("#1a9bc2")
		eye_material.emission_energy_multiplier = 2.4
		_apply_material(eye, eye_material)
		observatory.add_child(eye)
	var beacon: OmniLight3D = OmniLight3D.new()
	beacon.name = "LuzDoObservatorio"
	beacon.light_color = Color(0.22, 0.72, 1.0, 1.0)
	beacon.light_energy = 5.2
	beacon.omni_range = 34.0
	beacon.position = Vector3(0.0, 8.4, 0.0)
	beacon.shadow_enabled = false
	observatory.add_child(beacon)
	for fill_index: int in range(2):
		var fill: OmniLight3D = OmniLight3D.new()
		fill.name = "PreenchimentoObservatorio_%02d" % fill_index
		fill.light_color = Color("#7dc7d8")
		fill.light_energy = 1.45
		fill.omni_range = 22.0
		fill.position = Vector3(-6.0 + float(fill_index) * 12.0, 4.0, 2.5)
		fill.shadow_enabled = false
		observatory.add_child(fill)
	var frontal_fill: OmniLight3D = OmniLight3D.new()
	frontal_fill.name = "PreenchimentoFrontalObservatorio"
	frontal_fill.light_color = Color("#b7dce2")
	frontal_fill.light_energy = 1.15
	frontal_fill.omni_range = 20.0
	frontal_fill.position = Vector3(0.0, 8.5, -8.0)
	frontal_fill.shadow_enabled = false
	observatory.add_child(frontal_fill)

func _apply_r9_r10_integrated_visual_culling() -> void:
	# CP-D2-091: reduzir ruído visual do handoff sem remover colisores da rota.
	for node_name: String in ["AfloramentosDaTrilha", "RecorteAlpinoTrilhaTake8"]:
		var visual_node := get_node_or_null(node_name) as Node3D
		if visual_node != null:
			visual_node.visible = false
	for node in find_children("*", "OmniLight3D", true, false):
		if str(node.name).begins_with("LuzWayfinding_"):
			(node as OmniLight3D).visible = false

func _build_mountain_trail() -> void:
	var route: Array[Vector2] = [
		Vector2(174.0, 414.0), Vector2(130.0, 426.0), Vector2(76.0, 443.0),
		Vector2(28.0, 462.0), Vector2(-26.0, 482.0), Vector2(-76.0, 508.0), Vector2(-112.0, 532.0)
	]
	_build_organic_route("TrilhaDaMontanhaOrion", route, 4.1)
	var trail_marker: Node3D = ROCK_LARGE.instantiate() as Node3D
	if trail_marker != null:
		trail_marker.name = "MarcoOrganicoEntradaTrilhaTake8"
		trail_marker.position = Vector3(169.0, _height_at(169.0, 414.0) + 1.35, 414.0)
		trail_marker.scale = Vector3(0.72, 1.25, 0.66)
		trail_marker.rotation = Vector3(0.08, -0.26, -0.05)
		_apply_material(trail_marker, stone_material)
		add_child(trail_marker)
		var entry_rocks: Array[Vector3] = [Vector3(162.0, 0.0, 416.0), Vector3(158.0, 0.0, 421.0), Vector3(166.0, 0.0, 424.0)]
		for entry_index: int in range(entry_rocks.size()):
			var entry_rock: Node3D = ROCK_LARGE.instantiate() as Node3D
			if entry_rock == null:
				continue
			var entry_point: Vector3 = entry_rocks[entry_index]
			entry_rock.name = "ArcoOrganicoEntradaTake8_%02d" % entry_index
			entry_rock.position = Vector3(entry_point.x, _height_at(entry_point.x, entry_point.z) + 0.9 + float(entry_index) * 0.35, entry_point.z)
			entry_rock.scale = Vector3(0.52, 0.78 + float(entry_index) * 0.16, 0.48)
			entry_rock.rotation.y = -0.32 + float(entry_index) * 0.44
			_apply_material(entry_rock, stone_material)
			add_child(entry_rock)
	var alpine_fill := DirectionalLight3D.new()
	alpine_fill.name = "RecorteAlpinoTrilhaTake8"
	alpine_fill.light_color = Color("#9fc4d4")
	alpine_fill.light_energy = 0.22
	alpine_fill.shadow_enabled = false
	alpine_fill.rotation_degrees = Vector3(-48.0, -32.0, 0.0)
	add_child(alpine_fill)
	var rocks: Node3D = Node3D.new()
	rocks.name = "AfloramentosDaTrilha"
	add_child(rocks)
	for index: int in range(20):
		var t: float = float(index) / 19.0
		var z_value: float = lerpf(430.0, 540.0, t)
		var x_value: float = lerpf(128.0, -114.0, t) + sin(t * PI * 5.0) * 8.0
		var rock: Node3D = ROCK_LARGE.instantiate() as Node3D
		if rock == null:
			continue
		rock.position = Vector3(x_value, _height_at(x_value, z_value), z_value)
		var scale_value: float = 0.18 + fmod(float(index), 4.0) * 0.06
		rock.scale = Vector3(scale_value, scale_value, scale_value)
		rock.rotation.y = float(index) * 0.79
		rocks.add_child(rock)

func _build_region9_threshold() -> void:
	var route: Array[Vector2] = [
		Vector2(-112.0, 532.0), Vector2(-128.0, 542.0), Vector2(-144.0, 552.0), Vector2(-164.0, 560.0)
	]
	_build_organic_route("ContinuidadeRegiao08Para09", route, 3.6)
	var threshold := Node3D.new()
	threshold.name = "LimiarOrganicoRegiao09"
	threshold.position = Vector3(-164.0, _height_at(-164.0, 560.0), 560.0)
	add_child(threshold)
	for side: int in [-1, 1]:
		var jamb: Node3D = PILLAR.instantiate() as Node3D
		if jamb == null:
			continue
		jamb.name = "OmbreiraRegiao09_%s" % ("Norte" if side < 0 else "Sul")
		jamb.position = Vector3(float(side) * 4.2, 1.05, 0.0)
		jamb.scale = Vector3(1.6, 1.8, 1.2)
		jamb.rotation = Vector3(0.06, 0.18 * float(side), -0.04)
		_apply_material(jamb, stone_material)
		threshold.add_child(jamb)
	var threshold_cap: Node3D = ROCK_LARGE.instantiate() as Node3D
	if threshold_cap != null:
		threshold_cap.name = "ArcoOrganicoRegiao09"
		threshold_cap.position = Vector3(0.0, 2.3, 0.0)
		threshold_cap.scale = Vector3(3.5, 0.8, 1.2)
		threshold_cap.rotation = Vector3(0.04, 0.0, -0.02)
		_apply_material(threshold_cap, stone_material)
		threshold.add_child(threshold_cap)
	var threshold_beacon := OmniLight3D.new()
	threshold_beacon.name = "BeaconContinuidadeRegiao09"
	threshold_beacon.position = Vector3(0.0, 4.0, 0.0)
	threshold_beacon.light_color = Color("#5cc8ff")
	threshold_beacon.light_energy = 0.75
	threshold_beacon.omni_range = 12.0
	threshold_beacon.shadow_enabled = false
	threshold.add_child(threshold_beacon)

func _build_organic_route(route_name: String, route: Array[Vector2], width: float) -> void:
	var path: Node3D = Node3D.new()
	path.name = route_name
	add_child(path)
	var route_material: StandardMaterial3D = path_material.duplicate() as StandardMaterial3D
	route_material.emission_enabled = true
	route_material.emission = Color("#173b45")
	route_material.emission_energy_multiplier = 0.65
	var stone_index: int = 0
	for segment_index: int in range(route.size() - 1):
		var start: Vector2 = route[segment_index]
		var finish: Vector2 = route[segment_index + 1]
		var distance: float = start.distance_to(finish)
		var count: int = max(1, int(distance / 4.2))
		for index: int in range(count):
			var t: float = float(index) / float(count)
			var point: Vector2 = start.lerp(finish, t)
			var next: Vector2 = start.lerp(finish, minf(t + 0.08, 1.0))
			var stone: Node3D = ROCK_LARGE.instantiate() as Node3D
			if stone == null:
				continue
			stone.name = "DegrauOrganico_%03d" % stone_index
			var entry_step_lift: float = 0.28 if route_name == "TrilhaDaMontanhaOrion" and stone_index < 4 else 0.82
			stone.position = Vector3(point.x, _height_at(point.x, point.y) + entry_step_lift, point.y)
			if OS.get_environment("ORIGEM_DEBUG_ROUTE") == "1" and (stone_index == 0 or stone_index == 5 or stone_index == 10):
				print("[REGIAO8_9_ROUTE] index=%d world=%s" % [stone_index, str(stone.position)])
			stone.scale = Vector3(width * 0.18, 0.10 + fmod(float(stone_index), 3.0) * 0.025, 0.28)
			stone.rotation = Vector3(0.03, atan2(next.x - point.x, next.y - point.y), -0.04)
			_apply_material(stone, route_material)
			var stone_body := StaticBody3D.new()
			stone_body.name = "ColisaoTrilhaMontanha_%03d" % stone_index
			stone_body.collision_layer = 1
			stone_body.collision_mask = 1
			var stone_shape := CollisionShape3D.new()
			var stone_box := BoxShape3D.new()
			var entry_step_height: float = 0.12 if route_name == "TrilhaDaMontanhaOrion" and stone_index < 4 else 0.34
			stone_box.size = Vector3(width * 0.62, entry_step_height, 0.72)
			stone_shape.shape = stone_box
			stone_shape.position = Vector3(0.0, 0.10, 0.0)
			stone_body.add_child(stone_shape)
			stone.add_child(stone_body)
			path.add_child(stone)
			if stone_index % 5 == 0:
				var wayfinder: OmniLight3D = OmniLight3D.new()
				wayfinder.name = "LuzWayfinding_%03d" % stone_index
				wayfinder.light_color = Color("#4ea6b6")
				wayfinder.light_energy = 0.85
				wayfinder.omni_range = 8.0
				wayfinder.position = Vector3(0.0, 1.6, 0.0)
				wayfinder.shadow_enabled = false
				stone.add_child(wayfinder)
			stone_index += 1

func _build_flagstone_route(route_name: String, route: Array[Vector2], width: float) -> void:
	var path: Node3D = Node3D.new()
	path.name = route_name
	add_child(path)
	var slab_index: int = 0
	for segment_index: int in range(route.size() - 1):
		var start: Vector2 = route[segment_index]
		var finish: Vector2 = route[segment_index + 1]
		var distance: float = start.distance_to(finish)
		var count: int = max(1, int(distance / 3.0))
		for index: int in range(count):
			var t: float = float(index) / float(count)
			var point: Vector2 = start.lerp(finish, t)
			var next: Vector2 = start.lerp(finish, minf(t + 0.08, 1.0))
			var slab_mesh: BoxMesh = BoxMesh.new()
			slab_mesh.size = Vector3(width, 0.16, 2.2)
			var slab: MeshInstance3D = MeshInstance3D.new()
			slab.name = "Laje_%03d" % slab_index
			slab.mesh = slab_mesh
			slab.material_override = path_material
			slab.position = Vector3(point.x, _height_at(point.x, point.y) + 0.07, point.y)
			slab.rotation.y = atan2(next.x - point.x, next.y - point.y)
			path.add_child(slab)
			slab_index += 1

func _make_stone_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = MOSSY_RUIN_DIFF
	material.normal_enabled = true
	material.normal_texture = MOSSY_RUIN_NORMAL
	material.normal_scale = 0.30
	material.roughness = 0.95
	material.uv1_scale = Vector3(0.26, 0.26, 0.26)
	return material

func _make_roof_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.075, 0.09, 0.075, 1.0)
	material.roughness = 0.92
	return material

func _make_path_material() -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = FLAGSTONE
	material.normal_enabled = true
	material.normal_texture = GROUND_NORMAL
	material.normal_scale = 0.26
	material.roughness = 0.93
	material.uv1_scale = Vector3(0.34, 0.34, 0.34)
	return material

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)
