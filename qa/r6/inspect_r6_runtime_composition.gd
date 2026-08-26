extends SceneTree

func _init() -> void:
	call_deferred("_inspect")

func _inspect() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var lake: Node3D = region.get_node_or_null("RuinasSubmersasDoLago") as Node3D
	var water: MeshInstance3D = region.get_node_or_null("RuinasSubmersasDoLago/LagoDasRuinasSubmersas") as MeshInstance3D
	var stela: StaticBody3D = region.get_node_or_null("RuinasSubmersasDoLago/RuneP0_02") as StaticBody3D
	var debris: Node3D = region.get_node_or_null("R6_DetritosLinhaDeAgua") as Node3D
	var arrival_reading: Node3D = region.get_node_or_null("R6_LeituraArqueologicaDaMargem") as Node3D
	var dome: MeshInstance3D = region.get_node_or_null("RuinasSubmersasDoLago/DomoSubmersoDoHub") as MeshInstance3D
	if lake == null or water == null or stela == null or debris == null or arrival_reading == null or dome == null:
		printerr("[ORIGEM_R6_RUNTIME_COMPOSITION_ERROR] composição obrigatória ausente")
		quit(1)
		return
	var pillar_count: int = lake.find_children("PilarSubmerso_*", "Node3D", true, false).size()
	var landmark_count: int = lake.find_children("MarcoRuinaEmergente_*", "Node3D", true, false).size()
	var arrival_lights: int = arrival_reading.find_children("*", "Light3D", true, false).size()
	var arrival_colliders: int = arrival_reading.find_children("*", "CollisionShape3D", true, false).size()
	print("[ORIGEM_R6_RUNTIME_COMPOSITION] water=%s stela=%s debris=%d arrival=%d dome=%s pillars=%d landmarks=%d lights=%d colliders=%d" % [water.global_position, stela.global_position, debris.get_child_count(), arrival_reading.get_child_count(), dome.global_position, pillar_count, landmark_count, arrival_lights, arrival_colliders])
	if debris.get_child_count() != 9 or arrival_reading.get_child_count() != 3 or pillar_count != 8 or landmark_count != 3 or arrival_lights != 0 or arrival_colliders != 0:
		printerr("[ORIGEM_R6_RUNTIME_COMPOSITION_ERROR] contagem ou restrição R6 inválida")
		quit(1)
		return
	quit()
