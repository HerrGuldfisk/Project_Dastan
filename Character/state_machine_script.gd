extends KinematicBody2D

signal state_changed
signal direction_changed(new_direction)

var look_direction = Vector2(0, 1) setget set_look_direction

export var sneak = false setget set_sneak
export var run = false setget set_run

onready var possible_states = {
	'idle': $states/idle,
	'walk': $states/walk,
	'sneak': $states/sneak,
	'run': $states/run,
	#'jump': $states/jump
}

var states_stack = []
var current_state = null
var body_parts = []


func _ready():
	for states in $states.get_children():
		states.connect('finished', self, '_change_state')
		states.connect('motion_mode', self, '_change_motion')
		
	states_stack.push_front($states/idle)
	print(states_stack)
	
	current_state = states_stack[0]
	_change_state('idle')
	
func _physics_process(delta):
	current_state.update(delta)

func _input(event):
	current_state.handle_input(event)
	
func _on_animation_finished(anim_name):
	current_state._on_animation_finished(anim_name)
	
func _change_state(state_name):
	
	current_state.exit()
	
	if state_name == 'previous':
		states_stack.pop_front()
	elif state_name in ['jump']:
		states_stack.push_front(possible_states[state_name])
	elif state_name == 'dead':
		queue_free()
		return
	else:
		var new_state = possible_states[state_name]
		states_stack[0] = new_state
		
	if state_name == 'jump':
		$states/jump.initialize(current_state.speed, current_state.velocity)
		
	current_state = states_stack[0]
	# might be important later
	# if current_state != 'previous':
		
	current_state.enter()
		
	emit_signal('state_changed', states_stack)
	
func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	
func set_look_direction(value):
	look_direction = value
	emit_signal('direction_changed', value)
	
func _change_motion(changed_variable):
	
	if changed_variable == 'sneak':
		
		if sneak == true:
	
			for nodes in $states.get_children():
				nodes.set_sneak(false)
			set_sneak(false)
		
		else:
			for nodes in $states.get_children():
				nodes.set_sneak(true)
			set_sneak(true)
			
	if changed_variable == 'run':
		if run == true:
	
			for nodes in $states.get_children():
				nodes.set_run(false)
			set_run(false)
		
		else:
			for nodes in $states.get_children():
				nodes.set_run(true)
				nodes.set_sneak(false)
			set_sneak(false)
			set_run(true)

func set_sneak(value):
	sneak = value
	
func set_run(value):
	run = value
	