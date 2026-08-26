extends SceneTree

const INLET_ROOT := "AfluenteCartograficoRioParaBacia"
const INLET_WATER := "LaminaDoAfluenteCartografico"
const R6_LAKE_ROOT := "RuinasSubmersasDoLago"
const R6_LAKE_WATER := "LagoDasRuinasSubmersas"
const CANDIDATE_ALPHA := 0.68

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script := load("res://levels/ForestLakeRegion.gd") as Script
	if region_script == null:
		_fail("construtor regional indisponível")
		return
	var region := region_script.new() as Node3D
	if region == null:
		_fail("instância regional indisponível")
		return
	root.add_child(region)
	await process_frame
	await process_frame

	var inlet_root := region.get_node_or_null(INLET_ROOT) as Node3D
	var inlet_water := inlet_root.get_node_or_null(INLET_WATER) as MeshInstance3D if inlet_root != null else null
	var r6_lake_root := region.get_node_or_null(R6_LAKE_ROOT) as Node3D
	var r6_lake_water := r6_lake_root.get_node_or_null(R6_LAKE_WATER) as MeshInstance3D if r6_lake_root != null else null
	var inlet_mesh := inlet_water.mesh as ArrayMesh if inlet_water != null else null
	var r6_lake_mesh := r6_lake_water.mesh as ArrayMesh if r6_lake_water != null else null
	if inlet_mesh == null or r6_lake_mesh == null:
		_fail("malha R4 ou R6 indisponível")
		return

	var inlet_surface_material := inlet_mesh.surface_get_material(0) as ShaderMaterial
	var r6_surface_material := r6_lake_mesh.surface_get_material(0) as ShaderMaterial
	var inlet_shader_code_before := _shader_code(inlet_surface_material)
	var r6_shader_code_before := _shader_code(r6_surface_material)
	var inlet_bounds_before := inlet_mesh.get_aabb()
	var r6_bounds_before := r6_lake_mesh.get_aabb()
	var light_count_before := _count_lights(region)
	var inlet_transform_before := inlet_water.global_transform
	var r6_transform_before := r6_lake_water.global_transform

	var candidate := _make_local_inlet_candidate()
	inlet_water.material_override = candidate
	await process_frame

	var candidate_shader_code := _shader_code(candidate)
	var candidate_is_local := inlet_water.material_override == candidate \
		and inlet_mesh.surface_get_material(0) == inlet_surface_material \
		and candidate_shader_code.contains("blend_mix") \
		and candidate_shader_code.contains("depth_prepass_alpha") \
		and candidate_shader_code.contains("ALPHA = 0.68") \
		and not candidate_shader_code.contains("depth_draw_opaque")
	var geometry_unchanged := inlet_mesh.get_aabb() == inlet_bounds_before \
		and inlet_water.global_transform == inlet_transform_before
	var r6_unchanged := r6_lake_mesh.surface_get_material(0) == r6_surface_material \
		and r6_lake_water.material_override == null \
		and _shader_code(r6_surface_material) == r6_shader_code_before \
		and r6_lake_mesh.get_aabb() == r6_bounds_before \
		and r6_lake_water.global_transform == r6_transform_before
	var lights_unchanged := _count_lights(region) == light_count_before
	var source_material_unchanged := _shader_code(inlet_surface_material) == inlet_shader_code_before

	inlet_water.material_override = null
	region.queue_free()
	if candidate_is_local and geometry_unchanged and r6_unchanged and lights_unchanged and source_material_unchanged:
		print("[ORIGEM_R4_INLET_LOCAL_MATERIAL_CANDIDATE_OK] override local alpha=0.68; malha R4, material-fonte, R6 e luzes inalterados.")
		quit()
		return
	_fail("local=%s geometria=%s r6=%s luzes=%s fonte=%s" % [candidate_is_local, geometry_unchanged, r6_unchanged, lights_unchanged, source_material_unchanged])

func _make_local_inlet_candidate() -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode blend_mix, cull_disabled, depth_prepass_alpha, diffuse_burley;
void vertex() {
	VERTEX.y += sin(VERTEX.x * 0.16 + TIME * 0.72) * 0.11 + cos(VERTEX.z * 0.13 + TIME * 0.58) * 0.075;
}
void fragment() {
	float ripple = sin(VERTEX.x * 0.28 + VERTEX.z * 0.19 + TIME * 0.75) * 0.5 + 0.5;
	float broad_ripple = sin(VERTEX.x * 0.08 - VERTEX.z * 0.06 + TIME * 0.22) * 0.5 + 0.5;
	float variation = clamp(ripple * 0.62 + broad_ripple * 0.38, 0.0, 1.0);
	ALBEDO = mix(vec3(0.020, 0.082, 0.105), vec3(0.055, 0.190, 0.235), variation * 0.62);
	EMISSION = mix(vec3(0.002, 0.012, 0.018), vec3(0.010, 0.046, 0.062), variation * 0.35);
	ROUGHNESS = 0.64;
	SPECULAR = 0.18;
	ALPHA = 0.68;
}
"""
	var material := ShaderMaterial.new()
	material.shader = shader
	return material

func _shader_code(material: ShaderMaterial) -> String:
	if material == null or material.shader == null:
		return ""
	return material.shader.code

func _count_lights(node: Node) -> int:
	var count := 1 if node is Light3D else 0
	for child in node.get_children():
		count += _count_lights(child)
	return count

func _fail(detail: String) -> void:
	printerr("[ORIGEM_R4_INLET_LOCAL_MATERIAL_CANDIDATE_ERROR] %s" % detail)
	quit(1)
