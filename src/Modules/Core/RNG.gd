extends Node

var _rng = RandomNumberGenerator.new()

const MIN_INT = -9223372036854775807
const MAX_INT = 9223372036854775807

func _init():
	_rng.randomize()

func randf(from = 0.0, to = 1.0) -> float:
	return _rng.randf_range(from, to)

func randi(from = MIN_INT, to = MAX_INT) -> int:
	return _rng.randi_range(from, to)

func randv(v_from, v_to) -> Vector2:
	return Vector2(self.randi(v_from.x, v_to.x), self.randi(v_from.y, v_to.y))
