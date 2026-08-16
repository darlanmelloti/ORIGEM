@tool
extends Node3D
## ORIGEM Takes 5–7 director.
## Arqueologia Alpina Cinematográfica: organic silhouettes, wet stone, localized P-0 blue.
## This extension is additive to TempleLevel and deliberately avoids greybox meshes.

const ORGANIC_RUIN_KIT_SCRIPT: Script = preload("res://levels/OrganicRuinKit.gd")
const REGION8_WAYFINDING_ROCK: PackedScene = preload("res://assets/models_cc0/stone_largeA.glb")

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
	_build_take_8_temporal_echo()
	_build_kharu_tactical_presence()
	var validation_take: String = OS.get_environment("ORIGEM_VALIDATION_TAKE")
	if validation_take == "6":
		call_deferred("_activate_take6_validation_camera")
	elif validation_take == "7":
		call_deferred("_activate_take7_validation_camera")
	elif validation_take == "8":
		call_deferred("_activate_take8_validation_camera")
	elif OS.get_environment("ORIGEM_VALIDATION_REGION") == "7":
		call_deferred("_activate_region7_validation_camera")
	elif OS.get_environment("ORIGEM_VALIDATION_REGION") == "8":
		call_deferred("_activate_region8_validation_camera")
	elif OS.get_environment("ORIGEM_VALIDATION_REGION") == "10":
		call_deferred("_activate_region10_validation_camera")
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
	resonance.albedo_color = Color("#163c56")
	resonance.emission_enabled = true
	resonance.emission = Color("#5cc8ff")
	resonance.emission_energy_multiplier = 0.82
	resonance.roughness = 0.22
	bronze = StandardMaterial3D.new()
	bronze.albedo_color = Color("#4d3b24")
	bronze.metallic = 0.64
	bronze.roughness = 0.32

func _apply_material(root: Node, material: Material) -> void:
	for child: Node in root.get_children():
		if child is MeshInstance3D:
			(child as MeshInstance3D).material_override = material
		_apply_material(child, material)

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
		# Take 7 only: clear northern approach, below the column crowns, with a readable Cube-to-arena axis.
		var sweep: float = sin(validation_elapsed * 0.30) * 1.30
		var approach: float = cos(validation_elapsed * 0.24) * 0.7
		validation_camera.position = Vector3(sweep, 5.7 + sin(validation_elapsed * 0.28) * 0.14, -78.0 + approach)
		validation_camera.look_at(Vector3(0.0, 4.8, -103.0), Vector3.UP)
	elif validation_take_mode == 8:
		var orbit: float = validation_elapsed * 0.22
		validation_camera.position = Vector3(-112.0 + sin(orbit) * 1.8, 53.0 + sin(validation_elapsed * 0.31) * 0.14, 543.0 + cos(orbit) * 2.0)
		validation_camera.look_at(Vector3(-116.0, 48.0, 562.0), Vector3.UP)
	elif validation_take_mode == 9:
		var village_sweep: float = sin(validation_elapsed * 0.18) * 1.6
		validation_camera.position = Vector3(112.0 + village_sweep, 19.0 + sin(validation_elapsed * 0.22) * 0.20, 330.0)
		validation_camera.look_at(Vector3(140.0, 12.0, 354.0), Vector3.UP)
	elif validation_take_mode == 10:
		var observatory_sweep: float = sin(validation_elapsed * 0.20) * 2.2
		validation_camera.position = Vector3(188.0 + observatory_sweep * 0.45, 39.0 + sin(validation_elapsed * 0.24) * 0.12, 398.0)
		validation_camera.look_at(Vector3(194.0, 37.0, 404.0), Vector3.UP)
	elif validation_take_mode == 11:
		var trail_progress: float = minf(validation_elapsed * 0.16, 1.0)
		var trail_sway: float = sin(validation_elapsed * 0.35) * 1.4
		validation_camera.position = Vector3(178.0 - trail_progress * 30.0 + trail_sway, 56.0 + sin(validation_elapsed * 0.25) * 0.12, 420.0 + trail_progress * 24.0)
		validation_camera.look_at(Vector3(138.0 - trail_progress * 26.0, 28.0, 446.0 + trail_progress * 25.0), Vector3.UP)
	elif validation_take_mode == 12:
		var close_travel: float = minf(validation_elapsed * 0.08, 1.0)
		validation_camera.position = Vector3(210.0 - close_travel * 22.0, 46.0 + sin(validation_elapsed * 0.25) * 0.10, 404.0 + close_travel * 12.0)
		validation_camera.look_at(Vector3(174.0 - close_travel * 12.0, 29.0, 414.0 + close_travel * 13.0), Vector3.UP)
	elif validation_take_mode == 14:
		var trail_validation_progress: float = minf(validation_elapsed * 0.12, 1.0)
		var trail_validation_sway: float = sin(validation_elapsed * 0.24) * 1.1
		validation_camera.position = Vector3(184.0 - trail_validation_progress * 42.0 + trail_validation_sway, 35.0 + sin(validation_elapsed * 0.20) * 0.12, 398.0 + trail_validation_progress * 34.0)
		validation_camera.look_at(Vector3(168.0 - trail_validation_progress * 40.0, 25.0, 420.0 + trail_validation_progress * 30.0), Vector3.UP)
	elif validation_take_mode == 13:
		var cave_travel: float = minf(validation_elapsed * 0.045, 1.0)
		var cave_sway: float = sin(validation_elapsed * 0.28) * 0.85
		validation_camera.position = Vector3(-100.0 - cave_travel * 4.0 + cave_sway, 48.0 - cave_travel * 2.0 + sin(validation_elapsed * 0.24) * 0.14, 524.0 + cave_travel * 10.0)
		validation_camera.look_at(Vector3(-116.0, 41.0 - cave_travel * 1.0, 538.0 + cave_travel * 2.0), Vector3.UP)
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
	validation_camera.position = Vector3(0.0, 5.7, -78.0)
	add_child(validation_camera)
	validation_camera.look_at(Vector3(0.0, 4.8, -103.0), Vector3.UP)
	validation_camera.current = true

func _activate_take8_validation_camera() -> void:
	validation_take_mode = 8
	var legacy_enemies := get_parent().get_node_or_null("Enemies") as Node3D
	if legacy_enemies != null:
		legacy_enemies.visible = false
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraValidacaoTake8"
	validation_camera.fov = 58.0
	validation_camera.position = Vector3(0.0, 6.2, -112.2)
	add_child(validation_camera)
	validation_camera.look_at(Vector3(0.0, 4.2, -121.0), Vector3.UP)
	validation_camera.current = true

func _activate_region7_validation_camera() -> void:
	validation_take_mode = 9
	var legacy_enemies := get_parent().get_node_or_null("Enemies") as Node3D
	if legacy_enemies != null:
		legacy_enemies.visible = false
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraValidacaoRegiao07"
	validation_camera.fov = 56.0
	validation_camera.position = Vector3(112.0, 19.0, 330.0)
	add_child(validation_camera)
	validation_camera.look_at(Vector3(140.0, 12.0, 354.0), Vector3.UP)
	validation_camera.current = true

func _activate_region10_validation_camera() -> void:
	validation_take_mode = 13
	var legacy_enemies := get_parent().get_node_or_null("Enemies") as Node3D
	if legacy_enemies != null:
		legacy_enemies.visible = false
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraValidacaoRegiao10CavernaOrion"
	validation_camera.fov = 58.0
	add_child(validation_camera)
	var cave_node := get_parent().get_node_or_null("DestinosOrionEHubTemporal/CavernaDoOrion") as Node3D
	var cave_origin: Vector3 = cave_node.global_position if cave_node != null else Vector3(-116.0, 42.0, 548.0)
	validation_camera.global_position = cave_origin + Vector3(10.0, 6.0, 10.0)
	validation_camera.look_at(cave_origin + Vector3(0.0, 4.2, -8.0), Vector3.UP)
	validation_camera.current = true
	call_deferred("_hide_region10_later_landmarks")

func _hide_region10_later_landmarks() -> void:
	var destinations := get_parent().get_node_or_null("DestinosOrionEHubTemporal") as Node3D
	if destinations != null:
		_hide_region10_node_recursive(destinations)
		var approach := destinations.get_node_or_null("TransicaoRegiao09Para10") as Node3D
		if approach != null:
			approach.visible = false
	var temporal_echo := get_node_or_null("Take8_EcoTemporal") as Node3D
	if temporal_echo != null:
		temporal_echo.visible = false
	_hide_region10_auxiliary_markers(get_parent())

func _hide_region10_auxiliary_markers(node: Node) -> void:
	if node.name.contains("Fenda") or node.name.contains("Degrau") or node.name.contains("Wayfinding"):
		node.visible = false
		return
	for child in node.get_children():
		_hide_region10_auxiliary_markers(child)

func _hide_region10_node_recursive(node: Node) -> void:
	if node.name in ["CamaraDoOrionCube", "CuboOrion", "NucleoTemporal"]:
		node.visible = false
		return
	for child in node.get_children():
		_hide_region10_node_recursive(child)

func _activate_region8_validation_camera() -> void:
	validation_take_mode = 14 if OS.get_environment("ORIGEM_REGION8_TRAIL") == "1" else (12 if OS.get_environment("ORIGEM_REGION8_TO9_CLOSE") == "1" else (11 if OS.get_environment("ORIGEM_REGION8_TO9") == "1" else 10))
	var legacy_enemies := get_parent().get_node_or_null("Enemies") as Node3D
	if legacy_enemies != null:
		legacy_enemies.visible = false
	if validation_take_mode == 14:
		var observatory := get_tree().root.find_child("ObservatorioDaOrion", true, false) as Node3D
		if observatory != null:
			observatory.visible = false
		_build_region8_validation_wayfinding()
	validation_camera = Camera3D.new()
	validation_camera.name = "CameraValidacaoTrilhaRegiao08" if validation_take_mode == 14 else ("CameraValidacaoRegiao08Para09" if validation_take_mode == 11 else "CameraValidacaoRegiao08")
	validation_camera.fov = 64.0 if validation_take_mode == 14 else (50.0 if validation_take_mode == 12 else (54.0 if validation_take_mode == 10 else 58.0))
	if validation_take_mode == 14:
		validation_camera.position = Vector3(184.0, 35.0, 398.0)
		add_child(validation_camera)
		validation_camera.look_at(Vector3(168.0, 25.0, 420.0), Vector3.UP)
	elif validation_take_mode == 12:
		validation_camera.position = Vector3(210.0, 46.0, 404.0)
		add_child(validation_camera)
		validation_camera.look_at(Vector3(174.0, 29.0, 414.0), Vector3.UP)
	elif validation_take_mode == 11:
		validation_camera.position = Vector3(178.0, 56.0, 420.0)
		add_child(validation_camera)
		validation_camera.look_at(Vector3(138.0, 28.0, 446.0), Vector3.UP)
	else:
		validation_camera.position = Vector3(188.0, 39.0, 398.0)
		add_child(validation_camera)
		validation_camera.look_at(Vector3(194.0, 37.0, 404.0), Vector3.UP)
	validation_camera.current = true
	print("[CP_D2_002_CAMERA] mode=%d name=%s position=%s" % [validation_take_mode, validation_camera.name, str(validation_camera.position)])

func _build_region8_validation_wayfinding() -> void:
	var wayfinding := Node3D.new()
	wayfinding.name = "CPD2_WayfindingOrganicoRegiao08"
	var positions: Array[Vector2] = [
		Vector2(176.0, 416.0),
		Vector2(168.0, 424.0),
		Vector2(158.0, 434.0),
		Vector2(148.0, 444.0),
		Vector2(138.0, 454.0)
	]
	var observatory := get_tree().root.find_child("ObservatorioDaOrion", true, false) as Node3D
	var highlands := observatory.get_parent() as Node3D if observatory != null else null
	for index: int in range(positions.size()):
		var marker := REGION8_WAYFINDING_ROCK.instantiate() as Node3D
		if marker == null:
			continue
		marker.name = "MarcoOrganicoCPD2_%02d" % index
		var point := positions[index]
		var validation_ground_height: float = 32.8 + float(index) * 0.35
		marker.position = Vector3(point.x, validation_ground_height, point.y)
		marker.scale = Vector3(1.05, 1.62, 1.05)
		marker.rotation = Vector3(0.04, float(index) * 0.42, -0.03)
		_apply_material(marker, stone_dark)
		if index % 2 == 0:
			var marker_light := OmniLight3D.new()
			marker_light.name = "LuzWayfindingCPD2_%02d" % index
			marker_light.light_color = Color("#5ca9b8")
			marker_light.light_energy = 0.42
			marker_light.omni_range = 5.0
			marker_light.shadow_enabled = false
			marker_light.position = Vector3(0.0, 1.8, 0.0)
			marker.add_child(marker_light)
		wayfinding.add_child(marker)
	add_child(wayfinding)

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
		var radius: float = 13.5 + sin(float(index) * 2.1) * 0.8
		_add_organic_rock(chamber, Vector3(cos(angle) * radius, 4.2 + float(index % 3), sin(angle) * radius), Vector3(1.55, 4.4 + float(index % 3) * 0.8, 1.55), 990 + index, stone_wet, "ColunaCiclopea_%02d" % index)
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
	cube_material.emission = Color("#176fb8")
	cube_material.emission_energy_multiplier = 0.72
	var cube_mesh := BoxMesh.new()
	cube_mesh.size = Vector3(2.8, 2.8, 2.8)
	cube_mesh.material = cube_material
	cube.mesh = cube_mesh
	cube.position = Vector3(0.0, 6.5, 0.0)
	cube.rotation = Vector3(0.34, 0.48, 0.18)
	chamber.add_child(cube)
	for index: int in range(6):
		_add_canyon_brazier(chamber, Vector3(cos(index * TAU / 6.0) * 7.0, 0.9, sin(index * TAU / 6.0) * 7.0), "BraseiroCiano_Camara_%02d" % index)
	var open_light := OmniLight3D.new()
	open_light.name = "LuzDoNucleoOrion"
	open_light.position = Vector3(0.0, 5.5, 0.0)
	open_light.light_color = Color("#5cc8ff")
	open_light.light_energy = 1.8
	open_light.omni_range = 22.0
	open_light.shadow_enabled = true
	chamber.add_child(open_light)

func _build_take_8_temporal_echo() -> void:
	# Região 11 / Take 20–21: mecanismo temporal na Câmara do Orion Cube.
	# O marco é co-localizado com o destino regional oficial, sem reabrir as Regiões 1–6.
	var echo := Node3D.new()
	echo.name = "Take8_EcoTemporal"
	echo.position = Vector3(-116.0, 48.0, 562.0)
	add_child(echo)
	_add_organic_rock(echo, Vector3(0.0, -0.2, 0.0), Vector3(10.5, 0.7, 7.5), 1520, stone_dark, "PlataformaEcoTemporal")
	# Região 11: moldura de rocha orgânica para a câmara vertical; o Hub Temporal permanece exterior e separado.
	_add_organic_rock(echo, Vector3(-8.8, 4.6, 3.6), Vector3(3.4, 6.8, 2.8), 1530, stone_dark, "ParedeOrionCube_L")
	_add_organic_rock(echo, Vector3(8.8, 4.8, 3.8), Vector3(3.6, 7.2, 3.0), 1531, stone_dark, "ParedeOrionCube_R")
	_add_organic_rock(echo, Vector3(0.0, 8.8, 5.4), Vector3(8.5, 3.2, 2.6), 1532, moss_stone, "AbobadaOrionCube")
	_add_organic_rock(echo, Vector3(-5.8, 3.2, -5.0), Vector3(2.5, 4.8, 2.3), 1533, moss_stone, "RochaGaleria_L")
	_add_organic_rock(echo, Vector3(5.6, 3.0, -5.2), Vector3(2.7, 4.6, 2.4), 1534, moss_stone, "RochaGaleria_R")
	for index: int in range(3):
		var ring := MeshInstance3D.new()
		ring.name = "AnelTemporal_%02d" % index
		var ring_mesh := TorusMesh.new()
		ring_mesh.inner_radius = 3.0 + float(index) * 1.7
		ring_mesh.outer_radius = ring_mesh.inner_radius + 0.10
		ring_mesh.rings = 48
		ring_mesh.ring_segments = 12
		ring_mesh.material = resonance
		ring.mesh = ring_mesh
		ring.position = Vector3(0.0, 3.0 + float(index) * 1.25, -float(index) * 0.8)
		ring.rotation_degrees = Vector3(90.0, float(index) * 11.0, 0.0)
		echo.add_child(ring)
	for index: int in range(5):
		var angle: float = TAU * float(index) / 5.0
		_add_history_marker(echo, Vector3(cos(angle) * 7.0, 1.0, sin(angle) * 4.6), 80 + index)
		_add_resonance_fissure(echo, Vector3(cos(angle) * 4.2, 0.8, sin(angle) * 2.4), 1.4)
	var echo_light := OmniLight3D.new()
	echo_light.name = "LuzEcoTemporal"
	echo_light.position = Vector3(0.0, 4.5, 0.0)
	echo_light.light_color = Color("#6f8cff")
	echo_light.light_energy = 1.4
	echo_light.omni_range = 18.0
	echo_light.shadow_enabled = true
	echo.add_child(echo_light)

func _build_kharu_tactical_presence() -> void:
	# Take 7 only: a tactical silhouette staged before the Orion plaza.
	var marker := Node3D.new()
	marker.name = "PresencaTacticaSentinelaKharu"
	marker.position = Vector3(0.0, 0.0, -94.0)
	add_child(marker)
	_add_organic_rock(marker, Vector3(0.0, 2.0, -2.0), Vector3(1.7, 3.2, 1.2), 1410, stone_dark, "SilhuetaKharuTorso")
	_add_organic_rock(marker, Vector3(0.0, 4.5, -2.0), Vector3(1.0, 1.1, 0.9), 1411, stone_dark, "SilhuetaKharuMascara")
	_add_organic_rock(marker, Vector3(-1.5, 2.4, -2.0), Vector3(0.42, 2.2, 0.42), 1412, bronze, "ArmaKharuL")
	_add_organic_rock(marker, Vector3(1.5, 2.4, -2.0), Vector3(0.42, 2.2, 0.42), 1413, bronze, "ArmaKharuR")
	for side: float in [-1.0, 1.0]:
		_add_canyon_brazier(marker, Vector3(side * 5.4, 1.0, -1.0), "BraseiroCianoKharu_%s" % str(side))
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
