shader_type spatial;

uniform vec4 water_color : source_color = vec4(0.12, 0.48, 0.82, 0.82);
uniform sampler2D water_tex;
uniform float speed : hint_range(0.0, 2.0) = 0.35;
uniform float distortion : hint_range(0.0, 0.1) = 0.025;
uniform float wave_scale : hint_range(1.0, 8.0) = 4.0;

void fragment() {
	vec2 uv = UV * wave_scale;
	vec2 scroll = vec2(TIME * speed, TIME * speed * 0.5);
	vec2 distorted = uv + scroll + vec2(sin(uv.y * 8.0 + TIME) * distortion, cos(uv.x * 6.0 + TIME * 0.7) * distortion);
	
	vec4 tex = texture(water_tex, distorted);
	float fresnel = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), 2.0);
	vec3 color = mix(water_color.rgb, tex.rgb, 0.55);
	
	ALBEDO = color + vec3(fresnel * 0.15);
	ALPHA = water_color.a;
	METALLIC = 0.35;
	ROUGHNESS = 0.12;
	EMISSION = color * 0.04;
}
