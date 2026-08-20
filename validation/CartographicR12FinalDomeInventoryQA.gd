extends SceneTree
## CP-D2-R12-001 — inventário técnico Hub Temporal → Cúpula Final.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R12 final dome scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(3.0).timeout
	var destination: Node = root.get_node_or_null("TempleLevel/DestinosOrionEHubTemporal")
	var approach: Node = destination.get_node_or_null("TransicaoHubParaCupulaFinal") if destination != null else null
	var dome: Node = destination.get_node_or_null("CupulaFinal") if destination != null else null
	var failures: Array[String] = []
	var step_count: int = 0
	var step_colliders: int = 0
	var dynamic_lights: int = 0
	if destination == null:
		failures.append("Orion destination missing")
	if approach == null:
		failures.append("Hub-to-dome approach missing")
	if dome == null:
		failures.append("Final dome missing")
	if approach != null:
		for child: Node in approach.get_children():
			if child.name.begins_with("DegrauCupulaFinal_"):
				step_count += 1
				if child.find_child("ColisaoDegrauCupulaFinal_%02d" % (step_count - 1), true, false) != null:
					step_colliders += 1
			for nested: Node in child.find_children("*", "Light3D", true, false):
				if nested is Light3D and nested.visible:
					dynamic_lights += 1
			for direct: Node in approach.get_children():
				if direct is Light3D and direct.visible:
					dynamic_lights += 1
		if approach.find_child("WayfindingOrganicoSoleiraR12", true, false) == null:
			failures.append("R12 threshold marker missing")
	if dome != null:
		if dome.find_child("MassaVerticalPortalCupulaR12", true, false) == null:
			failures.append("vertical portal mass missing")
		if dome.find_child("ColisaoMassaVerticalPortalCupulaR12", true, false) == null:
			failures.append("portal collider missing")
		if dome.find_child("ColisaoSoleiraGatewayCupula", true, false) == null:
			failures.append("dome threshold collider missing")
		for light: Node in dome.find_children("*", "Light3D", true, false):
			if light is Light3D and light.visible:
				dynamic_lights += 1
	print("R12_FINAL_DOME_INVENTORY steps=%d step_colliders=%d portal_mass=%s dynamic_lights=%d" % [step_count, step_colliders, str(dome != null and dome.find_child("MassaVerticalPortalCupulaR12", true, false) != null), dynamic_lights])
	print("R12_FINAL_DOME_CONTRACT map_authority=mapaorigem.webp scope=REGIONS_7_12_ONLY")
	if step_count != 7:
		failures.append("expected 7 final dome steps, got %d" % step_count)
	if step_colliders != 7:
		failures.append("expected 7 step colliders, got %d" % step_colliders)
	if dynamic_lights > 16:
		failures.append("dynamic light budget exceeded: %d" % dynamic_lights)
	if failures.is_empty():
		print("CP-D2-R12-001_FINAL_DOME_INVENTORY=PASS")
	else:
		for failure: String in failures:
			print("R12_FINAL_DOME_INVENTORY_PENDING: " + failure)
		print("CP-D2-R12-001_FINAL_DOME_INVENTORY=REJECTED")
	root.free()
	await process_frame
	quit(0)
