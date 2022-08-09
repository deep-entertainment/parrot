<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# parrot\_dialog.gd

**Extends:** [CanvasLayer](../CanvasLayer)

## Description

Parrot dialog main scene

## Constants Descriptions

### DURATION\_NO\_SKIP

```gdscript
const DURATION_NO_SKIP: float = 0.5
```

Duration in seconds that mouse clicks are ignored when starting a dialog line

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

### ignore\_pause

```gdscript
var ignore_pause: bool
```

Let parrot ignore game pausing. So dialog will continue
playing when a game is paused

### skip\_enabled

```gdscript
var skip_enabled: bool = true
```

Enable skipping dialog lines

## Method Descriptions

### configure

```gdscript
func configure(p_theme: Theme, stretch_ratio: float, voice_bus: String = "Master")
```

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
