extends SceneTree

const TARGETS: Array[Dictionary] = [
	{
		"name": "FragmentoDeColunaMargemR6",
		"position": Vector3(3.8, 0.0, 235.0),
		"scale": Vector3(0.546, 0.7952, 0.5208),
		"rotation": Vector3(0.235, 0.44, -0.065)
	},
	{
		"name": "PedraLeituraMargemR6_00",
		"position": Vector3(0.8, 0.0, 233.6),
		"scale": Vector3(0.4352, 0.232696, 0.373592),
		"rotation": Vector3(0.085, -0.20, -0.12)
	},
	{
		"name": "PedraLeituraMargemR6_01",
		"position": Vector3(7.4, 0.0, 237.8),
		"scale": Vector3(0.3672, 0.181656, 0.28782),
		"rotation": Vector3(0.04, 0.615, 0.10)
	}
]

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var issues: PackedStringArray = PackedStringArray()
	var arrival_reading: Node3D = region.get_node_or_null("R6_LeituraArqueologicaDaMargem") as Node3D
	if arrival_reading == null:
		issues.append("a leitura arqueológica da chegada R6 não foi instanciada")
	else:
		if int(arrival_reading.get_meta("r6_midground_archaeology_targets", -1)) != 3:
			issues.append("a composição deve ajustar exactamente três vestígios existentes")
		if int(arrival_reading.get_meta("r6_midground_archaeology_dynamic_lights", -1)) != 0:
			issues.append("a composição não pode adicionar luz dinâmica")
		if int(arrival_reading.get_meta("r6_midground_archaeology_added_nodes", -1)) != 0:
			issues.append("a composição não pode criar nós adicionais")
		if arrival_reading.get_child_count() != 3:
			issues.append("a leitura de chegada deve preservar exactamente os três vestígios existentes")
		if not arrival_reading.find_children("*", "Light3D", true, false).is_empty():
			issues.append("a composição contém Light3D proibida")
		if not arrival_reading.find_children("*", "StaticBody3D", true, false).is_empty() or not arrival_reading.find_children("*", "CollisionShape3D", true, false).is_empty():
			issues.append("a composição contém colisão proibida")
		for target: Dictionary in TARGETS:
			var residue: Node3D = arrival_reading.get_node_or_null(String(target["name"])) as Node3D
			if residue == null:
				issues.append("vestígio ausente=%s" % String(target["name"]))
				continue
			if not bool(residue.get_meta("r6_midground_archaeology_composition", false)):
				issues.append("vestígio não marcado=%s" % residue.name)
			var base_position: Vector3 = residue.get_meta("r6_midground_archaeology_base_position", Vector3.INF) as Vector3
			if is_inf(base_position.x) or absf(base_position.x - (target["position"] as Vector3).x) > 0.001 or absf(base_position.z - (target["position"] as Vector3).z) > 0.001:
				issues.append("posição-base alterada=%s" % residue.name)
			if residue.position.distance_to(base_position) > 0.001:
				issues.append("translação proibida=%s" % residue.name)
			if residue.scale.distance_to(target["scale"] as Vector3) > 0.001:
				issues.append("escala inesperada=%s" % residue.name)
			if residue.rotation.distance_to(target["rotation"] as Vector3) > 0.001:
				issues.append("rotação inesperada=%s" % residue.name)
	if issues.is_empty():
		print("[ORIGEM_R6_MIDGROUND_ARCHAEOLOGY_OK] três vestígios existentes ajustados com posições-base, zero luzes, colisores e nós adicionais.")
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R6_MIDGROUND_ARCHAEOLOGY_ERROR] %s" % issue)
	quit(1)
