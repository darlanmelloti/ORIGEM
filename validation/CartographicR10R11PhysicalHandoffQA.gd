extends SceneTree
## CP-D2-R10R11-002 — auditor físico Caverna do Orion → Câmara do Orion Cube.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R10R11 physical handoff scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(2.6).timeout
	var destination: Node = root.get_node_or_null("TempleLevel/DestinosOrionEHubTemporal")
	var handoff: Node = destination.get_node_or_null("CPD2007_HandoffFisico_Regiao09_10_11") if destination != null else null
	var r10_threshold: Marker3D = handoff.get_node_or_null("CPD2007_LIMIAR_CAVERNA_10") as Marker3D if handoff != null else null
	var r10_mouth: Marker3D = handoff.get_node_or_null("CPD2007_BOCA_CAVERNA_10") as Marker3D if handoff != null else null
	var r10_interior: Marker3D = handoff.get_node_or_null("CPD2007_TRANSICAO_INTERIOR") as Marker3D if handoff != null else null
	var r11_chamber: Marker3D = handoff.get_node_or_null("CPD2007_CAMARA_CUBE_11") as Marker3D if handoff != null else null
	var failures: Array[String] = []
	var r10_r11_bodies: int = 0
	var light_count: int = 0
	if destination == null:
		failures.append("Orion destination region missing")
	if handoff == null:
		failures.append("CPD2007 physical handoff missing")
	for child: Node in handoff.get_children() if handoff != null else []:
		if child is StaticBody3D and child.get_meta("handoff_R10_R11", false):
			r10_r11_bodies += 1
		if child is Light3D and child.visible:
			light_count += 1
	if r10_threshold == null or r10_mouth == null or r10_interior == null:
		failures.append("R10 physical markers incomplete")
	if r11_chamber == null:
		failures.append("R11 chamber marker missing")
	if r10_r11_bodies != 3:
		failures.append("expected 3 R10-R11 collider bodies, got %d" % r10_r11_bodies)
	if light_count > 16:
		failures.append("dynamic light budget exceeded: %d" % light_count)
	print("R10R11_PHYSICAL_HANDOFF r10_threshold=%s r10_mouth=%s interior=%s r11_chamber=%s bodies=%d lights=%d" % [str(r10_threshold != null), str(r10_mouth != null), str(r10_interior != null), str(r11_chamber != null), r10_r11_bodies, light_count])
	print("R10R11_PHYSICAL_CONTRACT collider=ColisaoHandoffR10R11 map_authority=mapaorigem.webp physical=true")
	if failures.is_empty():
		print("CP-D2-R10R11-002_PHYSICAL_HANDOFF=PASS")
	else:
		for failure: String in failures:
			print("R10R11_PHYSICAL_HANDOFF_PENDING: " + failure)
		print("CP-D2-R10R11-002_PHYSICAL_HANDOFF=REJECTED")
	root.free()
	await process_frame
	quit(0)
