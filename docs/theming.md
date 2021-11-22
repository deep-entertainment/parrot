# Theming

The dialog display of Parrot can be themed using the standard Godot theming resources. See the [GUI skinning guide in the Godot docs for details](https://docs.godotengine.org/en/stable/tutorials/gui/gui_skinning.html).

The following resources can be themed:

| Type          | Name                     | Datatype | Description                                      |
| ------------- | ------------------------ | -------- | ------------------------------------------------ |
| RichTextLabel | dialog_mono_font         | Font     | Font used for monospaced text                    |
| RichTextLabel | dialog_bold_italics_font | Font     | Font used for text that is both bold and italics |
| RichTextLabel | dialog_italics_font      | Font     | Font used for text that is italics               |
| RichTextLabel | dialog_bold_font         | Font     | Font used for text that is bold                  |
| RichTextLabel | dialog_normal_font       | Font     | Font for regular text                            |
| Panel         | dialog_panel             | Style    | The panel around the dialog text                 |

An accessibility-friendly default theme is provided in the addons/parrot/contrib folder together with the [OpenSans Font from Google Fonts](https://fonts.google.com/specimen/Open+Sans#standard-styles).
