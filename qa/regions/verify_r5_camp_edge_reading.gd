extends SceneTree
const FOREST: Script = preload("res://levels/ForestLakeRegion.gd")
class Terrain:
	extends Node3D

	func height_at(_x: float, _z: float) -> float:
		return 0.0
func _init() -> void: call_deferred("_verify")
func _verify() -> void:
	var world := Node3D.new(); root.add_child(world)
	var terrain := Terrain.new(); terrain.name = "TerrainPatch"; world.add_child(terrain)
	var forest := FOREST.new() as Node3D; world.add_child(forest)
	await process_frame; await process_frame
	var camp := forest.get_node_or_null("AcampamentoMajestic") as Node3D
	var count := 0
	if camp != null and bool(camp.get_meta("r5_edge_reading_applied", false)) and int(camp.get_meta("r5_edge_reading_dynamic_lights", -1)) == 0:
		for node: Node in camp.get_children():
			if node is MeshInstance3D and bool(node.get_meta("r5_edge_reading_static", false)):
				count += 1
	if count == 3:
		print("[ORIGEM_R5_EDGE_OK] três rolos existentes ajustados, zero luzes."); quit(); return
	printerr("[ORIGEM_R5_EDGE_ERROR] rolos estáticos=%d" % count); quit(1)
