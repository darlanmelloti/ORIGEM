shader_type spatial;

uniform sampler2D grass_tex : source_color;
uniform sampler2D rock_tex : source_color;
uniform float slope_threshold : hint_range(0.0, 1.0) = 0.6;
uniform float blend_softness : hint_range(0.0, 1.0) = 0.18;
uniform vec3 grass_tint : source_color = vec3(0.32, 0.58, 0.24);
uniform vec3 rock_tint : source_color = vec3(0.48, 0.42, 0.34);

varying float v_slope;

void vertex() {
	v_slope = NORMAL.y;
}

void fragment() {
	vec2 uv = UV * 18.0;
	vec3 grass = texture(grass_tex, uv).rgb * grass_tint;
	vec3 rock = texture(rock_tex, uv).rgb * rock_tint;
	
	float blend = smoothstep(slope_threshold - blend_softness, slope_threshold + blend_softness, v_slope);
	vec3 base = mix(rock, grass, blend);
	float fresnel = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), 2.0);
	
	ALBEDO = base * (0.85 + fresnel * 0.20);
	ROUGHNESS = mix(0.95, 0.65, blend);
	METALLIC = 0.02;
	SPECULAR = 0.25;
}
