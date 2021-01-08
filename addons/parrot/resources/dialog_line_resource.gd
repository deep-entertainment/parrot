# A resource describing one line in a dialogue
tool
class_name DialogLineResource, \
		"res://addons/parrot/icons/dialog_line.svg"
extends Resource


# The character speaking
var character: Resource


# The text the character says
var text: String


# An image that is displayed full screen while the line is shown
var image: Texture


# Build the property list
#
# ** Returns **
# - The list of properties
func _get_property_list() -> Array:
	var properties = []
	properties.append({
		name = "character",
		type = TYPE_OBJECT,
		hint = PROPERTY_HINT_RESOURCE_TYPE,
		hint_string = "CharacterResource"
	})
	properties.append({
		name = "text",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_MULTILINE_TEXT,
	})
	properties.append({
		name = "image",
		type = TYPE_OBJECT,
		hint = PROPERTY_HINT_RESOURCE_TYPE,
		hint_string = "Texture"
	})
	return properties
