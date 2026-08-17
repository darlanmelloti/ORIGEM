extends SceneTree

func _init() -> void:
	call_deferred("_probe")

func _probe() -> void:
	var packed: PackedScene = load("res://scenes/main.tscn") as PackedScene
	if packed == null:
		push_error("[CP265_PRESENCE] Cena principal indisponível.")
		quit(1)
		return
	var world: Node = packed.instantiate()
	root.add_child(world)
	await create_timer(3.5).timeout
	var temple: Node = world.get_node_or_null("TempleLevel")
	var road: Node = temple.get_node_or_null("EstradaDoRioExploravel") if temple != null else null
	var forest: Node = temple.get_node_or_null("RegiaoFlorestaLagoExploravel") if temple != null else null
	var roadbed: Node = road.get_node_or_null("SoloCompactadoEstradaDoRio") if road != null else null
	var arch: Node = road.get_node_or_null("ArcoDasRuinas_EstradaDoRio") if road != null else null
	var voss_controllers: Array[Node] = get_nodes_in_group("voss_house_controller")
	print("[CP265_PRESENCE] temple=%s road=%s roadbed=%s arch=%s forest=%s voss_controllers=%d" % [temple != null, road != null, roadbed != null, arch != null, forest != null, voss_controllers.size()])
	quit(0 if road != null and roadbed != null and arch != null and forest != null else 1)
