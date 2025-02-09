shader_type canvas_item;

uniform vec4 new_color : source_color = vec4(1.0);
uniform float alp = 1.0;
uniform float darkness = 0;
uniform float flickering_speed:hint_range(0.0, 50.0, 1.);
uniform float minimal_flickering_alpha:hint_range(0.0, 0.9, 0.1);

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(TEXTURE, UV);
	if (color.a != 0.){
		color.rgb = mix(color.rgb, new_color.rgb, darkness);
		color.a = alp;
		COLOR = color;
	}
}
