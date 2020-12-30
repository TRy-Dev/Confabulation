extends KinematicBody2D

class_name PhysicalObject2D

export(float, 0.01, 100.0) var mass := 1.0
export(float, 0.0, 1.0) var friction_coeff := 0.02
export(float, 0.0, 1.0) var bounciness := 0.90

var velocity := Vector2()
var acceleration := Vector2()

func apply_force(force: Vector2) -> void:
	acceleration += force / mass

func update() -> void:
	var last_velocity = velocity
	# apply friction
	var friction = -1 * last_velocity * friction_coeff
	apply_force(friction)
	# apply acceleration
	last_velocity += acceleration;
	velocity = move_and_slide(last_velocity);
	# bounce if collided
	var slide_count = get_slide_count()
	if slide_count:
		var collision = get_slide_collision(slide_count - 1)
		velocity = bounciness * last_velocity.bounce(collision.normal)
	# reset acceleration
	acceleration = Vector2()
