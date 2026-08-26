## ForestMajesticThreshold.gd
## DEV4-R4-FOREST-MAJESTIC-THRESHOLD-022
## Clarificação estática do limiar para Majestic com uma pedra húmida R4 existente, sem criar nós, física ou efeitos.

class_name R4ForestMajesticThreshold
extends Node3D

const NODE_NAME: String = "R4LimiarMajesticFlorestal"
const BAND_START_Z: float = 182.0
const BAND_END_Z: float = 186.0
const MIN_PATH_CLEARANCE: float = 6.4

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, details_root: Node) -> R4ForestMajesticThreshold:
	if parent == null or details_root == null:
		return null
	var existing: R4ForestMajesticThreshold = parent.get_node_or_null(NODE_NAME) as R4ForestMajesticThreshold
	if existing != null:
		return existing
	var threshold: R4ForestMajesticThreshold = R4ForestMajesticThreshold.new()
	threshold.name = NODE_NAME
	parent.add_child(threshold)
	threshold._apply(path_x_at, height_at, details_root)
	return threshold

func _apply(path_x_at: Callable, height_at: Callable, details_root: Node) -> void:
	var adjusted: int = 0
	for child: Node in details_root.get_children():
		if not child is Node3D or not String(child.name).begins_with("PedraHumidaFlorestal_"):
			continue
		var rock: Node3D = child as Node3D
		var z_value: float = rock.position.z
		if z_value < BAND_START_Z or z_value > BAND_END_Z:
			continue
		var side: float = -1.0 if rock.position.x < float(path_x_at.call(z_value)) else 1.0
		var target_z: float = z_value + 0.22
		var target_x: float = float(path_x_at.call(target_z)) + side * 6.62
		if abs(target_x - float(path_x_at.call(target_z))) < MIN_PATH_CLEARANCE:
			continue
		rock.position = Vector3(target_x, float(height_at.call(target_x, target_z)) + 0.035, target_z)
		rock.rotation.y += 0.17
		rock.set_meta("r4_majestic_threshold_static", true)
		adjusted += 1
	set_meta("r4_majestic_threshold_adjusted", adjusted)
	set_meta("r4_majestic_threshold_dynamic_lights", 0)
	print("[ORIGEM_R4_MAJESTIC_THRESHOLD] ajustadas=%d luzes=0" % adjusted)
