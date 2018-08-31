extends Control

var button = 0
var menu_buttons
signal save_game()
signal load_game()

func _ready():
	# self.hide()
	menu_buttons = get_node('VBoxContainer/HBoxContainer/menu').get_children()
	change_button_focus(button)
	# Conecting save and load game buttons to main_script.gd
	connect('save_game', owner.self, '_save_game')
	connect('load_game', owner.self, '_load_game')
	
func enter():
	self.show()
	set_physics_process(true)
	
func exit():
	self.hide()
	set_physics_process(false)
	print('end menu')
	
	
func _physics_process(delta):
	if Input.is_action_just_pressed('ui_up'):
		if button == 0:
			button = 4
		else:
			button -= 1
			
		change_button_focus(button)
	
	if Input.is_action_just_pressed('ui_down'):
		if button == 4:
			button = 0
		else:
			button += 1
			
			
		change_button_focus(button)
	
	
func change_button_focus(index):
	for buttons in menu_buttons:
		if buttons.get_index() == index:
			print(index)
			buttons.grab_focus()
			
			
func _on_resume_pressed():
	print('Return to game')
	exit()
	
func _on_resume_mouse_entered():
	button = 0
	change_button_focus(button)


func _on_save_pressed():
	print('save game')
	emit_signal('save_game')
	
func _on_save_mouse_entered():
	button = 1
	change_button_focus(button)


func _on_load_pressed():
	print('load game')
	emit_signal('load_game')

func _on_load_mouse_entered():
	button = 2
	change_button_focus(button)


func _on_options_pressed():
	print('Option pressed')

func _on_options_mouse_entered():
	button = 3
	change_button_focus(button)


func _on_quit_pressed():
	print('Quit playing')
	get_tree().quit()

func _on_quit_mouse_entered():
	button = 4
	change_button_focus(button)
