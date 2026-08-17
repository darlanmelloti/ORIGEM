## LevelEnvironment.gd
## Ambiente naturalista do Vale de Kheper e adaptador visual do núcleo Chronos.

extends Node3D

# Fallback recuperável: a panorâmica de tempestade também serve como céu temporal de transição quando o HDRI de Kheper não está instalado.
const KHEPER_SKY_HDRI: Texture2D = preload("res://assets/hdri/generated_voss_reference_storm_panorama.png")
const VOSS_STORM_HDRI: Texture2D = preload("res://assets/hdri/generated_voss_reference_storm_panorama.png")

@onready var sun: DirectionalLight3D = $Sun
@onready var world_environment: WorldEnvironment = $WorldEnvironment

var environment: Environment
var active_profile_id: String = ""
var opening_storm_active: bool = false
var opening_house_fill: OmniLight3D
var opening_forest_fill: OmniLight3D

func _ready() -> void:
	_setup_sun()
	_setup_environment()
	EventBus.chronos_profile_changed.connect(_on_chronos_profile_changed)
	call_deferred("_sync_chronos_profile")

func _setup_sun() -> void:
	if sun == null:
		return
	sun.rotation_degrees = Vector3(-48.0, -32.0, 0.0)
	sun.light_color = Color(1.0, 0.93, 0.74)
	sun.light_energy = 1.22
	sun.shadow_enabled = true
	sun.shadow_bias = 0.018
	sun.shadow_normal_bias = 0.90
	sun.directional_shadow_max_distance = 145.0
	sun.directional_shadow_fade_start = 0.74

func _setup_environment() -> void:
	if world_environment == null:
		return
	if world_environment.environment == null:
		world_environment.environment = Environment.new()
	environment = world_environment.environment
	environment.background_mode = Environment.BG_SKY
	environment.sky = _create_daylight_sky()

	environment.background_energy_multiplier = 1.0
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
	# Preenchimento diurno de baixo custo: revela pedra, vegetação e água na abertura sem criar uma luz dinâmica adicional.
	environment.ambient_light_color = Color(0.70, 0.79, 0.76)
	environment.ambient_light_sky_contribution = 0.96
	environment.ambient_light_energy = 1.04
	environment.reflected_light_source = Environment.REFLECTION_SOURCE_SKY
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 1.10
	environment.glow_enabled = false

	# Efeitos de contacto contidos: detalhe nas ruínas sem obscurecer o exterior.
	environment.ssao_enabled = true
	environment.ssao_radius = 0.68
	environment.ssao_intensity = 0.48
	environment.ssao_power = 1.04
	environment.ssao_detail = 0.24
	environment.ssao_horizon = 0.70
	environment.ssao_sharpness = 0.88
	environment.ssr_enabled = true
	environment.ssr_max_steps = 24
	environment.ssr_fade_in = 0.10
	environment.ssr_fade_out = 1.12
	environment.ssr_depth_tolerance = 0.18

	# GI curta para o santuário; o vale ganha profundidade através de céu, sombras e neblina.
	environment.sdfgi_enabled = true
	environment.sdfgi_use_occlusion = true
	environment.sdfgi_read_sky_light = true
	environment.sdfgi_bounce_feedback = 0.14
	environment.sdfgi_cascades = 4
	environment.sdfgi_min_cell_size = 0.50
	environment.sdfgi_cascade0_distance = 12.0
	environment.sdfgi_max_distance = 64.0
	environment.sdfgi_energy = 0.58
	environment.sdfgi_normal_bias = 1.05
	environment.sdfgi_probe_bias = 1.08

	environment.fog_enabled = true
	# CP 211 — neblina litúrgica azulada, menos densa e mais integrada com o céu.
	# A profundidade adicional mantém a montanha legível como destino distante.
	environment.fog_light_color = Color(0.62, 0.76, 0.92)
	environment.fog_light_energy = 0.34
	environment.fog_density = 0.0015
	environment.fog_sky_affect = 0.72
	environment.volumetric_fog_enabled = false
	environment.adjustment_enabled = true
	environment.adjustment_brightness = 1.04
	environment.adjustment_contrast = 1.04
	environment.adjustment_saturation = 1.10

func _sync_chronos_profile() -> void:
	if opening_storm_active:
		return
	if TimelineManager != null:
		_apply_profile(TimelineManager.active_profile_id, TimelineManager.get_active_profile(), false)

func _on_chronos_profile_changed(profile_id: String, profile_data: Dictionary) -> void:
	if opening_storm_active:
		return
	_apply_profile(profile_id, profile_data, true)

func _apply_profile(profile_id: String, profile_data: Dictionary, animate: bool) -> void:
	if environment == null or profile_data.is_empty():
		return
	active_profile_id = profile_id
	var sky_material: ProceduralSkyMaterial = environment.sky.sky_material as ProceduralSkyMaterial
	var sky_top: Color = profile_data.get("sky_top", Color(0.13, 0.38, 0.72))
	var sky_horizon: Color = profile_data.get("sky_horizon", Color(0.72, 0.85, 0.95))
	var ambient: Color = profile_data.get("ambient", environment.ambient_light_color)
	var ambient_energy: float = profile_data.get("ambient_energy", environment.ambient_light_energy)
	var sun_color: Color = profile_data.get("sun_color", sun.light_color)
	var sun_energy: float = profile_data.get("sun_energy", sun.light_energy)
	var fog_color: Color = profile_data.get("fog_color", environment.fog_light_color)
	var fog_density: float = profile_data.get("fog_density", environment.fog_density)
	var saturation: float = profile_data.get("saturation", environment.adjustment_saturation)
	if not animate:
		if sky_material != null:
			sky_material.sky_top_color = sky_top
			sky_material.sky_horizon_color = sky_horizon
		environment.ambient_light_color = ambient
		environment.ambient_light_energy = ambient_energy
		environment.fog_light_color = fog_color
		environment.fog_density = fog_density
		environment.adjustment_saturation = saturation
		if sun != null:
			sun.light_color = sun_color
			sun.light_energy = sun_energy
		return
	var tween: Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	if sky_material != null:
		tween.tween_property(sky_material, "sky_top_color", sky_top, 1.8)
		tween.parallel().tween_property(sky_material, "sky_horizon_color", sky_horizon, 1.8)
	tween.parallel().tween_property(environment, "ambient_light_color", ambient, 1.8)
	tween.parallel().tween_property(environment, "ambient_light_energy", ambient_energy, 1.8)
	tween.parallel().tween_property(environment, "fog_light_color", fog_color, 1.8)
	tween.parallel().tween_property(environment, "fog_density", fog_density, 1.8)
	tween.parallel().tween_property(environment, "adjustment_saturation", saturation, 1.8)
	if sun != null:
		tween.parallel().tween_property(sun, "light_color", sun_color, 1.8)
		tween.parallel().tween_property(sun, "light_energy", sun_energy, 1.8)

func _create_rotated_voss_storm_sky(yaw_offset: float) -> Sky:
	# A mesma panorâmica é rodada no shader; não há fundo plano, nova imagem nem pós-processamento artificial.
	var sky_shader: Shader = Shader.new()
	sky_shader.code = """
shader_type sky;
uniform sampler2D storm_panorama : source_color;
uniform float panorama_yaw = 0.0;

void sky() {
	vec2 panorama_uv = vec2(fract(SKY_COORDS.x + panorama_yaw), SKY_COORDS.y);
	vec3 storm_color = texture(storm_panorama, panorama_uv).rgb;
	// Passe comparativo: uma abertura quente larga, difusa e de baixa intensidade na camada de nuvens.
	float wrap_x = min(abs(panorama_uv.x - 0.50), 1.0 - abs(panorama_uv.x - 0.50));
	float halo_distance = length(vec2(wrap_x, (panorama_uv.y - 0.44) * 0.72));
	float storm_halo = 1.0 - smoothstep(0.035, 0.205, halo_distance);
	storm_halo = storm_halo * storm_halo * 0.78;
	COLOR = storm_color + vec3(0.62, 0.36, 0.135) * storm_halo;
}
"""
	var storm_material: ShaderMaterial = ShaderMaterial.new()
	storm_material.shader = sky_shader
	storm_material.set_shader_parameter("storm_panorama", VOSS_STORM_HDRI)
	storm_material.set_shader_parameter("panorama_yaw", yaw_offset)
	var storm_sky: Sky = Sky.new()
	storm_sky.sky_material = storm_material
	return storm_sky

func apply_voss_daylight() -> void:
	# Variante diurna da Casa Voss: céu azul natural, sol oblíquo limpo e leitura suficiente de rio, lajes e margens.
	opening_storm_active = false
	if environment == null:
		return
	if opening_house_fill != null:
		opening_house_fill.queue_free()
		opening_house_fill = null
	if opening_forest_fill != null:
		opening_forest_fill.queue_free()
		opening_forest_fill = null
	environment.background_mode = Environment.BG_SKY
	# Revelação de dia: o céu mantém a referência dourada, mas a distância continua legível por contraste de valor, não por neblina azul pesada.
	environment.sky = _create_daylight_sky()
	environment.background_energy_multiplier = 1.00
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
	environment.ambient_light_color = Color(0.50, 0.58, 0.52, 1.0)
	environment.ambient_light_energy = 0.94
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.66, 0.74, 0.78, 1.0)
	environment.fog_light_energy = 0.26
	environment.fog_density = 0.0011

	environment.fog_sky_affect = 0.60
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 1.15

	environment.glow_enabled = false
	environment.adjustment_enabled = true
	environment.adjustment_brightness = 1.00
	environment.adjustment_contrast = 1.11
	environment.adjustment_saturation = 0.96

	if sun != null:
		sun.rotation_degrees = Vector3(-32.0, -38.0, 0.0)
		sun.light_color = Color(1.0, 0.80, 0.60, 1.0)
		sun.light_energy = 1.02
		sun.shadow_enabled = true

func apply_voss_opening_daylight() -> void:
	apply_voss_daylight()
	# Bloqueia perfis Chronos concorrentes durante a revelação; restore_timeline_environment repõe este estado no fim.
	opening_storm_active = true

func apply_voss_opening_storm() -> void:
	opening_storm_active = true
	if environment == null:
		return
	# Base aprovada: o halo da panorâmica preserva a leitura da casa e de Orion na tempestade.
	var storm_sky: Sky = _create_rotated_voss_storm_sky(0.23)
	environment.background_mode = Environment.BG_SKY
	environment.sky = storm_sky
	environment.background_energy_multiplier = 0.86
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
	environment.ambient_light_color = Color(0.22, 0.27, 0.31, 1.0)
	environment.ambient_light_energy = 0.32
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.185, 0.215, 0.225, 1.0)
	# Passe comparativo: neblina adicional separa planos e envolve a base de Orion sem recorrer a FogVolume.
	environment.fog_light_energy = 0.58
	environment.fog_density = 0.0220
	environment.fog_sky_affect = 0.70

	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 1.16
	environment.glow_enabled = true
	environment.glow_intensity = 0.62
	environment.glow_strength = 0.76
	environment.glow_bloom = 0.08
	environment.adjustment_enabled = true
	environment.adjustment_brightness = 0.98
	environment.adjustment_contrast = 1.08
	environment.adjustment_saturation = 0.80

	if sun != null:
		sun.rotation_degrees = Vector3(-24.0, 148.0, 0.0)
		sun.light_color = Color(1.0, 0.69, 0.40, 1.0)
		sun.light_energy = 0.075
		sun.shadow_enabled = true
	# Preenchimento no espaço mundial: replica a luz de leitura já validada na pré-visualização sem iluminar a serra.
	if opening_house_fill == null:
		opening_house_fill = OmniLight3D.new()
		opening_house_fill.name = "PreenchimentoAberturaCasaVoss"
		opening_house_fill.position = Vector3(-18.8, 4.5, 14.8)
		opening_house_fill.light_color = Color(0.43, 0.49, 0.56, 1.0)
		opening_house_fill.light_energy = 4.40
		opening_house_fill.omni_range = 18.0
		opening_house_fill.omni_attenuation = 1.30
		opening_house_fill.shadow_enabled = false
		add_child(opening_house_fill)
	# Preenchimento verde-acinzentado baixo: separa copas e troncos do vale sem atingir o pico Orion.
	if opening_forest_fill == null:
		opening_forest_fill = OmniLight3D.new()
		opening_forest_fill.name = "PreenchimentoBosqueAbertura"
		opening_forest_fill.position = Vector3(-24.0, 5.0, -2.0)
		opening_forest_fill.light_color = Color(0.24, 0.31, 0.28, 1.0)
		opening_forest_fill.light_energy = 0.64
		opening_forest_fill.omni_range = 34.0
		opening_forest_fill.omni_attenuation = 2.0
		opening_forest_fill.shadow_enabled = false
		add_child(opening_forest_fill)

func restore_timeline_environment() -> void:
	opening_storm_active = false
	if opening_house_fill != null:
		opening_house_fill.queue_free()
		opening_house_fill = null
	if opening_forest_fill != null:
		opening_forest_fill.queue_free()
		opening_forest_fill = null
	# A abertura devolve o controlo a Elias no perfil de crepúsculo; o Chronos só substitui este estado numa transição temporal explícita.
	apply_voss_daylight()

func _create_daylight_sky() -> Sky:
	# Shader de céu explícito: mantém o azul e os cúmulos leves também no renderizador de captura GL.
	var sky_shader: Shader = Shader.new()
	sky_shader.code = """
shader_type sky;

float hash21(vec2 p) {
	p = fract(p * vec2(123.34, 345.45));
	p += dot(p, p + 34.345);
	return fract(p.x * p.y);
}

float value_noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);
	return mix(mix(hash21(i), hash21(i + vec2(1.0, 0.0)), f.x), mix(hash21(i + vec2(0.0, 1.0)), hash21(i + vec2(1.0, 1.0)), f.x), f.y);
}

void sky() {
	vec3 view_dir = normalize(EYEDIR);
	float horizon = smoothstep(-0.10, 0.88, view_dir.y);
	vec3 horizon_color = vec3(0.63, 0.80, 0.94);
	vec3 zenith_color = vec3(0.055, 0.30, 0.67);
	vec3 color = mix(horizon_color, zenith_color, horizon);
	// Gradiente limpo de céu: evita costuras entre faces do cubemap no renderizador de captura.
	COLOR = color;
}
"""
	var sky_material: ShaderMaterial = ShaderMaterial.new()
	sky_material.shader = sky_shader
	var sky: Sky = Sky.new()
	sky.sky_material = sky_material
	return sky

func _create_liturgical_twilight_sky() -> Sky:
	var sky_shader: Shader = Shader.new()
	sky_shader.code = """
shader_type sky;
void sky() {
	vec3 view_dir = normalize(EYEDIR);
	float horizon = smoothstep(-0.16, 0.84, view_dir.y);
	vec3 horizon_color = vec3(0.13, 0.20, 0.28);
	vec3 zenith_color = vec3(0.008, 0.018, 0.055);
	float warm_band = exp(-pow((view_dir.y - 0.10) * 9.5, 2.0));
	vec3 color = mix(horizon_color, zenith_color, horizon);
	COLOR = color + vec3(0.12, 0.045, 0.018) * warm_band;
}
"""
	var sky_material: ShaderMaterial = ShaderMaterial.new()
	sky_material.shader = sky_shader
	var sky: Sky = Sky.new()
	sky.sky_material = sky_material
	return sky

func _create_temporal_sky() -> Sky:
	return _create_daylight_sky()
