shader_type canvas_item;

void fragment() { 
	COLOR = texture(TEXTURE, vec2(UV.x, UV.y - TIME * 0.01));
}
