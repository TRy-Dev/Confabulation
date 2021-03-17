shader_type canvas_item;

uniform vec2 screen_size = vec2(1366.0, 768.0);
uniform float strength :hint_range(0.0, 10.0) = 0.5;

const float mult = 1.0 / 270000.0;

void fragment() {
	float x = 0.20;
    vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(screen_size.x * mult, 0.0)).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(-screen_size.x * mult, 0.0)).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, screen_size.y * mult)).xyz * x;
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, -screen_size.y * mult)).xyz * x;
    COLOR.xyz = col;
}