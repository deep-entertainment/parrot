# A resource describing one line in a dialogue
tool
class_name DialogLineResource
extends Resource


# The character speaking
var character: Resource


# The text the character says
var text: String


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
	return properties
