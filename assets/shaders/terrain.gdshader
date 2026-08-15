shader_type spatial;

uniform sampler2D grass_tex : source_color;
uniform sampler2D rock_tex : source_color;
uniform float slope_threshold : hint_range(0.0, 1.0) = 0.7;
uniform float blend_softness : hint_range(0.0, 1.0) = 0.2;

varying float v_slope;

void vertex() {
	v_slope = NORMAL.y;
}

void fragment() {
	vec3 grass = texture(grass_tex, UV * 20.0).rgb;
	vec3 rock = texture(rock_tex, UV * 20.0).rgb;
	
	float blend = smoothstep(slope_threshold - blend_softness, slope_threshold + blend_softness, v_slope);
	
	ALBEDO = mix(rock, grass, blend);
	ROUGHNESS = 0.8;
}
