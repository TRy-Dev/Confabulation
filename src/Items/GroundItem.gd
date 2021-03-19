extends YSort

class_name GroundItem

#export(Texture) var image

onready var anim_player = $AnimationPlayer
onready var outline = $Outline

func _ready():
	AnimationController.reset(anim_player)
	$Sprite.texture = PlayerData.get_item_texture_by_name(name)
	outline.texture = $Sprite.texture
	outline.visible = true
	outline.global_position = $Sprite.global_position
	$Control/Label.text = name

func play_animation(name) -> void:
	AnimationController.play(anim_player, name)
#	yield(anim_player, "animation_finished")

func destroy():
	queue_free()

func _on_body_entered(body):
	outline.visible = true
#	print("%s entered GroundItem %s" %[body.name, name])

func _on_body_exited(body):
	outline.visible = false
#	print("%s exited GroundItem %s" %[body.name, name])
