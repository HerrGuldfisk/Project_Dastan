extends "../motion.gd"

export(float) var BASE_MAX_HORIZONTAL_SPEED = 200.0

export(float) var AIR_ACCELERATION = 500.0
export(float) var AIR_DECCELERATION = 1000.0
export(float) var AIR_STEERING_POWER = 20.0

export(float) var JUMP_HEIGHT = 80.0
export(float) var JUMP_DURATION = 0.8

export(float) var GRAVITY = 1600.0

var enter_velocity = Vector2()

var max_horizontal_speed = 0.0
var horizontal_speed = 0.0
var horizontal_velocity = Vector2()

var vertical_speed = 0.0
var height = 0.0

func initialize(speed, velocity):
	horizontal_speed = speed
	max_horizontal_speed = speed if speed > 0.0 else BASE_MAX_HORIZONTAL_SPEED
	enter_velocity = velocity

func enter():
	owner.get_node("AnimationPlayer").stop()
	var input_direction = get_input_direction()
	update_look_direction(input_direction)

	horizontal_velocity = enter_velocity if input_direction else Vector2()
	vertical_speed = 600.0

	owner.get_node("AnimationPlayer").play("jump")

func update(delta):
	var input_direction = get_input_direction()
	update_look_direction(input_direction)

	move_horizontally(delta, input_direction)
	animate_jump_height(delta)
	if height <= 0.0:
		emit_signal("finished", "previous")
		_on_AnimationPlayer_animation_finished("jump")

func move_horizontally(delta, direction):
	if direction:
		horizontal_speed += AIR_ACCELERATION * delta
	else:
		horizontal_speed -= AIR_DECCELERATION * delta
	horizontal_speed = clamp(horizontal_speed, 0, max_horizontal_speed)

	var target_velocity = horizontal_speed * direction.normalized()
	var steering_velocity = (target_velocity - horizontal_velocity).normalized() * AIR_STEERING_POWER
	horizontal_velocity += steering_velocity

	owner.move_and_slide(horizontal_velocity)

func animate_jump_height(delta):
	vertical_speed -= GRAVITY * delta
	height += vertical_speed * delta
	height = max(0.0, height)

	owner.get_node("BodyPivot").position.y = -height
	
func _on_AnimationPlayer_animation_finished(anim_name):
	# handles animation after landing, probably full of bugs
	# the jump animation needs to finish before animations can be swapped,
	# should change that to only depend on height above ground.
	owner.get_node("AnimationPlayer").stop()
	var moving = get_input_direction()
	if not moving:
		owner.get_node("AnimationPlayer").play("idle")
	elif moving:
		owner.get_node("AnimationPlayer").play("walk")
		