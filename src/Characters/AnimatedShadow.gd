extends Sprite

onready var anim_player = $AnimationPlayer

export (int, 4, 32) var frame_count = 32 # 32 - NPC, 4 - player


func _ready():
	play("idle")

func play(name):
	AnimationController.play(anim_player, name)

