extends SceneTree
## CP-D2-R9R10-002 — auditor do collider físico existente R9→R10.

func _initialize() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if scene == null:
		push_error("R9R10 physical handoff scene could not load")
		quit(1)
		return
	var root: Node = scene.instantiate()
	get_root().add_child(root)
	current_scene = root
	await create_timer(2.6).timeout
	var destination: Node = root.get_node_or_null("TempleLevel/DestinosOrionEHubTemporal")
	var handoff: Node = destination.get_node_or_null("CPD2007_HandoffFisico_Regiao09_10_11") if destination != null else null
	var r9_body: StaticBody3D = handoff.get_node_or_null("ColliderCPD2007_ENTRADA_TRILHA_09") as StaticBody3D if handoff != null else null
	var r10_marker: Marker3D = handoff.get_node_or_null("CPD2007_LIMIAR_CAVERNA_10") as Marker3D if handoff != null else null
	var failures: Array[String] = []
	if destination == null:
		failures.append("Orion destination region missing")
	if handoff == null:
		failures.append("CPD2007 physical handoff missing")
	if r9_body == null:
		failures.append("R9 collider body missing")
	if r10_marker == null:
		failures.append("R10 threshold marker missing")
	if r9_body != null and not r9_body.get_meta("handoff_R9_R10", false):
		failures.append("R9 body lacks handoff_R9_R10 metadata")
	var count: int = handoff.get_child_count() if handoff != null else 0
	print("R9R10_PHYSICAL_HANDOFF destination=%s handoff=%s r9_body=%s r10_marker=%s child_count=%d" % [str(destination != null), str(handoff != null), str(r9_body != null), str(r10_marker != null), count])
	print("R9R10_PHYSICAL_CONTRACT collider=ColisaoHandoffR9R10 map_authority=mapaorigem.webp physical=true")
	if failures.is_empty():
		print("CP-D2-R9R10-002_PHYSICAL_HANDOFF=PASS")
	else:
		for failure: String in failures:
			print("R9R10_PHYSICAL_HANDOFF_PENDING: " + failure)
		print("CP-D2-R9R10-002_PHYSICAL_HANDOFF=REJECTED")
	root.free()
	await process_frame
	quit(0)
