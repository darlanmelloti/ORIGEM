shader_type spatial;

uniform vec4 water_color : source_color = vec4(0.1, 0.5, 0.8, 0.8);
uniform sampler2D water_tex;
uniform float speed : hint_range(0.0, 2.0) = 0.5;
uniform float distortion : hint_range(0.0, 0.1) = 0.02;

void fragment() {
	vec2 uv = UV * 4.0;
	vec2 scroll = vec2(TIME * speed, 0.0);
	
	vec4 tex = texture(water_tex, uv + scroll + sin(uv.y * 10.0 + TIME) * distortion);
	
	ALBEDO = mix(water_color.rgb, tex.rgb, 0.4);
	ALPHA = water_color.a;
	METALLIC = 0.5;
	ROUGHNESS = 0.1;
	NORMAL_MAP = texture(water_tex, uv + scroll).rgb;
}
