# A dialog of characters speaking (or a monolog as well)
tool
class_name DialogResource, \
		"res://addons/parrot/images/dialog.svg"
extends Resource


# The descriptive id of this dialog
var id: String

# A list of dialog lines to speak
export(Array, Resource) var lines: Array

