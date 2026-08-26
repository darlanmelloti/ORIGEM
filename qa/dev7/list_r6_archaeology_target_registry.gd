## Sonda Dev7 — Registo de alvos arqueológicos R6.
## Enumerador somente de leitura: não cria variantes, luzes, colisores ou escritas de produção.
extends SceneTree

const REGION_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const TARGET_SETS: Dictionary = {
	"vestigios_de_entrada": [
		"VestigioDeAproximacaoBacia_",
		"VestigioDaEntradaDaBacia_",
	],
	"marcos_da_captura": [
		"EstelaDaChegada",
		"MarcoRuinaEmergente_",
		"PilarSubmerso_",
		"AfloramentoChegadaRuinas_",
	],
}

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var world := Node3D.new()
	world.name = "Dev7R6TargetRegistryWorld"
	root.add_child(world)
	var region := REGION_SCRIPT.new() as Node3D
	region.name = "R6RuntimeRegistry"
	world.add_child(region)
	await process_frame
	var result: Dictionary = {
		"probe": "DEV7-R6-ARCHAEOLOGY-TARGET-REGISTRY-005",
		"production_mutations": 0,
		"created_light3d": false,
		"created_collision": false,
		"created_override": false,
		"sets": {},
	}
	for set_name in TARGET_SETS.keys():
		var entries: Array = []
		for prefix_variant in TARGET_SETS[set_name]:
			var prefix := str(prefix_variant)
			for mesh in _find_meshes_by_prefix(region, prefix):
				entries.append({
						"prefix": prefix,
						"name": mesh.name,
						"node_path": str(mesh.get_path()),
						"parent_path": str(mesh.get_parent().get_path()) if mesh.get_parent() != null else "",
						"position": [mesh.global_position.x, mesh.global_position.y, mesh.global_position.z],
						"scale": [mesh.global_transform.basis.get_scale().x, mesh.global_transform.basis.get_scale().y, mesh.global_transform.basis.get_scale().z],
						"material_override": mesh.material_override != null,
					})
		result["sets"][set_name] = entries
	print("[ORIGEM_DEV7_R6_TARGET_REGISTRY_OK] %s" % JSON.stringify(result))
	world.queue_free()
	quit(0)

func _find_meshes_by_prefix(root_node: Node, prefix: String) -> Array[MeshInstance3D]:
	var found: Array[MeshInstance3D] = []
	if root_node.name.begins_with(prefix):
		var mesh := _find_first_mesh(root_node)
		if mesh != null:
			found.append(mesh)
	for child in root_node.get_children():
		found.append_array(_find_meshes_by_prefix(child, prefix))
	return found

func _find_first_mesh(root_node: Node) -> MeshInstance3D:
	if root_node is MeshInstance3D:
		return root_node as MeshInstance3D
	for child in root_node.get_children():
		var nested := _find_first_mesh(child)
		if nested != null:
			return nested
	return null
