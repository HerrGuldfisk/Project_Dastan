extends 'on_ground_script.gd'

var prev_input_direction = ''

func enter():
	speed = 0.0
	velocity = Vector2()
	
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	
	if input_direction.x != 0:
		owner.get_node('CS').get_node('Sprite').play('walk_side')
		owner.get_node('CS').get_node('Position').get_node('Animation').play('walk_side')
		
	elif input_direction.y != 0:
		
		if input_direction.y > 0:
			owner.get_node('CS').get_node('Sprite').play('walk_down')
			
		else:
			owner.get_node('CS').get_node('Sprite').play('walk_up')


func handle_input(event):
	return .handle_input(event)
	
func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal('finished', 'idle')
	update_look_direction(input_direction)
	
	if Input.is_action_pressed('ui_action_run'):
		emit_signal('motion_mode', 'run')
		
	if Input.is_action_just_pressed('ui_action_sneak'):
		emit_signal('motion_mode', 'sneak')
	
	if run == true:
		emit_signal('finished', 'run')
	if sneak == true:
		emit_signal('finished', 'sneak')
		
			
	if input_direction.x != 0:
		owner.get_node('CS').get_node('Sprite').play('walk_side')
		owner.get_node('CS').get_node('Position').get_node('Animation').play('walk_side')
		
	elif input_direction.y != 0:
		
		if input_direction.y > 0:
			owner.get_node('CS').get_node('Sprite').play('walk_down')
			
		else:
			owner.get_node('CS').get_node('Sprite').play('walk_up')
	
	var speed = walk_speed
	
	var collision_info = move(speed, input_direction)
	if not collision_info:
		return
	
	if speed == walk_speed and collision_info.collider.is_in_group('environment'):
		return null
		
func move(speed, direction):
	velocity = direction.normalized() * speed
	owner.move_and_slide(velocity, Vector2(), 5, 2)
	if owner.get_slide_count() == 0:
		return
	return owner.get_slide_collision(0)