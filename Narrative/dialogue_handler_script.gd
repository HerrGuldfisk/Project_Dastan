extends Control

enum variables {}

func _ready():

	for persons in get_node('dialogue_data').dialogue_array:
		print(persons)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
