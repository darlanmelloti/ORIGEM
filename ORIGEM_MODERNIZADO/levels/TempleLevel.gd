extends Node3D

var terrain_size := Vector2(250, 250)
var terrain_resolution := 100
var noise := FastNoiseLite.new()

# Sistema de ciclo dia/noite
var day_night_cycle_time: float = 0.0
var day_night_cycle_duration: float = 600.0  # 600 segundos = 24 horas do jogo (5 min dia, 5 min noite)
var sun_moon_node: Node3D = null
var directional_light: DirectionalLight3D = null

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.4, 0.7, 0.9))
	noise.seed = randi()
	noise.frequency = 0.02
	
	_build_temple()
	_build_modern_valley()
	_setup_environment()
	_create_grass_field()
	_create_horizon_mountains()
	_create_structures_system()
	_create_day_night_cycle()
	_create_temple_exit_door()
	_reposition_interactables()

func _process(delta: float) -> void:
	_update_day_night_cycle(delta)

func _setup_environment() -> void:
	var world_env = get_node_or_null("../LevelEnvironment/WorldEnvironment")
	if world_env:
		var env = world_env.environment
		env.background_mode = Environment.BG_SKY
		var sky = Sky.new()
		var sky_mat = PanoramaSkyMaterial.new()
		sky_mat.panorama = load("res://assets/textures/stylized_sky.png")
		sky.sky_material = sky_mat
		env.sky = sky
		
		env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
		env.ssao_enabled = true
		env.sdfgi_enabled = true
		env.glow_enabled = true
		env.glow_intensity = 1.0
		env.glow_bloom = 0.12
		env.fog_enabled = true
		env.fog_density = 0.008
		env.fog_sun_scatter = 0.2

func _build_temple() -> void:
	var mat_dark := StandardMaterial3D.new()
	mat_dark.albedo_color = Color(0.15, 0.10, 0.05)
	mat_dark.roughness = 0.9
	mat_dark.metallic = 0.05
	
	var mat_light := StandardMaterial3D.new()
	mat_light.albedo_color = Color(0.35, 0.25, 0.12)
	mat_light.roughness = 0.55
	mat_light.emission_enabled = true
	mat_light.emission = Color(0.18, 0.12, 0.06)
	mat_light.emission_energy_multiplier = 0.2
	
	var mat_pillar := StandardMaterial3D.new()
	mat_pillar.albedo_color = Color(0.28, 0.22, 0.16)
	mat_pillar.roughness = 0.85
	mat_pillar.metallic = 0.08

	var temple := Node3D.new()
	temple.name = "TempleStructure"
	add_child(temple)
	
	_make_temple_main_chamber(temple, mat_dark, mat_light, mat_pillar)
	_make_temple_entrance(temple, mat_dark, mat_pillar)
	_make_temple_altar_area(temple, mat_light)
	_make_temple_side_chambers(temple, mat_dark)

func _make_temple_main_chamber(parent: Node3D, mat_dark: StandardMaterial3D, mat_light: StandardMaterial3D, mat_pillar: StandardMaterial3D) -> void:
	var main_room := CSGBox3D.new()
	main_room.size = Vector3(20.0, 8.0, 20.0)
	main_room.position = Vector3(0, 2.0, 0)
	main_room.material_override = mat_dark
	main_room.use_collision = true
	parent.add_child(main_room)
	
	var interior_cut := CSGBox3D.new()
	interior_cut.size = Vector3(18.0, 7.0, 18.0)
	interior_cut.operation = CSGShape3D.OPERATION_SUBTRACTION
	interior_cut.position = Vector3(0, 2.5, 0)
	main_room.add_child(interior_cut)
	
	var ceiling_support := CSGBox3D.new()
	ceiling_support.size = Vector3(19.8, 0.8, 19.8)
	ceiling_support.position = Vector3(0, 6.2, 0)
	ceiling_support.material_override = mat_pillar
	ceiling_support.use_collision = true
	parent.add_child(ceiling_support)

func _make_temple_entrance(parent: Node3D, mat_dark: StandardMaterial3D, mat_pillar: StandardMaterial3D) -> void:
	for x_offset in [-4.0, 4.0]:
		var entrance_pillar := CSGCylinder3D.new()
		entrance_pillar.radius = 0.8
		entrance_pillar.height = 4.5
		entrance_pillar.position = Vector3(x_offset, 2.5, -11.0)
		entrance_pillar.material_override = mat_pillar
		entrance_pillar.use_collision = true
		parent.add_child(entrance_pillar)
	
	var entrance_arch := CSGBox3D.new()
	entrance_arch.size = Vector3(10.0, 2.0, 1.2)
	entrance_arch.position = Vector3(0, 5.0, -11.5)
	entrance_arch.material_override = mat_pillar
	entrance_arch.use_collision = true
	parent.add_child(entrance_arch)

func _make_temple_altar_area(parent: Node3D, mat_light: StandardMaterial3D) -> void:
	var altar := CSGBox3D.new()
	altar.size = Vector3(5.0, 1.5, 5.0)
	altar.position = Vector3(0, 3.5, 2.0)
	altar.material_override = mat_light
	altar.use_collision = true
	parent.add_child(altar)
	
	var altar_top := CSGBox3D.new()
	altar_top.size = Vector3(4.0, 0.8, 4.0)
	altar_top.position = Vector3(0, 4.5, 2.0)
	altar_top.material_override = mat_light
	altar_top.use_collision = true
	parent.add_child(altar_top)
	
	var orb_pedestal := CSGCylinder3D.new()
	orb_pedestal.radius = 0.6
	orb_pedestal.height = 1.0
	orb_pedestal.position = Vector3(0, 5.2, 2.0)
	orb_pedestal.material_override = mat_light
	orb_pedestal.use_collision = true
	parent.add_child(orb_pedestal)

func _make_temple_side_chambers(parent: Node3D, mat_dark: StandardMaterial3D) -> void:
	var side_positions := [
		Vector3(-9.0, 2.0, 0.0),
		Vector3(9.0, 2.0, 0.0),
		Vector3(0.0, 2.0, 9.0)
	]
	
	for pos in side_positions:
		var chamber := CSGBox3D.new()
		chamber.size = Vector3(5.0, 5.0, 5.0)
		chamber.position = pos
		chamber.material_override = mat_dark
		chamber.use_collision = true
		parent.add_child(chamber)
		
		var chamber_cut := CSGBox3D.new()
		chamber_cut.size = Vector3(4.0, 4.0, 4.0)
		chamber_cut.operation = CSGShape3D.OPERATION_SUBTRACTION
		chamber_cut.position = pos
		chamber.add_child(chamber_cut)
		
		var pillar := CSGCylinder3D.new()
		pillar.radius = 0.5
		pillar.height = 4.0
		pillar.position = pos + Vector3(1.2, 2.0, 1.2)
		pillar.material_override = mat_dark
		pillar.use_collision = true
		parent.add_child(pillar)

func _create_temple_exit_door() -> void:
	var door_holder := Node3D.new()
	door_holder.name = "TempleExitDoor"
	add_child(door_holder)
	
	var door_frame := CSGBox3D.new()
	door_frame.size = Vector3(3.5, 4.5, 0.4)
	door_frame.position = Vector3(0, 2.5, -12.0)
	var mat_frame := StandardMaterial3D.new()
	mat_frame.albedo_color = Color(0.25, 0.15, 0.08)
	mat_frame.roughness = 0.8
	mat_frame.metallic = 0.15
	door_frame.material_override = mat_frame
	door_frame.use_collision = true
	door_holder.add_child(door_frame)
	
	var door_interior := CSGBox3D.new()
	door_interior.size = Vector3(3.0, 4.0, 0.2)
	door_interior.operation = CSGShape3D.OPERATION_SUBTRACTION
	door_interior.position = Vector3(0, 2.5, -12.0)
	door_frame.add_child(door_interior)
	
	var door_material := StandardMaterial3D.new()
	door_material.albedo_color = Color(0.12, 0.25, 0.4)
	door_material.emission_enabled = true
	door_material.emission = Color(0.2, 0.5, 0.8)
	door_material.emission_energy_multiplier = 1.2
	door_material.metallic = 0.6
	door_material.roughness = 0.3
	
	var door_portal := CSGBox3D.new()
	door_portal.size = Vector3(3.0, 4.0, 0.15)
	door_portal.position = Vector3(0, 2.5, -11.95)
	door_portal.material_override = door_material
	door_holder.add_child(door_portal)
	
	var door_collider := StaticBody3D.new()
	door_collider.name = "TempleExitDoorCollider"
	door_collider.add_to_group("interactable")
	door_collider.position = Vector3(0, 2.5, -12.0)
	door_holder.add_child(door_collider)
	
	var door_collision_shape := CollisionShape3D.new()
	door_collision_shape.shape = BoxShape3D.new()
	door_collision_shape.shape.size = Vector3(3.0, 4.0, 0.5)
	door_collider.add_child(door_collision_shape)
	
	var side_pillars := [Vector3(-2.0, 0.0, 0.0), Vector3(2.0, 0.0, 0.0)]
	for offset in side_pillars:
		var pillar := CSGCylinder3D.new()
		pillar.radius = 0.5
		pillar.height = 5.0
		pillar.position = Vector3(0, 2.5, -12.0) + offset
		var mat_pillar := StandardMaterial3D.new()
		mat_pillar.albedo_color = Color(0.28, 0.22, 0.16)
		mat_pillar.roughness = 0.85
		mat_pillar.metallic = 0.08
		pillar.material_override = mat_pillar
		pillar.use_collision = true
		door_holder.add_child(pillar)

func _create_day_night_cycle() -> void:
	sun_moon_node := Node3D.new()
	sun_moon_node.name = "DayNightCycle"
	add_child(sun_moon_node)
	
	directional_light = get_node_or_null("../LevelEnvironment/Sun")
	
	# Criar o sol como MultiMesh
	var sun_mesh := SphereMesh.new()
	sun_mesh.radius = 8.0
	sun_mesh.height = 16.0
	
	var sun_material := StandardMaterial3D.new()
	sun_material.albedo_color = Color(1.0, 0.85, 0.2, 1.0)
	sun_material.emission_enabled = true
	sun_material.emission = Color(1.0, 0.85, 0.2, 1.0)
	sun_material.emission_energy_multiplier = 1.5
	sun_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	sun_mesh.material = sun_material
	
	var sun_instance := MeshInstance3D.new()
	sun_instance.name = "Sun"
	sun_instance.mesh = sun_mesh
	sun_instance.position = Vector3(0, 60, 80)
	sun_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	sun_moon_node.add_child(sun_instance)
	
	# Criar a lua como MultiMesh
	var moon_mesh := SphereMesh.new()
	moon_mesh.radius = 6.0
	moon_mesh.height = 12.0
	
	var moon_material := StandardMaterial3D.new()
	moon_material.albedo_color = Color(0.8, 0.8, 0.9, 1.0)
	moon_material.emission_enabled = true
	moon_material.emission = Color(0.4, 0.4, 0.6, 1.0)
	moon_material.emission_energy_multiplier = 0.6
	moon_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	moon_mesh.material = moon_material
	
	var moon_instance := MeshInstance3D.new()
	moon_instance.name = "Moon"
	moon_instance.mesh = moon_mesh
	moon_instance.position = Vector3(0, -60, -80)
	moon_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	moon_instance.visible = false
	sun_moon_node.add_child(moon_instance)

func _update_day_night_cycle(delta: float) -> void:
	day_night_cycle_time += delta
	
	# Fazer loop do ciclo
	if day_night_cycle_time >= day_night_cycle_duration:
		day_night_cycle_time = 0.0
	
	# Calcular posição no ciclo (0 a 1)
	var cycle_progress: float = day_night_cycle_time / day_night_cycle_duration
	var sun_node = sun_moon_node.get_node_or_null("Sun")
	var moon_node = sun_moon_node.get_node_or_null("Moon")
	
	if not sun_node or not moon_node:
		return
	
	# Primeira metade do ciclo (12 horas): Sol
	# Segunda metade do ciclo (12 horas): Lua
	if cycle_progress < 0.5:
		# Dia: Sol rotaciona de -90 a +90 graus
		var day_progress := cycle_progress * 2.0  # 0 a 1 durante o dia
		var sun_angle := (day_progress * PI) - (PI / 2.0)  # -90 a +90 graus
		
		sun_node.visible = true
		moon_node.visible = false
		
		# Posicionar sol em arco
		var sun_height := 80.0 * sin(sun_angle + PI / 2.0)
		var sun_distance := 80.0 * cos(sun_angle + PI / 2.0)
		sun_node.position = Vector3(sun_distance, sun_height + 20.0, 80.0)
		
		# Atualizar luz direcional
		if directional_light:
			directional_light.light_energy = 0.3 + (sin(sun_angle + PI / 2.0) * 0.5)
			var sun_color_intensity := maxf(0.0, sin(sun_angle + PI / 2.0))
			directional_light.light_color = Color(1.0, 0.95, 0.80).lerp(Color(0.2, 0.2, 0.3), 1.0 - sun_color_intensity)
	else:
		# Noite: Lua rotaciona de -90 a +90 graus
		var night_progress := (cycle_progress - 0.5) * 2.0  # 0 a 1 durante a noite
		var moon_angle := (night_progress * PI) - (PI / 2.0)  # -90 a +90 graus
		
		sun_node.visible = false
		moon_node.visible = true
		
		# Posicionar lua em arco oposto
		var moon_height := -80.0 * sin(moon_angle + PI / 2.0)
		var moon_distance := -80.0 * cos(moon_angle + PI / 2.0)
		moon_node.position = Vector3(moon_distance, moon_height + 20.0, -80.0)
		
		# Atualizar luz direcional para noite
		if directional_light:
			directional_light.light_energy = 0.1
			directional_light.light_color = Color(0.2, 0.2, 0.3)

func _build_modern_valley() -> void:
	var terrain = _create_terrain()
	add_child(terrain)
	
	_create_river()
	_populate_vegetation()

func _create_terrain() -> MeshInstance3D:
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = terrain_size
	plane_mesh.subdivide_depth = terrain_resolution
	plane_mesh.subdivide_width = terrain_resolution
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	var array_mesh = surface_tool.commit()
	
	var mdt = MeshDataTool.new()
	mdt.create_from_surface(array_mesh, 0)
	
	for i in range(mdt.get_vertex_count()):
		var vertex = mdt.get_vertex(i)
		var h = noise.get_noise_2d(vertex.x, vertex.z) * 15.0
		var dist_to_river = abs(vertex.x - sin(vertex.z * 0.05) * 10.0)
		if dist_to_river < 15.0:
			h -= (15.0 - dist_to_river) * 0.8
		vertex.y = h
		mdt.set_vertex(i, vertex)
	
	array_mesh.clear_surfaces()
	mdt.commit_to_surface(array_mesh)
	
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = array_mesh
	mesh_instance.create_trimesh_collision()
	
	var mat = ShaderMaterial.new()
	mat.shader = load("res://assets/shaders/terrain.gdshader")
	mat.set_shader_parameter("grass_tex", load("res://assets/textures/stylized_grass.png"))
	mat.set_shader_parameter("rock_tex", load("res://assets/textures/stylized_rock.png"))
	mesh_instance.material_override = mat
	
	return mesh_instance

func _create_river() -> void:
	var river_mesh = PlaneMesh.new()
	river_mesh.size = Vector2(15, 250)
	river_mesh.subdivide_depth = 50
	
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = river_mesh
	mesh_instance.position = Vector3(0, -2.5, 0)
	
	var mat = ShaderMaterial.new()
	mat.shader = load("res://assets/shaders/stylized_water.gdshader")
	mat.set_shader_parameter("water_tex", load("res://assets/textures/stylized_water.png"))
	mesh_instance.material_override = mat
	
	add_child(mesh_instance)

func _populate_vegetation() -> void:
	var tree_container = Node3D.new()
	tree_container.name = "Vegetation"
	add_child(tree_container)
	
	for i in range(50):
		var x := randf_range(-100.0, 100.0)
		var z := randf_range(-100.0, 100.0)
		
		# Excluir zonas perto do templo
		if abs(x) < 25.0 and abs(z) < 25.0:
			continue
		# Excluir perto da área de entrada
		if abs(x) < 20.0 and abs(z) > 60.0:
			continue
		
		var y := _get_height_with_river(x, z)
		
		# Não criar árvores na água ou muito baixo
		if y < -1.0:
			continue
		
		var pos := Vector3(x, y, z)
		_spawn_tree(tree_container, pos)

func _spawn_tree(parent: Node3D, pos: Vector3) -> void:
	var tree = Node3D.new()
	tree.position = pos
	parent.add_child(tree)
	
	var trunk = CSGCylinder3D.new()
	trunk.radius = 0.3
	trunk.height = 2.0
	var trunk_mat = StandardMaterial3D.new()
	trunk_mat.albedo_color = Color(0.4, 0.2, 0.1)
	trunk.material_override = trunk_mat
	tree.add_child(trunk)
	
	var leaves = CSGSphere3D.new()
	leaves.position = Vector3(0, 1.5, 0)
	leaves.radius = 1.5
	var leaves_mat = StandardMaterial3D.new()
	leaves_mat.albedo_color = Color(0.2, 0.5, 0.2)
	leaves.material_override = leaves_mat
	tree.add_child(leaves)

func _create_grass_field() -> void:
	var grass_holder := Node3D.new()
	grass_holder.name = "GrassField"
	add_child(grass_holder)

	var blade_mesh := PlaneMesh.new()
	blade_mesh.size = Vector2(0.16, 0.8)
	blade_mesh.orientation = PlaneMesh.FACE_Z

	var blade_material := StandardMaterial3D.new()
	blade_material.albedo_texture = load("res://assets/textures/stylized_grass.png")
	blade_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
	blade_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	blade_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR
	blade_mesh.material = blade_material

	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = blade_mesh
	multimesh.instance_count = 1200

	for i in range(multimesh.instance_count):
		var x := randf_range(-95.0, 95.0)
		var z := randf_range(-95.0, 95.0)
		var y := _get_height(x, z)
		if abs(x) < 24.0 and abs(z) < 24.0:
			continue
		if abs(x) < 15.0 and abs(z) > 70.0:
			continue

		var rotation_y := randf_range(0.0, TAU)
		var scale_y := randf_range(0.8, 1.35)
		var scale_x := randf_range(0.8, 1.1)
		var scale_z := randf_range(0.8, 1.2)
		var basis := Basis.from_euler(Vector3(0.0, rotation_y, 0.0))
		var transform := Transform3D(basis.scaled(Vector3(scale_x, scale_y, scale_z)), Vector3(x, y + 0.08, z))
		multimesh.set_instance_transform(i, transform)

	var grass_node := MultiMeshInstance3D.new()
	grass_node.name = "GrassBlades"
	grass_node.multimesh = multimesh
	grass_node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	grass_holder.add_child(grass_node)

func _create_horizon_mountains() -> void:
	var mountain_holder := Node3D.new()
	mountain_holder.name = "HorizonMountains"
	add_child(mountain_holder)

	var mountain_material := StandardMaterial3D.new()
	mountain_material.albedo_color = Color(0.30, 0.28, 0.25)
	mountain_material.roughness = 0.98

	var mountain_specs := [
		{ "position": Vector3(-90.0, 6.0, -140.0), "width": 26.0, "depth": 18.0, "height": 18.0 },
		{ "position": Vector3(70.0, 5.0, -132.0), "width": 20.0, "depth": 14.0, "height": 16.0 },
		{ "position": Vector3(-30.0, 7.0, -172.0), "width": 32.0, "depth": 22.0, "height": 22.0 },
		{ "position": Vector3(106.0, 4.5, -148.0), "width": 16.0, "depth": 12.0, "height": 14.0 }
	]

	for spec in mountain_specs:
		var mesh_instance := MeshInstance3D.new()
		mesh_instance.name = "Mountain"
		mesh_instance.mesh = _create_mountain_mesh(spec.width, spec.depth, spec.height)
		mesh_instance.material_override = mountain_material
		mesh_instance.position = spec.position
		mesh_instance.rotation.y = randf_range(-0.25, 0.25)
		mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
		mountain_holder.add_child(mesh_instance)

func _create_structures_system() -> void:
	var structures_holder := Node3D.new()
	structures_holder.name = "StructuresSystem"
	add_child(structures_holder)
	
	_create_ruined_columns(structures_holder)
	_create_stone_blocks(structures_holder)
	_create_abandoned_buildings(structures_holder)


func _create_ruined_columns(parent: Node3D) -> void:
	var column_mesh := CylinderMesh.new()
	column_mesh.top_radius = 0.35
	column_mesh.bottom_radius = 0.4
	column_mesh.height = 4.2
	
	var column_material := StandardMaterial3D.new()
	column_material.albedo_color = Color(0.42, 0.38, 0.32)
	column_material.roughness = 0.9
	column_material.metallic = 0.0
	column_mesh.material = column_material
	
	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = column_mesh
	multimesh.instance_count = 45
	
	for i in range(multimesh.instance_count):
		var x := randf_range(-85.0, 85.0)
		var z := randf_range(-85.0, 85.0)
		var y := _get_height_with_river(x, z)
		
		if abs(x) < 20.0 and abs(z) < 20.0:
			continue
		if abs(x) < 15.0:
			continue
		if y < -1.0:
			continue
		
		var height_variation := randf_range(0.6, 1.0)
		var rotation_y := randf_range(0.0, TAU)
		var scale_y := height_variation
		var basis := Basis.from_euler(Vector3(0.0, rotation_y, 0.0))
		var transform := Transform3D(basis.scaled(Vector3(1.0, scale_y, 1.0)), Vector3(x, y + 2.1 * height_variation, z))
		multimesh.set_instance_transform(i, transform)
	
	var column_instance := MultiMeshInstance3D.new()
	column_instance.name = "RuinedColumns"
	column_instance.multimesh = multimesh
	column_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(column_instance)


func _create_stone_blocks(parent: Node3D) -> void:
	var block_mesh := BoxMesh.new()
	block_mesh.size = Vector3(1.2, 0.8, 1.2)
	
	var block_material := StandardMaterial3D.new()
	block_material.albedo_color = Color(0.45, 0.4, 0.35)
	block_material.roughness = 0.88
	block_mesh.material = block_material
	
	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = block_mesh
	multimesh.instance_count = 60
	
	for i in range(multimesh.instance_count):
		var x := randf_range(-90.0, 90.0)
		var z := randf_range(-90.0, 90.0)
		var y := _get_height_with_river(x, z)
		
		if abs(x) < 25.0 and abs(z) < 25.0:
			continue
		if y < -1.0:
			continue
		
		var scale_var := randf_range(0.7, 1.3)
		var rotation_y := randf_range(0.0, TAU)
		var basis := Basis.from_euler(Vector3(randf_range(-0.1, 0.1), rotation_y, randf_range(-0.1, 0.1)))
		var transform := Transform3D(basis.scaled(Vector3(scale_var, randf_range(0.6, 1.2), scale_var)), Vector3(x, y + 0.5, z))
		multimesh.set_instance_transform(i, transform)
	
	var block_instance := MultiMeshInstance3D.new()
	block_instance.name = "StoneBlocks"
	block_instance.multimesh = multimesh
	block_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(block_instance)


func _create_abandoned_buildings(parent: Node3D) -> void:
	var building_material := StandardMaterial3D.new()
	building_material.albedo_color = Color(0.35, 0.30, 0.25)
	building_material.roughness = 0.92
	
	var buildings_holder := Node3D.new()
	buildings_holder.name = "AbandonedBuildings"
	parent.add_child(buildings_holder)
	
	var building_positions := [
		Vector3(-60.0, 0.0, -50.0),
		Vector3(55.0, 0.0, -65.0),
		Vector3(-70.0, 0.0, 40.0),
		Vector3(75.0, 0.0, 55.0),
		Vector3(0.0, 0.0, -70.0),
	]
	
	for building_pos in building_positions:
		var base_y := _get_height_with_river(building_pos.x, building_pos.z)
		if base_y >= -1.0:
			_create_single_ruin(buildings_holder, building_pos + Vector3(0, base_y, 0), building_material)


func _create_single_ruin(parent: Node3D, position: Vector3, material: StandardMaterial3D) -> void:
	var ruin := Node3D.new()
	ruin.position = position
	parent.add_child(ruin)
	
	var wall1 := CSGBox3D.new()
	wall1.size = Vector3(6.0, 3.5, 0.6)
	wall1.position = Vector3(0, 1.8, 0)
	wall1.material_override = material
	wall1.use_collision = true
	ruin.add_child(wall1)
	
	var wall2 := CSGBox3D.new()
	wall2.size = Vector3(0.6, 3.5, 6.0)
	wall2.position = Vector3(2.7, 1.8, 0)
	wall2.material_override = material
	wall2.use_collision = true
	ruin.add_child(wall2)
	
	var roof_fragment := CSGBox3D.new()
	roof_fragment.size = Vector3(4.0, 0.5, 3.0)
	roof_fragment.position = Vector3(-1.0, 3.8, -1.5)
	roof_fragment.rotation.z = randf_range(-0.15, 0.15)
	roof_fragment.material_override = material
	roof_fragment.use_collision = true
	ruin.add_child(roof_fragment)

func _create_mountain_mesh(width: float, depth: float, height: float) -> ArrayMesh:
	var surface_tool := SurfaceTool.new()
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)

	var base_a := Vector3(-width, 0.0, -depth)
	var base_b := Vector3(width, 0.0, -depth)
	var base_c := Vector3(width, 0.0, depth)
	var base_d := Vector3(-width, 0.0, depth)
	var apex := Vector3(0.0, height, 0.0)

	var vertices := [base_a, base_b, base_c, base_d, apex]
	for vertex in vertices:
		surface_tool.add_vertex(vertex)

	var indices := [
		0, 1, 4,
		1, 2, 4,
		2, 3, 4,
		3, 0, 4,
		0, 2, 1,
		0, 3, 2
	]
	for idx in indices:
		surface_tool.add_index(idx)

	surface_tool.generate_normals()
	return surface_tool.commit()

func _reposition_interactables() -> void:
	var interactables = get_node_or_null("../Interactables")
	if interactables:
		var cube = interactables.get_node_or_null("OrionCube")
		if cube: cube.position = Vector3(0, 3.5, 0)
		
		var t1 = interactables.get_node_or_null("Tablet1")
		if t1: t1.position = Vector3(-45, _get_height(-45, -30) + 0.5, -30)
		
		var t2 = interactables.get_node_or_null("Tablet2")
		if t2: t2.position = Vector3(50, _get_height(50, 40) + 0.5, 40)
		
		var t3 = interactables.get_node_or_null("Tablet3")
		if t3: t3.position = Vector3(10, _get_height(10, -80) + 0.5, -80)
		
		var terminal = interactables.get_node_or_null("TerminalP52")
		if terminal: terminal.position = Vector3(0, 3.5, -5)

func _get_height(x: float, z: float) -> float:
	return noise.get_noise_2d(x, z) * 15.0

func _get_height_with_river(x: float, z: float) -> float:
	var h := noise.get_noise_2d(x, z) * 15.0
	var dist_to_river: float = abs(x - sin(z * 0.05) * 10.0)
	if dist_to_river < 15.0:
		h -= (15.0 - dist_to_river) * 0.8
	return h
