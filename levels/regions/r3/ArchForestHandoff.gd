## ArchForestHandoff.gd
## DEV3-R3-FOREST-HANDOFF-002
## Leitura arqueológica aberta após o Arco, sem invadir a responsabilidade estrutural da R4.

class_name R3ArchForestHandoff
extends Node3D

static func install(parent: Node3D, road_x_at: Callable, height_at: Callable, rock_scene: PackedScene, fern_scene: PackedScene, stone_material: Material) -> R3ArchForestHandoff:
	if parent == null:
		return null
	var existing: R3ArchForestHandoff = parent.get_node_or_null("R3HandoffParaFloresta") as R3ArchForestHandoff
	if existing != null:
		return existing
	var handoff: R3ArchForestHandoff = R3ArchForestHandoff.new()
	handoff.name = "R3HandoffParaFloresta"
	parent.add_child(handoff)
	handoff._build(road_x_at, height_at, rock_scene, fern_scene, stone_material)
	return handoff

func _build(road_x_at: Callable, height_at: Callable, rock_scene: PackedScene, fern_scene: PackedScene, stone_material: Material) -> void:
	# A sequência começa depois do Arco e mantém uma faixa central muito superior à largura do jogador.
	var marker_specs: Array[Dictionary] = [
		{"z": 98.0, "side": -1.0, "offset": 5.10, "scale": 0.22, "yaw": 0.26},
		{"z": 102.5, "side": 1.0, "offset": 5.55, "scale": 0.28, "yaw": -0.38},
		{"z": 107.0, "side": -1.0, "offset": 5.75, "scale": 0.20, "yaw": 0.66},
		{"z": 111.5, "side": 1.0, "offset": 6.05, "scale": 0.30, "yaw": -0.54}
	]
	var wet_stone: StandardMaterial3D = StandardMaterial3D.new()
	wet_stone.albedo_color = Color(0.105, 0.135, 0.115, 1.0)
	wet_stone.roughness = 0.84
	for index: int in range(marker_specs.size()):
		var spec: Dictionary = marker_specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var path_x: float = float(road_x_at.call(z_value))
		var x_value: float = path_x + side * (spec["offset"] as float)
		var ground_y: float = float(height_at.call(x_value, z_value))
		var marker_root: Node3D = Node3D.new()
		marker_root.name = "MarcoAbertoPosArco_%02d" % (index + 1)
		add_child(marker_root)
		var rock: Node3D = rock_scene.instantiate() as Node3D
		if rock != null:
			rock.name = "PedraDeOrientacao_%02d" % (index + 1)
			rock.position = Vector3(x_value, ground_y + 0.035, z_value)
			var scale_value: float = spec["scale"] as float
			rock.scale = Vector3(scale_value, scale_value * 0.60, scale_value * 0.88)
			rock.rotation.y = spec["yaw"] as float
			rock.set("material_override", wet_stone if wet_stone != null else stone_material)
			marker_root.add_child(rock)
		for fern_index: int in range(2):
			var fern: Node3D = fern_scene.instantiate() as Node3D
			if fern == null:
				continue
			fern.name = "FetoAbertoPosArco_%02d_%02d" % [index + 1, fern_index + 1]
			var fern_x: float = x_value + side * (0.72 + float(fern_index) * 0.64)
			var fern_z: float = z_value + (-0.52 if fern_index == 0 else 0.64)
			fern.position = Vector3(fern_x, float(height_at.call(fern_x, fern_z)) + 0.02, fern_z)
			var fern_scale: float = 0.24 + float(fern_index) * 0.06
			fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			fern.rotation.y = side * (0.42 + float(fern_index) * 0.28)
			marker_root.add_child(fern)
