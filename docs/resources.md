# Dialogs, lines and characters

*Parrot* uses three main resources to play a dialog:

* A `Character` resource to differentiate between different persons speaking by using different colors

* A `DialogLine` resource that represents the currently spoken line by a character

* A `Dialog` resource that combines the spoken lines in order

When starting working with *Parrot*, the developer would first create the different speaking characters.

After that, `Dialog` resources can be created with the respective `DialogLine` resources.

## Voice support

*Parrot* automatically plays voice files corresponding to the currently playing dialog.

For this it checks out files in the folder *res://voices* for files named like the currently playing dialog and the id of the currently playing line (counted from zero) and the extension "ogg".

For example, if *Parrot* is currently playing the third line of the dialog "example.tres", a file `example_2.ogg` will be played.

The path and the extension can be configured.

For details, see the [API-Docs](api/parrot_dialog.gd.md).
