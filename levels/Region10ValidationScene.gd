extends Node3D
## Região 10 validation-only scene: organic alpine cave threshold.
## It is not part of normal gameplay and does not modify Regions 1–6.

const TERRAIN_SCRIPT: Script = preload("res://levels/TerrainPatch.gd")
const ORGANIC_KIT_SCRIPT: Script = preload("res://levels/OrganicRuinKit.gd")
var camera: Camera3D
var t: float = 0.0

func _ready() -> void:
	_build_environment()
	var terrain := TERRAIN_SCRIPT.new() as Node3D
	terrain.name = "TerrainPatch"
	add_child(terrain)
	var kit := ORGANIC_KIT_SCRIPT.new() as Node3D
	kit.name = "OrganicRuinKit_Region10Validation"
	add_child(kit)
	await get_tree().process_frame
	var wet_material: Material = kit.get("wet_stone_material") as Material
	if wet_material != null and kit.has_method("_add_boulder"):
		kit.call("_add_boulder", self, Vector3(-4.0, 3.0, -8.0), Vector3(1.45, 6.0, 1.25), 1201, wet_material, "CavernaArcoPilarEsquerdo", false)
		kit.call("_add_boulder", self, Vector3(4.0, 3.0, -8.0), Vector3(1.45, 6.0, 1.25), 1202, wet_material, "CavernaArcoPilarDireito", false)
		kit.call("_add_boulder", self, Vector3(0.0, 6.1, -8.0), Vector3(4.8, 1.55, 1.45), 1203, wet_material, "CavernaArcoLintel", false)
	_create_cave_fill(Vector3(0.0, 3.1, -8.7))
	camera = Camera3D.new()
	camera.name = "Region10ValidationCamera"
	camera.position = Vector3(12.0, 7.0, 18.0)
	camera.fov = 58.0
	add_child(camera)
	camera.look_at(Vector3(0.0, 3.7, -8.0), Vector3.UP)
	camera.current = true

func _build_environment() -> void:
	var world := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#071412")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#29443d")
	environment.ambient_light_energy = 0.62
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.glow_enabled = true
	environment.glow_intensity = 0.38
	environment.glow_bloom = 0.18
	world.environment = environment
	add_child(world)
	var sun := DirectionalLight3D.new()
	sun.light_color = Color("#9db8aa")
	sun.light_energy = 0.42
	sun.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	add_child(sun)

func _create_cave_fill(position_value: Vector3) -> void:
	var fill := OmniLight3D.new()
	fill.name = "BraseiroAzulInteriorEsquerdo"
	fill.position = position_value + Vector3(-2.2, 0.0, 0.5)
	fill.light_color = Color("#5cc8ff")
	fill.light_energy = 5.5
	fill.omni_range = 10.0
	fill.shadow_enabled = false
	add_child(fill)
	var fill_right := fill.duplicate() as OmniLight3D
	fill_right.name = "BraseiroAzulInteriorDireito"
	fill_right.position = position_value + Vector3(2.2, 0.0, 0.5)
	add_child(fill_right)
	_create_brazier_core(fill.position)
	_create_brazier_core(fill_right.position)

func _create_brazier_core(position_value: Vector3) -> void:
	var core := MeshInstance3D.new()
	core.name = "NucleoBraseiroAzul"
	var sphere := SphereMesh.new()
	sphere.radius = 0.26
	sphere.height = 0.52
	core.mesh = sphere
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#5cc8ff")
	material.emission_enabled = true
	material.emission = Color("#5cc8ff")
	material.emission_energy_multiplier = 4.5
	core.material_override = material
	core.position = position_value + Vector3(0.0, 0.55, 0.0)
	add_child(core)

func _process(delta: float) -> void:
	if camera == null:
		return
	t += delta
	camera.position = Vector3(12.0 + sin(t * 0.32) * 1.8, 7.0 + sin(t * 0.24) * 0.35, 18.0 + cos(t * 0.32) * 1.5)
	camera.look_at(Vector3(0.0, 3.7, -8.0), Vector3.UP)
