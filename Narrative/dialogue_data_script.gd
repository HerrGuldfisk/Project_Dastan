extends Node
"""Each line will start with an enumerator containing both the Node name of the character_type that the player are interacting with and a unique ID."""

# Different ways of reaching different typefaces
# **BOLD**
# //ITALIC//
# {{SPEED}}
# [[COLOR]]

var num_of_interaction = 0

func _ready():

	pass

func _get_text(character, chapter_number, ID):
	
	if character == 'Guard':
		
		if chapter_number > 1 and chapter_number < 5:
			
			