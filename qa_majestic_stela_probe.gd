extends SceneTree

func _init() -> void:
	call_deferred("_run_probe")

func _run_probe() -> void:
	var scene: Node = load("res://scenes/main.tscn").instantiate()
	root.add_child(scene)
	for frame_index: int in range(240):
		await process_frame
	var player: CharacterBody3D = get_first_node_in_group("player") as CharacterBody3D
	var stela: StaticBody3D = scene.get_node_or_null("TempleLevel/RegiaoFlorestaLagoExploravel/AcampamentoMajestic/RuneP0_01") as StaticBody3D
	if player == null or stela == null:
		print("[ORIGEM_QA_STELA_PROBE] FALHA: player=%s stela=%s" % [str(player), str(stela)])
		quit(2)
		return
	var terrain: Node = scene.get_node_or_null("TempleLevel/TerrainPatch") as Node
	var approach: Vector3 = stela.global_position + Vector3(0.0, 0.0, 2.0)
	var ground_y: float = float(terrain.call("height_at", approach.x, approach.z)) if terrain != null and terrain.has_method("height_at") else approach.y
	player.velocity = Vector3.ZERO
	player.global_position = Vector3(approach.x, ground_y + 1.25, approach.z)
	player.look_at(Vector3(stela.global_position.x, player.global_position.y, stela.global_position.z), Vector3.UP)
	var head: Node3D = player.get_node_or_null("Head") as Node3D
	if head != null:
		head.rotation = Vector3.ZERO
	await physics_frame
	await physics_frame
	var ray: RayCast3D = player.get_node_or_null("Head/Camera3D/InteractRay") as RayCast3D
	if ray == null:
		print("[ORIGEM_QA_STELA_PROBE] FALHA: raio ausente")
		quit(3)
		return
	ray.force_raycast_update()
	var collider: Object = ray.get_collider()
	var collider_name: String = collider.name if collider != null else "nenhum"
	var ray_success: bool = collider == stela
	if ray_success:
		var interact_event: InputEventAction = InputEventAction.new()
		interact_event.action = "interact"
		interact_event.pressed = true
		Input.parse_input_event(interact_event)
		await physics_frame
		await process_frame
	var main_script: Node = scene
	var message_label: Label = main_script.get("msg_label") as Label if main_script != null else null
	var hud_success: bool = message_label != null and "RUNAS: A água recorda" in message_label.text
	print("[ORIGEM_QA_STELA_PROBE] player=%s stela=%s alvo=%s raio=%s hud=%s texto=%s" % [player.global_position, stela.global_position, collider_name, str(ray_success), str(hud_success), message_label.text if message_label != null else "ausente"])
	quit(0 if ray_success and hud_success else 1)
