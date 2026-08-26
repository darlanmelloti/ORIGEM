extends SceneTree

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var camp: Node3D = region.get_node_or_null("AcampamentoMajestic") as Node3D
	if camp == null:
		printerr("[ORIGEM_R5_COMPOSITION_PROBE_ERROR] acampamento ausente")
		quit(1)
		return
	var targets: Array[Node3D] = []
	for target_name in ["MesaDeCartografiaMajestic", "MapaDaExpedicaoMajestic", "RoloDeCampoMajestic_00", "RoloDeCampoMajestic_01", "RoloDeCampoMajestic_02", "LonaDeChegadaMajestic_01", "LonaDeChegadaMajestic_02"]:
		var target: Node3D = camp.find_child(target_name, true, false) as Node3D
		if target != null:
			targets.append(target)
	if targets.size() != 7:
		printerr("[ORIGEM_R5_COMPOSITION_PROBE_ERROR] alvos=%d esperado=7" % targets.size())
		quit(1)
		return
	var centroid := Vector3.ZERO
	for target: Node3D in targets:
		centroid += target.global_position
	centroid /= float(targets.size())
	var recommendation := centroid + Vector3(8.0, 4.8, 10.0)
	var lights := 0
	for child: Node in camp.get_children():
		if child is Light3D:
			lights += 1
	if lights != 4:
		printerr("[ORIGEM_R5_COMPOSITION_PROBE_ERROR] luzes=%d esperado=4" % lights)
		quit(1)
		return
	print("[ORIGEM_R5_COMPOSITION_PROBE_OK] alvos=%d foco=(%.2f,%.2f,%.2f) camera_qa=(%.2f,%.2f,%.2f) luzes=%d" % [targets.size(), centroid.x, centroid.y, centroid.z, recommendation.x, recommendation.y, recommendation.z, lights])
	quit()
