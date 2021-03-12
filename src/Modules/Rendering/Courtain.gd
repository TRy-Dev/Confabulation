extends Control

onready var anim_player :AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	for effect in $CanvasLayer.get_children():
		effect.color.a = 0.0

func play(name, backwards := false) -> void:
	if anim_player.is_playing():
		print("HEY! Courtain animation is already playing animation: %s. New animation (%s) won't play!" %[anim_player.current_animation, name])
		return
	AnimationController.play(anim_player, name, false, backwards)
