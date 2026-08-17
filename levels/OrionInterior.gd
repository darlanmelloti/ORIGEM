extends Node3D

const ROCK_DIFFUSE: Texture2D = preload("res://assets/textures/pbr/mossy_rock_diff.jpg")
const ROCK_NORMAL: Texture2D = preload("res://assets/textures/pbr/mossy_rock_normal_gl.jpg")
const ROCK_ROUGHNESS: Texture2D = preload("res://assets/textures/pbr/mossy_rock_roughness.jpg")
const ROCK_LARGE_SCENE: PackedScene = preload("res://assets/models_cc0/stone_largeB.glb")
const ROCK_TALL_SCENE: PackedScene = preload("res://assets/models_cc0/stone_tallC.glb")
const FLOOR_DIFFUSE_PATH: String = "res://assets/textures/ambientcg_rock004/Rock004_1K-JPG_Color.jpg"
const FLOOR_NORMAL_PATH: String = "res://assets/textures/ambientcg_rock004/Rock004_1K-JPG_NormalGL.jpg"
const FLOOR_ROUGHNESS_PATH: String = "res://assets/textures/ambientcg_rock004/Rock004_1K-JPG_Roughness.jpg"
const PLAYER_SCRIPT: Script = preload("res://entities/player/Player.gd")

var player: CharacterBody3D
const RETURN_GATE_POSITION: Vector3 = Vector3(0.0, 0.0, 0.85)

func _ready() -> void:
	_build_environment()
	_build_camera()
	_build_grounded_tunnel()
	_build_player()
	if OS.get_environment("ORIGEM_QA_MEASURE_INTERIOR_ROCKS") == "1":
		_measure_interior_rock_pivots()

func _build_player() -> void:
	player = CharacterBody3D.new()
	player.name = "Player"
	player.set_script(PLAYER_SCRIPT)
	var player_shape: CollisionShape3D = CollisionShape3D.new()
	var capsule: CapsuleShape3D = CapsuleShape3D.new()
	capsule.radius = 0.35
	capsule.height = 1.70
	player_shape.shape = capsule
	player.add_child(player_shape)
	var head: Node3D = Node3D.new()
	head.name = "Head"
	head.position = Vector3(0.0, 0.62, 0.0)
	player.add_child(head)
	var camera: Camera3D = Camera3D.new()
	camera.name = "Camera3D"
	camera.current = true
	head.add_child(camera)
	var interaction_ray: RayCast3D = RayCast3D.new()
	interaction_ray.name = "InteractRay"
	interaction_ray.target_position = Vector3(0.0, 0.0, -2.2)
	interaction_ray.enabled = true
	camera.add_child(interaction_ray)
	var flashlight: SpotLight3D = SpotLight3D.new()
	flashlight.name = "Flashlight"
	flashlight.light_energy = 0.55
	flashlight.spot_range = 8.0
	flashlight.shadow_enabled = false
	camera.add_child(flashlight)
	var footsteps: Timer = Timer.new()
	footsteps.name = "FootstepTimer"
	player.add_child(footsteps)
	add_child(player)
	OrionTransitionState.restore_interior_player(player)
	# A exploração pertence sempre à câmara de Elias; qualquer câmara estática só serve para composição técnica e fica inactiva.
	var static_camera: Camera3D = get_node_or_null("CameraInteriorOrion") as Camera3D
	if static_camera != null:
		static_camera.current = false
	camera.current = true

func _process(_delta: float) -> void:
	if player == null or not is_instance_valid(player):
		return
	if player.global_position.distance_to(RETURN_GATE_POSITION) < 2.1 and Input.is_action_just_pressed("interact"):
		OrionTransitionState.begin_return(player)

func _build_environment() -> void:
	var environment: Environment = Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.027, 0.020, 0.014, 1.0)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.27, 0.205, 0.135, 1.0)
	environment.ambient_light_energy = 0.52
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	var world_environment: WorldEnvironment = WorldEnvironment.new()
	world_environment.environment = environment
	add_child(world_environment)
	var fill: OmniLight3D = OmniLight3D.new()
	fill.name = "LuzDaSoleiraInterior"
	fill.light_color = Color(0.82, 0.58, 0.32, 1.0)
	fill.light_energy = 1.55
	fill.omni_range = 9.0
	fill.shadow_enabled = false
	fill.position = Vector3(-1.35, 1.75, -1.6)
	add_child(fill)
	var route_light: SpotLight3D = SpotLight3D.new()
	route_light.name = "ProjectorDaCurvaInterior"
	route_light.light_color = Color(0.68, 0.46, 0.24, 1.0)
	route_light.light_energy = 1.10
	route_light.spot_range = 9.0
	route_light.spot_angle = 34.0
	route_light.shadow_enabled = false
	route_light.position = Vector3(-0.12, 1.58, -0.55)
	add_child(route_light)
	route_light.look_at(Vector3(-1.95, 0.72, 5.65), Vector3.UP)

func _build_camera() -> void:
	var camera: Camera3D = Camera3D.new()
	camera.name = "CameraInteriorOrion"
	camera.fov = 64.0
	camera.position = Vector3(0.0, 1.20, -1.65)
	# A câmara estática não participa no fluxo de jogo; a câmara de Elias assume controlo no final de _build_player().
	camera.current = false
	add_child(camera)
	camera.look_at(Vector3(-1.10, 0.95, 5.55), Vector3.UP)

func _measure_interior_rock_pivots() -> void:
	for candidate: PackedScene in [ROCK_LARGE_SCENE, ROCK_TALL_SCENE]:
		var root: Node3D = candidate.instantiate() as Node3D
		if root == null:
			continue
		root.visible = false
		add_child(root)
		var bounds: AABB = _recursive_mesh_aabb(root, Transform3D.IDENTITY)
		print("[CP-CINE-43] ROCK_PIVOT asset=%s min_y=%.4f max_y=%.4f" % [candidate.resource_path.get_file(), bounds.position.y, bounds.end.y])
		root.queue_free()

func _recursive_mesh_aabb(node: Node, accumulated: Transform3D) -> AABB:
	var local_transform: Transform3D = accumulated
	if node is Node3D:
		local_transform = accumulated * (node as Node3D).transform
	var has_bounds: bool = false
	var result: AABB = AABB()
	if node is MeshInstance3D and (node as MeshInstance3D).mesh != null:
		result = local_transform * (node as MeshInstance3D).mesh.get_aabb()
		has_bounds = true
	for child: Node in node.get_children():
		var child_bounds: AABB = _recursive_mesh_aabb(child, local_transform)
		if child_bounds.size != Vector3.ZERO:
			result = child_bounds if not has_bounds else result.merge(child_bounds)
			has_bounds = true
	return result if has_bounds else AABB()

func _build_grounded_tunnel() -> void:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_texture = ROCK_DIFFUSE
	material.albedo_color = Color(0.70, 0.61, 0.46, 1.0)
	material.normal_enabled = true
	material.normal_texture = ROCK_NORMAL
	material.normal_scale = 0.62
	material.roughness_texture = ROCK_ROUGHNESS
	material.roughness = 0.81
	material.uv1_triplanar = true
	material.uv1_world_triplanar = true
	material.uv1_scale = Vector3(0.62, 0.62, 0.62)
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	var profile: Array[Vector2] = [Vector2(-2.4, 0.0), Vector2(-2.45, 1.5), Vector2(-1.4, 3.25), Vector2(0.25, 4.05), Vector2(1.72, 3.45), Vector2(2.38, 1.9), Vector2(2.30, 0.0)]
	var rings: Array[float] = [-4.8, -2.5, 0.0, 2.4, 4.9, 7.4]
	var surface: SurfaceTool = SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for ring_index: int in range(rings.size() - 1):
		for profile_index: int in range(profile.size()):
			var next_index: int = (profile_index + 1) % profile.size()
			var a: Vector3 = _profile_point(profile[profile_index], rings[ring_index], ring_index)
			var b: Vector3 = _profile_point(profile[next_index], rings[ring_index], ring_index)
			var c: Vector3 = _profile_point(profile[next_index], rings[ring_index + 1], ring_index + 1)
			var d: Vector3 = _profile_point(profile[profile_index], rings[ring_index + 1], ring_index + 1)
			surface.add_vertex(a); surface.add_vertex(b); surface.add_vertex(c)
			surface.add_vertex(a); surface.add_vertex(c); surface.add_vertex(d)
	var end_center: Vector3 = Vector3(-2.35, 1.9, rings[-1])
	for profile_index: int in range(profile.size()):
		var next_index: int = (profile_index + 1) % profile.size()
		# Ordem virada para o interior: a normal da face de fundo aponta para a câmara e recebe a luz de profundidade.
		surface.add_vertex(end_center)
		surface.add_vertex(_profile_point(profile[profile_index], rings[-1], rings.size() - 1))
		surface.add_vertex(_profile_point(profile[next_index], rings[-1], rings.size() - 1))
	surface.generate_normals()
	var tunnel_mesh: ArrayMesh = surface.commit()
	var tunnel: MeshInstance3D = MeshInstance3D.new()
	tunnel.name = "CorredorDeRochaContinuo"
	tunnel.mesh = tunnel_mesh
	tunnel.material_override = material
	add_child(tunnel)
	_build_curved_floor_overlay(profile, rings)
	var body: StaticBody3D = StaticBody3D.new()
	body.name = "ColisaoDoCorredorInterior"
	var collision: CollisionShape3D = CollisionShape3D.new()
	collision.shape = tunnel_mesh.create_trimesh_shape()
	body.add_child(collision)
	add_child(body)

func _load_external_image_texture(resource_path: String) -> Texture2D:
	var image: Image = Image.load_from_file(ProjectSettings.globalize_path(resource_path))
	if image == null or image.is_empty():
		push_warning("Falha ao carregar textura CC0: %s" % resource_path)
		return null
	return ImageTexture.create_from_image(image)

func _build_curved_floor_overlay(profile: Array[Vector2], rings: Array[float]) -> void:
	var floor_material: StandardMaterial3D = StandardMaterial3D.new()
	floor_material.albedo_texture = _load_external_image_texture(FLOOR_DIFFUSE_PATH)
	floor_material.albedo_color = Color(0.82, 0.76, 0.64, 1.0)
	floor_material.normal_enabled = true
	floor_material.normal_texture = _load_external_image_texture(FLOOR_NORMAL_PATH)
	floor_material.normal_scale = 0.46
	floor_material.roughness_texture = _load_external_image_texture(FLOOR_ROUGHNESS_PATH)
	floor_material.roughness = 0.92
	floor_material.uv1_triplanar = true
	floor_material.uv1_world_triplanar = true
	floor_material.uv1_scale = Vector3(0.72, 0.72, 0.72)
	var floor_surface: SurfaceTool = SurfaceTool.new()
	floor_surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var left_index: int = profile.size() - 1
	var right_index: int = 0
	for ring_index: int in range(rings.size() - 1):
		var left_a: Vector3 = _profile_point(profile[left_index], rings[ring_index], ring_index) + Vector3.UP * 0.008
		var right_a: Vector3 = _profile_point(profile[right_index], rings[ring_index], ring_index) + Vector3.UP * 0.008
		var left_b: Vector3 = _profile_point(profile[left_index], rings[ring_index + 1], ring_index + 1) + Vector3.UP * 0.008
		var right_b: Vector3 = _profile_point(profile[right_index], rings[ring_index + 1], ring_index + 1) + Vector3.UP * 0.008
		floor_surface.add_vertex(left_a); floor_surface.add_vertex(right_b); floor_surface.add_vertex(right_a)
		floor_surface.add_vertex(left_a); floor_surface.add_vertex(left_b); floor_surface.add_vertex(right_b)
	floor_surface.generate_normals()
	var floor_mesh: ArrayMesh = floor_surface.commit()
	var floor: MeshInstance3D = MeshInstance3D.new()
	floor.name = "PisoDePedraDaCaverna"
	floor.mesh = floor_mesh
	floor.material_override = floor_material
	add_child(floor)

func _profile_point(point: Vector2, z_value: float, ring_index: int) -> Vector3:
	var lateral_variation: float = sin(float(ring_index) * 1.41 + point.y) * 0.16
	var vertical_variation: float = cos(float(ring_index) * 0.91 + point.x) * 0.09
	# A partir do terceiro anel, o corredor curva à esquerda: o fundo não é um painel frontal nem um vazio preto.
	var bend: float = -maxf(z_value - 1.0, 0.0) * 0.23
	return Vector3(point.x + lateral_variation + bend, point.y + vertical_variation, z_value)
