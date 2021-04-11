<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# parrot\_dialog.gd

**Extends:** [CanvasLayer](../CanvasLayer)

## Description

Parrot dialog main scene

## Property Descriptions

### dialog\_path

```gdscript
var dialog_path: String = "res://dialogs"
```

The base path where the dialog resources are

### voices\_path

```gdscript
var voices_path: String = "res://voices"
```

The path where the voice file are

### voices\_ext

```gdscript
var voices_ext: String = "ogg"
```

The extension of the voice files

### time\_addendum\_seconds

```gdscript
var time_addendum_seconds: float = 2
```

How much pause time to add

### reading\_speed\_words\_per\_minute

```gdscript
var reading_speed_words_per_minute: int = 160
```

The assumed readin speech (if no voice file exists for a line)

### subtitles

```gdscript
var subtitles
```

Wether subtitles are displayed

### theme

```gdscript
var theme: Theme
```

Theme

### dialog\_hotspot\_cursor\_shape

```gdscript
var dialog_hotspot_cursor_shape: int
```

Dialog hotspot cursor

## Method Descriptions

### configure

```gdscript
func configure(p_theme: Theme)
```

Configure Parrot. Set the theme to be used for the dialogs

### play

```gdscript
func play(dialog: DialogResource)
```

Play the specified dialog

** Arguments **
- dialog: The dialog to play

### cancel

```gdscript
func cancel()
```

Cancel the currently running dialog

### advance

```gdscript
func advance()
```

Advance one line in the dialog

## Signals

- signal parrot_configured(): Emitted when parrot was configured
- signal finished_line(): Emitted when a line was finished
- signal finished_dialog(): Emitted when the complete dialog was finished
