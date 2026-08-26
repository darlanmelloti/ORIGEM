## R6WaterlineReading.gd
## DEV6-R6-WATERLINE-READING-003
## Vestígios arqueológicos assimétricos junto à bacia, sem luz, shader, emissão ou colisão.

class_name R6WaterlineReading
extends Node3D

const NODE_NAME: String = "R6LeituraArqueologicaDaLinhaDeAgua"
const SET_COUNT: int = 3
const PIECES_PER_SET: int = 3
const R6_MIN_X: float = 0.0
const R6_MAX_X: float = 120.0
const R6_MIN_Z: float = 212.0
const R6_MAX_Z: float = 292.0

static func install(region: Node3D, rock_scene: PackedScene, height_at: Callable) -> R6WaterlineReading:
	if region == null or rock_scene == null or not height_at.is_valid():
		return null
	var existing: R6WaterlineReading = region.get_node_or_null(NODE_NAME) as R6WaterlineReading
	if existing != null:
		return existing
	var reading: R6WaterlineReading = R6WaterlineReading.new()
	reading.name = NODE_NAME
	region.add_child(reading)
	reading._build(rock_scene, height_at)
	return reading

func _build(rock_scene: PackedScene, height_at: Callable) -> void:
	# Cada grupo fica na margem exterior da elipse hídrica (centro 60/252), longe da chegada e das lajes R6→R7.
	var sets: Array[Dictionary] = [
		{
			"name": "ConjuntoArrastadoOcidental",
			"pieces": [
				{"x": 7.5, "z": 225.5, "s": 0.26, "yaw": 0.34, "pitch": 0.06},
				{"x": 13.4, "z": 220.9, "s": 0.18, "yaw": -0.51, "pitch": -0.04},
				{"x": 19.8, "z": 219.6, "s": 0.23, "yaw": 1.12, "pitch": 0.11}
			]
		},
		{
			"name": "ConjuntoDeExpedicaoSetentrional",
			"pieces": [
				{"x": 48.2, "z": 215.7, "s": 0.29, "yaw": -0.45, "pitch": 0.09},
				{"x": 59.4, "z": 214.4, "s": 0.19, "yaw": 0.83, "pitch": -0.07},
				{"x": 71.8, "z": 216.8, "s": 0.33, "yaw": 1.67, "pitch": 0.05}
			]
		},
		{
			"name": "ConjuntoDaMargemOriental",
			"pieces": [
				{"x": 104.6, "z": 234.2, "s": 0.27, "yaw": 0.42, "pitch": -0.08},
				{"x": 110.7, "z": 246.6, "s": 0.35, "yaw": -1.02, "pitch": 0.10},
				{"x": 107.1, "z": 259.8, "s": 0.22, "yaw": 2.06, "pitch": 0.03}
			]
		}
	]
	var total_pieces: int = 0
	for set_index: int in range(sets.size()):
		var spec: Dictionary = sets[set_index]
		var cluster: Node3D = Node3D.new()
		cluster.name = String(spec["name"])
		add_child(cluster)
		var pieces: Array = spec["pieces"] as Array
		for piece_index: int in range(pieces.size()):
			var piece: Dictionary = pieces[piece_index] as Dictionary
			var world_x: float = float(piece["x"])
			var world_z: float = float(piece["z"])
			var rock: Node3D = rock_scene.instantiate() as Node3D
			if rock == null:
				continue
			rock.name = "VestigioLinhaAgua_%02d_%02d" % [set_index + 1, piece_index + 1]
			var scale_value: float = float(piece["s"])
			rock.position = Vector3(world_x, float(height_at.call(world_x, world_z)) + 0.055, world_z)
			rock.scale = Vector3(scale_value, scale_value * (0.56 + 0.13 * float((set_index + piece_index) % 3)), scale_value * (0.78 + 0.10 * float(piece_index)))
			rock.rotation = Vector3(float(piece["pitch"]), float(piece["yaw"]), -0.08 + 0.07 * float((set_index + piece_index) % 3))
			rock.set_meta("r6_waterline_reading", true)
			cluster.add_child(rock)
			total_pieces += 1
	set_meta("r6_waterline_sets", SET_COUNT)
	set_meta("r6_waterline_pieces", total_pieces)
	set_meta("r6_waterline_dynamic_lights", 0)
	print("[ORIGEM_R6_WATERLINE] conjuntos=%d vestigios=%d luzes=0" % [SET_COUNT, total_pieces])

func is_within_r6_bounds(position_3d: Vector3) -> bool:
	return position_3d.x >= R6_MIN_X and position_3d.x <= R6_MAX_X and position_3d.z >= R6_MIN_Z and position_3d.z <= R6_MAX_Z
