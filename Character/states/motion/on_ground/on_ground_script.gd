extends '../motion_script.gd'

# export(float) var walk_speed = 100

func enter():
	var speed = 0.0
	var velocity = Vector2()

	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	owner.get_node('CollisionShape2D').get_node('AnimatedSprite').play('idle')
