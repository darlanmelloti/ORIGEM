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
var validation_elapsed := 0.0

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
	if OS.get_environment("ORIGEM_TAKE57") == "1":
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
	var travel: float = minf(validation_elapsed * 0.02, 0.35)
	var lateral: float = sin(validation_elapsed * 0.52) * 2.2
	validation_camera.position = Vector3(lateral, 2.7 + sin(validation_elapsed * 0.52) * 0.08, -28.5 - travel)
	validation_camera.look_at(Vector3(lateral * 0.34, 2.9, -45.0 - travel * 0.45), Vector3.UP)

func _activate_validation_camera() -> void:
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
	var canyon := Node3D.new()
	canyon.name = "Take6_DesfiladeiroEVestigios"
	canyon.position = Vector3(0.0, 0.0, -63.0)
	add_child(canyon)
	for index: int in range(12):
		var side := -1.0 if index % 2 == 0 else 1.0
		var z := -float(index) * 3.0
		var x := side * (5.5 + sin(index * 1.4) * 1.3)
		_add_organic_rock(canyon, Vector3(x, 1.2 + (index % 3) * 0.42, z), Vector3(2.8, 1.2 + (index % 3) * 0.32, 2.1), 710 + index, stone_wet, "DegrauOrganico_%02d" % index)
		if index % 3 == 0:
			_add_history_marker(canyon, Vector3(-side * 3.1, 1.6, z - 1.0), index)
	_add_organic_rock(canyon, Vector3(-11.0, 5.0, -16.0), Vector3(6.2, 8.0, 5.4), 880, moss_stone, "ParedeCanyon_L")
	_add_organic_rock(canyon, Vector3(11.0, 5.4, -18.0), Vector3(6.0, 8.4, 5.1), 881, moss_stone, "ParedeCanyon_R")
	_add_brazier(canyon, Vector3(-4.6, 1.2, -19.0), "BraseiroAzul_Ascensao_L")
	_add_brazier(canyon, Vector3(4.6, 1.2, -28.0), "BraseiroAzul_Ascensao_R")

func _build_take_7_open_orion_chamber() -> void:
	var chamber := Node3D.new()
	chamber.name = "Take7_CamaraAbertaDoOrion"
	chamber.position = Vector3(0.0, 0.0, -105.0)
	add_child(chamber)
	for index: int in range(12):
		var angle := TAU * float(index) / 12.0
		var radius := 11.0 + sin(index * 2.1) * 0.8
		_add_organic_rock(chamber, Vector3(cos(angle) * radius, 4.2 + (index % 3), sin(angle) * radius), Vector3(1.7, 5.0 + (index % 3), 1.7), 990 + index, stone_wet, "ColunaCiclopea_%02d" % index)
	_add_organic_rock(chamber, Vector3(0.0, 0.55, 0.0), Vector3(8.8, 0.75, 8.8), 1080, stone_dark, "DaisCuboOrion")
	var cube := MeshInstance3D.new()
	cube.name = "CuboDeOrion_Take7"
	var cube_mesh := BoxMesh.new()
	cube_mesh.size = Vector3(2.4, 2.4, 2.4)
	cube_mesh.material = resonance
	cube.mesh = cube_mesh
	cube.position = Vector3(0.0, 6.1, 0.0)
	cube.rotation = Vector3(0.34, 0.48, 0.18)
	chamber.add_child(cube)
	for index: int in range(6):
		_add_brazier(chamber, Vector3(cos(index * TAU / 6.0) * 6.7, 0.9, sin(index * TAU / 6.0) * 6.7), "BraseiroAzul_Camara_%02d" % index)
	var open_light := OmniLight3D.new()
	open_light.name = "LuzDoNucleoOrion"
	open_light.position = Vector3(0.0, 5.5, 0.0)
	open_light.light_color = Color("#5cc8ff")
	open_light.light_energy = 5.0
	open_light.omni_range = 24.0
	open_light.shadow_enabled = true
	chamber.add_child(open_light)

func _build_kharu_tactical_presence() -> void:
	var marker := Node3D.new()
	marker.name = "PresencaTacticaSentinelaKharu"
	marker.position = Vector3(0.0, 0.0, -78.0)
	add_child(marker)
	for side: float in [-1.0, 1.0]:
		_add_brazier(marker, Vector3(side * 5.4, 1.0, -1.0), "BraseiroKharu_%s" % str(side))
	var sentinel_light := OmniLight3D.new()
	sentinel_light.name = "OlharAzulKharu"
	sentinel_light.position = Vector3(0.0, 2.9, -3.0)
	sentinel_light.light_color = Color("#5cc8ff")
	sentinel_light.light_energy = 2.6
	sentinel_light.omni_range = 10.0
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
