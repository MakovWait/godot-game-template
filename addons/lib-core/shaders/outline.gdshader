shader_type canvas_item;

uniform vec4 color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float width : hint_range(0, 10) = 1.0;

//uniform int pattern : hint_range(0, 2) = 0; // diamond, circle, square
//uniform bool inside = false;
//uniform bool add_margins = true; // only useful when inside is false

void vertex() {
	VERTEX += (UV * 2.0 - 1.0) * width;
}

bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, sampler2D texture) {
	for (float i = -ceil(width); i <= ceil(width); i++) {
		float x = abs(i) > width ? width * sign(i) : i;
		float offset = width - abs(x);
		for (float j = -ceil(offset); j <= ceil(offset); j++) {
			float y = abs(j) > offset ? offset * sign(j) : j;
			vec2 xy = uv + texture_pixel_size * vec2(x, y);

			//if (xy == clamp(xy, vec2(0.0), vec2(1.0)) && texture(texture, xy).a != 0.0) {
			if (xy == clamp(xy, vec2(0.0), vec2(1.0)) && texture(texture, xy).a == 1.0) {
				return true;
			}
		}
	}

	return false;
}

void fragment() {
	vec2 uv = UV;
	vec4 incomingColor = COLOR;

	vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / TEXTURE_PIXEL_SIZE + vec2(width * 2.0));

	uv = (uv - texture_pixel_size * width) * TEXTURE_PIXEL_SIZE / texture_pixel_size;

	if (uv != clamp(uv, vec2(0.0), vec2(1.0))) {
		COLOR.a = 0.0;
	} else {
		COLOR = texture(TEXTURE, uv);
	}

	//if (COLOR.a == 0.0 && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
	if (COLOR.a != 1.0 && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
		COLOR.rgb = color.rgb;
		COLOR.a += (1.0 - COLOR.a) * color.a;
	}
}