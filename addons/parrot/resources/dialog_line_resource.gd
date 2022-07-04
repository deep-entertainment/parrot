# A resource describing one line in a dialogue
tool
class_name DialogLineResource, \
		"res://addons/parrot/images/dialog_line.svg"
extends Resource


# The character speaking
export(Resource) var character: Resource


# The text the character says
export(String, MULTILINE) var text: String


# An image that is displayed full screen while the line is shown
export(Texture) var image: Texture
