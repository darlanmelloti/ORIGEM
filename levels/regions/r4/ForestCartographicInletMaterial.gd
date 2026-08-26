## ForestCartographicInletMaterial.gd
## DEV4-R4-CARTOGRAPHIC-INLET-LOCAL-MATERIAL-CORRECTION-045
## Material exclusivo da lâmina R4: não modifica a fábrica lacustre partilhada com R6.

class_name R4CartographicInletMaterial
extends RefCounted

const INLET_ALPHA := 0.68

static func make_material() -> ShaderMaterial:
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
