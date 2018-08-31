extends '../states_script.gd'

export var sneak = false setget set_sneak
export var run = false setget set_run
export(float) var walk_speed = 150
export var speed = 0.0
export var velocity = Vector2()

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left'))
	input_direction.y = int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up'))
	
	return input_direction
	
func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
		
	if not direction.x in [-1, 1]:
		return
		
	# Might not be needed. Makes sprite always face down when there is no input.
	# owner.get_node('CS').get_node('Sprite').set_scale(Vector2(direction.x, 1))
	owner.get_node('CS').set_scale(Vector2(direction.x, 1))
	
func set_sneak(value):
	sneak = value
	
func set_run(value):
	run = value