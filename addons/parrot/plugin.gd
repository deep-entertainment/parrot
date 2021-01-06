# Parrot - a simple dialogue plugin
tool
extends EditorPlugin


# The importer scene
var _importer: Importer


# Add the ParrotDialog scene singleton and the import menu button
func _enter_tree():
	add_autoload_singleton("Parrot", "res://addons/parrot/scenes/parrot_dialog.tscn")
	add_tool_menu_item("Import Dialog", self, "_on_import_menu_clicked")
	_importer = preload("res://addons/parrot/scenes/importer.tscn").instance()
	add_child(_importer)


# remove the singleton and the import menu button
func _exit_tree():
	remove_autoload_singleton("Parrot")
	remove_tool_menu_item("Import Dialog")
	remove_child(_importer)


# Show the importer on the tool menu
func _on_import_menu_clicked(_ud):
	_importer.start_import()
	
