# A tool to export all dialogs to CSV format
tool
class_name Exporter
extends Control


# The delimiter used in the CSV file
var delimiter: String = ";"


# The dialog directory selector
var _directory_selector: EditorFileDialog = null

# Export directory selector
var _export_selector: EditorFileDialog = null

# The selected dialog parent directory
var _parent_directory: String = ""


func start_export():
	if _directory_selector == null:
		_directory_selector = EditorFileDialog.new()
		_directory_selector.mode = EditorFileDialog.MODE_OPEN_DIR
		_directory_selector.dialog_text = \
				"Please select a starting directory that contains dialog " +\
				"resources"
		add_child(_directory_selector)
		_directory_selector.connect(
			"dir_selected", 
			self, 
			"_dialog_parent_dir_selected"
		)
	_directory_selector.popup_centered_ratio(0.75)


# Called when a dialog parent dir was selected
func _dialog_parent_dir_selected(dir: String):
	_parent_directory = dir
	if _export_selector == null:
		_export_selector = EditorFileDialog.new()
		_export_selector.mode = EditorFileDialog.MODE_SAVE_FILE
		_export_selector.clear_filters()
		_export_selector.add_filter("*.csv")
		_export_selector.dialog_text = \
				"Please select a CSV file to store the dialogs in."
		add_child(_export_selector)
		_export_selector.connect(
			"file_selected",
			self,
			"_on_export_file_selected"
		)
	_export_selector.popup_centered_ratio(0.75)
	

# Called when the export file has been set
func _on_export_file_selected(file: String):
	var _export_lines = [[
		"dialog_id",
		"character_name",
		"character_color",
		"text"
	]]
	
	_export_lines += _get_export_lines(_parent_directory)
	
	var csv_file = File.new()
	csv_file.open(file, File.WRITE)
	
	for line in _export_lines:
		csv_file.store_csv_line(line, delimiter)

	csv_file.close()
	
	print("Export finished")
	
	
# A recursive function to gather all dialog resources and generate exports
# from it
func _get_export_lines(start_dir):
	var results = []
	var dir = Directory.new()
	dir.open(start_dir)
	dir.list_dir_begin(true, true)
	
	while true:
		var entry = dir.get_next()
		if entry == "":
			break
		if dir.current_is_dir():
			results += _get_export_lines(start_dir.plus_file(entry))
		else:
			var resource = ResourceLoader.load(
				start_dir.plus_file(entry), 
				"", 
				true
			)
			if resource is DialogResource:
				var dialog_id  = entry
				var count = 1
				for line in resource.lines:
					print("Exporting dialog %s... (%d/%d)" % [
						dialog_id,
						count,
						resource.lines.size()
					])
					var character = (line as DialogLineResource).character
					results.append([
						dialog_id.get_basename(),
						(character as CharacterResource).name,
						(character as CharacterResource).color.to_html(),
						(line as DialogLineResource).text
					])
					count += 1
	
	return results
