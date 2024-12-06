shader_type canvas_item;
render_mode unshaded;

uniform float progress : hint_range(0.0, 1.05);
uniform float ratio;

void fragment() {
	float dist = distance(vec2(0.5, 0.5), vec2(mix(0.5, UV.x, ratio), UV.y));
	COLOR.a = step(dist, progress);
}
