shader_type canvas_item;

uniform vec2 screen_size = vec2(1366.0, 768.0);
uniform float strength :hint_range(0.0, 10.0) = 0.5;

const float mult = 1 / 270000.0;

void fragment() {
	float x = 0.20;
	float div = 270000.0;
	div = div 
    vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(screen_size.x / div, 0.0)).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(-screen_size.x / div, 0.0)).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, screen_size.y / div)).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, -screen_size.y / div)).xyz * x;
    COLOR.xyz = col;
}