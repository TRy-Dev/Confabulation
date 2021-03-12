extends Node

func play(anim_player :AnimationPlayer, name :String, reset := true, backwards := false) -> void:
	if not anim_player.has_animation(name):
		push_error("HEY! Animation does not exist. Name: %s. Parent %s" % \
				[name, anim_player.owner.name])
		return
	if reset:
		anim_player.play("_reset")
#		yield(get_tree(), "idle_frame")
		yield(anim_player, "animation_finished")
	if backwards:
		anim_player.play_backwards(name)
	else:
		anim_player.play(name)

func queue(anim_player :AnimationPlayer, name :String, reset := true, backwards := false) -> void:
	if not anim_player.has_animation(name):
		push_error("HEY! Animation does not exist. Name: %s. Parent %s" % \
				[name, anim_player.owner.name])
		return
	if backwards:
		print("HEY! Queueing animations backwards not supported")
		return
	if anim_player.get_animation(anim_player.current_animation).loop:
		push_error("HEY! Trying to queue animation %s after looping animation %s" % \
				[name, anim_player.current_animation])
		return
	if reset:
		anim_player.queue("_reset")
	anim_player.queue(name)

func reset(anim_player :AnimationPlayer) -> void:
	anim_player.play("_reset")
