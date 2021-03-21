extends PanelContainer

onready var image_texture = $Image
#onready var label = $Container/Label

func initialize(data: Dictionary) -> void:
	if data.has("image"):
		image_texture.texture = data["image"]
#	if data.has("text"):
#		label.text = data["text"]
