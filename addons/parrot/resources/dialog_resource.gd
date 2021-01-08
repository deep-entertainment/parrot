# A dialog of characters speaking (or a monolog as well)
tool
class_name DialogResource, \
		"res://addons/parrot/icons/dialog.svg"
extends Resource


# The descriptive id of this dialog
var id: String

# A list of dialog lines to speak
var lines: Array


# Build the property list
#
# ** Returns **
# - The list of properties
func _get_property_list() -> Array:
	var properties = []
	properties.append({
		name = "id",
		type = TYPE_STRING,
	})
	properties.append({
		name = "lines",
		type = TYPE_ARRAY,
		hint = 24,
		hint_string = "17/17:DialogLineResource"
	})
	return properties
