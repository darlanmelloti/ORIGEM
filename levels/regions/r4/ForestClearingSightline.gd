## ForestClearingSightline.gd
## DEV4-R4-CLEARING-SIGHTLINE-001
## Clareira aberta de baixo custo; enquadra a leitura distante sem fechar o trilho R4.

class_name R4ForestClearingSightline
extends Node3D

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, rock_scene: PackedScene, fern_scene: PackedScene) -> R4ForestClearingSightline:
	if parent == null:
		return null
	var existing: R4ForestClearingSightline = parent.get_node_or_null("R4ClareiraDaVisadaOrion") as R4ForestClearingSightline
	if existing != null:
		return existing
	var clearing: R4ForestClearingSightline = R4ForestClearingSightline.new()
	clearing.name = "R4ClareiraDaVisadaOrion"
	parent.add_child(clearing)
	clearing._build(path_x_at, height_at, rock_scene, fern_scene)
	return clearing

func _build(path_x_at: Callable, height_at: Callable, rock_scene: PackedScene, fern_scene: PackedScene) -> void:
	# Os quadros laterais deixam uma abertura central de mais de 8 m para leitura da rota e da silhueta distante.
	var frame_specs: Array[Dictionary] = [
		{"z": 130.0, "side": -1.0, "offset": 5.25, "scale": 0.34, "yaw": 0.40},
		{"z": 135.0, "side": 1.0, "offset": 5.70, "scale": 0.28, "yaw": -0.58},
		{"z": 141.5, "side": -1.0, "offset": 6.15, "scale": 0.38, "yaw": 0.22},
		{"z": 147.0, "side": 1.0, "offset": 5.45, "scale": 0.30, "yaw": -0.44}
	]
	var damp_stone: StandardMaterial3D = StandardMaterial3D.new()
	damp_stone.albedo_color = Color(0.082, 0.112, 0.090, 1.0)
	damp_stone.roughness = 0.90
	for index: int in range(frame_specs.size()):
		var spec: Dictionary = frame_specs[index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var path_x: float = float(path_x_at.call(z_value))
		var x_value: float = path_x + side * (spec["offset"] as float)
		var y_value: float = float(height_at.call(x_value, z_value))
		var frame: Node3D = Node3D.new()
		frame.name = "QuadroAbertoOrion_%02d" % (index + 1)
		add_child(frame)
		var rock: Node3D = rock_scene.instantiate() as Node3D
		if rock != null:
			rock.name = "AfloramentoDaClareira_%02d" % (index + 1)
			rock.position = Vector3(x_value, y_value + 0.025, z_value)
			var scale_value: float = spec["scale"] as float
			rock.scale = Vector3(scale_value, scale_value * 0.62, scale_value * 0.86)
			rock.rotation.y = spec["yaw"] as float
			rock.set("material_override", damp_stone)
			frame.add_child(rock)
		for fern_index: int in range(2):
			var fern: Node3D = fern_scene.instantiate() as Node3D
			if fern == null:
				continue
			fern.name = "FetoLateralDaClareira_%02d_%02d" % [index + 1, fern_index + 1]
			var fern_x: float = x_value + side * (0.52 + float(fern_index) * 0.70)
			var fern_z: float = z_value + (-0.72 if fern_index == 0 else 0.68)
			fern.position = Vector3(fern_x, float(height_at.call(fern_x, fern_z)) + 0.02, fern_z)
			var fern_scale: float = 0.27 + float(fern_index) * 0.08
			fern.scale = Vector3(fern_scale, fern_scale, fern_scale)
			fern.rotation.y = side * (0.38 + float(fern_index) * 0.24)
			frame.add_child(fern)
