extends Button

export(Color) var font_color_focus
export(Color) var font_color_normal

func _ready():
	_set_color(font_color_normal)

func _on_focus_entered():
	_set_color(font_color_focus)

func _on_focus_exited():
	_set_color(font_color_normal)

func _set_color(col: Color) -> void:
	$Label.set('custom_colors/font_color', col)
