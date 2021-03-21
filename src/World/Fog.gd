extends Sprite

onready var tween = $Tween

const START_A = 0.0
const END_A = 1.0
const TRANS_DURATION = 6.0

func _ready():
	modulate.a = START_A

func _on_npc_destroyed(destroyed_count):
	var alpha = Math.map(destroyed_count, 0, 7, START_A, END_A)
	var end_mod = modulate
	end_mod.a = alpha
	print("setting fog alpha: %s" %alpha)
	tween.stop_all()
	tween.interpolate_property(self, "modulate", modulate, end_mod, TRANS_DURATION, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
