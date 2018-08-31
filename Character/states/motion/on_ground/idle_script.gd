extends 'on_ground_script.gd'

var all_animations = []

func enter():
	"""all_animations = owner.get_node('CS').get_children()
	for animation in all_animations:
		animation.play('idle')"""
	owner.get_node('CS').get_node('Sprite').play('idle')
	owner.get_node('CS').get_node('Position').get_node('Animation').play('idle')

func handle_input(event):
	return .handle_input(event)
	
func update(delta):
	# print(sneak)
	var input_direction = get_input_direction()
	
	if Input.is_action_just_pressed('ui_action_sneak'):
		emit_signal('motion_mode', 'sneak')
			
	# print(sneak)
	if input_direction:
		
		emit_signal('finished', 'walk')
		