extends Node3D

## Região 12 traversal harness: normal builder branches remain visible.
## This is a validation scene only; it does not modify Regions 1–6.

const DESTINATION_SCRIPT: Script = preload("res://levels/OrionDestinationRegion.gd")
const TERRAIN_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const ROCK_LARGE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const PILLAR: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
var camera: Camera3D
var elapsed: float = 0.0
var destination: Node3D
var recess_resonance_light: OmniLight3D
var performance_sample_timer: float = 0.0

func _ready() -> void:
	_build_environment()
	var terrain := TERRAIN_SCRIPT.new() as Node3D
	terrain.name = "TerrainPatchRegiao12Traversal"
	terrain.visible = false
	add_child(terrain)
	# A validação não usa uma plataforma cilíndrica como silhueta final; a base é composta por massas CC0 baixas.
	var traversal_base := Node3D.new()
	traversal_base.name = "BaseOrganicaTravessiaRegiao12"
	traversal_base.position = Vector3(164.0, 0.0, 186.0)
	add_child(traversal_base)
	var base_positions: Array[Vector3] = [
		Vector3(-10.0, 0.18, 0.0), Vector3(-6.0, 0.10, 3.2), Vector3(-1.8, 0.08, 4.0),
		Vector3(3.2, 0.12, 3.6), Vector3(7.6, 0.16, 1.2), Vector3(10.0, 0.10, -2.0), Vector3(0.0, 0.05, -1.2)
	]
	for index: int in range(base_positions.size()):
		var base_stone := ROCK_LARGE.instantiate() as Node3D
		if base_stone == null:
			continue
		base_stone.name = "MassaBaseOrganicaR12_%02d" % index
		base_stone.position = base_positions[index]
		base_stone.scale = Vector3(1.45 + float(index % 3) * 0.22, 0.34 + float(index % 2) * 0.12, 1.10 + float(index % 2) * 0.18)
		base_stone.rotation = Vector3(0.03 * float(index % 2), float(index) * 0.47, -0.02 * float(index % 3))
		traversal_base.add_child(base_stone)
	destination = DESTINATION_SCRIPT.new() as Node3D
	destination.name = "DestinosOrionRegiao12Traversal"
	add_child(destination)
	await get_tree().process_frame
	var hub := destination.get_node_or_null("HubTemporal") as Node3D
	if hub != null:
		var hub_core := hub.get_node_or_null("NucleoTemporal") as Node3D
		if hub_core != null:
			hub_core.visible = false
	var dome := destination.get_node_or_null("CupulaFinal") as Node3D
	if dome != null:
		# Dedicated validation isolates the proxy; the integrated builder remains unchanged in OrionDestinationRegion.gd.
		dome.visible = false
		dome.position += Vector3(0.0, 1.6, 0.0)
		var dome_light := OmniLight3D.new()
		dome_light.name = "FinalDomeApproachLight"
		dome_light.light_color = Color("#8bc7ff")
		dome_light.light_energy = 1.0

		dome_light.omni_range = 22.0
		dome_light.position = dome.position + Vector3(0.0, 4.0, 1.5)
		add_child(dome_light)
		_dampen_emissive_landmarks(destination)
		destination.visible = false
		_build_final_dome_traversal_proxy()
	var traversal_proxy := get_node_or_null("CupulaFinalTraversalOrganicReveal") as Node3D
	if traversal_proxy != null:
		# Dedicated Region 12 visual correction: enlarge the organic sanctuary for a readable cinematic take.
		traversal_proxy.visible = true
	_build_region12_wayfinding_lights()
	_build_region12_recess_resonance()
	_build_region12_cinematic_fill()
	camera = Camera3D.new()
	camera.name = "Region12TraversalCamera"
	camera.fov = 50.0
	add_child(camera)
	camera.current = true
	_set_camera(0.0)

func _build_region12_wayfinding_lights() -> void:
	var wayfinding_positions: Array[Vector3] = [
		Vector3(164.0, 0.95, 181.5),
		Vector3(163.8, 1.05, 179.8),
		Vector3(164.2, 1.15, 178.2),
		Vector3(164.0, 0.82, 171.9)
	]
	for index: int in range(wayfinding_positions.size()):
		var waypoint_light := OmniLight3D.new()
		waypoint_light.name = "LuzWayfindingR12_%02d" % index
		waypoint_light.light_color = Color("#58b9d6" if index < 3 else "#7f6bd6")
		waypoint_light.light_energy = 1.35 if index < 3 else 0.48
		waypoint_light.omni_range = 5.6 if index < 3 else 4.6
		waypoint_light.shadow_enabled = false
		waypoint_light.position = wayfinding_positions[index]
		add_child(waypoint_light)
		var resonance_core := MeshInstance3D.new()
		resonance_core.name = "NucleoWayfindingR12_%02d" % index
		var resonance_mesh := SphereMesh.new()
		resonance_mesh.radius = 0.11 if index < 3 else 0.09
		resonance_mesh.height = 0.22 if index < 3 else 0.18
		resonance_core.mesh = resonance_mesh
		var resonance_material := StandardMaterial3D.new()
		resonance_material.albedo_color = Color("#58b9d6" if index < 3 else "#8e7be0")
		resonance_material.emission_enabled = true
		resonance_material.emission = resonance_material.albedo_color
		resonance_material.emission_energy_multiplier = 7.0 if index < 3 else 2.4
		resonance_core.material_override = resonance_material
		resonance_core.position = wayfinding_positions[index] + Vector3(0.0, 0.10, 0.0)
		resonance_core.visible = index < 3
		add_child(resonance_core)

func _build_region12_recess_resonance() -> void:
	var recess_light := OmniLight3D.new()
	recess_resonance_light = recess_light
	recess_light.name = "RessonanciaRecessivoCupulaR12"
	recess_light.light_color = Color("#3c8fb5")
	recess_light.light_energy = 0.24
	recess_light.omni_range = 2.8
	recess_light.shadow_enabled = false
	recess_light.position = Vector3(164.0, 2.25, 173.0)
	add_child(recess_light)

func _build_region12_cinematic_fill() -> void:
	var rim_light := DirectionalLight3D.new()
	rim_light.name = "RecorteFrioCinematicoR12"
	rim_light.light_color = Color("#8fb7d6")
	rim_light.light_energy = 0.32
	rim_light.shadow_enabled = true
	rim_light.directional_shadow_max_distance = 28.0
	rim_light.rotation = Vector3(deg_to_rad(-48.0), deg_to_rad(-28.0), deg_to_rad(-12.0))
	add_child(rim_light)
	# Passe contínuo: recorte quente de baixa energia para separar a soleira e a rocha CC0 do núcleo violeta.
	var warm_fill := DirectionalLight3D.new()
	warm_fill.name = "RecorteQuenteSoleiraR12"
	warm_fill.light_color = Color("#c18b68")
	warm_fill.light_energy = 0.12
	warm_fill.shadow_enabled = false
	warm_fill.rotation = Vector3(deg_to_rad(-24.0), deg_to_rad(148.0), deg_to_rad(8.0))
	add_child(warm_fill)
	for local_x in [-2.2, 2.2]:
		var threshold_fill := OmniLight3D.new()
		threshold_fill.name = "PreenchimentoQuenteSoleira_%s" % str(local_x)
		threshold_fill.light_color = Color("#d39363")
		threshold_fill.light_energy = 0.42
		threshold_fill.omni_range = 7.0
		threshold_fill.shadow_enabled = false
		threshold_fill.position = Vector3(164.0 + local_x, 1.35, 173.9)
		add_child(threshold_fill)

func _dampen_emissive_landmarks(root: Node) -> void:
	for child in root.get_children():
		if child is OmniLight3D and (child.name.contains("Nucleo") or child.name.contains("Heart")):
			(child as OmniLight3D).light_energy = 0.35
		if child is MeshInstance3D and (child.name.contains("Nucleo") or child.name.contains("Heart")):
			(child as Node3D).scale *= 0.38
			if child.name == "NucleoCoroaFinal":
				(child as Node3D).visible = false
		_dampen_emissive_landmarks(child)

func _build_final_dome_traversal_proxy() -> void:
	var proxy := Node3D.new()
	proxy.name = "CupulaFinalTraversalOrganicReveal"
	proxy.position = Vector3(164.0, -0.85, 178.0)
	proxy.scale = Vector3(1.28, 1.28, 1.28)
	add_child(proxy)
	for index: int in range(7):
		var angle: float = float(index) * TAU / 7.0
		var pillar := PILLAR.instantiate() as Node3D
		if pillar == null:
			continue
		pillar.name = "PilarTravessiaCupula_%02d" % index
		pillar.position = Vector3(cos(angle) * 6.2, 0.95 + float(index % 2) * 0.22, sin(angle) * 6.2)
		pillar.scale = Vector3(0.95, 1.35 + float(index % 3) * 0.12, 0.95)
		pillar.rotation = Vector3(0.04 * sin(angle), angle, 0.04 * cos(angle))
		pillar.visible = false
		proxy.add_child(pillar)
	var left_arch := ROCK_LARGE.instantiate() as Node3D
	var right_arch := ROCK_LARGE.instantiate() as Node3D
	var crown := ROCK_LARGE.instantiate() as Node3D
	if left_arch != null:
		left_arch.name = "ArcoOrganicoEsquerdo"
		left_arch.position = Vector3(-2.35, 2.15, -4.38)
		left_arch.scale = Vector3(1.35, 2.55, 1.45)
		left_arch.rotation = Vector3(0.0, -0.08, 0.0)
		left_arch.visible = true
		proxy.add_child(left_arch)
	if right_arch != null:
		right_arch.name = "ArcoOrganicoDireito"
		right_arch.position = Vector3(2.35, 2.15, -4.38)
		right_arch.scale = Vector3(1.35, 2.55, 1.45)
		right_arch.rotation = Vector3(0.0, 0.08, 0.0)
		right_arch.visible = true
		proxy.add_child(right_arch)
		if crown != null:
			crown.name = "ArcoOrganicoCoroa"
			crown.visible = true
			crown.position = Vector3(0.0, 2.86, -4.34)
			crown.scale = Vector3(1.48, 0.78, 1.16)
			crown.rotation = Vector3(-0.22, 0.08, 0.06)
			proxy.add_child(crown)

	var lintel := ROCK_LARGE.instantiate() as Node3D
	if lintel != null:
		lintel.name = "LintelOrganicoCupulaFinal"
		lintel.position = Vector3(0.0, 2.72, -4.18)
		lintel.scale = Vector3(3.15, 1.08, 1.7)
		lintel.rotation = Vector3(0.0, 0.0, 0.02)
		lintel.visible = true
		proxy.add_child(lintel)
	for support_x in [-0.9, 0.9]:
		var center_support := PILLAR.instantiate() as Node3D
		if center_support == null:
			continue
		center_support.name = "SuporteCentralCupula_%s" % str(support_x)
		center_support.position = Vector3(support_x, 1.52, -4.05)
		center_support.scale = Vector3(0.78, 1.28, 0.78)
		center_support.rotation = Vector3(0.03, 0.08 * sign(support_x), -0.02)
		center_support.visible = true
		proxy.add_child(center_support)
	for shoulder_x in [-3.2, 3.2]:
		var shoulder := ROCK_LARGE.instantiate() as Node3D
		if shoulder == null:
			continue
		shoulder.name = "OmbroOrganicoCupula_%s" % str(shoulder_x)
		shoulder.position = Vector3(shoulder_x, 2.15, -4.1)
		shoulder.scale = Vector3(2.35, 0.82, 1.65)
		shoulder.rotation = Vector3(0.0, 0.12 * sign(shoulder_x), 0.03 * sign(shoulder_x))
		shoulder.visible = true
		proxy.add_child(shoulder)
	for connector_x in [-2.1, 2.1]:
		var connector := ROCK_LARGE.instantiate() as Node3D
		if connector == null:
			continue
		connector.name = "ConectorCoroaCupula_%s" % str(connector_x)
		connector.position = Vector3(connector_x, 2.48 + 0.08 * sign(connector_x), -4.30)
		connector.scale = Vector3(1.45, 0.78, 1.28)
		connector.rotation = Vector3(0.05 * sign(connector_x), 0.18 * sign(connector_x), 0.08 * sign(connector_x))
		connector.visible = true
		proxy.add_child(connector)
	for jamb_x in [-2.45, 2.45]:
		var jamb := ROCK_LARGE.instantiate() as Node3D
		if jamb == null:
			continue
		jamb.name = "JambaArcoCupula_%s" % str(jamb_x)
		jamb.position = Vector3(jamb_x * 1.08, 1.9, -4.35)
		jamb.scale = Vector3(0.92, 1.42, 1.16)
		jamb.rotation = Vector3(0.04, 0.12 * sign(jamb_x), 0.04 * sign(jamb_x))
		jamb.visible = true
		proxy.add_child(jamb)
	var recessed_backdrop := ROCK_LARGE.instantiate() as Node3D
	if recessed_backdrop != null:
		recessed_backdrop.name = "FundoOrganicoRecuadoCupula"
		recessed_backdrop.position = Vector3(0.0, 2.75, -5.05)
		recessed_backdrop.scale = Vector3(1.35, 0.82, 0.24)
		recessed_backdrop.rotation = Vector3(0.0, PI, 0.0)
		var backdrop_material := StandardMaterial3D.new()
		backdrop_material.albedo_color = Color("#0d1420")
		backdrop_material.roughness = 1.0
		backdrop_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		
		recessed_backdrop.visible = true
		proxy.add_child(recessed_backdrop)
	for monument_x in [-4.2, 4.2]:
		var monument := PILLAR.instantiate() as Node3D
		if monument == null:
			continue
		monument.name = "MonolitoEscalaCupula_%s" % str(monument_x)
		monument.position = Vector3(monument_x, 2.75, -4.45)
		monument.scale = Vector3(0.96, 3.45, 0.96)
		monument.rotation = Vector3(0.04, 0.10 * sign(monument_x), 0.03 * sign(monument_x))
		var monument_material := StandardMaterial3D.new()
		monument_material.albedo_color = Color("#6b8499")
		monument_material.roughness = 0.94
		for monument_mesh in monument.find_children("*", "MeshInstance3D", true, false):
			monument_mesh.set_surface_override_material(0, monument_material)
		proxy.add_child(monument)
	var base_edge := ROCK_LARGE.instantiate() as Node3D
	if base_edge != null:
		base_edge.name = "BordaBaseOrganicaCupula"
		base_edge.position = Vector3(0.0, 0.82, -5.05)
		base_edge.scale = Vector3(5.15, 0.34, 1.22)
		base_edge.rotation = Vector3(0.02, 0.0, 0.0)
		var base_edge_material := StandardMaterial3D.new()
		base_edge_material.albedo_color = Color("#34495c")
		base_edge_material.roughness = 0.98
		for base_edge_mesh in base_edge.find_children("*", "MeshInstance3D", true, false):
			base_edge_mesh.set_surface_override_material(0, base_edge_material)
		proxy.add_child(base_edge)
		for grounding_x in [-3.8]:
			var grounding_stone := ROCK_LARGE.instantiate() as Node3D
			if grounding_stone == null:
				continue
			grounding_stone.name = "ApoioBaixoSoleiraR12_%s" % str(grounding_x)
			grounding_stone.position = Vector3(grounding_x, 0.58, -4.82)
			grounding_stone.scale = Vector3(1.25, 0.34, 0.82)
			grounding_stone.rotation = Vector3(0.03, 0.12 * sign(grounding_x), 0.02)
			var grounding_material := StandardMaterial3D.new()
			grounding_material.albedo_color = Color("#455b70")
			grounding_material.roughness = 0.96
			grounding_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			for grounding_mesh in grounding_stone.find_children("*", "MeshInstance3D", true, false):
				grounding_mesh.set_surface_override_material(0, grounding_material)
			proxy.add_child(grounding_stone)
		for route_x in [0.0]:
			var route_marker := ROCK_LARGE.instantiate() as Node3D
			if route_marker == null:
				continue
			route_marker.name = "MarcadorRotaFisicaR12_%s" % str(route_x)
			route_marker.position = Vector3(route_x, 0.34, -3.05)
			route_marker.scale = Vector3(0.34, 0.12, 0.30)
			route_marker.rotation = Vector3(0.02, 0.10 * sign(route_x), 0.02)
			var route_material := StandardMaterial3D.new()
			route_material.albedo_color = Color("#263e50")
			route_material.roughness = 0.98
			route_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			for route_mesh in route_marker.find_children("*", "MeshInstance3D", true, false):
				route_mesh.set_surface_override_material(0, route_material)
			var route_body := StaticBody3D.new()
			route_body.collision_layer = 1
			route_body.collision_mask = 1
			var route_shape := CollisionShape3D.new()
			var route_box := BoxShape3D.new()
			route_box.size = Vector3(0.72, 0.22, 0.64)
			route_shape.shape = route_box
			route_shape.position = Vector3(0.0, -0.08, 0.0)
			route_body.add_child(route_shape)
			route_marker.add_child(route_body)
			proxy.add_child(route_marker)
	for wall_x in []:
		var wall := ROCK_LARGE.instantiate() as Node3D
		if wall == null:
			continue
		wall.name = "ParedeCanyonBaixaCupula_%s" % str(wall_x)
		wall.position = Vector3(wall_x, 1.65, -4.0)
		wall.scale = Vector3(2.2, 1.15, 1.65)
		wall.rotation = Vector3(0.06, 0.18 * sign(wall_x), 0.05 * sign(wall_x))
		var wall_material := StandardMaterial3D.new()
		wall_material.albedo_color = Color("#12192a")
		wall_material.roughness = 0.98
		wall_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		
		proxy.add_child(wall)
	for horizon_x in []:
		var horizon_mass := ROCK_LARGE.instantiate() as Node3D
		if horizon_mass == null:
			continue
		horizon_mass.name = "MassaHorizonteAlpino_%s" % str(horizon_x)
		horizon_mass.position = Vector3(horizon_x, 1.45, -7.4)
		horizon_mass.scale = Vector3(1.15, 0.92, 0.82)
		horizon_mass.rotation = Vector3(0.04, 0.18 * sign(horizon_x), 0.06 * sign(horizon_x))
		horizon_mass.visible = true
		proxy.add_child(horizon_mass)
	var alpine_backdrop := ROCK_LARGE.instantiate() as Node3D
	if alpine_backdrop != null:
		alpine_backdrop.name = "FundoAlpinoOrganicoRecuado"
		alpine_backdrop.position = Vector3(0.0, 4.35, -10.8)
		alpine_backdrop.scale = Vector3(5.4, 1.55, 0.48)
		alpine_backdrop.rotation = Vector3(0.03, 0.0, 0.0)
		var alpine_material := StandardMaterial3D.new()
		alpine_material.albedo_color = Color("#0b1222")
		alpine_material.roughness = 0.98
		alpine_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		for alpine_mesh in alpine_backdrop.find_children("*", "MeshInstance3D", true, false):
			alpine_mesh.set_surface_override_material(0, alpine_material)
		alpine_backdrop.visible = false
		proxy.add_child(alpine_backdrop)
	for frame_x in [-4.8, 4.8]:
		var frame_rock := ROCK_LARGE.instantiate() as Node3D
		if frame_rock == null:
			continue
		frame_rock.name = "MolduraDesfiladeiroCupula_%s" % str(frame_x)
		frame_rock.position = Vector3(frame_x, 3.6, -3.8)
		frame_rock.scale = Vector3(1.9, 4.4, 2.0)
		frame_rock.rotation = Vector3(0.08, 0.18 * sign(frame_x), 0.06 * sign(frame_x))

		var frame_material := StandardMaterial3D.new()
		frame_material.albedo_color = Color("#17182a")
		frame_material.roughness = 0.96
		frame_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		
		frame_rock.visible = false
		proxy.add_child(frame_rock)
	var threshold := ROCK_LARGE.instantiate() as Node3D
	if threshold != null:
		threshold.name = "SoleiraOrganicaCupulaFinal"
		threshold.position = Vector3(0.0, 0.68, -4.55)
		threshold.scale = Vector3(3.65, 0.30, 1.05)
		threshold.rotation = Vector3(0.02, 0.0, 0.0)
		var threshold_material := StandardMaterial3D.new()
		threshold_material.albedo_color = Color("#65778b")
		threshold_material.roughness = 0.86
		for threshold_mesh in threshold.find_children("*", "MeshInstance3D", true, false):
			threshold_mesh.set_surface_override_material(0, threshold_material)
		var threshold_body := StaticBody3D.new()
		threshold_body.collision_layer = 1
		threshold_body.collision_mask = 1
		var threshold_shape := CollisionShape3D.new()
		var threshold_box := BoxShape3D.new()
		threshold_box.size = Vector3(7.1, 0.52, 2.0)
		threshold_shape.shape = threshold_box
		threshold_shape.position = Vector3(0.0, -0.22, 0.0)
		threshold_body.add_child(threshold_shape)
		threshold.add_child(threshold_body)
		proxy.add_child(threshold)
		for connector_x in [-2.35, 2.35]:
			var threshold_connector := ROCK_LARGE.instantiate() as Node3D
			if threshold_connector == null:
				continue
			threshold_connector.name = "ConectorSoleiraGateway_%s" % str(connector_x)
			threshold_connector.position = Vector3(connector_x * 1.35, 0.66, -4.82)
			threshold_connector.scale = Vector3(1.7, 0.24, 1.05)
			threshold_connector.rotation = Vector3(0.04, 0.12 * sign(connector_x), 0.02 * sign(connector_x))
			threshold_connector.visible = false
			proxy.add_child(threshold_connector)
		for doorway_x in [-2.65, 2.65]:
			var doorway_jamb := PILLAR.instantiate() as Node3D
			if doorway_jamb == null:
				continue
			doorway_jamb.name = "JambaVerticalPortalCupula_%s" % str(doorway_x)
			doorway_jamb.position = Vector3(doorway_x * 0.92, 2.25, -4.36)
			doorway_jamb.scale = Vector3(0.72, 2.35, 0.72)
			doorway_jamb.rotation = Vector3(0.04, 0.10 * sign(doorway_x), 0.03 * sign(doorway_x))
			var jamb_body := StaticBody3D.new()
			jamb_body.collision_layer = 1
			jamb_body.collision_mask = 1
			var jamb_shape := CollisionShape3D.new()
			var jamb_box := BoxShape3D.new()
			jamb_box.size = Vector3(1.35, 4.6, 1.35)
			jamb_shape.shape = jamb_box
			jamb_shape.position = Vector3(0.0, -0.05, 0.0)
			jamb_body.add_child(jamb_shape)
			doorway_jamb.add_child(jamb_body)
			proxy.add_child(doorway_jamb)
	for crown_index in range(3):
		var crown_stone := ROCK_LARGE.instantiate() as Node3D
		if crown_stone == null:
			continue
		crown_stone.name = "CoroaValidadaCupula_%02d" % crown_index
		# A coroa assenta no conjunto vertical; o passe reduz a leitura de pedras flutuantes.
		crown_stone.position = Vector3(-2.35 + float(crown_index) * 2.35, 2.62 if crown_index != 1 else 3.06, -4.48)
		crown_stone.scale = Vector3(2.55 if crown_index != 1 else 2.95, 1.30 if crown_index != 1 else 1.52, 1.62)
		crown_stone.rotation = Vector3(0.08 * sign(float(crown_index - 1)), 0.08 * float(crown_index - 1), -0.06 * sign(float(crown_index - 1)))
		var crown_material := StandardMaterial3D.new()
		crown_material.albedo_color = Color("#4f657c") if crown_index != 1 else Color("#617b94")
		crown_material.roughness = 0.94
		for crown_mesh in crown_stone.find_children("*", "MeshInstance3D", true, false):
			crown_mesh.set_surface_override_material(0, crown_material)
		proxy.add_child(crown_stone)
		print("[REGION12_CROWN_DEBUG] index=", crown_index, " global=", crown_stone.global_position, " scale=", crown_stone.scale)
	var doorway_plane := ROCK_LARGE.instantiate() as Node3D
	if doorway_plane != null:
		doorway_plane.name = "PlanoPortaEscuraCupula"
		doorway_plane.position = Vector3(0.0, 2.35, -4.06)
		doorway_plane.scale = Vector3(1.85, 1.95, 0.10)
		doorway_plane.rotation = Vector3(0.0, PI, 0.0)
		var doorway_material := StandardMaterial3D.new()
		doorway_material.albedo_color = Color("#0a1020")
		doorway_material.roughness = 0.92
		
		doorway_plane.visible = false
		proxy.add_child(doorway_plane)
	var central_recess := ROCK_LARGE.instantiate() as Node3D
	if central_recess != null:
		central_recess.name = "RecessoEscuroCentralCupula"
		central_recess.position = Vector3(0.0, 3.62, -4.18)
		central_recess.scale = Vector3(1.12, 0.78, 0.14)
		central_recess.rotation = Vector3(0.0, PI, 0.0)
		var recess_material := StandardMaterial3D.new()
		recess_material.albedo_color = Color("#050914")
		recess_material.roughness = 1.0
		for recess_mesh in central_recess.find_children("*", "MeshInstance3D", true, false):
			recess_mesh.set_surface_override_material(0, recess_material)
		central_recess.visible = true
		proxy.add_child(central_recess)
	var centre_contact := ROCK_LARGE.instantiate() as Node3D
	if centre_contact != null:
		centre_contact.name = "PedraContactoCentroCupula"
		centre_contact.position = Vector3(0.0, 0.72, -4.22)
		centre_contact.scale = Vector3(1.8, 0.2, 0.72)
		centre_contact.rotation = Vector3(0.02, 0.1, 0.0)
		centre_contact.visible = false
		proxy.add_child(centre_contact)
	var doorway_marker := OmniLight3D.new()
	doorway_marker.name = "MarcadorInteriorAzulCupula"
	doorway_marker.light_color = Color("#4f91bf")
	doorway_marker.light_energy = 0.20
	doorway_marker.omni_range = 2.8
	doorway_marker.shadow_enabled = false
	doorway_marker.position = Vector3(164.0, 2.45, 173.6)
	add_child(doorway_marker)
	var threshold_light := OmniLight3D.new()
	threshold_light.name = "LuzInteriorSoleiraCupula"
	threshold_light.light_color = Color("#4b83a8")
	threshold_light.light_energy = 0.34
	threshold_light.omni_range = 4.2
	threshold_light.shadow_enabled = false
	threshold_light.position = Vector3(164.0, 0.78, 173.55)
	add_child(threshold_light)
	for contact_x in []:
		var contact_light := OmniLight3D.new()
		contact_light.name = "LuzContactoArco_%s" % str(contact_x)
		contact_light.light_color = Color("#6f9bc4")
		contact_light.light_energy = 0.18
		contact_light.omni_range = 2.8
		contact_light.shadow_enabled = false
		contact_light.position = Vector3(contact_x, 1.45, 173.6)
		add_child(contact_light)
	var portal_rim := OmniLight3D.new()
	portal_rim.name = "RimAzulPortalCupulaFinal"
	portal_rim.light_color = Color("#6aa7d8")
	portal_rim.light_energy = 0.22
	portal_rim.omni_range = 7.5
	portal_rim.shadow_enabled = false
	portal_rim.position = Vector3(164.0, 4.0, 170.5)
	portal_rim.visible = false
	add_child(portal_rim)

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#090d24")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#56618a")
	environment.ambient_light_energy = 0.52
	environment.fog_enabled = true
	environment.fog_light_color = Color("#53648b")
	environment.fog_light_energy = 0.38
	environment.fog_density = 0.0065
	environment.fog_sky_affect = 0.42
	environment.fog_height = 1.0
	environment.fog_height_density = 0.035
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.glow_enabled = false
	environment.glow_intensity = 0.0
	environment.glow_bloom = 0.0
	world.environment = environment
	add_child(world)
	var moon := DirectionalLight3D.new()
	moon.light_color = Color("#b7c5ee")
	moon.light_energy = 0.58
	moon.rotation_degrees = Vector3(-48.0, 22.0, 0.0)
	add_child(moon)

func _process(delta: float) -> void:
	elapsed += delta
	_set_camera(clamp(elapsed / 30.0, 0.0, 1.0))
	if recess_resonance_light != null:
		recess_resonance_light.light_energy = 0.20 + sin(elapsed * 1.7) * 0.055
	for child in get_children():
		if child is OmniLight3D and child.name.begins_with("PreenchimentoQuenteSoleira"):
			(child as OmniLight3D).light_energy = 0.34 + sin(elapsed * 1.25) * 0.08
		if child is MeshInstance3D and child.name == "NucleoCoroaFinal":
			var core_material := child.material_override as StandardMaterial3D
			if core_material != null:
				core_material.emission_energy_multiplier = 5.6 + sin(elapsed * 1.05) * 0.65
	performance_sample_timer += delta
	if performance_sample_timer >= 5.0:
		performance_sample_timer = 0.0
		var draw_calls := Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
		print("[REGION12_PERF] fps=", Engine.get_frames_per_second(), " draw_calls=", draw_calls, " elapsed=", snapped(elapsed, 0.1))

func _set_camera(progress: float) -> void:
	if camera == null:
		return
	var start := Vector3(164.0, 5.82, 182.6)
	var finish := Vector3(164.0, 5.48, 179.9)
	var position := start.lerp(finish, progress)
	position.x += sin(progress * TAU * 0.8) * 0.72
	position.y += sin(progress * PI) * 0.48
	camera.position = position
	var target := Vector3(164.0, 3.38, 173.5)
	camera.look_at(target, Vector3.UP)
