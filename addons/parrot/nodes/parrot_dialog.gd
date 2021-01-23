# Parrot dialog main scene
extends CanvasLayer


# Emitted when parrot was configured
signal parrot_configured

# Emitted when a line was finished
signal finished_line

# Emitted when the complete dialog was finished
signal finished_dialog


# The path where the voice file are
var voices_path: String = "res://voices"

# The extension of the voice files
var voices_ext: String = "ogg"

# How much pause time to add
var time_addendum_seconds: float = 2.0

# The assumed readin speech (if no voice file exists for a line)
var reading_speed_words_per_minute: int = 160

# Wether subtitles are displayed
var subtitles = true

# Theme
var theme: Theme

# Dialog hotspot cursor
var dialog_hotspot_cursor_shape: int = Input.CURSOR_IBEAM


# The current dialog playing
var _current_dialog: DialogResource

# The line in the current dialog
var _current_line: int

# Wether a dialog is currently playing
var _dialog_playing: bool


# Hide the subtitles when starting
func _ready():
	$VBox.hide()


# Skip the line on ui_skip action
func _input(event):
	if _dialog_playing and event.is_action_released("ui_skip"):
		advance()
		get_tree().set_input_as_handled()


# Configure Parrot. Set the theme to be used for the dialogs
func configure(p_theme: Theme):
	theme = p_theme
	$VBox/Skip/Panel.theme = theme
	$VBox/Skip/Panel.add_stylebox_override(
		"panel", 
		$VBox/Skip/Panel.get_stylebox("dialog_panel", "Panel")
	)
	$VBox/Skip/Panel/Margin/Text.add_font_override(
		"normal_font",
		$VBox/Skip/Panel/Margin/Text.get_font(
			"dialog_font", 
			"RichTextLabel"
		)
	)
	emit_signal("parrot_configured")


# Play the specified dialog
#
# ** Arguments **
# - dialog: The dialog to play
func play(dialog: DialogResource):
	dialog.id = dialog.resource_path.get_basename().get_file()
	_current_dialog = dialog
	_current_line = -1
	_dialog_playing = true
	advance()


# Advance one line in the dialog
func advance():
	print_debug("Stopping current line")
	$Voice.stop()
	$VBox.hide()
	$Timer.stop()
	if _current_line > -1:
		print_debug("Emitting finished_line signal")
		emit_signal("finished_line", _current_dialog.id, _current_line)
	
	_current_line = _current_line + 1
	
	if _current_dialog.lines.size() <= _current_line:
		print_debug("We're through. Emit the finished_dialog signal.")
		$Background.hide()
		_dialog_playing = false
		emit_signal("finished_dialog", _current_dialog.id)
	else:
		var line = _current_dialog.lines[_current_line] as DialogLineResource
		var text = line.text
		var character = line.character as CharacterResource
		
		if line.image != null:
			print_debug("Showing image")
			$Background.visible = true
			$Background.texture = line.image
		
		print_debug(
			"Speaking %s as character %s" % [text, character.name]
		)
		
		var voices_dir = Directory.new()
		voices_dir.open(voices_path)
		
		var line_length = time_addendum_seconds
		
		if voices_dir.file_exists(
			"%s-%s.%s" % [_current_dialog.id, _current_line, voices_ext]
		):
			print_debug(
				"We have a voice file. Calculate the time " + \
				"to advance to the next line"
			)
			
			var voice_sound = load(
				"%s/%s-%s.%s" % [
					voices_path, 
					_current_dialog.id, 
					_current_line, voices_ext]
			) as AudioStream
			line_length = line_length + voice_sound.get_length()
			$Voice.stream = voice_sound
			print_debug("Playing voice file")
			$Voice.play()
		else:
			print_debug(
				"No voice file found. Calculating the time to advance " + \
				"based on the reading speed."
			)
			var words = text.split(' ', false).size()
			line_length = \
				line_length + \
				ceil(words / reading_speed_words_per_minute * 60)
		
		if subtitles:
			print_debug("Displaying subtitles")
			$VBox/Skip/Panel/Margin/Text.bbcode_text = \
				"[color=#%s][center]%s[/center][/color]" % [
					character.color.to_html(false), 
					text
				]
			$VBox.show()
		
		$Timer.start(line_length)


# The voice and subtitle time has finished
func _on_Timer_timeout():
	advance()
