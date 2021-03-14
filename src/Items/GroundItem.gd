extends Area2D

class_name GroundItem

export(Texture) var image

onready var anim_player = $AnimationPlayer

func _ready():
	AnimationController.reset(anim_player)

func play_animation(name) -> void:
	AnimationController.play(anim_player, name)
#	yield(anim_player, "animation_finished")

func destroy():
	queue_free()

func _on_body_entered(body):
	print("%s entered GroundItem %s" %[body.name, name])

func _on_body_exited(body):
	print("%s exited GroundItem %s" %[body.name, name])
