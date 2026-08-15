extends Node3D

@onready var sun: DirectionalLight3D = $Sun
@onready var world_env: WorldEnvironment = $WorldEnvironment

func _ready() -> void:
	_setup_lighting()

func _setup_lighting() -> void:
	if sun:
		sun.light_color = Color(1.0, 0.9, 0.7)
		sun.light_energy = 2.0
		sun.shadow_enabled = true
		sun.shadow_blur = 1.5
		sun.rotation_degrees = Vector3(-45, 45, 0)
	
	if world_env:
		var env = world_env.environment
		env.background_mode = Environment.BG_SKY
		env.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
		env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
		env.glow_enabled = true
		env.glow_intensity = 0.8
		env.volumetric_fog_enabled = true
		env.volumetric_fog_density = 0.01
		env.volumetric_fog_albedo = Color(0.7, 0.8, 1.0)
