extends Area2D

func _on_body_entered(body):
	print("%s entered GroundItem %s" %[body.name, name])

func _on_body_exited(body):
	print("%s exited GroundItem %s" %[body.name, name])
