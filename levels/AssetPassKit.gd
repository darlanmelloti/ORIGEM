## AssetPassKit.gd
## Primeiro passe de ativos reais: modelos GLB CC0 importados, aterrados e colocados
## numa zona curta do Vale de Kheper para substituir os placeholders mais próximos.

extends Node3D

const ROCK_LARGE_A: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")
const ROCK_LARGE_B: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const ROCK_TALL_C: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const ROCK_SMALL_F: PackedScene = preload("res://assets/models_cc0/stone_smallF.glb")
const CLIFF_CAVE: PackedScene = preload("res://assets/models_cc0/cliff_cave_rock.glb")
const CLIFF_SLOPE: PackedScene = preload("res://assets/models_cc0/cliff_blockSlope_rock.glb")
const TREE_OAK: PackedScene = preload("res://assets/models_cc0/tree_oak_dark.glb")
const TREE_DETAILED: PackedScene = preload("res://assets/models_cc0/tree_detailed_dark.glb")
const TREE_DEFAULT: PackedScene = preload("res://assets/models_cc0/tree_default_dark.glb")
const STONE_BRIDGE: PackedScene = preload("res://assets/models_cc0/bridge_stone.glb")

var terrain_patch: Node3D

func _ready() -> void:
	terrain_patch = get_parent().get_node_or_null("TerrainPatch") as Node3D
	_build_asset_pass()

func _build_asset_pass() -> void:
	var pass_root: Node3D = Node3D.new()
	pass_root.name = "AssetPass_AreaInicial"
	add_child(pass_root)

	# Rochas hero: enquadram a praça e quebram a repetição do solo procedural.
	_place_asset(pass_root, ROCK_LARGE_A, Vector3(-10.8, 0.0, 4.8), Vector3(1.45, 1.45, 1.45), -0.35, "RochaHero_A")
	_place_asset(pass_root, ROCK_LARGE_B, Vector3(10.5, 0.0, 1.7), Vector3(1.25, 1.25, 1.25), 0.62, "RochaHero_B")
	_place_asset(pass_root, ROCK_TALL_C, Vector3(-12.8, 0.0, -12.0), Vector3(1.15, 1.25, 1.15), 1.12, "MenirErodido")
	_place_asset(pass_root, ROCK_SMALL_F, Vector3(9.6, 0.0, -18.5), Vector3(1.10, 1.10, 1.10), -0.74, "RochaDoCaminho")
	_place_asset(pass_root, ROCK_SMALL_F, Vector3(-8.8, 0.0, -26.0), Vector3(0.78, 0.78, 0.78), 0.21, "RochaDoCaminho")

	# Falésias de leitura próxima: paredes naturais, em vez de volumes retangulares.
	_place_asset(pass_root, CLIFF_SLOPE, Vector3(-25.0, 0.0, -38.0), Vector3(2.7, 2.7, 2.7), 0.35, "FalésiaDoCaminho")
	_place_asset(pass_root, CLIFF_CAVE, Vector3(28.0, 0.0, -46.0), Vector3(2.9, 2.9, 2.9), -1.25, "GrutaDaMargem")

	# Árvores reais, distribuídas em grupos de silhueta, nunca em linha regular.
	_place_asset(pass_root, TREE_OAK, Vector3(-18.0, 0.0, -6.0), Vector3(1.65, 1.65, 1.65), 0.32, "CarvalhoDaPraca")
	_place_asset(pass_root, TREE_DETAILED, Vector3(17.0, 0.0, -19.0), Vector3(1.35, 1.35, 1.35), -0.52, "ArvoreDaMargem")
	_place_asset(pass_root, TREE_DEFAULT, Vector3(-36.0, 0.0, -48.0), Vector3(1.85, 1.85, 1.85), 0.18, "ArvoreDoArco")
	_place_asset(pass_root, TREE_DETAILED, Vector3(42.0, 0.0, -72.0), Vector3(1.25, 1.25, 1.25), 2.10, "ArvoreDoLago")

	# Ponte real: reforça a rota do lago, mas mantém o caminho existente jogável.
	_place_asset(pass_root, STONE_BRIDGE, Vector3(8.5, 0.0, -57.0), Vector3(2.4, 1.0, 2.4), 0.0, "PonteDePedra")

func _place_asset(parent: Node3D, source: PackedScene, world_position: Vector3, scale_value: Vector3, yaw: float, node_name: String) -> void:
	var asset: Node3D = source.instantiate() as Node3D
	if asset == null:
		return
	asset.name = node_name
	asset.position = world_position
	asset.scale = scale_value
	asset.rotation.y = yaw
	_snap_to_terrain(asset, world_position.x, world_position.z)
	parent.add_child(asset)
	_configure_meshes(asset)

func _snap_to_terrain(asset: Node3D, world_x: float, world_z: float) -> void:
	if terrain_patch != null and terrain_patch.has_method("height_at"):
		asset.position.y = float(terrain_patch.call("height_at", world_x, world_z))

func _configure_meshes(root: Node) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			var mesh_instance: MeshInstance3D = child as MeshInstance3D
			mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
			mesh_instance.visibility_range_end = 95.0
			mesh_instance.visibility_range_end_margin = 12.0
		_configure_meshes(child)
