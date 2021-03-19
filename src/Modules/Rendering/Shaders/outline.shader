shader_type canvas_item;

uniform vec4 line_color : hint_color = vec4(1);
uniform float line_thickness : hint_range(0, 10) = 1.0;

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	
	float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	outline = min(outline, 1.0);
	
	vec4 color = texture(TEXTURE, UV);
	COLOR = mix(color, line_color, outline - color.a);
}
//shader_type canvas_item;
//render_mode unshaded;
//
//uniform float width : hint_range(0.0, 16.0);
//uniform vec4 outline_color : hint_color;
//const vec2 sprite_size = vec2(16.0, 16.0);
//
//void fragment()
//{
//    vec2 size = vec2(width); //vec2(width) / sprite_size;
//
//    vec4 sprite_color = texture(TEXTURE, UV);
//
//    float alpha = sprite_color.a;
//    alpha += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
//    alpha += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
//    alpha += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
//    alpha += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
//    alpha += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
//    alpha += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
//    alpha += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
//    alpha += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
//
//    vec3 final_color = mix(outline_color.rgb, sprite_color.rgb, sprite_color.a);
//    COLOR = vec4(final_color, clamp(alpha, 0.0, 1.0));
//}