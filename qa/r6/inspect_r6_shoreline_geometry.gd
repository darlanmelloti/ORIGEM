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
	if lake == null or water == null or stela == null or debris == null or arrival_reading == null:
		printerr("[ORIGEM_R6_SHORELINE_ERROR] nós R6 obrigatórios ausentes")
		quit(1)
		return
	var sample_points: Array[Vector2] = [
		Vector2(13.67871, 222.0),
		Vector2(52.0, 231.0),
		Vector2(60.0, 252.0),
		Vector2(18.0, 252.0),
		Vector2(60.0, 218.0)
	]
	var water_y: float = water.global_position.y
	var arrival_lights: int = arrival_reading.find_children("*", "Light3D", true, false).size()
	var arrival_colliders: int = arrival_reading.find_children("*", "CollisionShape3D", true, false).size()
	print("[ORIGEM_R6_SHORELINE] water_y=%.3f stela=%s debris=%d arrival_reading=%d lights=%d colliders=%d" % [water_y, stela.global_position, debris.get_child_count(), arrival_reading.get_child_count(), arrival_lights, arrival_colliders])
	for point: Vector2 in sample_points:
		var ground_y: float = float(region.call("_height_at", point.x, point.y))
		print("[ORIGEM_R6_SHORELINE_SAMPLE] x=%.3f z=%.3f ground_y=%.3f water_delta=%.3f" % [point.x, point.y, ground_y, water_y - ground_y])
	if debris.get_child_count() != 9:
		printerr("[ORIGEM_R6_SHORELINE_ERROR] esperado 9 detritos; obtido=%d" % debris.get_child_count())
		quit(1)
		return
	if arrival_reading.get_child_count() != 3 or arrival_lights != 0 or arrival_colliders != 0:
		printerr("[ORIGEM_R6_SHORELINE_ERROR] composição da margem inválida")
		quit(1)
		return
	quit()
