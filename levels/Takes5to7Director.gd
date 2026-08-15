@tool
extends Node3D
## ORIGEM Takes 5–7 director.
## Arqueologia Alpina Cinematográfica: organic silhouettes, wet stone, localized P-0 blue.
## This extension is additive to TempleLevel and deliberately avoids greybox meshes.

const ORGANIC_RUIN_KIT_SCRIPT: Script = preload("res://levels/OrganicRuinKit.gd")

var organic_kit: Node3D
var stone_wet: ShaderMaterial
var stone_dark: ShaderMaterial
var moss_stone: ShaderMaterial
var resonance: StandardMaterial3D
var bronze: StandardMaterial3D
var built := false
var validation_camera: Camera3D
var validation_elapsed: float = 0.0
var validation_take_mode: int = 0

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	_build_once()

func _build_once() -> void:
	if built:
		return
	built = true
	_configure_forward_plus_environment()
	_create_materials()
	organic_kit = ORGANIC_RUIN_KIT_SCRIPT.new() as Node3D
	organic_kit.name = "OrganicRuinKit_Takes5to7"
	add_child(organic_kit)
	_build_take_5_cave_threshold()
	_build_take_6_canyon_ascent()
	_build_take_7_open_orion_chamber()
	_build_kharu_tactical_presence()
	var validation_take: String = OS.get_environment("ORIGEM_VALIDATION_TAKE")
	if validation_take == "6":
		call_deferred("_activate_take6_validation_camera")
	elif validation_take == "7":
		call_deferred("_activate_take7_validation_camera")
	elif OS.get_environment("ORIGEM_TAKE57") == "1":
		call_deferred("_activate_validation_camera")

func _configure_forward_plus_environment() -> void:
	var world_environment := get_parent().get_node_or_null("LevelEnvironment/WorldEnvironment") as WorldEnvironment
	if world_environment == null or world_environment.environment == null:
		return
	var environment := world_environment.environment
	environment.sdfgi_enabled = true
	environment.sdfgi_max_distance = 72.0
	environment.sdfgi_cascade0_distance = 12.0
	environment.sdfgi_min_cell_size = 0.2
	environment.glow_enabled = true
	environment.glow_intensity = 0.32
	environment.glow_bloom = 0.10
	environment.fog_density = 0.004

func _create_materials() -> void:
	stone_wet = _organic_material(Color("#343d3a"), 0.88, 0.14, Color("#173522"))
	stone_dark = _organic_material(Color("#111a1a"), 0.96, 0.22, Color("#0b2424"))
	moss_stone = _organic_material(Color("#263d2d"), 0.94, 0.18, Color("#4d7549"))
	resonance = StandardMaterial3D.new()
	resonance.albedo_color = Color("#276e89")
	resonance.emission_enabled = true
	resonance.emission = Color("#5cc8ff")
	resonance.emission_energy_multiplier = 3.2
	resonance.roughness = 0.22
	bronze = StandardMaterial3D.new()
	bronze.albedo_color = Color("#4d3b24")
	bronze.metallic = 0.64
	bronze.roughness = 0.32

func _organic_material(base_color: Color, roughness_value: float, displacement_amount: float, moss_color: Color) -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx;
uniform vec4 base_color : source_color;
uniform vec4 moss_color : source_color;
uniform float displacement_amount = 0.12;
void vertex() {
    float n = sin(VERTEX.x * 3.7 + VERTEX.y * 1.9) * 0.035 + cos(VERTEX.z * 4.3 - VERTEX.y * 1.4) * 0.028;
    VERTEX += NORMAL * (n * displacement_amount * 4.0);
}
void fragment() {
    float moss_mask = smoothstep(0.34, 0.82, NORMAL.y + sin(VERTEX.x * 2.0) * 0.08);
    ALBEDO = mix(base_color.rgb, moss_color.rgb, moss_mask * 0.20);
    ROUGHNESS = %f;
    METALLIC = 0.02;
}
""" % roughness_value
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("base_color", base_color)
	material.set_shader_parameter("moss_color", moss_color)
	material.set_shader_parameter("displacement_amount", displacement_amount)
	return material

func _process(delta: float) -> void:
	if validation_camera == null or not is_instance_valid(validation_camera):
		return
	validation_elapsed += delta
	if validation_take_mode == 6:
		var canyon_travel: float = minf(validation_elapsed * 0.70, 11.0)
		var canyon_sway: float = sin(validation_elapsed * 0.42) * 1.15
		validation_camera.position = Vector3(-2.4 + canyon_sway, 5.6 + sin(validation_elapsed * 0.34) * 0.18, -72.0 - canyon_travel)
		validation_camera.look_at(Vector3(canyon_sway * 0.22, 4.8, -91.0 - canyon_travel), Vector3.UP)
	elif validation_take_mode == 7:
		var sweep: float = sin(validation_elapsed * 0.34) * 0.85
		validation_camera.position = Vector3(sweep, 10.2 + sin(validation_elapsed * 0.28) * 0.18, -86.0 + cos(validation_elapsed * 0.34) * 1.2)
		validation_camera.look_at(Vector3(0.0, 5.6, -105.0), Vector3.UP)
	else:
		var travel: float = minf(validation_elapsed * 0.02, 0.35)
		var lateral: float = sin(validation_elapsed * 0.52) * 2.2
		validation_camera.position = Vector3(lateral, 2.7 + sin(validation_elapsed * 0.52) * 0.08, -28.5 - travel)
		validation_camera.look_at(Vector3(lateral * 0.34, 2.9, -45.0 - travel * 0.45), Vector3.UP)

func _activate_validation_camera() -> void:
	validation_take_mode = 5
	# A validação do Take 5 deve atravessar a boca da caverna, não colidir com o Kharu herdado do prólogo.
	var legacy_enemies := get_parent().get_node_or_null("Enemies") as Node3D
	if legacy_enemies != null:
		legacy_enemies.visible = false
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraValidacaoTakes5a7"
	validation_camera.fov = 68.0
	validation_camera.position = Vector3(0.0, 2.7, -28.5)
	add_child(validation_camera)
	validation_camera.look_at(Vector3(0.0, 2.9, -45.0), Vector3.UP)
	validation_camera.current = true

func _activate_take6_validation_camera() -> void:
	validation_take_mode = 6
	var legacy_enemies := get_parent().get_node_or_null("Enemies") as Node3D
	if legacy_enemies != null:
		legacy_enemies.visible = false
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraValidacaoTake6"
	validation_camera.fov = 60.0
	validation_camera.position = Vector3(-2.4, 5.6, -72.0)
	add_child(validation_camera)
	validation_camera.look_at(Vector3(0.0, 4.8, -91.0), Vector3.UP)
	validation_camera.current = true

func _activate_take7_validation_camera() -> void:
	validation_take_mode = 7
	var legacy_enemies := get_parent().get_node_or_null("Enemies") as Node3D
	if legacy_enemies != null:
		legacy_enemies.visible = false
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraValidacaoTake7"
	validation_camera.fov = 60.0
	validation_camera.position = Vector3(0.0, 10.2, -86.0)
	add_child(validation_camera)
	validation_camera.look_at(Vector3(0.0, 5.6, -105.0), Vector3.UP)
	validation_camera.current = true

func _build_take_5_cave_threshold() -> void:
	var cave := Node3D.new()
	cave.name = "Take5_InteriorDaCaverna"
	cave.position = Vector3(0.0, 0.0, -34.0)
	add_child(cave)
	for index: int in range(10):
		var z := float(index) * -3.1
		_add_organic_rock(cave, Vector3(-7.0 - sin(index * 0.8) * 1.5, 3.6, z), Vector3(3.2, 5.2, 2.7), 510 + index, stone_dark, "ParedeCavernaL_%02d" % index)
		_add_organic_rock(cave, Vector3(7.0 + cos(index * 0.7) * 1.5, 3.4, z - 0.8), Vector3(3.0, 4.8, 2.8), 610 + index, stone_dark, "ParedeCavernaR_%02d" % index)
		if index % 2 == 0:
			_add_resonance_fissure(cave, Vector3(-2.8 + sin(index) * 1.5, 1.2, z - 1.1), 2.0 + index * 0.05)
		_add_brazier(cave, Vector3(-4.2, 1.0, -7.0), "BraseiroAzul_Caverna_L")
		_add_brazier(cave, Vector3(4.2, 1.0, -16.0), "BraseiroAzul_Caverna_R")
		_add_brazier(cave, Vector3(0.0, 1.0, -24.0), "BraseiroAzul_Caverna_Profundo")

func _build_take_6_canyon_ascent() -> void:
	# Take 6 exclusivo: desfiladeiro profundo, sem reabrir ou editar a zona de entrada.
	var canyon := Node3D.new()
	canyon.name = "Take6_DesfiladeiroEVestigios"
	canyon.position = Vector3(0.0, 0.0, -63.0)
	add_child(canyon)
	for index: int in range(16):
		var side: float = -1.0 if index % 2 == 0 else 1.0
		var z: float = -float(index) * 3.2
		var width: float = 6.4 + sin(float(index) * 1.17) * 1.4
		var x: float = side * width
		var ledge_height: float = 1.4 + float(index % 4) * 0.46
		_add_organic_rock(canyon, Vector3(x, ledge_height, z), Vector3(3.4, ledge_height + 0.9, 2.5), 710 + index, stone_wet, "DegrauOrganico_%02d" % index)
		_add_organic_rock(canyon, Vector3(side * (10.5 + sin(float(index) * 0.7)), 5.0 + float(index % 3), z - 1.2), Vector3(5.0, 6.6 + float(index % 3), 4.0), 760 + index, moss_stone, "ParedeTectonica_%02d" % index)
		if index % 3 == 0:
			_add_history_marker(canyon, Vector3(-side * 3.25, ledge_height + 1.1, z - 1.0), index)
		if index % 4 == 1:
			_add_tectonic_fissure(canyon, Vector3(side * (8.7 + sin(float(index)) * 0.5), 4.2, z - 0.8), 3.8 + float(index % 3) * 0.6, side)
	_add_organic_rock(canyon, Vector3(-14.0, 9.0, -24.0), Vector3(7.0, 12.0, 5.8), 880, moss_stone, "ParedeCanyon_L_Profunda")
	_add_organic_rock(canyon, Vector3(14.0, 9.4, -28.0), Vector3(7.2, 12.8, 6.0), 881, moss_stone, "ParedeCanyon_R_Profunda")
	_add_organic_rock(canyon, Vector3(0.0, 0.35, -39.0), Vector3(10.5, 0.8, 5.0), 882, stone_dark, "LeitoFendidoDoCanyon")
	_add_canyon_brazier(canyon, Vector3(-4.6, 1.2, -18.0), "BraseiroAzul_Ascensao_L")
	_add_canyon_brazier(canyon, Vector3(4.6, 1.2, -28.0), "BraseiroAzul_Ascensao_R")
	_add_canyon_brazier(canyon, Vector3(-3.8, 2.0, -39.0), "BraseiroAzul_FendaProfunda")

func _add_tectonic_fissure(parent: Node3D, position_value: Vector3, length_value: float, side: float) -> void:
	var fissure := MeshInstance3D.new()
	fissure.name = "FendaTectonica"
	var mesh := QuadMesh.new()
	mesh.size = Vector2(0.28, length_value)
	mesh.material = resonance
	fissure.mesh = mesh
	fissure.position = position_value
	fissure.rotation_degrees = Vector3(0.0, side * 78.0, 0.0)
	parent.add_child(fissure)
	var light := OmniLight3D.new()
	light.name = "LuzFendaTectonica"
	light.light_color = Color("#5cc8ff")
	light.light_energy = 1.5
	light.omni_range = 7.0
	light.shadow_enabled = false
	light.position = position_value + Vector3(0.0, 0.5, 0.0)
	parent.add_child(light)

func _build_take_7_open_orion_chamber() -> void:
	# Take 7 exclusivo: praça ciclópica, arena tática e Cubo de Orion no santuário aberto.
	var chamber := Node3D.new()
	chamber.name = "Take7_CamaraAbertaDoOrion"
	chamber.position = Vector3(0.0, 0.0, -105.0)
	add_child(chamber)
	for index: int in range(14):
		var angle: float = TAU * float(index) / 14.0
		var radius: float = 12.0 + sin(float(index) * 2.1) * 0.9
		_add_organic_rock(chamber, Vector3(cos(angle) * radius, 4.2 + float(index % 3), sin(angle) * radius), Vector3(1.9, 5.2 + float(index % 3), 1.9), 990 + index, stone_wet, "ColunaCiclopea_%02d" % index)
		if index % 2 == 0:
			_add_history_marker(chamber, Vector3(cos(angle) * 8.9, 1.3, sin(angle) * 8.9), 40 + index)
	for index: int in range(8):
		var slab_angle: float = TAU * float(index) / 8.0
		_add_organic_rock(chamber, Vector3(cos(slab_angle) * 7.4, 0.45, sin(slab_angle) * 7.4), Vector3(2.6, 0.65, 1.5), 1150 + index, stone_dark, "AnelArenaCiclopea_%02d" % index)
	_add_organic_rock(chamber, Vector3(0.0, 0.55, 0.0), Vector3(9.2, 0.75, 9.2), 1080, stone_dark, "DaisCuboOrion")
	_add_organic_rock(chamber, Vector3(0.0, 2.0, -6.4), Vector3(4.8, 3.2, 0.8), 1180, moss_stone, "TronoHistoricoOrion")
	var cube := MeshInstance3D.new()
	cube.name = "CuboDeOrion_Take7"
	var cube_material := StandardMaterial3D.new()
	cube_material.albedo_color = Color("#163c63")
	cube_material.metallic = 0.72
	cube_material.roughness = 0.28
	cube_material.emission_enabled = true
	cube_material.emission = Color("#2f9dff")
	cube_material.emission_energy_multiplier = 1.35
	var cube_mesh := BoxMesh.new()
	cube_mesh.size = Vector3(2.8, 2.8, 2.8)
	cube_mesh.material = cube_material
	cube.mesh = cube_mesh
	cube.position = Vector3(0.0, 6.5, 0.0)
	cube.rotation = Vector3(0.34, 0.48, 0.18)
	chamber.add_child(cube)
	for index: int in range(6):
		_add_brazier(chamber, Vector3(cos(index * TAU / 6.0) * 7.0, 0.9, sin(index * TAU / 6.0) * 7.0), "BraseiroAzul_Camara_%02d" % index)
	var open_light := OmniLight3D.new()
	open_light.name = "LuzDoNucleoOrion"
	open_light.position = Vector3(0.0, 5.5, 0.0)
	open_light.light_color = Color("#5cc8ff")
	open_light.light_energy = 3.2
	open_light.omni_range = 26.0
	open_light.shadow_enabled = true
	chamber.add_child(open_light)

func _build_kharu_tactical_presence() -> void:
	# Take 7 only: a tactical silhouette staged before the Orion plaza.
	var marker := Node3D.new()
	marker.name = "PresencaTacticaSentinelaKharu"
	marker.position = Vector3(0.0, 0.0, -78.0)
	add_child(marker)
	_add_organic_rock(marker, Vector3(0.0, 2.0, -2.0), Vector3(1.7, 3.2, 1.2), 1410, stone_dark, "SilhuetaKharuTorso")
	_add_organic_rock(marker, Vector3(0.0, 4.5, -2.0), Vector3(1.0, 1.1, 0.9), 1411, stone_dark, "SilhuetaKharuMascara")
	_add_organic_rock(marker, Vector3(-1.5, 2.4, -2.0), Vector3(0.42, 2.2, 0.42), 1412, bronze, "ArmaKharuL")
	_add_organic_rock(marker, Vector3(1.5, 2.4, -2.0), Vector3(0.42, 2.2, 0.42), 1413, bronze, "ArmaKharuR")
	for side: float in [-1.0, 1.0]:
		_add_brazier(marker, Vector3(side * 5.4, 1.0, -1.0), "BraseiroKharu_%s" % str(side))
	var sentinel_light := OmniLight3D.new()
	sentinel_light.name = "OlharAzulKharu"
	sentinel_light.position = Vector3(0.0, 3.4, -3.0)
	sentinel_light.light_color = Color("#5cc8ff")
	sentinel_light.light_energy = 2.2
	sentinel_light.omni_range = 12.0
	sentinel_light.shadow_enabled = true
	marker.add_child(sentinel_light)

func _add_organic_rock(parent: Node3D, position_value: Vector3, size_value: Vector3, seed_value: int, material: Material, node_name: String) -> MeshInstance3D:
	var visual := MeshInstance3D.new()
	visual.name = node_name
	visual.mesh = organic_kit.call("_create_rock_mesh", size_value, seed_value) as ArrayMesh
	visual.material_override = material
	visual.position = position_value
	visual.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(visual)
	return visual

func _add_resonance_fissure(parent: Node3D, position_value: Vector3, length_value: float) -> void:
	var fissure := MeshInstance3D.new()
	fissure.name = "FendaDeRessonancia"
	var mesh := QuadMesh.new()
	mesh.size = Vector2(0.16, length_value)
	mesh.material = resonance
	fissure.mesh = mesh
	fissure.position = position_value
	fissure.rotation_degrees.x = -90.0
	parent.add_child(fissure)
	var light := OmniLight3D.new()
	light.light_color = Color("#5cc8ff")
	light.light_energy = 0.6
	light.omni_range = 4.0
	light.position = position_value + Vector3(0.0, 0.4, 0.0)
	parent.add_child(light)

func _add_history_marker(parent: Node3D, position_value: Vector3, index: int) -> void:
	var marker := Node3D.new()
	marker.name = "VestigioHistorico_%02d" % index
	marker.position = position_value
	parent.add_child(marker)
	_add_organic_rock(marker, Vector3.ZERO, Vector3(0.75, 1.8, 0.38), 1300 + index, stone_wet, "Estela")
	_add_resonance_fissure(marker, Vector3(0.0, 0.9, -0.22), 0.8)

func _add_canyon_brazier(parent: Node3D, position_value: Vector3, node_name: String) -> void:
	var brazier := Node3D.new()
	brazier.name = node_name
	brazier.position = position_value
	parent.add_child(brazier)
	_add_organic_rock(brazier, Vector3(0.0, 0.3, 0.0), Vector3(0.8, 0.58, 0.8), 1900 + parent.get_child_count(), bronze, "Base")
	var flame_material := StandardMaterial3D.new()
	flame_material.albedo_color = Color("#2a87a5")
	flame_material.emission_enabled = true
	flame_material.emission = Color("#5cc8ff")
	flame_material.emission_energy_multiplier = 0.9
	flame_material.roughness = 0.24
	var flame := MeshInstance3D.new()
	flame.name = "ChamaCianoControlada"
	var flame_mesh := SphereMesh.new()
	flame_mesh.radius = 0.24
	flame_mesh.height = 0.60
	flame_mesh.material = flame_material
	flame.mesh = flame_mesh
	flame.position.y = 0.9
	brazier.add_child(flame)
	var light := OmniLight3D.new()
	light.name = "LuzCianoControlada"
	light.light_color = Color("#5cc8ff")
	light.light_energy = 1.35
	light.omni_range = 7.0
	light.shadow_enabled = false
	light.position.y = 0.9
	brazier.add_child(light)

func _add_brazier(parent: Node3D, position_value: Vector3, node_name: String) -> void:
	var brazier := Node3D.new()
	brazier.name = node_name
	brazier.position = position_value
	parent.add_child(brazier)
	_add_organic_rock(brazier, Vector3(0.0, 0.3, 0.0), Vector3(0.75, 0.55, 0.75), 1600 + parent.get_child_count(), bronze, "Base")
	var flame := MeshInstance3D.new()
	flame.name = "ChamaAzul"
	var flame_mesh := SphereMesh.new()
	flame_mesh.radius = 0.34
	flame_mesh.height = 0.85
	flame_mesh.material = resonance
	flame.mesh = flame_mesh
	flame.position.y = 1.0
	brazier.add_child(flame)
	var light := OmniLight3D.new()
	light.name = "LuzDoBraseiro"
	light.light_color = Color("#5cc8ff")
	light.light_energy = 2.5
	light.omni_range = 8.0
	light.shadow_enabled = false
	light.position.y = 1.0
	brazier.add_child(light)
