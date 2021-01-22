# A button that triggers a dialog
tool
class_name DialogHotspot, \
		"res://addons/parrot/images/dialog_hotspot.svg"
extends Button


# The dialog to play
var dialog: DialogResource


# Connect the pressed signal to the pressed func
func _ready():
	connect("pressed", self, "_on_pressed")


# Set theme and add overrides
func _enter_tree():
	if not Engine.editor_hint:
		if Parrot.theme == null:
			yield(Parrot, "parrot_configured")
		theme = Parrot.theme
		add_stylebox_override(
			"normal",
			get_stylebox(
				"dialog_hotspot_normal",
				"Button"
			)
		)
		add_stylebox_override(
			"hover",
			get_stylebox(
				"dialog_hotspot_hover",
				"Button"
			)
		)
		add_stylebox_override(
			"disabled",
			get_stylebox(
				"dialog_hotspot_disabled",
				"Button"
			)
		)		
		add_stylebox_override(
			"pressed",
			get_stylebox(
				"dialog_hotspot_pressed",
				"Button"
			)
		)
		add_font_override(
			"font",
			get_font(
				"dialog_hotspot_font",
				"Button"
			)
		)
		add_color_override(
			"font_color_normal",
			get_color(
				"dialog_hotspot_font_color_normal",
				"Button"
			)
		)
		add_color_override(
			"font_color_hover",
			get_color(
				"dialog_hotspot_font_color_hover",
				"Button"
			)
		)
		add_color_override(
			"font_color_disabled",
			get_color(
				"dialog_hotspot_font_color_disabled",
				"Button"
			)
		)
		add_color_override(
			"font_color_pressed",
			get_color(
				"dialog_hotspot_font_color_pressed",
				"Button"
			)
		)
		mouse_default_cursor_shape = Parrot.dialog_hotspot_cursor_shape
	else:
		var _theme = Theme.new()
		_theme.set_stylebox("normal", "Button", StyleBoxEmpty.new())
		theme = _theme


# Play dialog
func _on_pressed():
	release_focus()
	Parrot.play(dialog)
	

# Return properties
func _get_property_list():
	return [{
		"name": "dialog",
		"type": TYPE_OBJECT,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "DialogResource"
	}]
