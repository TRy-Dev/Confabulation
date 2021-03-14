extends PanelContainer

onready var image_texture = $Container/Image
onready var label = $Container/Label

func initialize(data: Dictionary) -> void:
	image_texture.texture = data["image"]
	label.text = data["text"]
