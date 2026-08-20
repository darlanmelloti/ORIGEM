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
	traversal_base.position = Vector3(164.0, 0.0, 173.8)
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
		if OS.get_environment("QA_VALIDATION_ROUTE") == "R11_R12_HUB_DEDICATED":
			base_stone.visible = false
		traversal_base.add_child(base_stone)
		var contact_mass := ROCK_LARGE.instantiate() as Node3D
		if contact_mass != null:
			contact_mass.name = "ApoioContactoBaseR12_%02d" % index
			contact_mass.position = base_positions[index] + Vector3(0.0, -0.46, 0.18)
			contact_mass.scale = Vector3(1.08 + float(index % 2) * 0.18, 0.22, 0.86 + float(index % 3) * 0.10)
			contact_mass.rotation = Vector3(0.03, float(index) * 0.31, -0.015)
			traversal_base.add_child(contact_mass)
	var foundation_positions: Array[Vector3] = [
		Vector3(-4.8, -0.18, -1.8), Vector3(0.0, -0.28, -2.3), Vector3(4.8, -0.18, -1.8),
		Vector3(-7.0, -0.08, 1.0), Vector3(7.0, -0.08, 1.0)
	]

	for foundation_index: int in range(foundation_positions.size()):
		var foundation_stone := ROCK_LARGE.instantiate() as Node3D
		if foundation_stone == null:
			continue
		foundation_stone.name = "FundacaoBaixaCupulaR12_%02d" % foundation_index
		foundation_stone.position = foundation_positions[foundation_index]
		foundation_stone.scale = Vector3(2.15 if foundation_index < 3 else 1.55, 0.48, 1.42)
		foundation_stone.rotation = Vector3(0.02, -0.24 + float(foundation_index) * 0.31, 0.01)
		if OS.get_environment("QA_VALIDATION_ROUTE") == "R11_R12_HUB_DEDICATED":
			foundation_stone.visible = false
		traversal_base.add_child(foundation_stone)
	var valley_floor := ROCK_LARGE.instantiate() as Node3D
	if valley_floor != null:
		valley_floor.name = "MassaValeOrganicoCupulaR12"
		valley_floor.position = Vector3(0.0, -0.44, 0.25)
		valley_floor.scale = Vector3(8.6, 0.52, 5.4)
		valley_floor.rotation = Vector3(0.02, 0.08, -0.01)
		traversal_base.add_child(valley_floor)
	var support_positions: Array[Vector3] = [
		Vector3(-4.6, 2.05, -1.8), Vector3(0.0, 1.82, -2.35), Vector3(4.6, 2.05, -1.8),
		Vector3(-6.4, 1.55, 0.95), Vector3(6.4, 1.55, 0.95)
	]
	for support_index: int in range(support_positions.size()):
		var support := PILLAR.instantiate() as Node3D
		if support == null:
			continue
		support.name = "ContraforteVerticalCupulaR12_%02d" % support_index
		support.position = support_positions[support_index]
		support.scale = Vector3(0.82 if support_index < 3 else 0.68, 3.05 if support_index < 3 else 2.40, 0.82 if support_index < 3 else 0.68)
		support.rotation = Vector3(0.04, -0.15 + float(support_index) * 0.23, 0.02)
		if OS.get_environment("QA_VALIDATION_ROUTE") == "R11_R12_HUB_DEDICATED":
			support.visible = false
		traversal_base.add_child(support)

	if OS.get_environment("QA_VALIDATION_ROUTE") == "R11_R12_HUB_DEDICATED":
		traversal_base.visible = false
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
		if OS.get_environment("QA_VALIDATION_ROUTE") == "R11_R12_HUB_DEDICATED":
			_build_clean_r12_portal()
	var traversal_proxy := get_node_or_null("CupulaFinalTraversalOrganicReveal") as Node3D
	if traversal_proxy != null:
		# Dedicated Region 12 visual correction: enlarge the organic sanctuary for a readable cinematic take.
		traversal_proxy.visible = OS.get_environment("QA_VALIDATION_ROUTE") != "R11_R12_HUB_DEDICATED"
		if OS.get_environment("QA_VALIDATION_ROUTE") in ["R10_CAVE_TO_R12_HUB_FULL", "R11_R12_HUB_DEDICATED"]:
			for proxy_name in ["SuporteCentralCupula_-0.9", "SuporteCentralCupula_0.9", "OmbroOrganicoCupula_-3.2", "OmbroOrganicoCupula_3.2", "ConectorCoroaCupula_-2.1", "ConectorCoroaCupula_2.1", "JambaArcoCupula_-2.45", "JambaArcoCupula_2.45", "MonolitoEscalaCupula_-4.2", "MonolitoEscalaCupula_4.2", "FundoOrganicoRecuadoCupula", "BordaBaseOrganicaCupula", "CoroaValidadaCupula_00", "CoroaValidadaCupula_01", "CoroaValidadaCupula_02"]:
					var proxy_decorative_node := traversal_proxy.find_child(proxy_name, true, false)
					if proxy_decorative_node != null:
						proxy_decorative_node.visible = false
			for proxy_child in traversal_proxy.get_children():
				var keep_dedicated_silhouette := proxy_child.name.begins_with("ArcoOrganico") or proxy_child.name == "LintelOrganicoCupulaFinal" or proxy_child.name == "SoleiraOrganicaCupulaFinal" or proxy_child.name.begins_with("JambaVerticalPortalCupula_") or proxy_child.name == "RecessoEscuroCentralCupula" or proxy_child.name.begins_with("DegrauCentralCupulaR12_") or proxy_child.name.begins_with("MarcadorRotaFisicaR12") or proxy_child.name == "ApoioBaixoSoleiraR12_-3.8"
				proxy_child.visible = keep_dedicated_silhouette
	_build_region12_wayfinding_lights()
	_build_region12_recess_resonance()
	_build_region12_cinematic_fill()
	if destination != null:
		destination.call_deferred("_report_region12_render_inventory")
	camera = Camera3D.new()
	camera.name = "Region12TraversalCamera"
	camera.fov = 44.0
	add_child(camera)
	camera.current = true
	_set_camera(0.0)

func _build_clean_r12_portal() -> void:
	var portal := Node3D.new()
	portal.name = "CupulaFinalCleanPortalR12"
	portal.position = Vector3(164.0, -0.85, 178.0)
	add_child(portal)
	var base := ROCK_LARGE.instantiate() as Node3D
	if base != null:
		base.name = "BaseAterradaPortalLimpoR12"
		base.position = Vector3(0.0, 0.34, -2.55)
		base.scale = Vector3(4.4, 0.30, 1.05)
		portal.add_child(base)
		base.visible = false
	var ground := ROCK_LARGE.instantiate() as Node3D
	if ground != null:
		ground.name = "ChaoAterramentoPortalLimpoR12"
		ground.position = Vector3(0.0, -0.38, -2.25)
		ground.scale = Vector3(6.8, 0.18, 3.2)
		ground.rotation = Vector3(0.015, 0.04, -0.01)
		var ground_material := StandardMaterial3D.new()
		ground_material.albedo_color = Color("#506579")
		ground_material.roughness = 0.92
		for ground_mesh in ground.find_children("*", "MeshInstance3D", true, false):
			ground_mesh.set_surface_override_material(0, ground_material)
		portal.add_child(ground)
	for side in [0.0]:
		var jamb := PILLAR.instantiate() as Node3D
		if jamb == null:
			continue
		jamb.name = "MassaVerticalPortalLimpoR12"
		jamb.position = Vector3(0.0, 0.62, -2.70)
		jamb.scale = Vector3(1.12, 1.62, 0.82)
		jamb.rotation = Vector3(0.03, side * 0.08, side * 0.02)
		var jamb_material := StandardMaterial3D.new()
		jamb_material.albedo_color = Color("#344d63")
		jamb_material.emission_enabled = true
		jamb_material.emission = Color("#17324c")
		jamb_material.emission_energy_multiplier = 0.22
		jamb_material.roughness = 0.94
		for jamb_mesh in jamb.find_children("*", "MeshInstance3D", true, false):
			jamb_mesh.set_surface_override_material(0, jamb_material)
		portal.add_child(jamb)
	for wing_side in []:
		var wing := ROCK_LARGE.instantiate() as Node3D
		if wing == null:
			continue
		wing.name = "AlaBaixaOrganicaR12_%s" % str(wing_side)
		wing.position = Vector3(wing_side * 1.62, -0.16, -2.52)
		wing.scale = Vector3(0.78, 0.26, 0.62)
		wing.rotation = Vector3(0.04, wing_side * 0.18, wing_side * 0.06)
		portal.add_child(wing)
	for monolith_side in [0.0]:
		var monolith := PILLAR.instantiate() as Node3D
		if monolith == null:
			continue
		monolith.name = "CoroamentoMassaVerticalPortalR12"
		monolith.position = Vector3(0.0, 1.82, -2.62)
		monolith.scale = Vector3(0.48, 0.72, 0.42)
		monolith.rotation = Vector3(0.04, monolith_side * 0.10, monolith_side * 0.04)
		var monolith_material := StandardMaterial3D.new()
		monolith_material.albedo_color = Color("#526b7d")
		monolith_material.roughness = 0.90
		for monolith_mesh in monolith.find_children("*", "MeshInstance3D", true, false):
			monolith_mesh.set_surface_override_material(0, monolith_material)
		portal.add_child(monolith)
		if OS.get_environment("QA_VALIDATION_ROUTE") == "R11_R12_HUB_DEDICATED":
			monolith.visible = false
		var grounded_crown := ROCK_LARGE.instantiate() as Node3D
		if grounded_crown != null:
			grounded_crown.name = "CoroamentoBaixoAterradoR12"
			grounded_crown.position = Vector3(0.0, 0.10, -2.72)
			grounded_crown.scale = Vector3(1.32, 0.22, 0.62)
			grounded_crown.rotation = Vector3(0.02, 0.0, 0.0)
			var crown_material := StandardMaterial3D.new()
			crown_material.albedo_color = Color("#526f88")
			crown_material.roughness = 0.82
			for crown_mesh in grounded_crown.find_children("*", "MeshInstance3D", true, false):
				crown_mesh.set_surface_override_material(0, crown_material)
			portal.add_child(grounded_crown)
		var lintel := ROCK_LARGE.instantiate() as Node3D
		if lintel != null:
			lintel.name = "LintelPortalLimpoR12"
			lintel.position = Vector3(0.0, 0.32, -2.48)
			lintel.scale = Vector3(1.08, 0.22, 0.46)
			lintel.rotation = Vector3(0.02, 0.0, 0.0)
			var lintel_material := StandardMaterial3D.new()
			lintel_material.albedo_color = Color("#4b668c")
			lintel_material.roughness = 0.84
			for lintel_mesh in lintel.find_children("*", "MeshInstance3D", true, false):
				lintel_mesh.set_surface_override_material(0, lintel_material)
			portal.add_child(lintel)
			lintel.visible = true
	var recess := ROCK_LARGE.instantiate() as Node3D
	if recess != null:
		recess.name = "RecessoPortalLimpoR12"
		recess.position = Vector3(0.0, -0.10, -2.96)
		recess.scale = Vector3(1.24, 0.30, 0.14)
		var material := StandardMaterial3D.new()
		material.albedo_color = Color("#16294a")
		material.roughness = 0.92
		for recess_mesh in recess.find_children("*", "MeshInstance3D", true, false):
			recess_mesh.set_surface_override_material(0, material)
		portal.add_child(recess)
		if OS.get_environment("QA_VALIDATION_ROUTE") == "R11_R12_HUB_DEDICATED":
			recess.visible = true
		var temporal_core := ROCK_LARGE.instantiate() as Node3D
		if temporal_core != null:
			temporal_core.name = "NucleoTemporalEncastradoR12"
			temporal_core.position = Vector3(0.0, 0.32, -2.58)
			temporal_core.scale = Vector3(0.44, 0.30, 0.44)
			var core_material := StandardMaterial3D.new()
			core_material.albedo_color = Color("#38447f")
			core_material.emission_enabled = true
			core_material.emission = Color("#8178ee")
			core_material.emission_energy_multiplier = 2.05
			core_material.roughness = 0.72
			for core_mesh in temporal_core.find_children("*", "MeshInstance3D", true, false):
				core_mesh.set_surface_override_material(0, core_material)
			portal.add_child(temporal_core)
			var core_pedestal := ROCK_LARGE.instantiate() as Node3D
			if core_pedestal != null:
				core_pedestal.name = "BaseOrganicaNucleoR12"
				core_pedestal.position = Vector3(0.0, 0.22, -2.55)
				core_pedestal.scale = Vector3(0.78, 0.18, 0.62)
				var pedestal_material := StandardMaterial3D.new()
				pedestal_material.albedo_color = Color("#36556f")
				pedestal_material.emission_enabled = true
				pedestal_material.emission = Color("#244a6e")
				pedestal_material.emission_energy_multiplier = 0.52
				for pedestal_mesh in core_pedestal.find_children("*", "MeshInstance3D", true, false):
					pedestal_mesh.set_surface_override_material(0, pedestal_material)
				portal.add_child(core_pedestal)
	for crown_side in [-1.0, 1.0]:
		var crown := PILLAR.instantiate() as Node3D
		if crown == null:
			continue
		crown.name = "CoroaVerticalR12_%s" % str(crown_side)
		crown.position = Vector3(crown_side * 1.08, 0.92, -2.84)
		crown.scale = Vector3(0.32, 0.68, 0.32)
		crown.rotation = Vector3(0.02, crown_side * 0.06, crown_side * 0.03)
		portal.add_child(crown)
		crown.visible = false
	var portal_light := OmniLight3D.new()
	portal_light.name = "LuzPortalLimpoR12"
	portal_light.light_color = Color("#6d83d7")
	portal_light.light_energy = 0.30
	portal_light.omni_range = 4.2
	portal_light.shadow_enabled = false
	portal_light.position = Vector3(164.0, 2.55, 175.2)
	add_child(portal_light)
	var core_light := OmniLight3D.new()
	core_light.name = "LuzNucleoTemporalR12"
	core_light.light_color = Color("#6c62d7")
	core_light.light_energy = 0.42
	core_light.omni_range = 3.6
	core_light.shadow_enabled = false
	core_light.position = Vector3(164.0, 0.08, 175.42)
	add_child(core_light)
	var contact_light := OmniLight3D.new()
	contact_light.name = "LuzContactoNucleoR12"
	contact_light.light_color = Color("#8176d6")
	contact_light.light_energy = 0.28
	contact_light.omni_range = 1.9
	contact_light.shadow_enabled = false
	contact_light.position = Vector3(164.0, -0.12, 175.10)
	add_child(contact_light)
	var left_rim := OmniLight3D.new()
	left_rim.name = "RecorteAzulPilarEsquerdoR12"
	left_rim.light_color = Color("#4f8fc4")
	left_rim.light_energy = 0.14
	left_rim.omni_range = 5.4
	left_rim.shadow_enabled = false
	left_rim.position = Vector3(161.15, 0.84, 175.72)
	add_child(left_rim)
	var right_rim := OmniLight3D.new()
	right_rim.name = "RecorteVioletaPilarDireitoR12"
	right_rim.light_color = Color("#7562c8")
	right_rim.light_energy = 0.12
	right_rim.omni_range = 5.4
	right_rim.shadow_enabled = false
	right_rim.position = Vector3(166.85, 0.84, 175.72)
	add_child(right_rim)

func _build_region12_wayfinding_lights() -> void:
	var wayfinding_positions: Array[Vector3] = [
		Vector3(164.0, 0.95, 181.5),
		Vector3(163.8, 1.05, 179.8),
		Vector3(164.2, 1.15, 178.2),
		Vector3(164.0, 0.28, 175.9),
		Vector3(164.0, 0.82, 171.9)
		]
	for index: int in range(wayfinding_positions.size()):
		var waypoint_light := OmniLight3D.new()
		waypoint_light.name = "LuzWayfindingR12_%02d" % index
		waypoint_light.light_color = Color("#58b9d6" if index < 3 else "#7f6bd6")
		waypoint_light.light_energy = 1.35 if index < 3 else 0.14
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
		resonance_material.emission_energy_multiplier = 7.0 if index < 3 else 0.65
		resonance_core.material_override = resonance_material
		resonance_core.position = wayfinding_positions[index] + Vector3(0.0, 0.10, 0.0)
		resonance_core.visible = index < 4 and (index != 3 or OS.get_environment("QA_VALIDATION_ROUTE") != "R11_R12_HUB_DEDICATED")
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
		left_arch.position = Vector3(-2.35, 1.42, -4.38)
		left_arch.scale = Vector3(1.35, 2.55, 1.45)
		left_arch.rotation = Vector3(0.0, -0.08, 0.0)
		left_arch.visible = true
		proxy.add_child(left_arch)
	if right_arch != null:
		right_arch.name = "ArcoOrganicoDireito"
		right_arch.position = Vector3(2.35, 1.42, -4.38)
		right_arch.scale = Vector3(1.35, 2.55, 1.45)
		right_arch.rotation = Vector3(0.0, 0.08, 0.0)
		right_arch.visible = true
		proxy.add_child(right_arch)
		if crown != null:
			crown.name = "ArcoOrganicoCoroa"
			crown.visible = true
			crown.position = Vector3(0.0, 1.92, -4.34)
			crown.scale = Vector3(1.48, 0.78, 1.16)
			crown.rotation = Vector3(-0.22, 0.08, 0.06)
			proxy.add_child(crown)

	var lintel := ROCK_LARGE.instantiate() as Node3D
	if lintel != null:
		lintel.name = "LintelOrganicoCupulaFinal"
		lintel.position = Vector3(0.0, 1.78, -4.18)
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
		base_edge_material.albedo_color = Color("#405b70")
		base_edge_material.roughness = 0.93
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
			grounding_material.albedo_color = Color("#526a7e")
			grounding_material.roughness = 0.91
			grounding_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			for grounding_mesh in grounding_stone.find_children("*", "MeshInstance3D", true, false):
				grounding_mesh.set_surface_override_material(0, grounding_material)
			proxy.add_child(grounding_stone)
		for route_x in [0.0]:
			var route_marker := ROCK_LARGE.instantiate() as Node3D
			if route_marker == null:
				continue
			route_marker.name = "MarcadorRotaFisicaR12_%s" % str(route_x)
			route_marker.position = Vector3(route_x * 0.960, 0.345, -3.045)
			route_marker.scale = Vector3(0.33, 0.11, 0.29)
			route_marker.rotation = Vector3(0.018, 0.17 * sign(route_x), 0.018)
			var route_material := StandardMaterial3D.new()
			route_material.albedo_color = Color("#3f687c")
			route_material.roughness = 0.93
			route_material.emission_enabled = true
			route_material.emission = Color("#5bc8ee")
			route_material.emission_energy_multiplier = 0.30
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
		alpine_material.albedo_color = Color("#101a2c")
		alpine_material.roughness = 0.96
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
		frame_material.albedo_color = Color("#202842")
		frame_material.roughness = 0.91
		frame_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		
		frame_rock.visible = false
		proxy.add_child(frame_rock)
	var threshold := ROCK_LARGE.instantiate() as Node3D
	if threshold != null:
		threshold.name = "SoleiraOrganicaCupulaFinal"
		threshold.position = Vector3(0.0, 0.68, -4.55)
		threshold.scale = Vector3(4.10, 0.32, 1.16)
		threshold.rotation = Vector3(0.02, 0.0, 0.0)
		var threshold_material := StandardMaterial3D.new()
		threshold_material.albedo_color = Color("#788fa3")
		threshold_material.roughness = 0.82
		threshold_material.emission_enabled = true
		threshold_material.emission = Color("#315a79")
		threshold_material.emission_energy_multiplier = 0.16
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
		crown_stone.position = Vector3(-2.45 + float(crown_index) * 2.45, 2.18 if crown_index != 1 else 2.76, -4.48)
		crown_stone.scale = Vector3(2.55 if crown_index != 1 else 3.15, 1.18 if crown_index != 1 else 1.48, 1.62 if crown_index != 1 else 1.78)
		crown_stone.rotation = Vector3(0.08 * sign(float(crown_index - 1)), 0.08 * float(crown_index - 1), -0.06 * sign(float(crown_index - 1)))
		var crown_material := StandardMaterial3D.new()
		crown_material.albedo_color = Color("#5b718b") if crown_index != 1 else Color("#708aa5")
		crown_material.roughness = 0.82
		crown_material.emission_enabled = true
		crown_material.emission = Color("#3d6281")
		crown_material.emission_energy_multiplier = 0.12
		for crown_mesh in crown_stone.find_children("*", "MeshInstance3D", true, false):
			crown_mesh.set_surface_override_material(0, crown_material)
		# QA-only composition: keep the central crown as the vertical focal point; side stones read as floating in the traversal frame.
		if crown_index != 1 and OS.get_environment("QA_VALIDATION_ROUTE") != "R11_R12_HUB_DEDICATED":
			crown_stone.visible = false
		proxy.add_child(crown_stone)
		print("[REGION12_CROWN_DEBUG] index=", crown_index, " global=", crown_stone.global_position, " scale=", crown_stone.scale)
	var shoulder_positions: Array[Vector3] = [
		Vector3(-4.25, 1.35, -4.18), Vector3(4.25, 1.35, -4.18), Vector3(-3.15, 1.48, -4.76), Vector3(3.15, 1.48, -4.76)
	]
	for shoulder_index: int in range(shoulder_positions.size()):
		var shoulder := ROCK_LARGE.instantiate() as Node3D
		if shoulder == null:
			continue
		shoulder.name = "OmbroOrganicoCupulaR12_%02d" % shoulder_index
		shoulder.position = shoulder_positions[shoulder_index]
		shoulder.scale = Vector3(1.28 if shoulder_index < 2 else 1.06, 0.54 if shoulder_index < 2 else 0.44, 0.98)
		shoulder.rotation = Vector3(0.05, -0.18 + float(shoulder_index) * 0.26, 0.03)
		var shoulder_material := StandardMaterial3D.new()
		shoulder_material.albedo_color = Color("#4e667d")
		shoulder_material.roughness = 0.88
		for shoulder_mesh in shoulder.find_children("*", "MeshInstance3D", true, false):
			shoulder_mesh.set_surface_override_material(0, shoulder_material)
		if OS.get_environment("QA_VALIDATION_ROUTE") != "R11_R12_HUB_DEDICATED":
			shoulder.visible = false
		proxy.add_child(shoulder)
	var lateral_links: Array[Vector3] = [
		Vector3(-3.72, 1.12, -4.42), Vector3(3.72, 1.12, -4.42),
		Vector3(-2.72, 0.92, -4.62), Vector3(2.72, 0.92, -4.62)
	]
	for link_index: int in range(lateral_links.size()):
		var link_stone := ROCK_LARGE.instantiate() as Node3D
		if link_stone == null:
			continue
		link_stone.name = "LigacaoLateralCupulaR12_%02d" % link_index
		link_stone.position = lateral_links[link_index]
		link_stone.scale = Vector3(1.08, 0.40, 0.82)
		link_stone.rotation = Vector3(0.05, -0.20 + float(link_index) * 0.26, 0.04)
		var link_material := StandardMaterial3D.new()
		link_material.albedo_color = Color("#526d84")
		link_material.roughness = 0.90
		for link_mesh in link_stone.find_children("*", "MeshInstance3D", true, false):
			link_mesh.set_surface_override_material(0, link_material)
		if OS.get_environment("QA_VALIDATION_ROUTE") != "R11_R12_HUB_DEDICATED":
			link_stone.visible = false
		proxy.add_child(link_stone)
	var link_support_positions: Array[Vector3] = [
		Vector3(-3.72, 0.58, -4.42), Vector3(3.72, 0.58, -4.42),
		Vector3(-2.72, 0.48, -4.62), Vector3(2.72, 0.48, -4.62)
	]
	for link_support_index: int in range(link_support_positions.size()):
		var link_support := PILLAR.instantiate() as Node3D
		if link_support == null:
			continue
		link_support.name = "ApoioLigacaoLateralR12_%02d" % link_support_index
		link_support.position = link_support_positions[link_support_index]
		link_support.scale = Vector3(0.44, 0.62 if link_support_index < 2 else 0.48, 0.44)
		link_support.rotation = Vector3(0.03, -0.14 + float(link_support_index) * 0.22, 0.02)
		proxy.add_child(link_support)
	var central_steps: Array[Vector3] = [
		Vector3(0.0, 0.32, -2.68), Vector3(0.0, 0.50, -3.42), Vector3(0.0, 0.74, -4.40)
	]
	for step_index: int in range(central_steps.size()):
		var central_step := ROCK_LARGE.instantiate() as Node3D
		if central_step == null:
			continue
		central_step.name = "DegrauCentralCupulaR12_%02d" % step_index
		central_step.position = central_steps[step_index]
		central_step.scale = Vector3(1.50 - float(step_index) * 0.12, 0.24 if step_index == 2 else 0.22, 0.82 if step_index == 2 else 0.76)
		central_step.rotation = Vector3(0.025, 0.02 * float(step_index), 0.015)
		var step_material := StandardMaterial3D.new()
		step_material.albedo_color = Color("#5e7890")
		step_material.roughness = 0.90
		if step_index == 2:
			step_material.emission_enabled = true
			step_material.emission = Color("#2c82aa")
			step_material.emission_energy_multiplier = 0.18
		for step_mesh in central_step.find_children("*", "MeshInstance3D", true, false):
			step_mesh.set_surface_override_material(0, step_material)
		proxy.add_child(central_step)
		if step_index == 2:
			var step_contact_light := OmniLight3D.new()
			step_contact_light.name = "LuzContactoUltimoDegrauR12"
			step_contact_light.light_color = Color("#5ab7d8")
			step_contact_light.light_energy = 0.28
			step_contact_light.omni_range = 2.8
			step_contact_light.shadow_enabled = false
			step_contact_light.position = Vector3(164.0, 0.96, 169.40)
			add_child(step_contact_light)
	var approach_body := StaticBody3D.new()
	approach_body.name = "CollidersAproximacaoHubR12"
	add_child(approach_body)
	var approach_shapes: Array[Vector3] = [
		Vector3(2.40, 0.48, 1.32), Vector3(2.18, 0.52, 1.28), Vector3(1.94, 0.58, 1.34)
	]
	var approach_positions: Array[Vector3] = [
		Vector3(164.0, 0.24, 171.12), Vector3(164.0, 0.50, 170.38), Vector3(164.0, 0.80, 169.40)
	]
	var collider_names: Array[String] = ["ColisaoHandoffCubeR11", "ColisaoHandoffSoleiraR12", "ColisaoHandoffHubR12"]
	for collider_index: int in range(approach_shapes.size()):
		var collision := CollisionShape3D.new()
		collision.name = collider_names[collider_index]
		var shape := BoxShape3D.new()
		shape.size = approach_shapes[collider_index]
		collision.shape = shape
		collision.position = approach_positions[collider_index]
		approach_body.add_child(collision)
	var handoff_positions: Array[Vector3] = [
		Vector3(164.0, 0.78, 171.12), Vector3(164.0, 0.92, 170.38), Vector3(164.0, 1.08, 169.40)
	]
	var handoff_names: Array[String] = ["HandoffCubeR11", "HandoffSoleiraR12", "HandoffHubR12"]
	for handoff_index: int in range(handoff_positions.size()):
		var handoff_marker := Marker3D.new()
		handoff_marker.name = handoff_names[handoff_index]
		handoff_marker.position = handoff_positions[handoff_index]
		handoff_marker.set_meta("dev2_scope", "regions_7_to_12")
		handoff_marker.set_meta("sequence_order", handoff_index + 1)
		add_child(handoff_marker)
		print("REGION12_HANDOFF_POSITION name=", handoff_marker.name, " sequence=", handoff_index + 1, " position=", handoff_marker.position)
	var validation_anchors: Array[Dictionary] = [
		{"name": "ValidationR11_CamaraOrionCube", "position": Vector3(164.0, 1.18, 171.12), "region": 11, "role": "cube_chamber_frame"},
		{"name": "ValidationR12_HubTemporal", "position": Vector3(164.0, 1.34, 169.40), "region": 12, "role": "hub_approach_frame"}
	]
	for validation_anchor: Dictionary in validation_anchors:
		var anchor := Marker3D.new()
		anchor.name = validation_anchor["name"]
		anchor.position = validation_anchor["position"]
		anchor.set_meta("dev2_scope", "regions_7_to_12")
		anchor.set_meta("validation_region", validation_anchor["region"])
		anchor.set_meta("validation_role", validation_anchor["role"])
		add_child(anchor)
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
		recess_material.albedo_color = Color("#0b1524")
		recess_material.roughness = 0.94
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
	doorway_marker.light_energy = 0.34
	doorway_marker.omni_range = 2.8
	doorway_marker.shadow_enabled = false
	doorway_marker.position = Vector3(164.0, 2.45, 173.6)
	add_child(doorway_marker)
	var threshold_light := OmniLight3D.new()
	threshold_light.name = "LuzInteriorSoleiraCupula"
	threshold_light.light_color = Color("#4b83a8")
	threshold_light.light_energy = 0.48
	threshold_light.omni_range = 4.2
	threshold_light.shadow_enabled = false
	threshold_light.position = Vector3(164.0, 0.78, 173.55)
	add_child(threshold_light)
	for contact_x in [-2.2, 2.2]:
		var contact_light := OmniLight3D.new()
		contact_light.name = "LuzContactoArco_%s" % str(contact_x)
		contact_light.light_color = Color("#6f9bc4")
		contact_light.light_energy = 0.18
		contact_light.omni_range = 2.8
		contact_light.shadow_enabled = false
		contact_light.position = Vector3(contact_x, 1.45, 173.6)
		if OS.get_environment("QA_VALIDATION_ROUTE") == "R10_CAVE_TO_R12_HUB_FULL" and is_equal_approx(contact_x, 2.2):
			contact_light.visible = false
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
	environment.ambient_light_energy = 0.54
	environment.fog_enabled = true
	environment.fog_light_color = Color("#53648b")
	environment.fog_light_energy = 0.38
	environment.fog_density = 0.0048
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
	moon.light_energy = 0.48
	moon.rotation_degrees = Vector3(-48.0, 22.0, 0.0)
	add_child(moon)

func _process(delta: float) -> void:
	elapsed += delta
	_set_camera(clamp(elapsed / 30.0, 0.0, 1.0))
	if recess_resonance_light != null:
		recess_resonance_light.light_energy = 0.20 + sin(elapsed * 1.7) * 0.055
	var temporal_portal := get_node_or_null("CupulaFinalCleanPortalR12/NucleoTemporalEncastradoR12")
	if temporal_portal != null:
		for temporal_mesh in temporal_portal.find_children("*", "MeshInstance3D", true, false):
			var temporal_material := temporal_mesh.get_surface_override_material(0) as StandardMaterial3D
			if temporal_material != null:
				temporal_material.emission_energy_multiplier = 0.76 + sin(elapsed * 1.12) * 0.22
	for child in get_children():
		if child is OmniLight3D and child.name.begins_with("PreenchimentoQuenteSoleira"):
			(child as OmniLight3D).light_energy = 0.34 + sin(elapsed * 1.25) * 0.08
		if child is OmniLight3D and child.name == "LuzNucleoTemporalR12":
			(child as OmniLight3D).light_energy = 0.24 + sin(elapsed * 1.12) * 0.08
		if child is OmniLight3D and child.name == "LuzContactoNucleoR12":
			(child as OmniLight3D).light_energy = 0.10 + sin(elapsed * 1.12) * 0.03
		if child is MeshInstance3D and child.name == "NucleoCoroaFinal":
			var core_material := child.material_override as StandardMaterial3D
			if core_material != null:
				var core_pulse_base := 1.8 if OS.get_environment("QA_VALIDATION_ROUTE") == "R10_CAVE_TO_R12_HUB_FULL" else 5.6
				var core_pulse_amp := 0.18 if OS.get_environment("QA_VALIDATION_ROUTE") == "R10_CAVE_TO_R12_HUB_FULL" else 0.65
				core_material.emission_energy_multiplier = core_pulse_base + sin(elapsed * 1.05) * core_pulse_amp
		if child is MeshInstance3D and child.name.begins_with("MarcadorRotaFisicaR12"):
			var route_marker_material := child.material_override as StandardMaterial3D
			if route_marker_material != null:
				route_marker_material.emission_energy_multiplier = 0.28 + sin(elapsed * 1.10) * 0.06
	performance_sample_timer += delta
	if performance_sample_timer >= 5.0:
		performance_sample_timer = 0.0
		var draw_calls := Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
		print("[REGION12_PERF] fps=", Engine.get_frames_per_second(), " draw_calls=", draw_calls, " elapsed=", snapped(elapsed, 0.1))

func _set_camera(progress: float) -> void:
	if camera == null:
		return
	# CP-D2-R12-004: enquadramento elevado para revelar portal, núcleo e base da Cúpula.
	var start := Vector3(163.82, 5.20, 187.40)
	var finish := Vector3(164.32, 4.45, 181.80)
	var position := start.lerp(finish, progress)
	position.x += sin(progress * TAU * 0.8) * 0.10
	position.y += sin(progress * PI) * 0.10
	camera.position = position
	var target := Vector3(164.00 + sin(progress * PI) * 0.02, 2.55 + progress * 0.25, 177.10)
	camera.look_at(target, Vector3.UP)
