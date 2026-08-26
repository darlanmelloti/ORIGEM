extends SceneTree

const ORION_START_Z: float = 126.0
const ORION_END_Z: float = 151.0
const MIN_PATH_CLEARANCE: float = 8.0
const INLET_NAME: StringName = &"AfluenteCartograficoRioParaBacia"
const WATER_NAME: StringName = &"LaminaDoAfluenteCartografico"
const DETAIL_CONTAINER: StringName = &"RaizesPedrasESinaisP0"

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script: Script = load("res://levels/ForestLakeRegion.gd") as Script
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var issues: PackedStringArray = PackedStringArray()
	var inlet: Node3D = region.get_node_or_null(NodePath(INLET_NAME)) as Node3D
	if inlet == null:
		issues.append("o afluente cartográfico não foi encontrado")
	else:
		var water: MeshInstance3D = inlet.get_node_or_null(NodePath(WATER_NAME)) as MeshInstance3D
		if water == null:
			issues.append("a lâmina partilhada do afluente está ausente")
		elif water.get_surface_override_material(0) != null:
			issues.append("a lâmina partilhada não pode receber override de material local")
		elif water.mesh == null or water.mesh.surface_get_material(0) == null:
			issues.append("a lâmina partilhada perdeu o material lacustre canónico")
		elif inlet.find_children("*", "Light3D", true, false).size() != 0:
			issues.append("o afluente não pode conter luzes R4")
		elif inlet.find_children("*", "StaticBody3D", true, false).size() != 0:
			issues.append("o afluente não pode conter colisores R4")
	var details: Node3D = region.get_node_or_null(NodePath(DETAIL_CONTAINER)) as Node3D
	if details == null:
		issues.append("o contentor de detalhes ambientais R4 não foi encontrado")
	var inventory: Array[Dictionary] = []
	if details != null:
		for child: Node in details.get_children():
			if not child is MeshInstance3D:
				continue
			var mesh: MeshInstance3D = child as MeshInstance3D
			if not String(mesh.name).begins_with("RaizExpostaFlorestal_"):
				continue
			var z_value: float = mesh.global_position.z
			var clearance: float = abs(mesh.global_position.x - float(region.call("_path_x", z_value)))
			if z_value >= ORION_START_Z and z_value <= ORION_END_Z:
				continue
			if clearance < MIN_PATH_CLEARANCE:
				continue
			if mesh.find_children("*", "Light3D", true, false).size() != 0:
				issues.append("ativo R4 inventariado contém luz: %s" % mesh.name)
				continue
			if mesh.find_children("*", "StaticBody3D", true, false).size() != 0:
				issues.append("ativo R4 inventariado contém colisão: %s" % mesh.name)
				continue
			inventory.append({
				"name": String(mesh.name),
				"z": z_value,
				"clearance": clearance,
				"owner": "Dev4/R4 existente",
				"state": "inventariado; não autorizado para produção"
			})
	if inventory.is_empty():
		issues.append("a auditoria não encontrou margem R4 existente elegível para inventário")
	for entry: Dictionary in inventory:
		print("[ORIGEM_R4_INLET_050_INVENTORY] name=%s z=%.2f clearance=%.2f owner=%s state=%s" % [entry.name, entry.z, entry.clearance, entry.owner, entry.state])
	if issues.is_empty():
		print("[ORIGEM_R4_INLET_050_OK] inventario=%d corredor>=%.2fm; clareira, agua R6 e producao preservadas; nenhuma candidata autorizada." % [inventory.size(), MIN_PATH_CLEARANCE])
		quit()
		return
	for issue: String in issues:
		printerr("[ORIGEM_R4_INLET_050_ERROR] %s" % issue)
	quit(1)
