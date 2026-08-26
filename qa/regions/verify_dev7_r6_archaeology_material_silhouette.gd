extends SceneTree

const REGION_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const TARGET_PREFIXES: Array[String] = [
	"EstelaDaChegada",
	"MarcoRuinaEmergente_",
	"PilarSubmerso_",
	"AfloramentoChegadaRuinas_",
]
const R6_LIGHT_NAMES: Array[String] = [
	"PreenchimentoMundialDoLago",
	"PreenchimentoOpostoDoLago",
	"PreenchimentoAzulDaMargem",
	"LuzSubaquaticaCentral",
]

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var world := Node3D.new()
	world.name = "Dev7ArchaeologyAuditWorld"
	root.add_child(world)
	var region := REGION_SCRIPT.new() as Node3D
	world.add_child(region)
	await process_frame
	var matched: Array[MeshInstance3D] = []
	for prefix in TARGET_PREFIXES:
		var mesh := _find_mesh_by_prefix(region, prefix)
		if mesh == null:
			_fail("missing_target=%s" % prefix)
			return
		matched.append(mesh)
	var simulated_overrides := 0
	for mesh in matched:
		var material := mesh.get_active_material(0)
		if material is StandardMaterial3D:
			var source := material as StandardMaterial3D
			var simulated := source.duplicate() as StandardMaterial3D
			simulated.albedo_color = source.albedo_color.lerp(Color(0.62, 0.56, 0.43, 1.0), 0.20)
			simulated.roughness = clampf(source.roughness + 0.08, 0.0, 1.0)
			simulated_overrides += 1
	var exact_lights := 0
	for light_name in R6_LIGHT_NAMES:
		if _find_node_by_name(region, light_name) is Light3D:
			exact_lights += 1
	if exact_lights != 4:
		_fail("r6_lights=%d expected=4" % exact_lights)
		return
	print("[ORIGEM_DEV7_R6_ARCHAEOLOGY_AUDIT_OK] meshes=%d simulated_overrides=%d r6_lights=%d production_mutations=0" % [matched.size(), simulated_overrides, exact_lights])
	quit(0)

func _find_mesh_by_prefix(root_node: Node, prefix: String) -> MeshInstance3D:
	if root_node.name.begins_with(prefix):
		if root_node is MeshInstance3D:
			return root_node as MeshInstance3D
		for child in root_node.get_children():
			if child is MeshInstance3D:
				return child as MeshInstance3D
	for child in root_node.get_children():
		var found := _find_mesh_by_prefix(child, prefix)
		if found != null:
			return found
	return null

func _find_node_by_name(root_node: Node, target_name: String) -> Node:
	if root_node.name == target_name:
		return root_node
	for child in root_node.get_children():
		var found := _find_node_by_name(child, target_name)
		if found != null:
			return found
	return null

func _fail(reason: String) -> void:
	printerr("[ORIGEM_DEV7_R6_ARCHAEOLOGY_AUDIT_FAIL] %s" % reason)
	quit(2)
