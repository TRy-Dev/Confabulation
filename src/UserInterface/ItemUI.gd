extends PanelContainer

onready var texture_rect = $VBoxContainer/TextureRect
onready var label = $VBoxContainer/Label

func initialize(item_name, img) -> void:
	label.text = item_name
	texture_rect.texture = img
