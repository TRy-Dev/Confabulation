extends KinematicBody2D

class_name PhysicalObject2D

# Properties
export(float, 0.01, 100.0) var mass := 1.0
export(float, 0.0, 1.0) var friction_coeff := 0.02
export(float, 0.0, 1.0) var bounciness := 0.90

# Constraints
export(float, 0.0, 10000.0) var max_speed := 1000.0
export(float, 0.0, 10000.0) var max_force := 1000.0
export(bool) var should_rotate := false

var velocity := Vector2()
var acceleration := Vector2()

const FLOOR_NORMAL = Vector2.UP
const ROTATION_MIN_VELOCITY_SQ = pow(10.0, 2.0)

func apply_force(force: Vector2) -> void:
	acceleration += force.clamped(max_force) / mass

func update() -> void:
	var last_velocity = velocity
	# Apply friction
	if friction_coeff > 0.0:
		var friction = -1 * last_velocity * friction_coeff
		apply_force(friction)
	# Apply acceleration
	last_velocity += acceleration
	last_velocity = last_velocity.clamped(max_speed)
	velocity = move_and_slide(last_velocity, FLOOR_NORMAL)
	# Bounce if collided
	var slide_count = get_slide_count()
	if slide_count and bounciness:
		var collision = get_slide_collision(slide_count - 1)
		velocity = bounciness * last_velocity.bounce(collision.normal)
	# Rotate if rotation enabled
	if should_rotate and velocity.length_squared() >= ROTATION_MIN_VELOCITY_SQ:
		rotation = lerp(rotation, velocity.angle(), 0.2) #look_at(global_position + velocity)
	# Reset acceleration
	acceleration = Vector2()
