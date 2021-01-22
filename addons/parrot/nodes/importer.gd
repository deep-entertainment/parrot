# An importer to build dialog resources based on CSV files
tool
class_name Importer
extends Control


# The delimiter used in the CSV file
var import_delimiter: String = ";"


# The current import file
var _import_file: String


# Show the import source dialog to get started
func start_import():
	$ImportDialog.popup_centered()


# A source file was selected
#
# ** Arguments **
# - The path of the import file
func _on_ImportDialog_file_selected(path):
	_import_file = path
	$TargetDialog.popup_centered()


# A target dir was selected. This starts the import
#
# ** Arguments **
# - The target directory
func _on_TargetDialog_dir_selected(dir):
	var target_dir = Directory.new()
	target_dir.open(dir)
	
	print_debug("Opening dialog file")
	var csv_file = File.new()
	csv_file.open(_import_file, File.READ)
	
	print_debug("Reading headers")
	var headers = csv_file.get_csv_line(import_delimiter)
	var dialog_id_col
	var character_name_col
	var character_color_col
	var text_col
	
	for col in range(headers.size()):
		match headers[col]:
			"dialog_id": 
				print_debug("ID is in col %d" % col)
				dialog_id_col = col
			"character_name":
				print_debug("Character name is in col %d" % col)
				character_name_col = col
			"character_color":
				print_debug("Character color is in col %d" % col)
				character_color_col = col
			"text":
				print_debug("Text is in col %d" % col)
				text_col = col
	
	var dialog: DialogResource
	var lines: Array
	var current_id: String = ""
	while ! csv_file.eof_reached():
		var line = csv_file.get_csv_line(import_delimiter)
		print_debug("Read line: %s" % JSON.print(line))
		if (current_id != line[dialog_id_col]):
			current_id = line[dialog_id_col]
			if dialog != null:
				print_debug("Saving dialog resoures %s/%s.tres with %d lines" % [dir, dialog.id, lines.size()])
				dialog.lines = lines
				ResourceSaver.save("%s/%s.tres" % [dir, dialog.id], dialog)
			if target_dir.file_exists("%s.tres" % current_id):
				print_debug("Dialog resoures %s/%s.tres already exists. Removing it." % [dir, current_id])
				target_dir.remove("%s.tres" % current_id)
			print_debug("Creating a new dialog resource")
			dialog = DialogResource.new()
			dialog.id = current_id
			lines = []
			
		print_debug("Adding line")
		var dialog_line = DialogLineResource.new()
		dialog_line.character = CharacterResource.new()
		(dialog_line.character as CharacterResource).name = line[character_name_col]
		(dialog_line.character as CharacterResource).color = Color(line[character_color_col])
		dialog_line.text = line[text_col]
		lines.append(dialog_line)
	print_debug("Saving dialog resoures %s/%s.tres with %d lines" % [dir, dialog.id, lines.size()])
	dialog.lines = lines
	ResourceSaver.save("%s/%s.tres" % [dir, dialog.id], dialog)
	$AcceptDialog.popup_centered()
