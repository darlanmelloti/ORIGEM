## ForestClearingLore.gd
## DEV4-R4-ORION-CLEARING-LORE-003
## Leitura ambiental silenciosa para a clareira Orion.
## Não cria UI, texto, colecionáveis, eventos, luzes, colisores ou bloqueios no trilho.

class_name R4ForestClearingLore
extends Node3D

const NODE_NAME: String = "R4LeituraArqueologicaDaClareira"
const CLEARING_START_Z: float = 126.0
const CLEARING_END_Z: float = 151.0
const MIN_PATH_CLEARANCE: float = 4.40

static func install(parent: Node3D, path_x_at: Callable, height_at: Callable, rock_scene: PackedScene) -> R4ForestClearingLore:
	if parent == null or rock_scene == null:
		return null
	var existing: R4ForestClearingLore = parent.get_node_or_null(NODE_NAME) as R4ForestClearingLore
	if existing != null:
		return existing
	var lore: R4ForestClearingLore = R4ForestClearingLore.new()
	lore.name = NODE_NAME
	parent.add_child(lore)
	lore._build(path_x_at, height_at, rock_scene)
	return lore

func _build(path_x_at: Callable, height_at: Callable, rock_scene: PackedScene) -> void:
	# Três sinais materiais de passagem antiga. Os conjuntos ficam laterais para a rota e nunca apontam com UI.
	var cluster_specs: Array[Dictionary] = [
		{"z": 132.0, "side": 1.0, "offset": 4.75, "yaw": -0.38, "scale": 0.21},
		{"z": 139.0, "side": -1.0, "offset": 4.95, "yaw": 0.44, "scale": 0.24},
		{"z": 146.0, "side": 1.0, "offset": 4.70, "yaw": -0.20, "scale": 0.20},
	]
	var worn_stone: StandardMaterial3D = StandardMaterial3D.new()
	worn_stone.albedo_color = Color(0.105, 0.123, 0.102, 1.0)
	worn_stone.roughness = 0.94
	for cluster_index: int in range(cluster_specs.size()):
		var spec: Dictionary = cluster_specs[cluster_index]
		var z_value: float = spec["z"] as float
		var side: float = spec["side"] as float
		var path_x: float = float(path_x_at.call(z_value))
		var x_value: float = path_x + side * (spec["offset"] as float)
		var cluster: Node3D = Node3D.new()
		cluster.name = "VestigioDePassagem_%02d" % (cluster_index + 1)
		cluster.set_meta("r4_lore_environmental", true)
		cluster.set_meta("r4_lore_dynamic_lights", 0)
		add_child(cluster)
		for stone_index: int in range(3):
			var rock: Node3D = rock_scene.instantiate() as Node3D
			if rock == null:
				continue
			var lateral_spread: float = side * (0.40 + float(stone_index) * 0.38)
			var longitudinal_spread: float = -0.56 + float(stone_index) * 0.54
			var stone_x: float = x_value + lateral_spread
			var stone_z: float = z_value + longitudinal_spread
			rock.name = "PedraGasta_%02d_%02d" % [cluster_index + 1, stone_index + 1]
			rock.position = Vector3(stone_x, float(height_at.call(stone_x, stone_z)) + 0.02, stone_z)
			var base_scale: float = spec["scale"] as float
			var scale_factor: float = base_scale * (1.0 - float(stone_index) * 0.14)
			rock.scale = Vector3(scale_factor, scale_factor * 0.48, scale_factor * 0.82)
			rock.rotation.y = (spec["yaw"] as float) + float(stone_index) * 0.31
			_apply_worn_material(rock, worn_stone)
			cluster.add_child(rock)
	set_meta("r4_lore_clusters", cluster_specs.size())
	set_meta("r4_lore_dynamic_lights", 0)
	set_meta("r4_lore_path_clearance", MIN_PATH_CLEARANCE)
	print("[ORIGEM_R4_LORE] vestigios=%d luzes=0 faixa=%.0f-%.0f" % [cluster_specs.size(), CLEARING_START_Z, CLEARING_END_Z])

func _apply_worn_material(root: Node, material: Material) -> void:
	if root is GeometryInstance3D:
		(root as GeometryInstance3D).material_override = material
	for geometry_node: Node in root.find_children("*", "GeometryInstance3D", true, false):
		var geometry: GeometryInstance3D = geometry_node as GeometryInstance3D
		if geometry != null:
			geometry.material_override = material
