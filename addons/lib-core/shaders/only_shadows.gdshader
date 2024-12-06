shader_type canvas_item;

uniform vec2 offset = vec2(2.0, 5.0);
uniform vec4 modulate : source_color = vec4(0.102, 0.102, 0.102, 0.541);

void fragment() {
	vec2 uv_offset = UV - offset * TEXTURE_PIXEL_SIZE;
	vec4 shadow = vec4(modulate.rgb, texture(TEXTURE, uv_offset).a);
	shadow = vec4(shadow.rgb, step(1, shadow.a) * modulate.a);
	COLOR = shadow;
}
