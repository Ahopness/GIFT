shader_type canvas_item;

uniform sampler2D dither_tex: hint_white;
uniform float col_depth = 32.0;

uniform float dith_range: hint_range(0,1) = 1.0;

uniform vec2 dith_size;
uniform vec2 buf_size;

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	color = round(color * 255.0) / 255.0;

	vec3 dith = texture(dither_tex, SCREEN_UV*(buf_size/dith_size)).rgb;
	dith -= 0.5;
	
	color.rgb = round((color.rgb + (dith_range*dith)/col_depth) * col_depth) / col_depth;
	
	COLOR.rgba = color.rgba;
}